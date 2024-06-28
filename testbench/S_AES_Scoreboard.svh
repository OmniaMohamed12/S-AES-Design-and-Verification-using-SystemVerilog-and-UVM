/*######################################################################*\
## Class Name: S_AES_Scoreboard   
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef S_AES_SCOREBOARD
`define S_AES_SCOREBOARD
class S_AES_Scoreboard extends uvm_scoreboard;
    `uvm_component_utils(S_AES_Scoreboard)

    uvm_analysis_imp#(S_AES_Seq_Item,S_AES_Scoreboard) scb_analyais_imp;
    S_AES_Seq_Item actual_item,expected_item;
    S_AES_Reference_Model ref_model;
    int num_passed_cases;
    int num_failed_cases;
    extern function new(string name="S_AES_Scoreboard",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern function void write (input S_AES_Seq_Item seq_item);
    extern function void check_results ();

endclass:S_AES_Scoreboard
function S_AES_Scoreboard::new(string name="S_AES_Scoreboard",uvm_component parent=null);
    super.new(name,parent);
endfunction
function void S_AES_Scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_analyais_imp=new("scb_analyais_imp",this);
    ref_model=S_AES_Reference_Model::type_id::create("ref_model",this);
    actual_item=new("actual_item");
endfunction
function void S_AES_Scoreboard::check_results ();
    if(actual_item.compare(expected_item))begin
        `uvm_info("S_AES_Scoreboard","TEST PASSED ",UVM_NONE);
        num_passed_cases++;
        expected_item.print();
        actual_item.print();
    end
    else begin
        `uvm_info("S_AES_Scoreboard","TEST FAILED ",UVM_NONE);
        num_failed_cases++;
        expected_item.print();
        actual_item.print();
    end

endfunction
function void S_AES_Scoreboard::write (input S_AES_Seq_Item seq_item);
    `uvm_info("S_AES_Scoreboard", $sformatf("Data  Scoreboard plaintext : %0h , key0 : %0h and ciphertext  : %0h", seq_item.plaintext,seq_item.initialkey,seq_item.ciphertext ), UVM_NONE);
    actual_item.copy(seq_item);
    actual_item.print();
    expected_item=ref_model.encryption(seq_item);
    check_results();
    $display("num_passed_cases=%0d num_failed_cases=%0d",num_passed_cases,num_failed_cases);
endfunction

`endif //`ifndef S_AES_SCOREBOARD