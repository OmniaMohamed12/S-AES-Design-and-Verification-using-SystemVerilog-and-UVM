/*######################################################################*\
## Class Name: S_AES_Reference_Model   
## Author : Omnia Mohamed
## Date: March 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef S_AES_Reference_Model
`define S_AES_Reference_Model
class S_AES_Reference_Model extends uvm_component;
    `uvm_component_utils(S_AES_Reference_Model)

    
    extern function new(string name="S_AES_Reference_Model",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern function  logic[3:0] s_box(input logic[3:0] in);
    extern function logic[15:0]  key1_generation (input logic[15:0] key0);
    extern function logic[15:0]  key2_generation (input logic[15:0] key1);
    extern function  logic[15:0] add_round_key(input logic[15:0] in_text,key);
    extern function  logic[15:0] nibble_substitution(input logic[15:0] in);
    extern function  logic[15:0] shift_row(input logic[15:0] in);
    extern function  logic[3:0] multiply_4(input logic[3:0] in);
    extern function  logic[15:0] mix_columns(input logic[15:0] in);
    extern function  logic[15:0]  round1(input logic[15:0] in, input logic[15:0] key1);
    extern function  logic[15:0]  round2(input logic[15:0] in,logic[15:0] key2);
    extern function S_AES_Seq_Item encryption (input S_AES_Seq_Item item);

endclass:S_AES_Reference_Model

function S_AES_Reference_Model::new(string name="S_AES_Reference_Model",uvm_component parent=null);
    super.new(name,parent);
endfunction

function void S_AES_Reference_Model::build_phase(uvm_phase phase);
    super.build_phase(phase);
   
endfunction

function  logic[3:0] S_AES_Reference_Model::s_box(input logic[3:0] in);
    case(in)
        4'b0000: s_box=4'h9;
        4'b0001: s_box=4'h4;
        4'b0010: s_box=4'ha;
        4'b0011: s_box=4'hb;
        4'b0100: s_box=4'hd;
        4'b0101: s_box=4'h1;
        4'b0110: s_box=4'h8;
        4'b0111: s_box=4'h5;
        4'b1000: s_box=4'h6;
        4'b1001: s_box=4'h2;
        4'b1010: s_box=4'h0;
        4'b1011: s_box=4'h3;
        4'b1100: s_box=4'hc;
        4'b1101: s_box=4'he;
        4'b1110: s_box=4'hf;
        4'b1111: s_box=4'h7;
    endcase
endfunction:s_box

function logic[15:0]  S_AES_Reference_Model::key1_generation (input logic[15:0] key0);
logic [7:0] w0 =key0[15:8];
logic [7:0] w1=key0[7:0];
logic [7:0] rcon1=8'h80;
key1_generation[15:8] = key0[15:8] ^ rcon1 ^ {s_box(key0[3:0]),s_box(key0[7:4])};
key1_generation[7:0] = key1_generation[15:8] ^ key0[7:0];
endfunction:key1_generation

function logic[15:0]  S_AES_Reference_Model::key2_generation (input logic[15:0] key1);
logic [7:0] rcon2=8'h30;
key2_generation[15:8] = key1[15:8] ^ rcon2 ^ {s_box(key1[3:0]),s_box(key1[7:4])};
key2_generation[7:0] = key2_generation[15:8] ^ key1[7:0];
endfunction:key2_generation

function  logic[15:0] S_AES_Reference_Model::add_round_key(input logic[15:0] in_text,key);
    add_round_key= in_text ^ key;
endfunction:add_round_key

function  logic[15:0] S_AES_Reference_Model::nibble_substitution(input logic[15:0] in);
    nibble_substitution= {s_box(in[15:12]),s_box(in[11:8]),s_box(in[7:4]),s_box(in[3:0])};
endfunction:nibble_substitution

function  logic[15:0] S_AES_Reference_Model::shift_row(input logic[15:0] in);
    shift_row={in[15:12],in[3:0],in[7:4],in[11:8]};

endfunction:shift_row

function  logic[3:0] S_AES_Reference_Model::multiply_4(input logic[3:0] in);
    case(in)
        4'h0: multiply_4=4'h0;
        4'h1: multiply_4=4'h4;
        4'h2: multiply_4=4'h8;
        4'h3: multiply_4=4'hC;
        4'h4: multiply_4=4'h3;
        4'h5: multiply_4=4'h7;
        4'h6: multiply_4=4'hB;
        4'h7: multiply_4=4'hF;
        4'h8: multiply_4=4'h6;
        4'h9: multiply_4=4'h2;
        4'hA: multiply_4=4'hE;
        4'hB: multiply_4=4'hA;
        4'hC: multiply_4=4'h5;
        4'hD: multiply_4=4'h1;
        4'hE: multiply_4=4'hD;
        4'hF: multiply_4=4'h9;
    endcase
endfunction:multiply_4

function  logic[15:0] S_AES_Reference_Model::mix_columns(input logic[15:0] in);
    mix_columns[15:12]= in[15:12] ^ multiply_4(in[11:8]);
    mix_columns[11:8]= in[11:8] ^ multiply_4(in[15:12]);
    mix_columns[7:4]= in[7:4] ^ multiply_4(in[3:0]);
    mix_columns[3:0]= in[3:0] ^ multiply_4(in[7:4]);

endfunction:mix_columns

function  logic[15:0]  S_AES_Reference_Model::round1(input logic[15:0] in,key1);
    round1=add_round_key(mix_columns(shift_row(nibble_substitution(in))),key1);

endfunction:round1

function  logic[15:0]  S_AES_Reference_Model::round2(input logic[15:0] in,key2);
    round2=add_round_key(shift_row(nibble_substitution(in)),key2);

endfunction:round2

function S_AES_Seq_Item  S_AES_Reference_Model::encryption (input S_AES_Seq_Item item);

    logic[15:0] key1;
    logic[15:0] key2;
    logic[15:0] out_add_round0;
    logic[15:0] out_round1;
    key1=key1_generation(item.initialkey);
    key2=key2_generation(key1);
    out_add_round0=add_round_key(item.plaintext,item.initialkey);
    out_round1=round1(out_add_round0,key1);
    item.ciphertext=round2(out_round1,key2);
    `uvm_info("S_AES_Refernce_Modal", $sformatf("Expected output >>  plaintext : %0h , key0 : %0h and ciphertext  : %0h", item.plaintext,item.initialkey,item.ciphertext ), UVM_NONE);
    item.print();
    return item;

endfunction


`endif //`ifndef S_AES_Reference_Modal