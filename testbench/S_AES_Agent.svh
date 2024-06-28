/*######################################################################*\
## Class Name: S_AES_Agent   
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/

`ifndef S_AES_AGENT
`define S_AES_AGENT
class S_AES_Agent extends uvm_agent;
    `uvm_component_utils(S_AES_Agent)

    S_AES_Driver driver;
    S_AES_Sequencer sequencer;
    S_AES_Monitor monitor;
    uvm_analysis_port#(S_AES_Seq_Item) agent_ap;

    extern function new(string name="S_AES_Agent",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
   
endclass:S_AES_Agent
function S_AES_Agent::new(string name="S_AES_Agent",uvm_component parent=null);
    super.new(name,parent);
endfunction
function void S_AES_Agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active == UVM_ACTIVE) begin
        driver=S_AES_Driver::type_id::create("driver",this);
        sequencer=S_AES_Sequencer::type_id::create("sequencer",this);
    end
    monitor=S_AES_Monitor::type_id::create("monitor",this);
    agent_ap=new("agent_ap",this);
endfunction
function void S_AES_Agent::connect_phase(uvm_phase phase);
    super.connect_phase (phase);
    if (get_is_active() == UVM_ACTIVE) begin
        driver.seq_item_port.connect(sequencer.seq_item_export);
    end
   monitor.mon_ap.connect(this.agent_ap);
endfunction
`endif//`ifndef S_AES_AGENT
