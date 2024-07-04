# S-AES-Design-and-Verification-using-SystemVerilog-and-UVM
Simplified Advanced Encryption Standard (S-AES) Design and Verification Using System Verilog and UVM.

## UVM Architecture
![Copy of s aes uvm env - Page 1](https://github.com/OmniaMohamed12/S-AES-Design-and-Verification-using-SystemVerilog-and-UVM/assets/110364388/780c6516-966e-48be-88a7-e301bc2dcbd3)

## Coverage Results

- **Functional Coverage**:
  
   ![image](https://github.com/OmniaMohamed12/S-AES-Design-and-Verification-using-SystemVerilog-and-UVM/assets/110364388/6e027066-7b22-4875-b703-c135ec46676e)

- **Code Coverage**:
 
![image](https://github.com/OmniaMohamed12/S-AES-Design-and-Verification-using-SystemVerilog-and-UVM/assets/110364388/08d27a24-9756-45ab-a1e4-c49ca0313a63)

Detailed coverage reports can be found in the `sim` directory, specifically in the `code_cov_report.txt` file and `functional_cov_report.txt` file.

## Compilation and Simulation Steps

To compile the design and testbench, use the following command:

```bash
 vlog S_AES_Package.svh S_AES_Top.sv +cover
```
To simulate and run test with coverage analysis, use the following command:

```bash
vsim -batch S_AES_Top -coverage -do "run -all; coverage report -codeAll -cvg -verbose"
```
