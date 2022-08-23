module bus(
    input               clk,
    input       [3:0]   read_en,
    input       [15:0]  r1,r2,r3,r4,r5,r,dar,ac,im,
    input       [7:0]   dm,
    output reg  [15:0]  bus_out
    );
    
    always @(*) begin
        case (read_en)
            4'd1:    bus_out <= dar;
            4'd2:    bus_out <= ac;
            4'd3:    bus_out <= r;
            4'd4:    bus_out <= r1;
            4'd5:    bus_out <= r2;
            4'd6:    bus_out <= r3;
            4'd7:    bus_out <= r4;
            4'd8:    bus_out <= r5;
            4'd9:    bus_out <= dm + 16'd0;
            4'd10:   bus_out <= im;
            default: bus_out <= 16'd0;
        endcase
    end
endmodule