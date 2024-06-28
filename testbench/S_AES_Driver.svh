/*######################################################################*\
## Class Name: S_AES_Driver   
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/

`ifndef S_AES_DRIVER
`define S_AES_DRIVER
class S_AES_Driver  extends uvm_driver#(S_AES_Seq_Item);
    `uvm_component_utils(S_AES_Driver)
    S_AES_Seq_Item seq_item;
    virtual S_AES_IF vif;
    extern function new(string name="S_AES_Driver",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    extern task drive_item(input S_AES_Seq_Item seq_item);

endclass:S_AES_Driver
function S_AES_Driver::new(string name="S_AES_Driver",uvm_component parent=null);
        super.new(name,parent);
        
endfunction
function void S_AES_Driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual S_AES_IF)::get(this,"","vif",vif))
        `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
endfunction
task S_AES_Driver::run_phase(uvm_phase phase);
    forever begin
    // Get the next data item from sequencer
    `uvm_info("S_AES_Driver","S_AES_Driver is requesting an item", UVM_LOW)
    seq_item_port.get_next_item(seq_item);
    `uvm_info("S_AES_Driver","S_AES_Driver got the requested item", UVM_LOW)
    seq_item.print();
    drive_item(seq_item);
    seq_item_port.item_done();
    #2;
    end
endtask
task S_AES_Driver::drive_item(input S_AES_Seq_Item seq_item);
    vif.plaintext <= seq_item.plaintext;
    vif.initialkey <= seq_item.initialkey;
endtask
`endif//`ifndef S_AES_DRIVER