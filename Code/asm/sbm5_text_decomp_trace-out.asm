
//org $c0004d		// This is a unique sequence
lda [$a5],y   
sta $a5       
sep #$30      
stz $0343     
lda $1d28     
sta $0344     
lda $1d2a     
sta $0345     
ldy #$00      
lda [$a5],y   
sta $1d34     
bne $006e     
iny           
lda [$a5],y   
sta $1d35     
iny           
lda $0341     
bit #$02      
bne $009e     
bit #$04      
beq $00bc     
lda [$a5],y   
sta $1d28     
iny           
lda [$a5],y   
sta $1d2a     
iny           
lda [$a5],y   
sta $0342     
iny           
lda $0341     
bit #$01      
beq $00de     
clc           
tya           
adc $a5       
sta $a5       
lda #$00      
adc $a6       
sta $a6       
jsl $c01cb0   
phx           
rep #$20      
lda $a5       
sta $60       
sep #$20      
lda $a7       
sta $62       
ldx #$00      
stz $0200,x   
inx           
bne $1cbf     

//org $c01cc5		// This is a unique sequence
stz $66       
jsr $1d45     
lda [$60]     
sta $64       
and #$1f      
inc           
sta $65       
lda $64       
lsr a         
lsr a         
lsr a         
lsr a         
and #$0e      
sta $64       
inc $60       
bne $1d62     
rts           
plx           
rtl           
stz $0352     
jsr $0135     
lda $1d2a     
pha           
ldy $1d35     
jsl $c008e0   
lda $1d28     
sta $b1       
lda $1d2a     
sta $b3       
jsr $0906     
phy           
lda $0372     
beq $0915     
sta $b5       
stz $b2       
stz $b4       
lda $b1       
clc           
adc $036c     
and #$7f      
ldy $b5       
bne $0929     
and #$3f      
sta $b1       
lda $b3       
clc           
adc $036d     
and #$7f      
ldy $b5       
bne $0939     
and #$1f      
sta $b3       
rep #$20      
ldy $b5       
bne $0956     
lda $b1       
and #$0020    
asl a         
asl a         
asl a         
asl a         
asl a         
sta $9f       
lda $b1       
and #$001f    
ora $9f       
sta $b1       
lda $b3       
asl a         
asl a         
asl a         
asl a         
asl a         
ldy $b5       
beq $0963     
ora $b1       
ldy $0372     
bne $096e     
clc           
adc $036f     
sep #$20      
ply           
rts           
sta $08       
xba           
sta $09       
rtl           
rep #$20      
lda $08       
sta $ae       
sep #$20      
jsl $c00478   
phx           
rep #$30      
ldx $0357     
lda $ae       
sta $7e8004,x 
lda $0352     
sta $7e8000,x 
txa           
clc           
adc #$0006    
sta $035b     
sep #$30      
plx           
rtl           
ldx $1d34     
jsl $c01ccc   
phx           
ldx $64       
jsr ($1ce5,x) 
ldx $66       
dex           
lda $0200,x   
rts           
ldx $66       
sta $0200,x   
inc $66       
dec $65       
bne $1ce0     
lda $0200,x   
plx           
rtl           
sta $a5       
jsl $c01ccc   

//org $c00159		// This is a unique sequence
sta $a6       
jsl $c00497   
phx           
rep #$30      
ldx $035b     
lda $a5       
sta $7e8000,x 
inx           
inx           
stx $035b     
sep #$30      
plx           
rtl           
dex           
dex           
bne $014f     

//org $c01cdd		// This is a unique sequence
jsr $1d45     

//org $c01cf5		// This is a unique sequence
lda [$60]     
inc $60       
bne $1d01     
rts           

//org $c01d2f		// This is a unique sequence
ldx $66       
txa           
sec           
sbc #$20      
tax           
lda $0200,x   
rts           

//org $c00163		// This is a unique sequence
jsl $c004ac   
phx           
rep #$30      
ldx $0357     
lda $035b     
sec           
sbc $0357     
sbc #$0006    
sta $7e8002,x 
lda $035b     
and #$3fff    
sta $0357     
sep #$30      
plx           
rtl           
inc $1d2a     
dey           
bne $013c     

//org $c01d19		// This is a unique sequence
ldx $66       
txa           
sec           
sbc #$04      
tax           
lda $0200,x   
rts           

//org $c01cfb		// This is a unique sequence
inc $61       
bne $1d01     

//org $c01d11		// This is a unique sequence
ldx $66       
dex           
dex           
lda $0200,x   
rts           

//org $c01d3a		// This is a unique sequence
ldx $66       
txa           
sec           
sbc #$40      
tax           
lda $0200,x   
rts           

//org $f3ba		// This is a unique sequence
jml $80f3be   
cli           
cld           
rep #$30      
phd           
phb           
pha           
phx           
phy           
lda #$0000    
tcd           
sep #$30      
lda #$00      
pha           
plb           
lda $4210      //RDNMI - (65816)Interrupt Flag Registers
lda $67       
bne $f442     
inc $67       
lda #$80      
sta $2100      //INIDISP - (65816)Screen Display Register
stz $420c      //HDMAEN - (65816)HDMA Enable Register
jsl $c0061e   
phx           
inc $0367     
ldx $0367     
lda $2137      //SLHV - (65816)Software Latch Register
lda $213f      //STAT78 - (65816)PPU Status Register
lda $213d      //OPVCT - (65816)Scanline Location Registers (Vertical)
xba           
lda $213d      //OPVCT - (65816)Scanline Location Registers (Vertical)
and #$01      
xba           
cpx $0367     
bne $061f     
plx           
rtl           
jsr $f716     
lda $104b     
bmi $f76b     
rts           
lda $0ae9     
beq $f3f7     
stz $0365     
stz $0366     
lda $036a     
sta $2109      //BG3SC - (65816)BG Tilemap Address Registers (BG3)
jsl $c00244   
lda $0351     
beq $028e     
lda $03d3     
beq $028e     
rtl           
jsl $c014f9   
lda $03d3     
beq $152d     
rtl           
jsr $f44a     
jmp ($006b)   
rts           
jsr $f5db     
rep #$20      
phd           
lda #$0300    
tcd           
sep #$20      
lda $03d3     
bne $f5ec     
jmp $f685     
lda $02       
sta $2105      //BGMODE - (65816)BG Mode and Character Size Register
lda $03       
sta $2106      //MOSAIC - (65816)Mosaic Register
lda $05       
sta $211a      //M7SEL - (65816)Mode 7 Settings Register
lda $06       
sta $2123      //W12SEL - (65816)Window Mask Settings Registers
lda $07       
sta $2124      //W34SEL - (65816)Window Mask Settings Registers
lda $08       
sta $2125      //WOBJSEL - (65816)Window Mask Settings Registers
lda $09       
sta $2126      //WH0 - (65816)Window Position Registers (WH0)
lda $0a       
sta $2127      //WH1 - (65816)Window Position Registers (WH1)
lda $0b       
sta $2128      //WH2 - (65816)Window Position Registers (WH2)
lda $0c       
sta $2129      //WH3 - (65816)Window Position Registers (WH3)
lda $0d       
sta $212a      //WBGLOG - (65816)Window Mask Logic registers (BG)
lda $0e       
sta $212b      //WOBJLOG - (65816)Window Mask Logic registers (OBJ)
lda $0f       
sta $212c      //TM - (65816)Screen Destination Registers
lda $10       
sta $212d      //TS - (65816)Screen Destination Registers
lda $11       
sta $212e      //TMW - (65816)Window Mask Destination Registers
lda $12       
sta $212f      //TSW - (65816)Window Mask Destination Registers
lda $13       
sta $2130      //CGWSEL - (65816)Color Math Registers
lda $14       
sta $2131      //CGADSUB - (65816)Color Math Registers
lda $15       
ora #$20      
sta $2132      //COLDATA - (65816)Color Math Registers
lda $16       
ora #$40      
sta $2132      //COLDATA - (65816)Color Math Registers
lda $17       
ora #$80      
sta $2132      //COLDATA - (65816)Color Math Registers
lda $18       
sta $2133      //SETINI - (65816)Screen Mode Select Register
pld           
rts           
jsl $c003e4   
phy           
phx           
ldx #$00      
rep #$20      
lda $7e2b6a,x 
beq $040b     
lda #$0000    
sta $7e2b6a   
sep #$20      
plx           
ply           
rtl           
jsl $c042eb   
rep #$10      
phy           
phx           
lda $1ba0     
bne $434d     
rep #$20      
ldy #$0010    
ldx $1b9e     
cpx $1b9c     
beq $4348      //A2A4L - (65816)HDMA Mid Frame Table Address Registers (Low)
sep #$20      
stx $1b9e     
plx           
ply           
sep #$10      
rtl           
jsl $c546da   
lda $1b95     
beq $472c     
rtl           
jsl $c56aaf   
phy           
phx           
lda $03d3     
beq $6af2     
plx           
ply           
rtl           
jsl $c004e0   
rep #$10      
lda $0300     
bmi $0500     
jsl $c0061e   

