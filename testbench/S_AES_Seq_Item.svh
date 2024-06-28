/*######################################################################*\
## Class Name: S_AES_Seq_Item   
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef S_AES_SEQ_ITEM
`define S_AES_SEQ_ITEM
class S_AES_Seq_Item  extends uvm_sequence_item;
    rand logic [15:0] plaintext;
    rand logic [15:0] initialkey;
    logic [15:0] ciphertext;

    `uvm_object_utils_begin(S_AES_Seq_Item)
        `uvm_field_int(plaintext,UVM_HEX)
        `uvm_field_int(initialkey,UVM_HEX)
        `uvm_field_int(ciphertext,UVM_HEX)
    `uvm_object_utils_end

    function new(string name="S_AES_Seq_Item");
        super.new(name);
        
    endfunction
endclass:S_AES_Seq_Item

`endif//`ifndef S_AES_SEQ_ITEM