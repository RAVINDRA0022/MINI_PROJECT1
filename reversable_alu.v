`timescale 1ns / 1ps

module basic_alu_unit (
    input [7:0] a,      
    input [7:0] b,       
    input [2:0] sel,    
    output reg [7:0] out 
);

    wire [7:0] x1, x2, x3;
    wire [7:0] y1, y2, y3;
    
   
    peres_gate pg1 (
        .a(1'b0),
        .b(b),
        .c(c), // dummy input for Peres gate
        .x(x1),
        .y(x2),
        .z(x3)
    );
    
    fredkin_gate fg1 (
        .a(1'b0),
        .b(b),
        .c(c), // dummy input for Fredkin gate
        .x(y1),
        .y(y2),
        .z(y3)
    );
    
    always @(*) begin
        case(sel)
            3'b000: out = a + b;                  // Addition
            3'b001: out = a - b;                  // Subtraction
            3'b010: out = a * b;                  // Multiplication
            3'b011: out = (b != 0) ? a / b : 8'b0; // Division 
            3'b100: out = a << 1;                 // Left shift
            3'b101: out = a >> 1;                 // Right shift
            3'b110: out =  ~(a & b);                //Bitwise AND
            3'b111: out = (a ^ b);                 // xor
            default: out = 8'b0;                  // Default case (zero output)
        endcase
    end

endmodule

// Peres gate module
module peres_gate (
    input [7:0] a, b, c,
    output [7:0] x, y, z
);
    assign x = a;                
    assign y = a ^ b;          
    assign z = (a & b) ^ c;  
endmodule

// Fredkin gate module
module fredkin_gate (
    input [7:0] a, b, c,
    output [7:0] x, y, z
);
    wire [7:0] a1;
    assign a1 = ~a;              
    assign x = a;              
    assign y = (a1 & b) | (a & c); 
    assign z = (a & b) | (a1 & c); 
endmodule