//org $c004eb		// This is a unique sequence
rep #$20      
cmp #$00dc    
bcc $04fb     
cmp #$0104    
bcs $04fb     
sep #$20      
bra $0500     
ldx $0355     
cpx $0357     
bne $050b     
rep #$20      
lda $7e8000,x 
sta $0359     
inx           
inx           
lda $7e8000,x 
sta $035f     
inx           
inx           
lda $7e8000,x 
sta $0361     
inx           
inx           
stx $0363     
lda $035f     
cmp #$0008    
sep #$20      
bcs $0538     
lda $0359     
and #$83      
sta $2115      //VMAIN - (65816)Video Port Control Register
lda $0359     
and #$04      
lsr a         
lsr a         
sta $4300      //DMAP0 - (65816)DMA Control Register
lda $0359     
and #$84      
cmp #$80      
beq $0557     
lda #$18      
bra $0559     
sta $4301      //BBAD0 - (65816)DMA Destination Register
lda #$7e      
sta $4304      //A1B0 - (65816)DMA Source Address Registers
rep #$20      
lda $0363     
clc           
adc #$8000    
sta $4302      //A1T0L - (65816)DMA Source Address Registers
lda $035f     
sta $4305      //DAS0L - (65816)DMA Size Registers (Low)
lda $0361     
sta $2116      //VMADDL - (65816)VRAM Address Registers (Low)
sep #$20      
lda #$01      
sta $420b      //MDMAEN - (65816)DMA Enable Register
nop           
sep #$20      
lda #$80      
sta $2115      //VMAIN - (65816)Video Port Control Register
rep #$20      
lda $0355     
clc           
adc $035f     
clc           
adc #$0006    
and #$3fff    
sta $0355     
sep #$20      
jmp $04e2     

//org $c00508		// This is a unique sequence
jmp $05a0     
sep #$10      
rtl           
lda $033d     
sta $4200      //NMITIMEN - (65816)Interrupt Enable Register
lda $0300     
sta $2100      //INIDISP - (65816)Screen Display Register
inc $68       
inc $0aeb     
stz $67       
lda $0aea     
sta $420c      //HDMAEN - (65816)HDMA Enable Register
jsl $80f1b3   
phy           
phx           
jsr $f1d7     
php           
sep #$30      
stz $18       
lda $4212      //HVBJOY - (65816)PPU Status Register
and #$01      
bne $f1dc     
lda $4219      //JOY1H - (65816)Controller Port Data Registers (Pad 1 - High)
sta $1a       
lda $4218      //JOY1L - (65816)Controller Port Data Registers (Pad 1 - Low)
sta $19       
and #$0f      
sta $23       
lda $4016      //JOYSER0 - (65816)Old Style Joypad Registers
lsr a         
rol $23       
lda $421b      //JOY2H - (65816)Controller Port Data Registers (Pad 2 - High)
sta $1c       
lda $421a      //JOY2L - (65816)Controller Port Data Registers (Pad 2 - Low)
sta $1b       
and #$0f      
sta $24       
lda $421f      //JOY4H - (65816)Controller Port Data Registers (Pad 4 - High)
sta $1e       
lda $421e      //JOY4L - (65816)Controller Port Data Registers (Pad 4 - Low)
sta $1d       
and #$0f      
sta $25       
lda $4017      //JOYSER1 - (65816)Old Style Joypad Registers
lsr a         
rol $24       
lsr a         
rol $25       
lda #$7f      
sta $4201      //WRIO - (65816)IO Port Write Register
ldy #$10      
lda $4017      //JOYSER1 - (65816)Old Style Joypad Registers
rep #$20      
lsr a         
rol $1f       
lsr a         
rol $21       
sep #$20      
dey           
bne $f223     

//org $80f233		// This is a unique sequence
lda $1f       
and #$0f      
sta $26       
lda $21       
and #$0f      
sta $27       
lda $4017      //JOYSER1 - (65816)Old Style Joypad Registers
lsr a         
rol $26       
lsr a         
rol $27       
lda #$ff      
sta $4201      //WRIO - (65816)IO Port Write Register
plp           
rts           
plx           
ply           
rtl           
rep #$30      
ply           
plx           
pla           
plb           
pld           
rti           

//org $c01d02		// This is a unique sequence
ldx $66       
dex           
lda $0200,x   
inc           
rts           

//org $c0016d		// This is a unique sequence
pla           
sta $1d2a     
rts           
lda $0342     
bne $0109     
lda #$80      
sta $0352     
jsl $c01d63   
sec           
rep #$20      
lda $60       
sbc #$0001    
sta $a5       
sep #$20      
lda $62       
sbc #$00      
sta $a7       
rtl           
jsl $c01cb0   

//org $c00106		// This is a unique sequence
jsr $0135     

//org $c01d24		// This is a unique sequence
ldx $66       
txa           
sec           
sbc #$10      
tax           
lda $0200,x   
rts           

//org $c00557		// This is a unique sequence
lda #$19      

//org $c01d5c		// This is a unique sequence
inc $61       
bne $1d62     

//org $c00109		// This is a unique sequence
lda #$84      
sta $0352     
lda $0341     
bit #$01      
beq $0128     
inc $0343     
jsl $c01d63   

//org $c0012f		// This is a unique sequence
jmp $0062     

//org $c0006b		// This is a unique sequence
jmp $0132     
plx           
ply           
rtl           
jsl $c00607   
rep #$20      
lda $0357     
cmp $0355     
sep #$20      
bne $0607     

