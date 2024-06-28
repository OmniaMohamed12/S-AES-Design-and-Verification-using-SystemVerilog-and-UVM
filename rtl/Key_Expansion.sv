/*######################################################################*\
## Module Name: Key_Expansion    
## Author : Omnia Mohamed
## Date: March 2024
## Description : this module is used to generate key1 for round1 and key2 for round2.
## 
\*######################################################################*/
module Key_Expansion(
    input  logic[15:0] key0,
    output logic[15:0] key1,
    output logic[15:0] key2);
    //wo=key0[16:8],w1=key0[7:0]
    logic [7:0] rcon1=8'h80;
    logic [7:0] rcon2=8'h30;
    function automatic logic[7:0] RotNib(input logic[7:0] w);
        RotNib={w[3:0],w[7:4]};
    endfunction
    function automatic logic[3:0] S_Box(input logic[3:0] in_rot);
    case(in_rot)
        4'b0000: S_Box=4'h9;
        4'b0001: S_Box=4'h4;
        4'b0010: S_Box=4'ha;
        4'b0011: S_Box=4'hb;
        4'b0100: S_Box=4'hd;
        4'b0101: S_Box=4'h1;
        4'b0110: S_Box=4'h8;
        4'b0111: S_Box=4'h5;
        4'b1000: S_Box=4'h6;
        4'b1001: S_Box=4'h2;
        4'b1010: S_Box=4'h0;
        4'b1011: S_Box=4'h3;
        4'b1100: S_Box=4'hc;
        4'b1101: S_Box=4'he;
        4'b1110: S_Box=4'hf;
        4'b1111: S_Box=4'h7;
    endcase
endfunction:S_Box
    always_comb begin
        key1[15:8]=key0[15:8] ^ rcon1 ^ {S_Box(key0[3:0]),S_Box(key0[7:4])} ;
        key1[7:0]=  key1[15:8] ^ key0[7:0];
        key2[15:8]=key1[15:8] ^ rcon2 ^ {S_Box(key1[3:0]),S_Box(key1[7:4])} ;
        key2[7:0]=  key2[15:8] ^ key1[7:0];
    end
endmodule:Key_Expansion