/*######################################################################*\
## Module Name: Shift_Row    
## Author : Omnia Mohamed
## Date: March 2024
## Description : this module performs a one nibble circular shift of the second row of the state matrix;
##               the first row is not altered.       
## 
\*######################################################################*/
module  Shift_Row(input logic[15:0] in_state,output logic[15:0] out_state);
    always_comb begin
        out_state[15:12]=in_state[15:12];
        out_state[11:8]=in_state[3:0];
        out_state[7:4]=in_state[7:4];
        out_state[3:0]=in_state[11:8];
    end
endmodule:Shift_Row