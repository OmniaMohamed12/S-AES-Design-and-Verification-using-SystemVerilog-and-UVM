/*######################################################################*\
## Class Name: S_AES_Env   
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/

`ifndef S_AES_ENV
`define S_AES_ENV
class S_AES_Env extends uvm_env;
    `uvm_component_utils(S_AES_Env)

    S_AES_Agent agent;
    S_AES_Scoreboard scb;
    S_AES_Coverage_Collector cov;
    bit agent_is_active=1'b0;

    
    extern function new(string name="S_AES_Env",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    
endclass:S_AES_Env
function S_AES_Env::new(string name="S_AES_Env",uvm_component parent=null);
    super.new(name,parent);
endfunction
function void S_AES_Env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(bit)::get(this,"","agent_is_active",agent_is_active))
        `uvm_fatal("NoEnvConfig","No set for the parameter agent_is_active")  
    agent = S_AES_Agent::type_id::create("agent",this);
    if (agent_is_active)
        agent.is_active = UVM_ACTIVE;
    else
        agent.is_active = UVM_PASSIVE;
   
   // create scb and cov
   scb=S_AES_Scoreboard::type_id::create("scb",this);
   cov=S_AES_Coverage_Collector::type_id::create("cov",this);
  endfunction
function void S_AES_Env::connect_phase(uvm_phase phase);
    super.connect_phase (phase);
    agent.agent_ap.connect(scb.scb_analyais_imp);
    agent.agent_ap.connect(cov.cov_analyais_imp);
endfunction
`endif//`ifndef S_AES_Env
