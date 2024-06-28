/*######################################################################*\
## Class Name: S_AES_Test   
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef S_AES_TEST
`define S_AES_TEST
class S_AES_Test extends uvm_test;
  `uvm_component_utils(S_AES_Test)

   S_AES_Env env;
   S_AES_Sequence seq;
  function new (string name = "S_AES_Test", uvm_component parent = null);
     super.new (name, parent);
  endfunction

  virtual function void build_phase (uvm_phase phase);
     super.build_phase(phase);
     env = S_AES_Env::type_id::create("env",this);
     configure_env();
     seq = S_AES_Sequence::type_id::create("seq");
  endfunction

  virtual task run_phase (uvm_phase phase);
     seq.num_transactions = 200;
     phase.raise_objection(this);
     seq.start(env.agent.sequencer);
     #50;
     seq.start(env.agent.sequencer);
     #50;
     seq.start(env.agent.sequencer);
     #50;
     phase.drop_objection(this);
    
  endtask

  function void configure_env();
     uvm_config_db#(bit)::set(this,"*","agent_is_active", 1'b1);
  endfunction
endclass
`endif // `ifndef S_AES_TEST