//org $c00613		// This is a unique sequence
lda $7e2b6a   
ora $7e2b6b   
bne $0607     
rtl           
rtl           
plx           
ply           
rtl           
lda $0d77,x   
bmi $023b     
lda #$00      
and #$7f      
sta $0d77,x   
bra $0222     
lda $0380     
bit #$40      
bne $0242     
jsr $0254     
rep #$20      
lda $10       
cmp #$0400    
bcc $025f     
rep #$20      
lda $0a       
cmp #$0000    
sep #$20      
lda $0c       
sbc #$c6      
bcs $0270     
rts           
lda [$0a]     
beq $0242     
jsl $c2038f   
phy           
phx           
lda #$c2      
sta $bf       
sta $c2       
lda [$0a]     
cmp #$fe      
bcs $03d1     
cmp #$fd      
beq $03cc     
cmp #$fc      
beq $03c7     
dec           
tax           
lda $c20af5,x 
sta $b1       
txa           
rep #$30      
and #$00ff    
asl a         
tax           
lda $c204fa,x 
sta $bd       
sep #$30      
lda #$01      
jsr $041d     
phx           
ldx $0073     
sta $0d9f,x   
lda $b1       
sta $0dc7,x   
lda $0d77,x   
bne $044c     
clc           
lda $0d9f,x   
adc $0a       
sta $0d       
rep #$20      
lda #$0000    
adc $0b       
sta $0e       
sep #$20      
lda $0d9f,x   
clc           
adc $b1       
sta $0d9f,x   
bra $0467     
clc           
lda $0d9f,x   
adc $0a       
sta $0a       
rep #$20      
lda #$0000    
adc $0b       
sta $0b       
sep #$20      
plx           
rts           
jsr $0412     
ldx $0073     
jsr $04ea     
lda $0a       
sta $0c87,x   
lda $0b       
sta $0caf,x   
lda $0c       
sta $0cd7,x   
rts           
ldy #$01      
jmp [$00bd]   
lda [$0d]     
bra $1acb     
sta $0373     
stz $0374     
rts           
bra $040f     

//org $c21af2		// This is a unique sequence
jsr $1ecf     
rep #$20      
lda [$0d]     
sta $bd       
sep #$20      
lda #$7e      
sta $bf       
rts           
rep #$20      
lda $0373     
sta [$bd]     
sep #$20      
rts           

//org $c21ae9		// This is a unique sequence
jsr $1ecf     

//org $c21aec		// This is a unique sequence
lda $0373     
sta [$bd]     
rts           

//org $c21714		// This is a unique sequence
rep #$20      
lda [$0d]     
sta $c9       
sep #$20      
iny           
lda [$0d],y   
sta $cb       
bra $1737     
jsl $c202ee   
lda $0b       
xba           
lda $0a       
jsl $c202bc   
phx           
rep #$30      
ldx $10       
sta $7e2000,x 
inx           
inx           
stx $10       
sep #$30      
plx           
rtl           
lda $0c       
jsl $c202ac   
phx           
rep #$10      
ldx $10       
sta $7e2000,x 
inx           
stx $10       
sep #$10      
plx           
rtl           
rtl           
inc $0cff,x   
rep #$20      
lda $c9       
sta $0a       
sep #$20      
lda $cb       
sta $0c       
rts           

//org $c21705		// This is a unique sequence
lda [$0d]     
sta $037c     
rep #$20      
lda [$0d],y   
sta $037d     
sep #$20      
rts           

//org $c21a15		// This is a unique sequence
lda #$01      
sta $b1       
stz $b2       
rep #$10      
ldy #$0000    
ldx $10       
lda [$0d],y   
sta $7e2000,x 
inx           
iny           
cpy $b1       
bcc $1a22     
stx $10       
sep #$10      
rts           

//org $c21a3b		// This is a unique sequence
lda #$02      
bra $1a41     
sta $b1       
stz $b2       
jsr $1ecf     

//org $c21a48		// This is a unique sequence
rep #$10      
ldy #$0000    
ldx $10       
lda [$bd],y   
sta $7e2000,x 
inx           
iny           
cpy $b1       
bcc $1a4f     

//org $c21a5b		// This is a unique sequence
stx $10       
sep #$10      
rts           

//org $c219d8		// This is a unique sequence
lda #$81      
sta $0d77,x   
rts           

//org $c2044c		// This is a unique sequence
lda $0dc7,x   
rep #$20      
and #$00ff    
sta $9f       
clc           
lda $10       
adc #$2000    
sec           
sbc $9f       
sta $0d       
sep #$20      
lda #$7e      
sta $0f       

//org $c2179f		// This is a unique sequence
lda [$0d]     
jsl $c2265c   
phx           
jsl $c2267d   
stz $1999     
phb           
phy           
phx           
sta $9f       
lda #$80      
pha           
plb           
ldx $1999     
lda $19ca,x   
bit #$80      
bne $269b     
stx $1996     
lda $9f       
dec           
sta $b1       
stz $b2       
lda #$0a      
sta $b3       
stz $b4       
jsl $c00baf   
phy           
phx           
rep #$20      
stz $b5       
stz $b7       
sep #$20      
ldy #$00      
ldx #$00      
lda $b1,x     
sta $4202      //WRMPYA - (65816)Multiplicand Registers
lda $00b3,y   
sta $4203      //WRMPYB - (65816)Multiplicand Registers
phx           
stx $a1       
tya           
clc           
adc $a1       
tax           
lda $4216      //RDMPYL - (65816)Multiplication Or Divide Result Registers (Low)
adc $b5,x     
sta $b5,x     
lda $4217      //RDMPYH - (65816)Multiplication Or Divide Result Registers (High)
adc $b6,x     
sta $b6,x     
plx           
inx           
cpx #$02      
bcc $0bbd     

//org $c00be4		// This is a unique sequence
iny           
cpy #$02      
bcc $0bbb     

//org $c00be9		// This is a unique sequence
plx           
ply           
rtl           
clc           
lda $b5       
adc #$e0      
sta $c9       
lda $b6       
adc #$cd      
sta $ca       
lda ($c9)     
beq $26d7     
jsl $c012c3   
phy           
phx           
sta $53       
lda $03d2     
cmp #$30      
bcc $12d1     
ldx #$00      
lda $03d7,x   
beq $12e0     
ldy $049b     
lda $03d7,y   
cmp $53       
beq $12ec     
bcs $12f2     
tya           
sta $043b,x   
phx           
txa           
ldx $043c,y   
sta $043b,x   
txa           
plx           
sta $043c,x   
txa           
sta $043c,y   
lda $53       
sta $03d7,x   
stz $049f,x   
stz $079f,x   
stz $07a0,x   
stz $07ff,x   
rep #$20      
stz $073f,x   
sep #$20      
stz $067f,x   
stz $0680,x   
stz $0860,x   
stz $085f,x   
lda #$01      
sta $0800,x   
lda #$ff      
sta $06df,x   
sta $06e0,x   
inc $03d2     
txa           
stx $53       
clc           
plx           
ply           
rtl           
bcc $26e2     
ldx $53       
ldy #$01      
lda ($c9),y   
sta $0ae7     
iny           
lda ($c9),y   
sta $0348     
iny           
lda ($c9),y   
phx           
phy           
plx           
ply           
jsl $c01f23   
jsr $1f39     
pha           
lda $06df,y   
jsl $c00345   
phy           
phx           
tax           
bmi $0376     
plx           
ply           
rtl           
lda #$ff      
sta $06df,y   
pla           
rts           
jsl $c00295   
phy           
phx           
sta $0346     
jsr $01de     
phy           
phx           
pha           
cmp #$00      
bne $01e6     
sta $0346     
dec           
tay           
lda $0ae7     
asl a         
tax           
rep #$20      
lda $c00379,x 
sta $a8       
sep #$20      
lda #$81      
sta $aa       
rep #$30      
tya           
and #$00ff    
asl a         
tay           
lda [$a8],y   
sta $a8       
sep #$30      
pla           
plx           
ply           
rts           
ldy #$02      
rep #$20      
lda [$a8],y   
sta $ab       
lsr a         
lsr a         
lsr a         
lsr a         
bne $02ae     
cmp #$0009    
bcc $02bb     
sep #$20      
sta $0347     
lda $0348     
sta $b1       
ldx #$00      
lsr $b1       
bcc $02dd     
inx           
cpx #$08      
bcc $02c7     

