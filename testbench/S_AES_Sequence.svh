/*######################################################################*\
## Class Name: S_AES_Sequence   
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef S_AES_SEQUENCE
`define S_AES_SEQUENCE
class S_AES_Sequence  extends uvm_sequence#(S_AES_Seq_Item);
    `uvm_object_utils(S_AES_Sequence)
    int num_transactions;
    S_AES_Seq_Item seq_item;
    task body();
        repeat(num_transactions)begin 
            do_item();
        end
    endtask:body
    task do_item();
        seq_item=S_AES_Seq_Item::type_id::create("seq_item");
        start_item(seq_item);
        `uvm_info("S_AES_Sequence","S_AES_Sequence is starting an item", UVM_LOW)
        assert(seq_item.randomize());
    
        `uvm_info("S_AES_Sequence","S_AES_Sequence is randomizing an item", UVM_LOW)
        finish_item(seq_item);
        `uvm_info("S_AES_Sequence","S_AES_Sequence is finishing an item", UVM_LOW)
        
    endtask:do_item
        

    function new(string name="S_AES_Sequence");
        super.new(name);
        
    endfunction
endclass:S_AES_Sequence

`endif//`ifndef S_AES_SEQUENCE