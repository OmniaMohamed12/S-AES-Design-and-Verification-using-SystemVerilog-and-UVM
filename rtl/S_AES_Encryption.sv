/*######################################################################*\
## Module Name: S_AES_Encryption    
## Author : Omnia Mohamed
## Date: March 2024
## Description : top module for the encryption process.  
## 
\*######################################################################*/
`include "Key_Expansion.sv"
`include "Add_Round_Key.sv"
`include "Nib_Substitution.sv"
`include "Shift_Row.sv"
`include "Mix_Columns.sv"
module S_AES_Encryption(
    input logic[15:0] key0,
    input logic [15:0] plaintext,
    output logic [15:0] ciphertext);
    logic[15:0] key1;
    logic[15:0] key2;
    logic [15:0] out_add_round0;
    logic [15:0] out_NibSub_round1;
    logic [15:0] out_shift_round1;
    logic [15:0] out_Mix_Columns_round1;
    logic [15:0] out_add_round1;
    logic [15:0] out_NibSub_round2;
    logic [15:0] out_shift_round2;
   
    Key_Expansion keyexp( key0, key1,key2);
    Add_Round_Key AddRoundKey0(plaintext,key0,out_add_round0);
    Nibble_Substitution NibSub_round1(out_add_round0,out_NibSub_round1);
    Shift_Row shift_round1(out_NibSub_round1,out_shift_round1);
    Mix_Columns Mix_Columns_round1(out_shift_round1,out_Mix_Columns_round1);
    Add_Round_Key AddRoundKey1(out_Mix_Columns_round1,key1,out_add_round1);
    Nibble_Substitution NibSub_round2(out_add_round1,out_NibSub_round2);
    Shift_Row shift_round2(out_NibSub_round2,out_shift_round2);
    Add_Round_Key AddRoundKey2(out_shift_round2,key2,ciphertext);

endmodule:S_AES_Encryption