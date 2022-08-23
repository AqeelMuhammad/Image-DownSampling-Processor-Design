module regr (
    input             clk, write_en,
    input      [15:0] data_in,
    output reg [15:0] data_out
    );
    
    always @(posedge clk) begin
        if (write_en == 1)
            data_out <= data_in;
    end
endmodule