//org $c002cb		// This is a unique sequence
lda $7e2b10,x 
cmp $0346     
bne $02dd     

//org $c002e2		// This is a unique sequence
ldx #$00      
lda $0348     
sta $b1       
ldy $0347     
lsr $b1       
bcc $02fb     
ldy $0347     
inx           
cpx #$08      
bcc $02ec     

//org $c002f0		// This is a unique sequence
lda $7e2b10,x 
bne $02fb     
dey           
beq $0308     
txa           
sec           
sbc $0347     
inc           
tax           
lda $0347     
sta $7e2b20,x 
tay           
phx           
lda $0346     
sta $7e2b10,x 
lda $0ae7     
sta $7e2b18,x 
inx           
dey           
bne $0318     
plx           
txa           
asl a         
asl a         
asl a         
asl a         
adc #$80      
sta $ae       
stz $af       
lda $0346     
jsl $c001c8   
phy           
jsr $01de     

//org $c001cc		// This is a unique sequence
rep #$20      
lda $a8       
clc           
adc #$0004    
sta $a8       
sep #$20      
jsl $c00210   
phy           
phx           
lda $ac       
cmp #$02      
bcc $021e     
rep #$30      
lda $ae       
asl a         
tax           
ldy #$0000    
lda [$a8],y   
sta $7e2910,x 
inx           
inx           
iny           
iny           
dec $ab       
bne $0227     

//org $c00235		// This is a unique sequence
sep #$30      
jsl $c0023e   
lda #$01      
sta $0351     
rtl           
plx           
ply           
rtl           
ply           
rtl           
inc $0349,x   
txa           
clc           
plx           
ply           
rtl           
bra $1f33     
bcs $1f38     
sta $06df,y   
rtl           
bcs $26c8     
phx           
phy           
plx           
ply           
iny           
lda ($c9),y   
pha           
iny           
lda ($c9),y   
sta $04a0,x   
and #$0f      
sta $04ff,x   
iny           
lda ($c9),y   
phx           
phy           
plx           
ply           
jsl $c011ec   
sta $079f,y   
lda #$00      
sta $07ff,y   
jsr $11f8     
phb           
phy           
phx           
lda $04ff,y   
sta $5b       
asl a         
adc $5b       
tax           
rep #$20      
lda $c0171d,x 
sta $5b       
sep #$20      
lda $c0171f,x 
pha           
plb           
lda $079f,y   
bne $1221     
dec           
asl a         
bcc $1227     
pha           
phy           
plx           
ply           
rep #$20      
lda ($5b),y   
sta $5e       
sep #$20      
ldy $07ff,x   
lda ($5e),y   
sta $049f,x   
iny           
lda ($5e),y   
sta $07a0,x   
txy           
jsl $c01289   
phx           
phy           
lda $04ff,y   
sta $5b       
asl a         
adc $5b       
tax           
rep #$20      
lda $c016cc,x 
sta $5b       
sep #$20      
lda $c016ce,x 
sta $5d       
lda $049f,y   
dec           
rep #$30      
and #$00ff    
asl a         
tay           
lda [$5b],y   
sep #$10      
plx           
sta $7e2eea,x 
sep #$20      
lda $5d       
sta $7e2f4a,x 
txy           
plx           
rtl           
tyx           
lda #$ff      
sta $7e2f4b,x 
lda $07a0,y   
plx           
ply           
plb           
rts           
rtl           
phx           
phy           
plx           
ply           
iny           
stz $0ae4     
stz $0ae5     
lda ($c9),y   
beq $2737     
pla           
phx           
phy           
plx           
ply           
jsl $c01f09   
jsl $c018fc   
phx           
cmp #$00      
beq $193e     
sta $0adf     
jsl $c01b04   
phb           
phy           
phx           
dec           
tay           
lda $0ae7     
asl a         
tax           
lda #$85      
sta $c8       
rep #$20      
lda $c01c96,x 
sta $c6       
tya           
rep #$10      
and #$00ff    
asl a         
asl a         
asl a         
tay           
lda [$c6],y   
sta $ae       
iny           
iny           
lda [$c6],y   
sta $ab       
iny           
iny           
lda [$c6],y   
sta $a5       
iny           
iny           
sep #$20      
lda [$c6],y   
sta $a7       
iny           
lda [$c6],y   
sta $a8       
sep #$10      
bpl $1b63     
jsl $c01cb0   

//org $c01b67		// This is a unique sequence
phk           
pla           
sta $7c       
lda $c030e8   
sta $7b       
lda $c030e7   
sta $7a       
plx           
ply           
plb           
rtl           
lda $a8       
and #$7f      
cmp #$05      
bne $193e     
lda $0ae4     
bne $1921     
rep #$20      
lda $ab       
sta $0ae2     
sep #$20      
jsr $1ab3     
rep #$20      
lda $0ae2     
lsr a         
lsr a         
lsr a         
lsr a         
lsr a         
sep #$20      
sta $0ae4     
rts           
ldx #$00      
jsr $19bb     
lda $7e30ea,x 
cmp $0adf     
bne $19dd     
rts           
beq $1943     
inx           
cpx #$20      
bcc $1923     

//org $c0192d		// This is a unique sequence
ldx #$00      
lda $7e30ea,x 
beq $1954     
txa           
jsr $1a0a     
phx           
pha           
jsr $1a3c     
phy           
phx           
lda $0ae4     
dec           
lsr a         
inc           
sta $a3       
ldx $0ae8     
lda $7e2faa,x 
bmi $1a69     
stx $a1       
ldy $a3       
dey           
beq $1a7d     
inx           
beq $1a82     
lda $7e2faa,x 
cmp #$ff      
bne $1a49     
bra $1a6d     

//org $c01a7d		// This is a unique sequence
lda $a1       
clc           
bra $1a83     
plx           
ply           
rts           
bcc $1a18     
tax           
pla           
bcs $1a3a     
jsr $1a86     
phy           
phx           
pha           
lda $0ae4     
dec           
lsr a         
inc           
tay           
pla           
sta $7e2faa,x 
inx           
dey           
bne $1a91     

