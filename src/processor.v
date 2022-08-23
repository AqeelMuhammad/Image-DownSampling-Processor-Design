 module processor (
    input        clk,
    input [7:0]  dm_out, data_in,
    input [15:0] im_out, data_addr_in,
    input [1:0]  status,

    output reg        dm_en, im_en,
    output     [15:0] pc_out,
    output reg [15:0] dar_out, bus_out,
    output            end_process
    );

    wire [2:0]  alu_op;
    wire [15:0] alu_out;
    wire [15:0] dar_wire;
    wire [15:0] bus_wire;
    
    wire [15:0] regr_out;
    wire [15:0] regr1_out;
    wire [15:0] regr2_out;
    wire [15:0] regr3_out;
    wire [15:0] regr4_out;
    wire [15:0] regr5_out;
    
    wire [15:0] ac_out;

    wire [15:0] ir_out;

    wire [15:0] write_en ;
    wire [3:0]  read_en;
    wire [7:0]  inc_en;

    wire        z;
    
    regr    reg_r    (.clk(clk), .write_en (write_en[5]),.data_in(bus_wire),.data_out(regr_out ));

    regrinc regr_r1  (.clk(clk), .write_en (write_en[6]),.data_in(bus_wire),.data_out(regr1_out),
                      .inc_en(inc_en[4]));

    regrinc regr_r2  (.clk(clk), .write_en (write_en[7]),.data_in(bus_wire),.data_out(regr2_out),
                      .inc_en(inc_en[5]));

    regrinc regr_r3  (.clk(clk), .write_en (write_en[8]),.data_in(bus_wire),.data_out(regr3_out),
                      .inc_en(inc_en[6]));

    regr    regr_r4  (.clk(clk), .write_en (write_en[9]),.data_in(bus_wire),.data_out(regr4_out ));

    regr    regr_r5  (.clk(clk), .write_en (write_en[10]),.data_in(bus_wire),.data_out(regr5_out ));

    regrinc dar      (.clk(clk), .write_en (write_en[2]),.data_in(bus_wire),.data_out(dar_wire),.inc_en(inc_en[3]));

    regr    ir       (.clk(clk), .write_en (write_en[3]),.data_in(bus_wire),.data_out(ir_out));

    bus     bus1     (.r1(regr1_out ),.r2(regr2_out ),.r3(regr3_out ),.r4(regr4_out ),.r5(regr5_out ),.r(regr_out ),
                      .dar(dar_out),.ac(ac_out),.dm(dm_out),.im(im_out),.bus_out(bus_wire),.read_en(read_en),.clk(clk));

    ac      ac1      (.clk(clk), .write_en (write_en[4]),.data_in(bus_wire),.data_out(ac_out),.alu_out(alu_out),
                      .alu_to_ac (write_en[13]),.inc_en(inc_en[2]));

    regrinc pc       (.clk(clk), .write_en (write_en[1]),.data_in(bus_wire),.data_out(pc_out),.inc_en(inc_en[1]));

    alu     alu1     (.clk(clk),.in1(regr_out ),.in2(ac_out),.alu_op(alu_op),.alu_out(alu_out),.z(z));

    control control1 (.clk(clk),.z(z),.instruction (ir_out),.alu_op(alu_op),.write_en (write_en ),
                      .read_en(read_en),.inc_en(inc_en),.end_process (end_process ),.status(status));

    always @ (posedge clk)
        if (status == 2'b01) begin
            dm_en   <= write_en [11];
            im_en   <= 1'b0;
            dar_out <= dar_wire;
            bus_out <= bus_wire;
        end
        else if (status == 2'b10) begin
            dm_en   <= 1'b1;
            im_en   <= 1'b0;
            bus_out <= data_in;
            dar_out <= data_addr_in;
        end
        else if (status == 2'b11) begin
            dm_en   <= 1'b0;
            im_en   <= 1'b0;
            dar_out <= data_addr_in;
        end
endmodule
