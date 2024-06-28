/*######################################################################*\
## Class Name: S_AES_IF 
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/
`ifndef S_AES_IF
`define S_AES_IF
interface S_AES_IF();

    logic [15:0] plaintext;
    logic [15:0] initialkey;
    logic [15:0] ciphertext;

endinterface
`endif//`ifndef S_AES_IF