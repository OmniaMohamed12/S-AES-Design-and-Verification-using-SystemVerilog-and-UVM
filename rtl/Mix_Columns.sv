/*######################################################################*\
## Module Name: Mix_Columns   
## Author : Omnia Mohamed
## Date: March 2024
## Description : this module operates on each column individually.each 4-bits of a column is mapped into a new value 
##               that is a function of both values in that column.The transformation can be defined by the following matrix multiplication 
##               on the state matrix, where arithmetic is performed in GF(2^4).       
## 
\*######################################################################*/
module  Mix_Columns(input logic[15:0] in_state,output logic[15:0] out_state);
  
    function automatic logic[3:0] multiply_by_4(input logic[3:0] in);
        logic[4:0] irreducible=5'b10011;
        logic[7:0] product=in <<2;
        if(in[3:2]=='0)
            product=product;
        else if( in[3]==1'b1)begin
            product = product ^ irreducible;
            if(product[5]==1)
                product = product ^ (irreducible<<1);
            if(product[4]==1)
                product = product ^ irreducible;
        end
        else  
            product= product ^ irreducible;
        multiply_by_4=product[3:0];
    endfunction:multiply_by_4
  
    always_comb begin
        out_state[15:12]=in_state[15:12] ^ multiply_by_4(in_state[11:8]);
        out_state[11:8]=multiply_by_4(in_state[15:12]) ^ in_state[11:8];
        out_state[7:4]=in_state[7:4] ^ multiply_by_4(in_state[3:0]);
        out_state[3:0]=multiply_by_4(in_state[7:4]) ^ in_state[3:0];
    end
endmodule:Mix_Columns