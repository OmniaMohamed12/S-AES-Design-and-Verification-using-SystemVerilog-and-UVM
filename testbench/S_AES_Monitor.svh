/*######################################################################*\
## Class Name: S_AES_Monitor   
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef S_AES_Monitor
`define S_AES_Monitor
class S_AES_Monitor  extends uvm_monitor;
    `uvm_component_utils(S_AES_Monitor)

    S_AES_Seq_Item seq_item;
    virtual S_AES_IF vif;
    uvm_analysis_port #(S_AES_Seq_Item) mon_ap;

    extern function new(string name="S_AES_Monitor",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    

endclass:S_AES_Monitor
function S_AES_Monitor::new(string name="S_AES_Monitor",uvm_component parent=null);
        super.new(name,parent);
        
endfunction
function void S_AES_Monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual S_AES_IF)::get(this,"","vif",vif))
        `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
        seq_item=new("seq_item");
        mon_ap=new("mon_ap",this);
endfunction
task S_AES_Monitor::run_phase(uvm_phase phase);
    forever begin
        #2;
        seq_item.plaintext = vif.plaintext;
        seq_item.initialkey = vif.initialkey;
        seq_item.ciphertext = vif.ciphertext;
        mon_ap.write(seq_item);
        `uvm_info("S_AES_Monitor","S_AES_Monitor got the requested item", UVM_LOW)
        `uvm_info("MON", $sformatf("Data send to Scoreboard plaintext : %0h , key0 : %0h and ciphertext  : %0h", seq_item.plaintext,seq_item.initialkey,seq_item.ciphertext ), UVM_NONE);
        seq_item.print();
        seq_item=new("seq_item");
    end
endtask
`endif//`ifndef S_AES_Monitor