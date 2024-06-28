/*######################################################################*\
## Module Name: Nib_Substitution     
## Author : Omnia Mohamed
## Date: March 2024
## Description : an s_box is a 4*4 matrix of values that contain a permutation of all possible 4 bit values.
##               each value of the state matrix is mapped into a new value in the following way:
##              the leftmost 2 bits are used as a row value and the right most 2 bits are used as a column value.
## 
\*######################################################################*/
module  Nib_Substitution(input logic[15:0] in_state,output logic[15:0] out_state);
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
        out_state[15:12]=S_Box(in_state[15:12]);
        out_state[11:8]=S_Box(in_state[11:8]);
        out_state[7:4]=S_Box(in_state[7:4]);
        out_state[3:0]=S_Box(in_state[3:0]);
    end
endmodule:Nib_Substitution