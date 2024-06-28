/*######################################################################*\
## Class Name: S_AES_Coverage_Collector   
## Author : Omnia Mohamed
## Date: feb 2024
## 
\*######################################################################*/

`ifndef S_AES_Coverage_Collector
`define S_AES_Coverage_Collector
class S_AES_Coverage_Collector extends uvm_subscriber#(S_AES_Seq_Item);
    `uvm_component_utils(S_AES_Coverage_Collector)

    uvm_analysis_imp#(S_AES_Seq_Item,S_AES_Coverage_Collector) cov_analyais_imp;
    S_AES_Seq_Item item_cov;
    
    covergroup s_aes_cg;
	
        plaintext:coverpoint item_cov.plaintext;
        key:coverpoint item_cov.initialkey;
        ciphertext:coverpoint item_cov.ciphertext;
        
    endgroup

    extern function new(string name="S_AES_Coverage_Collector",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void write ( T t);
    extern function void report_phase (uvm_phase phase);

endclass:S_AES_Coverage_Collector
function S_AES_Coverage_Collector::new(string name="S_AES_Coverage_Collector",uvm_component parent=null);
    super.new(name,parent);
     s_aes_cg=new();
endfunction
function void S_AES_Coverage_Collector::build_phase(uvm_phase phase);
    super.build_phase(phase);
    cov_analyais_imp=new("cov_analyais_imp",this);
    item_cov=new("item_cov");
endfunction

function void S_AES_Coverage_Collector::write (T t);
   `uvm_info("S_AES_Coverage_Collector", $sformatf("  plaintext : %0h , key0 : %0h and ciphertext  : %0h", t.plaintext,t.initialkey,t.ciphertext ), UVM_NONE);
    item_cov.copy(t);
    item_cov.print();
    s_aes_cg.sample();
endfunction
function void S_AES_Coverage_Collector::report_phase (uvm_phase phase);
    `uvm_info("S_AES_Coverage_Collector", $sformatf("coverage =%0d", s_aes_cg.get_coverage), UVM_NONE);
endfunction
`endif //`ifndef S_AES_Coverage_Collector