//org $c01a99		// This is a unique sequence
plx           
ply           
rts           
txa           
rep #$20      
jsl $c01ad7   
asl a         
asl a         
asl a         
asl a         
sta $9f       
asl a         
and #$1e00    
sta $a3       
lda $9f       
and #$00f0    
ora $a3       
ora #$6000    
rtl           
sta $0ae0     
sta $ae       
sep #$20      
jsr $1a9c     
pha           
lda $0ae4     
rep #$20      
dec           
and #$00ff    
inc           
asl a         
asl a         
asl a         
asl a         
asl a         
sta $0ae2     
sep #$20      
pla           
rts           
rep #$20      
lda $0ae2     
sta $ab       
sep #$20      
clc           
plx           
rts           
bcs $193c     
jsr $19de     
lda $0ae7     
sta $7e30ca,x 
lda $0adf     
sta $7e30ea,x 
lda $0ae5     
sta $7e310a,x 
lda $0ae4     
sta $7e312a,x 
rep #$20      
lda $0ae0     
jsl $c01ac3   
lsr a         
lsr a         
lsr a         
lsr a         
sta $9f       
and #$000f    
sta $a3       
lda $9f       
lsr a         
and #$00f0    
ora $a3       
rtl           
sep #$20      
sta $7e30aa,x 
rts           
jsr $1c26     
phy           
phx           
ldy $0ae5     
beq $1c33     
jsr $1c69     
phy           
phx           
jsl $c00478   

//org $c01c6f		// This is a unique sequence
ldy #$0f      
jsl $c030f6   
jmp [$007a]   

//org $c01c75		// This is a unique sequence
pha           
jsl $c030f6   

//org $c01c7a		// This is a unique sequence
xba           
pla           
rep #$30      
ldx $035b     
sta $7e8000,x 
inx           
inx           
stx $035b     
sep #$30      
dey           
bpl $1c71     

//org $c01c8f		// This is a unique sequence
jsl $c004ac   

//org $c01c93		// This is a unique sequence
plx           
ply           
rts           
rep #$20      
lda $ae       
clc           
adc #$0100    
sta $ae       
sep #$20      
jsr $1c69     

//org $c01c45		// This is a unique sequence
rep #$20      
lda $ae       
clc           
adc #$ff10    
bit #$00ff    
bne $1c56     
sta $ae       
lda $ab       
sec           
sbc #$0040    
sta $ab       
sep #$20      
beq $1c66     
bcs $1c33     

//org $c01c52		// This is a unique sequence
clc           
adc #$0100    

//org $c01c66		// This is a unique sequence
plx           
ply           
rts           
lda $7e314a,x 
inc           
sta $7e314a,x 
clc           
txa           
plx           
rtl           
bcs $1f22     
pha           
lda $06e0,y   
bmi $1f19     
pla           
sta $06e0,y   
jsl $c01eca   
lda $0ae5     
and #$e0      
sta $9f       
lda $0ae5     
and #$1f      
lsr a         
ora $9f       
rep #$20      
and #$00ff    
asl a         
asl a         
asl a         
asl a         
sta $9f       
lda $0ae0     
and #$1fff    
sec           
sbc $9f       
lsr a         
lsr a         
lsr a         
lsr a         
bit #$0800    
beq $1ef9     
sep #$20      
sta $073f,y   
xba           
sta $0740,y   
rtl           
clc           
rtl           
bcc $2745     
phx           
phy           
plx           
ply           
iny           
jsr $27c5     
ldx $1996     
ldy #$08      
lda ($c9),y   
sta $19e2,x   
iny           
lda ($c9),y   
sta $19fa,x   
rts           
lda $53       
sta $199a,x   
tay           
inc $1997     
lda #$80      
sta $055f,y   
lda #$00      
sta $0560,y   
lda #$00      
sta $061f,y   
lda #$80      
sta $05bf,y   
lda #$00      
sta $05c0,y   
lda #$00      
sta $0620,y   
stz $1a12,x   
stz $1a2a,x   
stz $1a42,x   
stz $1a5a,x   
stz $1a72,x   
stz $1a8a,x   
stz $1b1a,x   
lda $1995     
sta $19b2,x   
tay           
lda #$00      
cpy #$18      
bcs $279b     
sta $19ca,x   
stz $1b62,x   
stz $1b4a,x   
stz $1b32,x   
lda #$00      
sta $7e504d,x 
sta $7e5065,x 
sta $7e507d,x 
lda #$01      
tsb $1d1b     
txa           
clc           
bra $27c1     
plx           
ply           
plb           
rtl           
bcs $267b     
tax           
lda $037c     
sta $7e504d,x 
lda $037d     
sta $7e5065,x 
lda $037e     
sta $7e507d,x 
txa           
clc           
plx           
rtl           
bcs $17c3     
tax           
lda $199a,x   
tax           
lda [$0d],y   
sta $055f,x   
iny           
lda [$0d],y   
sta $0560,x   
iny           
lda [$0d],y   
sta $05bf,x   
iny           
lda [$0d],y   
sta $05c0,x   
jmp $1d58     
bcc $1d74     
rep #$20      
lda #$ffff    
sta $0373     
sep #$20      
rts           

//org $c21aaa		// This is a unique sequence
stz $a0       
lda [$0d]     
sta $9f       
bpl $1ab4     
rep #$20      
lda $10       
sec           
sbc $9f       
bpl $1abd     
sta $10       
sep #$20      
rts           

//org $c21850		// This is a unique sequence
ldy #$01      
bra $1856     
jsl $c22801   
phb           
phx           
lda #$7e      
pha           
plb           
ldx #$00      
lda $19ca,x   
bit #$80      
bne $282c     
lda $037c     
cmp $504d,x   
bne $282c     
lda $037d     
cmp $5065,x   
bne $282c     
lda $037e     
cmp $507d,x   
bne $282c     
sec           
txa           
bra $2832     
plx           
plb           
rtl           
bcs $185e     
tax           
lda [$0d]     
dey           
beq $1874     
eor #$ff      
and $1b62,x   
sta $1b62,x   
sta $0373     
jsl $c174d1   
sta $0373     
stz $0374     
rtl           
rts           

//org $c203cc		// This is a unique sequence
jsr $04b0     
ldy #$01      
lda [$0a],y   
dec           
tax           
lda $c20b9e,x 
sta $b1       
txa           
rep #$30      
and #$00ff    
sta $9f       
asl a         
adc $9f       
tax           
lda $c209a7,x 
sta $ae       
sep #$20      
lda $c209a9,x 
sta $b0       
lda #$02      
sep #$10      
jsr $041d     

//org $c204dd		// This is a unique sequence
ldx $0073     
stz $0d77,x   
jsr $04ea     

//org $c204e6		// This is a unique sequence
jsl $c02268   
lda #$01      
bra $226e     
sta $a8       
ldx $73       
rep #$20      
lda $75       
sec           
sbc #$0006    
tcs           
sep #$20      
lda #$00      
pha           
plb           
lda $a8       
bne $229a     
pla           
pla           
pla           
lda $0af1,x   
jsl $c020c1   
phy           
phx           
sta $74       
lda $0def     
cmp #$28      
bcs $20d8     
ldx #$00      
lda $0af1,x   
beq $20f5     
inx           
cpx #$28      
bne $20ce     

//org $c020f5		// This is a unique sequence
ldy $0b43     
lda $0af1,y   
cmp #$ff      
beq $210d      //BG1HOFS - (65816)BG Scroll Registers (BG1)
and #$7f      
cmp $74       
beq $2107      //BG1SC - (65816)BG Tilemap Address Registers (BG1)
lda $0b1b,y   
tay           
bra $20f8     

