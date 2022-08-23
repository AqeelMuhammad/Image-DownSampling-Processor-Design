module ac(
    input               clk, write_en, alu_to_ac,inc_en,
    input       [15:0]  data_in, alu_out,
    output reg  [15:0]  data_out = 16'd0
    );
    
    always @(posedge clk) begin
        if (inc_en == 1)
            data_out <= data_out + 16'd1;
        else if (write_en == 1)
            data_out <= data_in;
        else if (alu_to_ac == 1)
            data_out <= alu_out;
    end
endmodule