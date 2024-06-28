/*######################################################################*\
## Class Name: S_AES_Sequencer   
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef S_AES_SEQUENCER
`define S_AES_SEQUENCER
class S_AES_Sequencer  extends uvm_sequencer#(S_AES_Seq_Item);
    `uvm_component_utils(S_AES_Sequencer)

    function new(string name="S_AES_Sequencer",uvm_component parent=null);
        super.new(name,parent);
        
    endfunction
endclass:S_AES_Sequencer

`endif//`ifndef S_AES_SEQUENCER