module control(
    input             clk, z,
    input      [15:0] instruction,
    input      [1:0]  status,
    output reg [2:0]  alu_op,
    output reg [7:0]  inc_en,
    output reg [15:0] write_en,
    output reg [3:0]  read_en,
    output reg        end_process
    );
    
    reg [5:0] present = 6'd0;
    reg [5:0] next    = 6'd0;
    
    parameter
    idle       = 6'd0,
    fetch1     = 6'd1,
    fetch2     = 6'd2,
    fetch3     = 6'd3,
    loadac1    = 6'd4,
    loadac2    = 6'd5,
    loadac3    = 6'd6,
    loadac4    = 6'd7,
    movacr     = 6'd8,
    movacr1    = 6'd9,
    movacr2    = 6'd10,
    movacr3    = 6'd11,
    movacr4    = 6'd12,
    movacr5    = 6'd13,
    movacdar   = 6'd14,
    movrac     = 6'd15,
    movr1ac    = 6'd16,
    movr2ac    = 6'd17,
    movr3ac    = 6'd18,
    movr4ac    = 6'd19,
    movr5ac    = 6'd20,
    movdarac   = 6'd21,
    stac1      = 6'd22,
    stac2      = 6'd23,
    stac3      = 6'd24,
    add1       = 6'd25,
    add2       = 6'd26,
    sub1       = 6'd27,
    sub2       = 6'd28,
    lshift1    = 6'd29,
    lshift2    = 6'd30,
    rshift1    = 6'd31,
    rshift2    = 6'd32,
    incac      = 6'd33,
    incdar     = 6'd34,
    incr1      = 6'd35,
    incr2      = 6'd36,
    incr3      = 6'd37,
    loadim1    = 6'd38,
    loadim2    = 6'd39,
    loadim3    = 6'd40,
    jumpz1     = 6'd41,
    jumpz2     = 6'd42,
    jumpz3     = 6'd43,
    jumpz4     = 6'd44,
    jumpz5     = 6'd45,
    jumpz6     = 6'd46,
    jumpz7     = 6'd47,
    jumpnz1    = 6'd48,
    jump       = 6'd49,
    nop        = 6'd50,
    endop      = 6'd51;
    
    always @(posedge clk)
        present <= next;
    
    always @(posedge clk) begin
        if (present == endop)
        end_process <= 1'd1;
        else
        end_process <= 1'd0;
    end
    
    always @(present or z or instruction or status)
    case(present)
        idle: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            if (status == 2'b01)
                next <= fetch1;
            else
                next <= idle;
        end

        fetch1: begin
            read_en  <=  4'd10;
            write_en <= 16'b0000000000001000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= fetch2;
        end

        fetch2: begin
            read_en  <=  4'd10;
            write_en <= 16'b0000000000001000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= fetch3;
        end

        fetch3: begin
            read_en  <=  4'd10;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= instruction [5:0];
        end

        loadac1: begin 
            read_en  <=  4'd2;
            write_en <= 16'b0000000000000100;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= loadac2;
        end

        loadac2 : begin 
            read_en  <=  4'd2;
            write_en <= 16'b0000000000000100;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= loadac3;
        end

        loadac3 : begin
            read_en  <=  4'd9;
            write_en <= 16'b0000000000010000; 
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= loadac4;
        end

        loadac4: begin
            read_en  <=  4'd9;
            write_en <= 16'b0000000000010000; 
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
        end

        movacr: begin
            read_en  <=  4'd2;
            write_en <= 16'b0000000000100000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
        end

        movacr1: begin
            read_en  <=  4'd2;
            write_en <= 16'b0000000001000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
        end

        movacr2: begin
            read_en  <=  4'd2;
            write_en <= 16'b0000000010000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
        end

        movacr3: begin
            read_en  <=  4'd2;
            write_en <= 16'b0000000100000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
        end

        movacr4: begin
            read_en  <=  4'd2;
            write_en <= 16'b0000001000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
        end

        movacr5: begin
            read_en  <=  4'd2;
            write_en <= 16'b0000010000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         movacdar : begin
            read_en  <=  4'd2;
            write_en <= 16'b0000000000000100;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         movrac: begin
            read_en  <=  4'd3;
            write_en <= 16'b0000000000010000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         movr1ac: begin
            read_en  <=  4'd4;
            write_en <= 16'b0000000000010000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         movr2ac: begin
            read_en  <=  4'd5;
            write_en <= 16'b0000000000010000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         movr3ac: begin
            read_en  <=  4'd6;
            write_en <= 16'b0000000000010000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         movr4ac: begin
            read_en  <=  4'd7;
            write_en <= 16'b0000000000010000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         movr5ac: begin
            read_en  <=  4'd8;
            write_en <= 16'b0000000000010000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         movdarac : begin
            read_en  <=  4'd1;
            write_en <= 16'b0000000000010000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         stac1: begin
            read_en  <=  4'd2;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= stac2;
         end

         stac2: begin
            read_en  <=  4'd2;
            write_en <= 16'b0000100000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= stac3;
         end

         stac3: begin
            read_en  <=  4'd2;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         add1: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd1;
            next     <= add2;
         end

         add2: begin
            read_en  <=  4'd0;
            write_en <= 16'b0010000000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd1;
            next     <= fetch1;
         end

         sub1: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd2;
            next     <= sub2;
         end

         sub2: begin
            read_en  <=  4'd0;
            write_en <= 16'b0010000000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd2;
            next     <= fetch1;
         end

         lshift1: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd3;
            next     <= lshift2;
         end

         lshift2: begin
            read_en  <=  4'd0;
            write_en <= 16'b0010000000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd3;
            next     <= fetch1;
         end

         rshift1: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd4;
            next     <= rshift2;
         end

         rshift2: begin
            read_en  <=  4'd0;
            write_en <= 16'b0010000000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd4;
            next     <= fetch1;
         end

         incac: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000110;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end
            
         incdar: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00001010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         incr1: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00010010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         incr2: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00100010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         incr3: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b01000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         loadim1: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= loadim2;
         end

         loadim2: begin
            read_en  <=  4'd10;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= loadim3;
         end

         loadim3: begin
            read_en  <=  4'd10;
            write_en <= 16'b0000000000010000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
         end

         jump: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= jumpz2;
         end
            
         jumpz1: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            if (z == 1)
                next <= jumpz2;
            else
                next <= jumpz6;
         end

         jumpnz1: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000010;
            alu_op <=  3'd0;
            if (z == 0)
                next <= jumpz3;
            else
                next <= jumpz7;
         end

         jumpz2: begin
            read_en  <=  4'd10;
            write_en <= 16'b0000000000000010;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= jumpz3;
         end

         jumpz3: begin
            read_en  <=  4'd10;
            write_en <= 16'b0000000000000010;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= jumpz4;
         end

         jumpz4: begin
            read_en  <=  4'd10;
            write_en <= 16'b0000000000001000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= jumpz5;
         end

         jumpz5: begin
            read_en  <=  4'd10;
            write_en <= 16'b0000000000001000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= fetch3;
         end

         jumpz6: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= jumpz7;
         end
            
         jumpz7: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en  <= 16'b00000010;
            alu_op  <=  3'd0;
            next    <= jumpz4;
        end

        nop: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000010;
            alu_op   <=  3'd0;
            next     <= fetch1;
        end

        endop: begin
            read_en  <=  4'd9;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= endop;
        end

        default: begin
            read_en  <=  4'd0;
            write_en <= 16'b0000000000000000;
            inc_en   <=  8'b00000000;
            alu_op   <=  3'd0;
            next     <= fetch1;
        end        
    endcase
endmodule