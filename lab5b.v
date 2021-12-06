`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab5 b
//////////////////////////////////////////////////////////////////////////////////

module lab5b(
    input [3:0] SW,
    output[2:0] LED
    );

    wire e,f,g; 
    wire a1, a0, b1 ,b0; 

    assign a0 = SW[0]; 
    assign a1 = SW[1]; 
    assign b0 = SW[2]; 
    assign b1 = SW[3]; 

    assign LED[0] = e; 
    assign LED[1] = f; 
    assign LED[2] = g; 
   
    // e LED[0]
    assign e = (~b1 & ~b0 & ~a1 & ~a0) | 
               (~b1 & b0 & ~a1 & a0) | 
               ( b1 & ~b0 & a1 & ~a0) | 
               ( b1 & b0 & a1 & a0);
    // f LED[1]
    assign f = (~b1 & ~b0 & ~a1 & a0) | 
               (~b1 & ~b0 & a1 & ~a0) | 
               (~b1 & ~b0 & a1 & a0) | 
               (~b1 & b0 & a1 & ~a0) | 
               (~b1 & b0 & a1 & a0) | 
               ( b1 & ~b0 & a1 & a0); 
    // g LED[2]    
    assign g = ~e & ~f; 

endmodule 
