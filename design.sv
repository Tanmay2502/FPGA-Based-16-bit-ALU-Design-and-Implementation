module alu(
    input [15:0] A, B, 
    input [2:0] op,
    output reg [15:0] Alu_out, 
    output reg [2:0] flags // [2] = Sign, [1] = Zero, [0] = Carry
);
    reg [16:0] temp; // Temporary register

    always @(*) begin
        flags = 3'b000;
        Alu_out = 16'h0000;

        case (op)
            3'b000: begin // Addition
                temp = {1'b0, A} + {1'b0, B};
                Alu_out = temp[15:0];
                flags[0] = temp[16];
                flags[2] = Alu_out[15]; 
                flags[1] = (Alu_out == 16'h0000) ? 1'b1 : 1'b0; 
            end
            
            3'b001: begin // Subtraction
                temp = {1'b0, A} - {1'b0, B};
                Alu_out = temp[15:0];
                flags[0] = temp[16]; 
                flags[2] = Alu_out[15]; 
                flags[1] = (Alu_out == 16'h0000) ? 1'b1 : 1'b0;
            end
            
            3'b010: begin // Compare A and B
                temp = {1'b0, A} - {1'b0, B};
                Alu_out =16'h0000;
                flags[0] = temp[16];
                flags[2] = Alu_out[15];
                flags[1] = (Alu_out == 16'h0000) ? 1'b1 : 1'b0;
            end
            
            3'b011: begin // Increment A
                temp = {1'b0, A} + 1;
                Alu_out = temp[15:0];
                flags[0] = temp[16];
                flags[2] = Alu_out[15];
                flags[1] = (Alu_out == 16'h0000) ? 1'b1 : 1'b0;
            end
            
            3'b100: begin // Bitwise AND
                Alu_out = A & B;
                flags[2] = Alu_out[15];
                flags[1] = (Alu_out == 16'h0000) ? 1'b1 : 1'b0;
            end
            
            3'b101: begin // Bitwise OR
                Alu_out = A | B;
                flags[2] = Alu_out[15];
                flags[1] = (Alu_out == 16'h0000) ? 1'b1 : 1'b0;
            end
            
            3'b110: begin // Bitwise NOT A
                Alu_out = ~A;
                flags[2] = Alu_out[15];
                flags[1] = (Alu_out == 16'h0000) ? 1'b1 : 1'b0;
            end
            
            3'b111: begin // Bitwise NOT B
                Alu_out = ~B;
                flags[2] = Alu_out[15];
                flags[1] = (Alu_out == 16'h0000) ? 1'b1 : 1'b0;
            end
            
            default: begin
                Alu_out = 16'h0000;
                flags = 3'b000;
            end
        endcase
    end
endmodule
