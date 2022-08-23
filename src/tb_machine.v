`timescale 1 ns / 1 ps

module tb_machine();
	reg        clk;
	reg [1:0]  status;
	reg [15:0] addr;
	reg [7:0]  data;
	
	wire       end_process;
	wire [7:0] out;
	
	integer    f;
	reg [7:0]  read_data [0:65535];
	
	machine dut(clk, status, data, addr, end_process, out);
	
	initial begin
        clk = 0;
        forever clk = #(50) ~clk;
    end
    
    initial begin
        $readmemb("image.txt", read_data);
        f = $fopen("output_downscaled.txt", "w");
//        f = $fopen("output_filtered.txt", "w");
        status = 2'b10;
    end
    
    integer i;
    initial begin
        for (i=0;i<256*256;i=i+1) begin
            addr = i;
            data = read_data[i];
            #100;
        end
        status = 2'b01;
        while (end_process != 1'b1) begin
            #100;
        end
        status = 2'b11;
        for (i=0;i<128*128;i=i+1) begin
//        for (i=0;i<256*256;i=i+1) begin
            addr = i;
            #200
            $fwrite(f, "%u\n", out);
        end
        $fclose(f);
    end 
endmodule