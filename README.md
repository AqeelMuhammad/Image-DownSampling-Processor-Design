# Image Down Sampling Processor Design

## About The Project

* This repository includes all the project files related to the development of a custom processor in Verilog HDL for image downsampling. 
* The project was done by a team of 4 undergraduates at the Department of Electronic and Telecommunication Engineering, University of Moratuwa, Sri Lanka for UOM's EN3030 Circuits and Systems Design module.
* The primary objective of this project was to design a processor which can downsample a given `256x256` greyscale 8-bit image. The coding was done using Verilog Hardware Description Language (HDL).  
* `Xilinx Vivado` was used as the analysis and synthesis tool for the design of the processor and for the simulation of Verilog HDL designs.

|*Original Image*|*Filtered Image*|*Down Sampled Image*|
|:----:|:----:|:----:|
| <img src="IO_Code/test.png"/> |<img src="IO_Code/filtered.png"/>|<img src="IO_Code/downsampled.png"/>|

## Getting Started

**Converting the 8-bit Input Image to its Binary Values** 

* `IO_Code` directory includes the python code `input_create.py` which converts the origanl input image to its binary values and save them in the `input.txt` text file.
* Copy this text file and paste it in your `<project_name>\<project_name>.sim\sim_1\behav\xsim` folder path of the vivado project created.

**Compiling the Assembly Code** 

* `Compiler` directory includes the text file `Assembly.txt` which includes the assembly code for image filtering and down sampling.

* In `compiler_bin.py` and `compiler_ram.py` python code files it contains the *opcodes* of each instruction. 

* Using `compiler_bin.py`, you can get the binary values of the assembly code according to the *opcodes* . The binary values will save in `output_bin.txt`.

* You can assign the `8'd` or `16'd` values for the assembly code to each memory location according to this *opcodes* using `compiler_ram.py`. This will create `output_bin.txt` as below.

```
ram[0] = 8'd38;
ram[1] = 16'd257;
ram[2] = 8'd9;
ram[3] = 8'd16;
          :
          :
          :
ram[169] = 8'd37;
ram[170] = 8'd49;
ram[171] = 8'd132;
ram[172] = 8'd51;    
```
* Copy everything in that `output_bin.txt`  file by pressing `Ctrl + A` and paste in between `begin` and `end` (line `10` to `183`) in the `instr_memory.v` file in `src` directory. This file can be opened using the vivado 's bult-in editor. Once the lines are replaced, save the file and run the simulation again. 

**Executing the Test Bench** 

* To simulate the processor, open Vivado software and load the project. Once the project is loaded, run the simulation.
* Once the simulation is complete, it will generate a text file named `output_downscaled.txt` in the  `<project_name>\<project_name>.sim\sim_1\behav\xsim` directory. It contains the 1D binary representation of the  resultatnt down sampled image of the original image that we have input to the simulation.
* To obtain the *filtered* image binary data, replace `loadim` with `endop` in `line 128` in the `Assembly.txt` and follow the above steps.

**Display the Outputs** 

* Copy and paste the `output_filtered.txt` and `output_downscaled.txt` files in the `IO_Code` directory and run the `show.py` python code to display the results.

## Resources

* You can use the `run.py` code in the `IO_Code` directory to filter and down sample the image using python.
* Block Diagrams and Final Report are included in the `Block_Diagram` and `Documentation` folders respectively.

### Contributors

1. [Muhammad Aqeel](https://github.com/AqeelMuhammad)
1. [Navindu Rasanjana](https://github.com/NavinduRasanjana)
1. [Tharuka Nilupul](https://github.com/TharukaN17)
1. [Hasantha Nadeeshan]()