//org $c02105		// This is a unique sequence
bcs $210d      //BG1HOFS - (65816)BG Scroll Registers (BG1)
tya           
sta $0b1b,x   
phx           
txa           
ldx $0b45,y   
sta $0b45,y   
sta $0b1b,x   
txa           
plx           
sta $0b45,x   
lda $74       
sta $0af1,x   
lda $b0       
sta $0c0f,x   
lda $ae       
sta $0bbf,x   
lda $af       
sta $0be7,x   
lda #$ff      
sta $0c37,x   
sta $0b6f,x   
stz $0b97,x   
inc $0def     
stx $74       
txa           
clc           
plx           
ply           
rtl           
bcs $22bb     
ldx $74       
lda $73       
sta $0b6f,x   
tay           
txa           
jsr $22da     
phy           
phx           
tax           
ldy $0b45,x   
lda $0b1b,x   
sta $0b1b,y   
tay           
lda $0b45,x   
sta $0b45,y   
plx           
ply           
rts           
jsr $22bc     
phy           
phx           
lda $0b45,y   
sta $0b45,x   
lda $0b1b,y   
sta $0b1b,x   
txa           
ldy $0b1b,x   
sta $0b45,y   
ldy $0b45,x   
sta $0b1b,y   
plx           
ply           
rts           
lda $0b45,x   
sta $0aef     
rtl           
ldy $0aef     
ldx $0b1b,y   
cpx #$28      
bcc $22fe     
stx $73       
stx $0aef     
lda $1d1d     
beq $2313     
lda $0b97,x   
beq $231d     
lda $0bbf,x   
sta $bd       
lda $0be7,x   
sta $be       
lda $0c0f,x   
sta $bf       
ldy $0c37,x   
sty $52       
lda #$00      
pha           
plb           
jsl $c02346   
jmp [$00bd]   
lda [$0d]     
sta $0c5f,x   
ldy #$01      
lda [$0d],y   
sta $0c87,x   
iny           
lda [$0d],y   
sta $0caf,x   
jsl $c02160   
ldx $73       
pla           
clc           
adc #$01      
sta $0bbf,x   
pla           
adc #$00      
sta $0be7,x   
pla           
adc #$00      
sta $0c0f,x   
rtl           

//org $c22564		// This is a unique sequence
lda #$80      
pha           
plb           
ldx #$00      
lda $19ca,x   
bmi $257d     
ldy $199a,x   
stx $1995     
sty $52       
jsr $2586     
jsr $25cf     
lda $1b1a,x   
beq $25db     
lda $19e2,x   
sta $91       
lda $19fa,x   
sta $92       
lda $19ca,x   
bmi $2614     
lda ($91)     
beq $2624     
phy           
asl a         
tay           
rep #$20      
lda $cd59,y   
sta $ae       
sep #$20      
phk           
pla           
sta $b0       
ply           
lda ($91)     
rep #$20      
inc $91       
sep #$20      
jsr $2626     
jmp [$00ae]   
lda ($91)     
sta $1b1a,x   
jmp $1fa4     
lda #$01      
bra $1faa     
clc           
adc $91       
sta $91       
lda #$00      
adc $92       
sta $92       
rts           
ldx $1995     
ldy $52       
lda $1b1a,x   
beq $25e5     
dec $1b1a,x   
lda $91       
sta $19e2,x   
lda $92       
sta $19fa,x   
clc           
bra $2625     
rts           
bcs $25c5     
lda $19ca,x   
bit #$0f      
beq $2597     
jsr $2403     
stz $b2       
lda $1a72,x   
bpl $240c     
clc           
adc $1a12,x   
sta $1a12,x   
lda $b2       
adc $1a2a,x   
sta $1a2a,x   
stz $b4       
lda $1a8a,x   
bpl $2424     
clc           
adc $1a42,x   
sta $1a42,x   
lda $b4       
adc $1a5a,x   
sta $1a5a,x   
rts           
lda $19ca,x   
bit #$40      
beq $25a6     
jsr $2356     
stz $ae       
lda $1a2a,x   
bpl $235f     
lda $19ca,x   
bit #$20      
beq $2383     
clc           
lda $061f,y   
adc $1a12,x   
sta $061f,y   
lda $055f,y   
adc $1a2a,x   
sta $055f,y   
lda $0560,y   
adc $ae       
sta $0560,y   
clc           
lda $1a42,x   
adc $0620,y   
sta $0620,y   
stz $ae       
lda $1a5a,x   
bpl $23b1     
adc $05bf,y   
sta $05bf,y   
lda $ae       
adc $05c0,y   
sta $05c0,y   
rts           
rts           
ldx $1995     
inx           
cpx #$18      
bcc $256a     

//org $c22582		// This is a unique sequence
stx $1995     
rtl           

//org $c5449d		// This is a unique sequence
lda $1b7c     
jsl $c007b8   
phx           
sta $036e     
sta $9f       
lda $0371     
asl a         
asl a         
clc           
adc $9f       
dec           
asl a         
tax           
rep #$20      
lda $808035,x 
sta $036f     
sep #$20      
jsl $c007da   
phx           
lda $036e     
asl a         
tax           
lda $0318,x   
lsr a         
lda $0317,x   
ror a         
lsr a         
lsr a         
sta $036c     
lda $031d,x   
inc           
lsr a         
lsr a         
lsr a         
sta $036d     
plx           
rtl           
plx           
rtl           
lda #$80      
sta $1453     
ldx $13d2     
cpx #$80      
bcs $44d8     
rtl           

//org $c10992		// This is a unique sequence
lda #$80      
pha           
plb           
lda $0ae7     
sta $0cff,x   
lda $039e     
ora $0df2     
bne $09f4     
lda $0caf,x   
bne $09f1     
dec $0caf,x   
lda $0cff,x   
sta $0ae7     
rtl           

//org $c5054a		// This is a unique sequence
lda $1d1a     
and #$08      
beq $0552     
rtl           

//org $c00b59		// This is a unique sequence
jsl $c0473a   
phx           
lda $1cbe     
ora $1cbd     
beq $4791     
plx           
rtl           
jsl $c01459   
phb           
lda #$80      
sta $57       
rep #$20      
stz $58       
stz $54       
sep #$20      
lda #$04      
sta $56       
ldy $049b     
bra $149f     
cpy #$60      
bcc $146f     
lda $085f,y   
beq $147c     
lda $049f,y   
beq $1488     
jsr $152e     
phy           
phx           
sty $a5       
stz $a6       
tyx           
lda $04a0,x   
and #$40      
beq $1540     
lda $03d4     
sta $5a       
lda $05bf,x   
clc           
adc $067f,x   
sec           
sbc $0680,x   
sta $b7       
lda $05c0,x   
sbc #$00      
sta $b8       
rep #$20      
lda $055f,x   
sta $b5       
lda $073f,x   
sta $c3       
lda $7e2eea,x 
sta $bd       
sep #$20      
lda $7e2f4a,x 
pha           
plb           
stz $c6       
lda $06df,x   
asl a         
sta $c7       
lda $04a0,x   
sta $a7       
and #$30      
tsb $c7       
lda $5a       
and #$30      
trb $c7       
lda ($bd)     
sta $aa       
cmp $57       
bcc $1595     
lda $a7       
bpl $15ab     
rep #$10      
ldy #$0001    
rep #$20      
lda ($bd),y   
clc           
adc $b5       
sta $b1       
adc #$000f    
cmp #$0110    
bcs $1621     
iny           
iny           
lda ($bd),y   
adc $b7       
sta $b3       
adc #$000f    
cmp #$00f0    
bcs $1623     
iny           
iny           
lda ($bd),y   
adc $c3       
and #$01ff    
sta $ae       
sep #$20      
iny           
iny           
lda ($bd),y   
sta $ad       
and $5a       
clc           
adc $c7       
tsb $af       
iny           
ldx $54       
lsr $b2       
ror $0abf,x   
lda $ad       
lsr a         
ror $0abf,x   
dec $56       
bne $1604     
ldx $58       
lda $b3       
xba           
lda $b1       
rep #$20      
sta $08bf,x   
inx           
inx           
lda $ae       
sta $08bf,x   
inx           
inx           
sep #$20      
stx $58       
dec $57       
bra $1628     
dec $aa       
bne $15b0     
sec           
sep #$10      
plx           
ply           
rts           
bcs $148f     
lda $1d1d     
bne $1497     
jsr $1254     
phx           
ldx $0800,y   
beq $1287     
lda $07a0,y   
bne $1274     
lda $079f,y   
beq $1281     
lda $07a0,y   
cmp #$ff      
beq $1281     
sta $07a0,y   
dex           
bne $125a     
plx           
rts           
lda $043b,y   
pha           
jsr $1419     
phx           
lda $03d7,y   
cmp #$38      
bne $1457     
ldx $043c,y   
cmp $03d7,x   
bne $1457     
plx           
rts           
ply           

