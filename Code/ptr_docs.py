# Pointer Table Documentation Maker, DackR 2018-09
# ----------------------------------------------------------
# The purpose of this script is to extract a list of
# pointers and their locations for use in documentation.
# ----------------------------------------------------------

ptr_table_path = '../Data/0x11A000_MenuTextPointerTable.bin'
start_pc_address = 0x11A000
start_hirom_address = 0xD1A000
docs_output_file = '../Notes/ptr_docs.csv'
# indicates the location of the pointer, the pointer value in hirom, and the pointer value in pc
docs_header = 'Pointer Offset,HIROM,PC,Description'
