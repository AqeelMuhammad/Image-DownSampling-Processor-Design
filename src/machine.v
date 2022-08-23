module machine(
	input 		   clk,
	input  [1:0]   status,
	input  [7:0]   data_in,
	input  [15:0]  data_addr_in,
	output 		   end_process,
	output [7:0]   data_out
	);
	
	wire 		dm_en;
	wire 		im_en;
	wire [15:0] pc_out;
	wire [15:0] dar_out;
	wire [15:0] bus_out;
	wire [7:0]  dm_out;
	wire [15:0] im_out;
	
	assign data_out = dm_out;
	
	processor    processor    (.clk(clk),.dm_out(dm_out),.im_out(im_out),.data_in(data_in),.data_addr_in(data_addr_in),.status(status), 
	                           .dm_en(dm_en),.im_en(im_en),.pc_out(pc_out),.dar_out(dar_out),.bus_out(bus_out),.end_process(end_process));

	data_memory  data_memory  (.clk(clk),.write_en(dm_en),.addr(dar_out),.data_in(bus_out),.data_out(dm_out));

	instr_memory instr_memory (.clk(clk),.write_en(im_en),.addr(pc_out),.instr_in(bus_out),.instr_out(im_out));
endmodule