//org $c014a3		// This is a unique sequence
ldy $56       
cpy #$04      
beq $14b8     
ldx $54       
lda $0abf,x   
lsr a         
lsr a         
dey           
bne $14ae     

//org $c014b3		// This is a unique sequence
sta $0abf,x   
inc $54       
lda $57       
sec           
sbc $03d5     
bcc $14f7     
beq $14f7     
sta $b1       
stz $b2       
rep #$10      
ldx $58       
ldy $b1       
lda #$e0      
stz $08bf,x   
sta $08c0,x   
stz $08c1,x   
stz $08c2,x   
inx           
inx           
inx           
inx           
dey           
bne $14ce     

//org $c014e1		// This is a unique sequence
sep #$10      
lda $b1       
lsr a         
lsr a         
ldx $54       
tay           
lda #$00      
cpy #$00      
bra $14f5     
bne $14f0     
sta $0abf,x   
inx           
dey           

//org $c014f7		// This is a unique sequence
plb           
rtl           
lda #$01      
sta $03d3     
lda $1d1b     
bit #$08      
beq $0b71     
rtl           

//org $c00ff6		// This is a unique sequence
lda $03c4     
beq $1068     
jsr $1135     
lda $03c2     
beq $113d     
lda $03c3     
beq $1145     
stz $03c2     
stz $03c3     
rts           
rtl           

//org $c02343		// This is a unique sequence
plx           
ply           
rtl           
bra $0b2c     
lda $03bf     
bne $0b35     
jsl $80f496   
lda $68       
cmp $68       
beq $f498     

//org $c0024e		// This is a unique sequence
lda #$00      
sta $4300      //DMAP0 - (65816)DMA Control Register
lda #$22      
sta $4301      //BBAD0 - (65816)DMA Destination Register
lda #$10      
sta $4302      //A1T0L - (65816)DMA Source Address Registers
lda #$29      
sta $4303      //A1T0H - (65816)DMA Source Address Registers
lda #$7e      
sta $4304      //A1B0 - (65816)DMA Source Address Registers
lda #$00      
sta $4305      //DAS0L - (65816)DMA Size Registers (Low)
lda #$02      
sta $4306      //DAS0H - (65816)DMA Size Registers (High)
lda #$00      
sta $4307      //DASB0 - (65816)HDMA Indirect Address Registers
stz $2121      //CGADD - (65816)CGRAM Address Register
lda #$01      
sta $420b      //MDMAEN - (65816)DMA Enable Register
stz $0351     
rep #$20      
lda $0365     
adc #$02c0    
sta $0365     
sep #$20      

//org $c014fe		// This is a unique sequence
lda $57       
sta $03d5     
stz $4300      //DMAP0 - (65816)DMA Control Register
lda #$bf      
sta $4302      //A1T0L - (65816)DMA Source Address Registers
lda #$08      
sta $4303      //A1T0H - (65816)DMA Source Address Registers
stz $4304      //A1B0 - (65816)DMA Source Address Registers
lda #$04      
sta $4301      //BBAD0 - (65816)DMA Destination Register
lda #$20      
sta $4305      //DAS0L - (65816)DMA Size Registers (Low)
lda #$02      
sta $4306      //DAS0H - (65816)DMA Size Registers (High)
stz $2102      //OAMADDL - (65816)OAM Address Registers (Low)
stz $2103      //OAMADDH - (65816)OAM Address Registers (High)
lda #$01      
sta $420b      //MDMAEN - (65816)DMA Enable Register

//org $80f5ec		// This is a unique sequence
lda $01       
sta $2101      //OBSEL - (65816)Object Size and Character Size Register
lda $19       
ldy $1a       
sta $210d      //BG1HOFS - (65816)BG Scroll Registers (BG1)
sty $210d      //BG1HOFS - (65816)BG Scroll Registers (BG1)
lda $1f       
ldy $20       
sta $210e      //BG1VOFS - (65816)BG Scroll Registers (BG1)
sty $210e      //BG1VOFS - (65816)BG Scroll Registers (BG1)
lda $1b       
ldy $1c       
sta $210f      //BG2HOFS - (65816)BG Scroll Registers (BG2)
sty $210f      //BG2HOFS - (65816)BG Scroll Registers (BG2)
lda $21       
ldy $22       
sta $2110      //BG2VOFS - (65816)BG Scroll Registers (BG2)
sty $2110      //BG2VOFS - (65816)BG Scroll Registers (BG2)
lda $1d       
ldy $1e       
sta $2111      //BG3HOFS - (65816)BG Scroll Registers (BG3)
sty $2111      //BG3HOFS - (65816)BG Scroll Registers (BG3)
lda $23       
ldy $24       
sta $2112      //BG3VOFS - (65816)BG Scroll Registers (BG3)
sty $2112      //BG3VOFS - (65816)BG Scroll Registers (BG3)
lda $2d       
ldy $2e       
sta $211f      //M7X - (65816)Mode 7 Matrix Registers
sty $211f      //M7X - (65816)Mode 7 Matrix Registers
lda $2f       
ldy $30       
sta $2120      //M7Y - (65816)Mode 7 Matrix Registers
sty $2120      //M7Y - (65816)Mode 7 Matrix Registers
lda $25       
ldy $26       
sta $211b      //M7A - (65816)Mode 7 Matrix Registers
sty $211b      //M7A - (65816)Mode 7 Matrix Registers
lda $27       
ldy $28       
sta $211c      //M7B - (65816)Mode 7 Matrix Registers
sty $211c      //M7B - (65816)Mode 7 Matrix Registers
lda $29       
ldy $2a       
sta $211d      //M7C - (65816)Mode 7 Matrix Registers
sty $211d      //M7C - (65816)Mode 7 Matrix Registers
lda $2b       
ldy $2c       
sta $211e      //M7D - (65816)Mode 7 Matrix Registers
sty $211e      //M7D - (65816)Mode 7 Matrix Registers
rep #$20      
lda $19       
sta $31       
lda $1b       
sta $33       
lda $1d       
sta $35       
lda $1f       
sta $37       
lda $21       
sta $39       
lda $23       
sta $3b       
sep #$20      

