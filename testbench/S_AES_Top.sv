
`include "uvm_macros.svh"
import uvm_pkg::*;

`include "S_AES_IF.svh"
import S_AES_Package::*;
`include "S_AES_Encryption.sv"

module S_AES_Top;

 S_AES_IF ifc();
 S_AES_Ecryption encrypt(ifc.initialkey,ifc.plaintext,ifc.ciphertext);
 
 initial begin
  uvm_config_db#(virtual S_AES_IF)::set(null,"*","vif", ifc);
  run_test("S_AES_Test");
 end

endmodule : S_AES_Top