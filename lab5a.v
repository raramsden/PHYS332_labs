`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab5 a & b
//////////////////////////////////////////////////////////////////////////////////


module lab5a(
    input [7:0] SW,
    output [7:0] LED,
    output LED16_B, 
    output LED16_G,
    output LED16_R
    );
    
    assign LED[0] = SW[0];
    assign LED[1] = SW[1];
    assign LED[2] = SW[2];
    assign LED[3] = SW[3];
    
    assign LED16_B = SW[0] & SW [1];
    assign LED16_G = SW[0] & SW [2];
    assign LED16_R = SW[0] & SW [3];
    
endmodule
