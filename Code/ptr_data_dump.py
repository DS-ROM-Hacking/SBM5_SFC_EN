# Pointer Table Documentation Maker, DackR 2018-09
# ----------------------------------------------------------
# This routine will read through the entire pointer table
# for the misc menu text and attempt to dump the data into
# separate binary files...
# ----------------------------------------------------------

# NOTE: CURRENTLY ONLY LOOKING AT 256 MAX POINTERS!! there might be more...


def get_index(lst, value):
    idx = 0
    for v in lst:
        if v == value:
            break
        idx += 1
    if idx > 255:
        idx = None
    return idx


def write_file(filename, data, wtype='w'):
    print('WRITING "{0}"...'.format(filename))
    with open(filename, wtype) as of:
        of.write(data)
        of.close()
        print('FILE SAVED')


orig_rom_file_path = '../Base/base.sfc'
orig_ptr_table_path = '../Data/0x3DC4A_MiscTextPointerTable_Original.bin'
wip_rom_file_path = '../Base/svambo_wip_9-23.sfc'
wip_ptr_table_path = '../Data/0x3DC4A_MiscTextPointerTable.bin'
pc_pointer_bnk = 0x030000
log_output_file = '../Notes/sorted_misc_text_pointers.txt'
wip_log_output_file = '../Notes/wip_sorted_misc_text_pointers.txt'
export_path = '../Data/wip_misc_text_data/'

pointer_list = list()
pointer_int_list = list()
pointer_index = list()


print("READING:")
index = 0
with open(wip_ptr_table_path, 'rb') as ptr_file:
    while True:
        ptr = ptr_file.read(2)
        if len(ptr) == 0:
            break

        int_ptr = int.from_bytes(ptr, byteorder='little')
        fp = pc_pointer_bnk + int_ptr
        print('Index: {0}, Value: {1}, Integer: {2}, PC Ptr: {3}'.format(index,
                                                                         ptr.hex().upper(),
                                                                         int_ptr,
                                                                         fp.to_bytes(3, byteorder='big').hex().upper()))

        pointer_list.append(ptr)
        pointer_int_list.append(int_ptr)
        pointer_index.append(index)
        index += 1
        if index > 255:
            break

pointer_sort = pointer_int_list.copy()
pointer_sort.sort()


log = ''
print("SORTED:")
for ptr in pointer_sort:
    fp = pc_pointer_bnk + ptr
    index = get_index(pointer_int_list, ptr)
    log += 'StIdx: {0}, Value: {1}, Integer: {2}, PC Ptr: {3}\r\n'.format(index.to_bytes(1, 'big').hex().upper(),
                                                                          ptr.to_bytes(2, 'big').hex().upper(),
                                                                          ptr,
                                                                          fp.to_bytes(3, byteorder='big').hex().upper())

print(log)
write_file(log_output_file, log)

print('Reading Data...')
with open(wip_rom_file_path, 'rb') as rom_file:
    idx = 0
    for ptr in pointer_sort.copy():
        # int_ptr = int.from_bytes(ptr, byteorder='little')
        fp = pc_pointer_bnk + ptr
        index = get_index(pointer_int_list, ptr)

        next_ptr = pointer_sort[idx + 1]
        length = next_ptr - ptr
        print('Length:', length)

        rom_file.seek(fp)
        this_data = rom_file.read(length)
        this_name = export_path + '0x{0}_Index_{1}_Ptr_{2}.bin'.format(fp.to_bytes(3, byteorder='big').hex().upper(),
                                                                       index.to_bytes(1, 'big').hex().upper(),
                                                                       ptr.to_bytes(2, 'big').hex().upper())
        write_file(this_name, this_data, 'wb')

        idx += 1
    rom_file.close()
    print('FINISHED READING')