//org $c56ab6		// This is a unique sequence
lda $1cff     
beq $6af2     

//org $80f49c		// This is a unique sequence
rtl           
lda $0068     
sta $006a     
stz $03bf     
inc $0069     
jsr $0b4a     
stz $03d3     
stz $1d1b     
jsl $c00a56   
phy           
phx           
ldx #$00      
txa           
asl a         
tay           
lda $2c,x     
sta $039f,x   
lda $31,x     
sta $03a4,x   
lda $23,x     
cmp #$01      
beq $0a75     
lda $0019,y   
and #$f0      
sta $2c,x     
lda $001a,y   
and #$0f      
sta $31,x     
lda $001a,y   
lsr a         
lsr a         
lsr a         
lsr a         
ora $2c,x     
sta $2c,x     
stz $3b,x     
lda $03b8,x   
bne $0ac6     
lda $31,x     
eor $03a4,x   
and $31,x     
sta $3b,x     
beq $0ab1     
lda $31,x     
beq $0ac6     
stz $40,x     
stz $3b,x     
lda $03b8,x   
beq $0ad2     
stz $36,x     
lda $03b3,x   
bne $0ae9     
lda $2c,x     
eor $039f,x   
and $2c,x     
sta $36,x     
beq $0ae9     
lda $03b3,x   
beq $0af1     
inx           
cpx #$05      
bcs $0af9     
jmp $0a5a     

//org $c00a6d		// This is a unique sequence
lda #$00      
sta $0019,y   
sta $001a,y   

//org $c00af9		// This is a unique sequence
plx           
ply           
rtl           
jsl $c04733   
stz $1cbd     
stz $1cbe     
rtl           
rts           
jsl $c022f0   
phy           
phx           
rep #$20      
tsc           
sta $75       
sep #$20      
ldx $0b43     
bra $233f     

//org $c175a8		// This is a unique sequence
lda $0c87,x   
xba           
lda $0c5f,x   
rep #$20      
cmp #$ffff    
sep #$20      
beq $75c9     
rep #$20      
dec           
sep #$20      
sta $0c5f,x   
xba           
sta $0c87,x   
ora $0c5f,x   
beq $75dd     
lda $0caf,x   
beq $75dc     
rtl           

//org $c2226b		// This is a unique sequence
lda ($91)     
and $1b62,x   
sta $1b32,x   
jmp $1fa4     

//org $c22163		// This is a unique sequence
lda $1b32,x   
beq $2156     
lda ($91)     
jmp $1fb6     
phy           
phx           
ldx #$00      
tay           
bpl $1fbe     
dex           
clc           
adc $91       
sta $91       
txa           
adc $92       
sta $92       
plx           
ply           
rts           

//org $c175dd		// This is a unique sequence
jsl $c021ce   
lda $73       
bra $21d2     
phy           
phx           
cmp #$00      
bne $21d8     
tax           
bmi $221a     
lda $0b6f,x   
bmi $21eb     
txy           
tax           
jsr $22bc     

//org $c021e5		// This is a unique sequence
tyx           
ldy $0b45,x   
bra $21fb     
cpx $73       
bne $2202      //SIC - (SA-1)Super Nintendo CPU INT Clear
sty $0aef     
dec $0def     
stz $0af1,x   
stz $0bbf,x   
stz $0be7,x   
stz $0c0f,x   
stz $0b45,x   
stz $0b1b,x   
stz $0b97,x   
plx           
ply           
rtl           
rtl           

//org $c20211		// This is a unique sequence
lda $0c87,x   
sta $0a       
lda $0caf,x   
sta $0b       
lda $0cd7,x   
sta $0c       
bra $0234     

//org $c20242		// This is a unique sequence
jsl $c202fe   
jsl $c202cd   
phx           
rep #$10      
ldx $10       
dex           
lda $7e2000,x 
stx $10       
sep #$10      
plx           
rtl           
sta $0c       
jsl $c202dd   
phx           
rep #$30      
ldx $10       
dex           
dex           
lda $7e2000,x 
stx $10       
sep #$30      
plx           
rtl           
sta $0a       
xba           
sta $0b       
rtl           
dec $0cff,x   
bpl $0234     

//org $c21ac6		// This is a unique sequence
jsr $1ecf     

//org $c21ac9		// This is a unique sequence
lda [$bd]     

//org $c21b8d		// This is a unique sequence
lda [$0d]     
bra $1b96     
and $0373     
sta $0373     
stz $0374     
rts           

//org $c21d02		// This is a unique sequence
jsr $1edc     
lda [$0d]     
sta $b1       
stz $b2       
bra $1f04     
rep #$20      
lda $0373     
cmp $b1       
sep #$20      
rts           
bra $1d14     
bne $1d74     
bra $1d7f     
stz $0373     
stz $0374     
rts           

//org $c219b3		// This is a unique sequence
lda $0373     
ora $0374     
beq $19bc     
stz $b1       
lda [$0d]     
bpl $19c4     
xba           
lda $b1       
xba           
clc           
rep #$20      
adc $0a       
sta $0a       
sep #$20      
lda $b1       
adc $0c       
sta $0c       
rts           

//org $c21940		// This is a unique sequence
jsr $1956     
ldy #$00      
jsr $1971     
rep #$20      
lda [$0d],y   
sta $bd       
sep #$20      
lda #$7e      
sta $bf       
rts           
lda [$bd]     
sta $b1       
ldy #$02      
rep #$20      
lda [$0d],y   
sta $bd       
sep #$20      
iny           
iny           
lda [$0d],y   
sta $bf       
iny           
rts           
ldy $b1       
lda [$bd],y   
jsl $c174d1   

//org $c2194b		// This is a unique sequence
rts           

//org $c21a3f		// This is a unique sequence
lda #$01      

//org $c203d1		// This is a unique sequence
eor #$ff      
asl a         
tax           
rep #$20      
lda $c2064c,x 
sta $c0       
lda $c209d4,x 
sta $bd       
sep #$20      
ldy #$01      
lda [$0a],y   
dec           
tay           
lda [$bd],y   
sta $b1       
tya           
rep #$30      
and #$00ff    
sta $9f       
asl a         
adc $9f       
tay           
lda [$c0],y   
sta $bd       
iny           
lda [$c0],y   
sta $be       
sep #$30      
lda #$02      
jsr $041d     

//org $c2040b		// This is a unique sequence
jsl $c20412   

//org $c174f1		// This is a unique sequence
jsr $7511     
lda [$0d],y   
sta $0340     
iny           
lda [$0d],y   
jsl $c007b8   

//org $c1751d		// This is a unique sequence
iny           
lda [$0d],y   
sta $1d28     
iny           
lda [$0d],y   
sta $1d2a     
lda [$0d]     
rts           
jsl $c00009   
sta $9f       
lda #$02      
sta $0341     
bra $0020     
phy           
phx           
lda $9f       
dec           
cmp #$ff      
bne $002c     
pha           
lda $0340     
asl a         
adc $0340     
tax           
rep #$20      
lda $808000,x 
sta $a5       
sep #$20      
lda $808002,x 
sta $a7       
pla           
rep #$30      
and #$00ff    
asl a         
tay           
