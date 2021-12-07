`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab6 Full Adder
//////////////////////////////////////////////////////////////////////////////////

module FullAdder(
//inputs
    input A,
    input B,
    input C_IN,
//outputs
    output C_OUT,
    output S
    );
    
    assign C_OUT = (A & B)|(C_IN & B)|(C_IN & A);
    assign S = (~A & ~B & C_IN)|(~A & B & ~C_IN)|(A & B & C_IN)|(A & ~B & ~C_IN);
   
endmodule

 /////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: lab6 Display set up
//////////////////////////////////////////////////////////////////////////////////

module Display(
//inputs
    input S0,
    input S1,
    input S2,
    input S3,
//outputs
    output DA,
    output DB,
    output DC,
    output DD,
    output DE,
    output DF,
    output DG
    );

    wire zero, one, two, three, four, five, six, seven, eight, nine;
    
//assigning each wire switches
    assign zero  = ~S3 & ~S2 & ~S1 & ~S0;
    assign one   = ~S3 & ~S2 & ~S1 &  S0;
    assign two   = ~S3 & ~S2 &  S1 & ~S0;
    assign three = ~S3 & ~S2 &  S1 &  S0;
    assign four  = ~S3 &  S2 & ~S1 & ~S0;
    assign five  = ~S3 &  S2 & ~S1 &  S0;
    assign six   = ~S3 &  S2 &  S1 & ~S0;
    assign seven = ~S3 &  S2 &  S1 &  S0;
    assign eight =  S3 & ~S2 & ~S1 & ~S0;
    assign nine  =  S3 & ~S2 & ~S1 &  S0;
    
//assigning each output with our wires
    assign DA = zero | two   | three | five  | six   | seven | eight | nine;
    assign DB = zero | one   | two   | three | four  | seven | eight | nine;
    assign DC = zero | one   | three | four  | five  | six   | seven | eight | nine;
    assign DD = zero | two   | three | five  | six   | eight;
    assign DE = zero | two   | six   | eight;
    assign DF = zero | four  | five  | six   | eight | nine;
    assign DG = two  | three | four  | five  | six   | eight | nine;
endmodule

 /////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Module Name: Lab6 Test 
// LEDs, Switches, ANs, Global inputs/outputs
// using FullAdder.v and Display.v
//////////////////////////////////////////////////////////////////////////////////

module Lab6Test(
// input switches
    input [7:0] SW,
// outputs--LED, AN, CA-CG
    output [3:0] LED,
    output [7:0] AN,
    output CA,
    output CB,
    output CC,
    output CD,
    output CE,
    output CF,
    output CG
    );
    
    wire A0, A1, A2, A3, B0, B1, B2, B3;
    wire S0, S1, S2, S3, C1, C2, C3, cout;

// A0-A3, B0-B3 GLOBAL inputs
    assign A0 = SW[0];
    assign A1 = SW[1];
    assign A2 = SW[2];
    assign A3 = SW[3];
    assign B0 = SW[4];
    assign B1 = SW[5];
    assign B2 = SW[6];
    assign B3 = SW[7];

// LED[0-3] GLOBAL outputs
    assign LED[0] = S0;
    assign LED[1] = S1;
    assign LED[2] = S2;
    assign LED[3] = S3;
    
    assign DP = 1'b1;
    
    wire DA, DB, DC, DD, DE, DF, DG;

//first-fourth adders, create the Display
    FullAdder first  (A0, B0, 0,  C1, S0);
    FullAdder second (A1, B1, C1, C2, S1);
    FullAdder third  (A2, B2, C2, C3, S2);
    FullAdder fourth (A3, B3, C3, cout, S3);
    Display   create (S0, S1, S2, S3, DA, DB, DC, DD, DE, DF, DG);
    
    assign CA = ~DA;
    assign CB = ~DB;
    assign CC = ~DC;
    assign CD = ~DD;
    assign CE = ~DE;
    assign CF = ~DF;
    assign CG = ~DG;
    
    assign AN[0]   = 1'b0;
    assign AN[7:1] = 7'b111_1111;
    
endmodule
