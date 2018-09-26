def unrle(rom, start=0x000000, length=0xffff):

    rompos = start
    romend = start + length

    ring = bytearray(256)
    ringpos = 0

    vram = bytearray()

    def copy(frompos, topos, cnt, add):

        while frompos < 0:
            frompos = frompos + 256

        for _ in range(cnt):

            value = (ring[frompos] + add) & 255
            frompos = (frompos + 1) & 255

            ring[topos] = value
            topos = (topos + 1) & 255

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
                    copy(ringpos - 16, ringpos, cnt, 0)

                elif cmd == 0x06:
                    copy(ringpos - 32, ringpos, cnt, 0)

                elif cmd == 0x07:
                    copy(ringpos - 64, ringpos, cnt, 0)

                ringpos = (ringpos + cnt) & 255
    except:
        print('aborted')

    return vram


# file_bytes = bytearray(open("test.bin", "rb").read())

# block = unrle(file_bytes)

# open("out.bin", "wb").write(block)

#	for i, x in enumerate(range(0x05e22d, 0x05eb45, 8)):
#
#		flag = rom[x + 7]
#		addr = ((rom[x + 6] & 0x3f) << 16) + (rom[x + 5] << 8) + (rom[x + 4] << 0)
#		length = rom[x + 3] * 256 + rom[x+2]
#
#		block = unrle(rom, addr, length)
#		open("out-%04x-%06x-%02x.bin" % (i, addr, flag), "wb").write(block)
