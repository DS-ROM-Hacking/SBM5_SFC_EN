# Pointer Table Documentation Maker, DackR 2018-09
# ----------------------------------------------------------
# The purpose of this script is to extract a list of
# pointers and their locations for use in documentation.
# ----------------------------------------------------------

rom_file_path = '../Base/base.sfc'
ptr_table_path = '../Data/0x11A000_MenuTextPointerTable.bin'
start_pc_address = 0x11A000
start_hirom_address = 0xD1A000
hirom_bank = 'D1'
pc_bank = '11'
docs_output_file = '../Notes/ptr_docs.csv'
# indicates the location of the pointer, the pointer value in hirom, and the pointer value in pc
docs_header = 'Count,PC Offset,HIROM Offset,PC Pointer,HIROM Pointer,Description'

out_doc = ''

ptr_count = 0
position = 0

print('READING POINTERS...')
out_doc += docs_header + '/r/n'
with open(ptr_table_path, 'rb') as ptr_file:
    while True:
        val = ptr_file.read(1)
        if len(val) == 0:
            break
        page = ptr_file.read(1)
        if len(page) == 0:
            break

        out_line = '{0},{1:X},{2:X},{5}{3}{4}, {6}{3}{4},'.format(ptr_count,
                                                                  (start_pc_address + position),
                                                                  (start_hirom_address + position),
                                                                  page.hex().upper(), val.hex().upper(),
                                                                  pc_bank, hirom_bank)
        print(out_line)
        out_doc += out_line + '/r/n'

        ptr_count += 1
        position += 2
    ptr_file.close()
    print('FINISHED READING')

print('WRITING OUTPUT...')
with open(docs_output_file, "w") as out_file:
    out_file.write(out_doc)
    out_file.close()
    print('FILE SAVED')

print('ALL DONE')
