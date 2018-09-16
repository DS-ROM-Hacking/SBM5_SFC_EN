#include <iostream>
#include <fstream>
#include <iomanip>
#include <cstdlib>

using namespace std;

const unsigned int BUFFER_SIZE=0x10000;

uint8_t in_buf[BUFFER_SIZE]={0};
uint8_t out_buf[BUFFER_SIZE]={0};

struct pos_t
{
uint16_t in, out;
};

//void decompress(uint8_t* read_buf, uint8_t* write_buf, uint32_t size);

int main(int argc, char **argv)
{
//uint32_t p_off = 0x05e74c;//pointer offset type=0x05
uint32_t p_off = 0x05e57c;//pointer offset type=0x02
//uint32_t p_off = 0x05e52c;//pointer offset type=0x04
//uint32_t p_off = 0x05e524;//pointer offset type=0x03
uint8_t c_type=0;//compression type
uint8_t *out_size[2]={0};//output size
uint8_t *p_data[3]={0};//offset of data

FILE *in_file;
FILE *out_file;

const char* in_name = "Super Bomberman 5 (J).smc";
const char* out_name = "Super Bomberman 5 (J)_decomp_revisited_0x05e57c.bin";

in_file = fopen(in_name, "rb");
out_file = fopen(out_name, "wb");

fseek (in_file,p_off,SEEK_SET);
c_type = getc (in_file);

//cout << hex << "\nc_type: " << (int)c_type;

fseek (in_file,p_off+3,SEEK_SET);
fread(out_size,sizeof(uint8_t),sizeof(out_size),in_file);

//cout << hex << "\nout_size[1]: " << (int)out_size[1];
//cout << hex << "\nout_size[0]: " << (int)out_size[0];

uint32_t os = ((int) out_size[0])&0xffff;

//cout << hex << "\nos: " << (int)os;


fseek (in_file,p_off+5,SEEK_SET);
fread(p_data,sizeof(uint8_t),sizeof(p_data),in_file);

//cout << hex << "\np_data[2]: " << (int)p_data[2];
//cout << hex << "\np_data[1]: " << (int)p_data[1];
//cout << hex << "\np_data[0]: " << (int)p_data[0];

uint32_t p=(int)p_data[2];
p=(p&0xff)-0xc0;
p=p<<16;
p=p|(((int)(p_data[1]))<<8);
p=p|(int)p_data[0];
p=((int)p_data[0] & 0xffffff) - 0xc00000;

//cout << hex << "\nP_Offset: " << (int)p;

if ((c_type==0x05)||(c_type==0x02)||(c_type==0x04)||(c_type==0x03))
{

fseek (in_file,p,SEEK_SET);
fread(in_buf,sizeof(uint8_t),BUFFER_SIZE,in_file);
decompress(in_buf, out_buf, os);
fwrite(out_buf,sizeof(uint8_t),os,out_file);

}

fclose(in_file);
fclose(out_file);
return 0;
};

void decompress(uint8_t* read_buf, uint8_t* write_buf, uint32_t size)
{
uint32_t in_pos = 0;
uint32_t out_pos = 0;


while (out_pos<BUFFER_SIZE)
{

uint8_t ctrl;

int32_t rle_pos;

uint32_t i,cnt;
uint8_t e;
uint8_t chr;

cout << hex << "\nIn.pos.=[" << setw(4) << (int) in_pos << "]";
cout << hex << " Out.pos.=[" << setw(4) << (int) out_pos << "]";

ctrl=in_buf[in_pos++];

e=ctrl>>5;

switch (e)
{

//RLE PREVIOUS - 0x02
//011x xxxx
//0x60 - 0x7F
case (0x03):

cout << hex << "\tRLE: 0x60 - 0x7F";
cnt = (ctrl & 0x1f)+1;
rle_pos=out_pos-2;
for (i=0; i<cnt; i++)
{ 
out_buf[out_pos++]=out_buf[rle_pos++];				
}
break;


//RLE PREVIOUS - 0x10
//011x xxxx
//0xA0 - 0xBF
case (0x05):

cout << hex << "\tRLE: 0xA0 - 0xBF";
cnt = (ctrl & 0x1f)+1;
rle_pos=out_pos-0x10;
for (i=0; i<cnt; i++)
{ 
out_buf[out_pos++]=out_buf[rle_pos++];				
}
break;                


//RLE PREVIOUS - 0x04
//100x xxxx
//0x80 - 0x9F
case (0x04):

cout << hex << "\tRLE: 0x80 - 0x9F";
cnt = (ctrl & 0x1f)+1;
rle_pos=out_pos-4;
for (i=0; i<cnt; i++)
{ 
out_buf[out_pos++]=out_buf[rle_pos++];				
}
break;


//RLE PREVIOUS - 0x20
//100x xxxx
//0xC0 - 0xDF
case (0x06):

cout << hex << "\tRLE: 0xC0 - 0xDF";
cnt = (ctrl & 0x1f)+1;
rle_pos=out_pos-0x20;
for (i=0; i<cnt; i++)
{ 
out_buf[out_pos++]=out_buf[rle_pos++];				
}
break;


//RLE PREVIOUS - 0x40
//111x xxxx
//0xE0 - 0xFF
case (0x07):

cout << hex << "\tRLE: 0xE0 - 0xFF";
cnt = (ctrl & 0x1f)+1;
rle_pos=out_pos-0x40;
if(rle_pos>0)
{
for (i=0; i<cnt; i++)
{ 
out_buf[out_pos++]=out_buf[rle_pos++];				
}
}
else
{
for (i=0; i<cnt; i++)
{ 
out_buf[out_pos++]=0x00;				
}	
}
break;

//RLE PREVIOUS - 0x01
//010x xxxx
//0x40 - 0x5F
case (0x02):

cout << hex << "\tRLE: 0x40 - 0x5F";
cnt = (ctrl & 0x1f)+1;

if (out_pos==0)
{ chr=0x00;

out_buf[out_pos++]=chr;
rle_pos=0;
for (i=0; i<cnt-1; i++)
{ 
out_buf[out_pos++]=out_buf[rle_pos++];
}

}

else{
rle_pos=out_pos-1;
for (i=0; i<cnt; i++)
{ 
out_buf[out_pos++]=out_buf[rle_pos++];				
}
}

break;

//RAW
//000x xxxx
//0x00 - 0x1F
case (0x00):

cout << hex << "\tRAW: 0x00 - 0x1F";
cnt = (ctrl & 0x1f)+1;
for (i=0; i<cnt; i++) out_buf[out_pos++]=in_buf[in_pos++];
break;            

//RLE PREVIOUS+INCREMENT
//001x xxxx
//0x20 - 0x3F
case (0x01):

cout << "\tRLE: 0x20 - 0x3F";
cnt = (ctrl & 0x1f)+1;
chr=out_buf[out_pos-1];

for (i=0; i<cnt; i++) out_buf[out_pos++]=++chr;
break;            

}
}
cout << hex << "\nDecompressed data size: " << (int)out_pos;

}
