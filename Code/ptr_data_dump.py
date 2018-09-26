# Pointer Table Data Dumper, DackR 2018-09
# ----------------------------------------------------------
# This routine will read through the entire pointer table
# for the misc menu text and attempt to dump the data into
# separate binary files...
# ----------------------------------------------------------

# NOTE: CURRENTLY ONLY LOOKING AT 256 MAX POINTERS!! there might be more...
from bm5rle import *

# "global" variables
pointer_list = list()
pointer_int_list = list()
pointer_index = list()


def get_index(lst, value):
    # Intended to get the index in the list for the supplied value
    idx = 0
    for v in lst:
        if v == value:
            break
        idx += 1
    if idx > 255:
        idx = None
    return idx


def write_file(filename, data, wtype='w'):
    # write the file using the provided data and method
    print('WRITING "{0}"...'.format(filename))
    with open(filename, wtype) as of:
        of.write(data)
        of.close()
        print('FILE SAVED')


def read_and_sort_ptr_table(filename, pc_bnk, max_len=255, file_pos=None):
    print("READING:")
    index = 0
    with open(filename, 'rb') as ptr_file:
        if file_pos is not None:
            ptr_file.seek(file_pos)
        while True:
            ptr = ptr_file.read(2)  # Read 2 bytes
            if len(ptr) == 0:
                break

            int_ptr = int.from_bytes(ptr, byteorder='little')  # convert the pointer to an int value
            fp = pc_bnk + int_ptr  # add the bank to the pointer
            print('Index: {0}, Value: {1}, Integer: {2}, PC Ptr: {3}'.format(index,
                                                                             ptr.hex().upper(),
                                                                             int_ptr,
                                                                             fp.to_bytes(3,
                                                                                         byteorder='big').hex().upper()))

            # writing these lists in the "global" scope
            pointer_list.append(ptr)  # keep a list of the original bytes
            pointer_int_list.append(int_ptr)  # keep a list of the pointer as an integer
            pointer_index.append(index)  # keep a list of the pointer indexes
            index += 1
            if index > max_len:
                break

    # create a sorted version of the pointer list (sorted by the data's position in the ROM)
    ptr_sort = pointer_int_list.copy()
    ptr_sort.sort()

    return ptr_sort


def export_log(log_filename, pc_bnk):
    # the following loop is just dumping a text version of the pointer table with detail (not required)
    log = ''
    print("SORTED:")
    for ptr in pointer_sort:
        fp = pc_bnk + ptr  # "full pointer" - the pointer with the bank added to it
        index = get_index(pointer_int_list, ptr)  # get the index of the original pointer
        # ^^(this could be a problem if there is more than one pointer referencing the same data block)
        log += 'StIdx: {0}, Value: {1}, Integer: {2}, PC Ptr: {3}\r\n'.format(index.to_bytes(1, 'big').hex().upper(),
                                                                              ptr.to_bytes(2, 'big').hex().upper(),
                                                                              ptr,
                                                                              fp.to_bytes(3,
                                                                                          byteorder='big').hex().upper())

    print(log)
    write_file(log_filename, log)


def extract_data_blocks(filename, export_path, pc_bnk, expand=False, header_size=0x0):
    print('Reading Data...')
    with open(filename, 'rb') as rom_file:
        idx = 0
        for ptr in pointer_sort.copy():
            # int_ptr = int.from_bytes(ptr, byteorder='little')
            fp = pc_bnk + ptr  # "full pointer" - the pointer with the bank added to it
            index = get_index(pointer_int_list, ptr)  # get the index of the original pointer

            if len(pointer_sort) > (idx + 1):
                next_ptr = pointer_sort[idx + 1]  # get the position of the next data block
            else:
                next_ptr = pointer_sort[idx] + 64 # default to 64 bytes in this block... needs manual correction rn
            length = next_ptr - ptr  # get the length of the next data block
            print('Length:', length)

            rom_file.seek(fp)  # seek to the current pointer location
            this_data = rom_file.read(length)  # read the expected number of bytes
            this_name = export_path + '0x{0}_Index_{1}_Ptr_{2}.bin'.format(
                fp.to_bytes(3, byteorder='big').hex().upper(),
                index.to_bytes(1, 'big').hex().upper(),
                ptr.to_bytes(2, 'big').hex().upper())
            # write the extracted data block to it's own file
            if expand:
                print("Expanding...")
                this_data = unrle(this_data, header_size=header_size)
            write_file(this_name, this_data, 'wb')
            idx += 1
        rom_file.close()
        print('FINISHED READING')


# log_output_file = '../Notes/sorted_misc_text_pointers.txt'
# orig_rom_file_path = '../Base/base.sfc'
# orig_ptr_table_path = '../Data/0x3DC4A_MiscTextPointerTable_Original.bin'
# orig_data_export_path = '../Data/misc_text_data/'
# pc_pointer_bnk = 0x030000

# wip_log_output_file = '../Notes/wip_sorted_misc_text_pointers.txt'
# wip_rom_file_path = '../Base/svambo_wip_9-23.sfc'
# wip_ptr_table_path = '../Data/0x3DC4A_MiscTextPointerTable.bin'
# wip_data_export_path = '../Data/wip_misc_text_data/'
# pc_pointer_bnk = 0x030000

menu_log_output_file = '../Notes/wip_menu_layout_data_pointers.txt'
menu_rom_file_path = '../SuperBomberMan5_EN_v0.01.sfc'
menu_ptr_table_path = '../Data/0x11A000_MenuTextPointerTable.bin'
menu_data_export_path = '../Data/wip_menu_layout_data/'
pc_pointer_bnk = 0x110000

# at this point, this could become a commandline utility, but for now, I'll document the process as variables above
pointer_sort = read_and_sort_ptr_table(menu_ptr_table_path, pc_pointer_bnk)

export_log(menu_log_output_file, pc_pointer_bnk)

extract_data_blocks(menu_rom_file_path, menu_data_export_path, pc_pointer_bnk, True, 0x5)

print('SUCCESS')
