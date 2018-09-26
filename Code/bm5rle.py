def unrle(rom, start=0x000000, length=None, header_size=0x0, footer_size=0x0):

    if length is None:
        length = len(rom)

    rompos = start + header_size
    romend = (start + length) - footer_size

    ring = bytearray(256)
    ringpos = 0

    vram = bytearray()
    header = None
    footer = None

    if header_size > 0:
        print('Preserving Header...')
        header = bytearray(header_size)

        for i in range(header_size):
            header[i] = rom[i]

    if footer_size > 0:
        print('Preserving Footer...')
        footer = bytearray(footer_size)
        for i in range(footer_size):
            footer[i] = rom[romend + i]

    def copy(from_pos, to_pos, cont, add):

        while from_pos < 0:
            from_pos = from_pos + 256

        for _ in range(cont):

            value = (ring[from_pos] + add) & 255
            from_pos = (from_pos + 1) & 255

            ring[to_pos] = value
            to_pos = (to_pos + 1) & 255

            vram.append(value)

    try:
        while rompos < romend and len(vram) < 65536:

            ctrl = rom[rompos]
            rompos += 1

            cmd = (ctrl >> 5)
            cnt = (ctrl & 0b00011111) + 1

            if cmd == 0x00:

                for _ in range(cnt):

                    value = rom[rompos]
                    rompos += 1

                    ring[ringpos] = value
                    ringpos = (ringpos + 1) & 255

                    vram.append(value)

            else:

                if cmd == 0x01:
                    copy(ringpos - 1, ringpos, cnt, 1)

                elif cmd == 0x02:
                    copy(ringpos - 1, ringpos, cnt, 0)

                elif cmd == 0x03:
                    copy(ringpos - 2, ringpos, cnt, 0)

                elif cmd == 0x04:
                    copy(ringpos - 4, ringpos, cnt, 0)

                elif cmd == 0x05:
                    copy(ringpos - 0x10, ringpos, cnt, 0)

                elif cmd == 0x06:
                    copy(ringpos - 0x20, ringpos, cnt, 0)

                elif cmd == 0x07:
                    copy(ringpos - 0x40, ringpos, cnt, 0)

                ringpos = (ringpos + cnt) & 0xff
    except:
        print('aborted')

    if header and len(header) > 0:
        vram = header + vram

    if footer and len(footer) > 0:
        vram = vram + footer

    return vram


def rle(data_bytes, start=0x000000, length=None, header_size=0x0, footer_size=0x0):
    print('Compressing...')
    buffer_size = 0x10000

    backref_t = {'distance': 0, 'length': 0}
    distance_data = [1, 2, 4, 16, 32, 64]
    D = 6
    max_len = 32
    min_len = 1
    max_raw = 32

    def search_backref(position, buffer, length):
        variant = backref_t.copy()

        for idx in range(0, D, 1):
            search_pos = position - distance_data[idx]

            if search_pos > -1:
                if buffer[search_pos] == buffer[position]:
                    match = 1
                    while buffer[search_pos + match] == buffer[position + match] and (position + match) < length and (
                            search_pos + max_len) < (position + max_len):
                        if match >= max_len:
                            break
                        match += 1
                    if match > variant['length']:
                        variant['length'] = match
                        variant['distance'] = distance_data[idx]
        return variant

    def search_incr(position, buffer, length):
        variant = backref_t.copy()
        search_pos = position - 1

        if search_pos > -1:
            c = buffer[search_pos]
            n = c + 1
            if buffer[position] == n:
                match = 1
                while buffer[position + match] == (n + match):
                    if match >= max_len:
                        break
                    match += 1
                if match > variant['length']:
                    variant['length'] = match

        return variant

    def write_raw(out_bytes, out_pos, in_bytes, in_size):
        size = in_size - 1
        out_pos += 1
        out_bytes[out_pos] = (0x00 | size) & 0x00ff
        for i in range(0, in_size):
            out_pos += 1
            out_bytes[out_pos] = in_bytes[i]

    def write_incrref(out_bytes, out_pos, backref):
        size = backref['length'] - 1
        out_bytes[out_pos] = (0x20 | size) & 0x00ff

    def write_backref(out_bytes, out_pos, backref):
        size = backref['length'] - 1
        if backref['distance'] == 1:
            out_bytes[out_pos] = (0x40 | size) & 0xff
        elif backref['distance'] == 2:
            out_bytes[out_pos] = (0x60 | size) & 0xff
        elif backref['distance'] == 4:
            out_bytes[out_pos] = (0x80 | size) & 0xff
        elif backref['distance'] == 16:
            out_bytes[out_pos] = (0xa0 | size) & 0xff
        elif backref['distance'] == 32:
            out_bytes[out_pos] = (0xc0 | size) & 0xff
        elif backref['distance'] == 64:
            out_bytes[out_pos] = (0xe0 | size) & 0xff

    def finalize(data, end):
        out_data = bytearray(end)
        for i in range(0, end):
            out_data[i] = data[i]
        return out_data

    pos = start + header_size
    end = (start + length) - footer_size

    output_data = bytearray(buffer_size)
    raw_data = bytearray(max_raw)
    raw_length = 0
    out_pos = 0
    if length is None:
        length = len(data_bytes)
    input_size = length
    new_size = input_size

    while pos < new_size:
        backref = search_backref(pos, data_bytes, new_size)
        incrref = search_incr(pos, data_bytes, new_size)

        if incrref['length'] > backref['length'] or (incrref['length'] >= raw_length and incrref['length'] >= min_len):
            if raw_length > 0:
                write_raw(output_data, out_pos, raw_data, raw_length)
                out_pos += raw_length + 1
                raw_length = 0
            write_incrref(output_data, out_pos, incrref)

            pos += incrref['length']
            out_pos += 1
        else:
            if backref['length'] > raw_length or backref['length'] > min_len or (
                    raw_length > backref['length'] > min_len):
                if raw_length > 0:
                    write_raw(output_data, out_pos, raw_data, raw_length)
                    out_pos += raw_length + 1
                    raw_length = 0
                write_backref(output_data, out_pos, backref)
                pos += backref['length']
                out_pos += 1
            else:
                raw_length += 1
                pos += 1
                raw_data[raw_length] = data_bytes[pos]
                if raw_length == max_raw:
                    write_raw(output_data, out_pos, raw_data, raw_length)
                    out_pos += raw_length + 1
                    raw_length = 0

    if raw_length > 0:
        write_raw(output_data, out_pos, raw_data, raw_length)
        pos += raw_length
        out_pos += raw_length + 1
        # raw_length = 0

    return finalize(output_data, out_pos)
