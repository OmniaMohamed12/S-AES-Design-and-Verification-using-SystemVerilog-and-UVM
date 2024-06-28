/*######################################################################*\
## Module Name: Add_Round_Key    
## Author : Omnia Mohamed
## Date:  March 2024
## Description : this module consists of the bitwise xor of the 16-bit round key and the 16-bit state matrix.
## 
\*######################################################################*/
module  Add_Round_Key(input logic [15:0] plain_text,input logic[15:0] key0,output logic [15:0] new_state);
    assign new_state[15:12]= plain_text[15:12] ^ key0[15:12];
    assign new_state[11:8]= plain_text[11:8] ^ key0[11:8];
    assign new_state[7:4]= plain_text[7:4] ^ key0[7:4];
    assign new_state[3:0]= plain_text[3:0] ^ key0[3:0];
endmodule:Add_Round_Key