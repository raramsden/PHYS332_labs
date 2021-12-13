`timescale 1ns / 1ps

module display(
  input CLK100MHZ,
  input [5:0] SW,
  output CA,CB,CC,CD,CE,CF,CG,DP,
  output [7:0] AN 
  );

  wire d1a, d1b, d1c, d1d, d1e, d1f, d1g;
  wire d2a, d2b, d2c, d2d, d2e, d2f, d2g;

  reg [7:0] allAN;
  reg [6:0] allCAs;
  reg ctr = 0;


  clock100MHz_to_1kHz setClock(CLK100MHZ, clock);

  display_setup firstDisplay(SW[3], SW[2], SW[1], SW[0], d1a, d1b, d1c, d1d, d1e, d1f, d1g);
  display_setup secondDisplay(0,0, SW[5], SW[4], d2a, d2b, d2c, d2d, d2e, d2f, d2g);

  assign AN[7:0] = allAN[7:0];
  assign CG = allCAs[0];
  assign CF = allCAs[1];
  assign CE = allCAs[2];
  assign CD = allCAs[3];
  assign CC = allCAs[4];
  assign CB = allCAs[5];
  assign CA = allCAs[6];
  assign DP=1'b1;

  always @(posedge clock) begin

    if(ctr == 0) begin
        allAN <= 8'b1111_1110;
        allCAs[6] <= ~d1a;
        allCAs[5] <= ~d1b;
        allCAs[4] <= ~d1c;
        allCAs[3] <= ~d1d;
        allCAs[2] <= ~d1e;
        allCAs[1] <= ~d1f;
        allCAs[0] <= ~d1g;
    
    end else if(ctr == 1) begin
        allAN <= 8'b1111_1101;
        allCAs[6] <= ~d2a;
        allCAs[5] <= ~d2b;
        allCAs[4] <= ~d2c;
        allCAs[3] <= ~d2d;
        allCAs[2] <= ~d2e;
        allCAs[1] <= ~d2f;
        allCAs[0] <= ~d2g;
    end
    
    ctr <= ctr + 1;
  end
endmodule


//100 MHz to 1 kHz
//17 bits needed since 100 MHz to 1 kHz is 100,000 cycles (log2(100,000) = 16.6)
module clock100MHz_to_1kHz(
    input CLK_100MHZ,
    output reg clock1kHz
    );

    reg[16:0] ctr;
    
    always @(posedge CLK_100MHZ) begin
        if (ctr == 49_999) begin
            clock1kHz <= 1'b1;
            ctr <= ctr + 1;
        end else if (ctr == 99_999) begin
            clock1kHz <= 1'b0;
            ctr <= 0;
        end else begin
            ctr <= ctr + 1;
        end
    end
endmodule


module display_setup(
    input s3,
    input s2,
    input s1,
    input s0, 
    output da,
    output db,
    output dc,
    output dd,
    output de,
    output df,
    output dg);

    wire zero, one, two, three, four, five, six, seven, eight, nine;
    assign zero     = ~s3 & ~s2 & ~s1 & ~s0;
    assign one      = ~s3 & ~s2 & ~s1 &  s0;
    assign two      = ~s3 & ~s2 &  s1 & ~s0;
    assign three    = ~s3 & ~s2 &  s1 &  s0;
    assign four     = ~s3 &  s2 & ~s1 & ~s0;
    assign five     = ~s3 &  s2 & ~s1 &  s0;
    assign six      = ~s3 &  s2 &  s1 & ~s0;
    assign seven    = ~s3 &  s2 &  s1 &  s0;
    assign eight    =  s3 & ~s2 & ~s1 & ~s0;
    assign nine     =  s3 & ~s2 & ~s1 &  s0;
    assign ten      =  s3 & ~s2 &  s1 & ~s0;
    assign eleven   =  s3 & ~s2 &  s1 &  s0;
    assign twelve   =  s3 &  s2 & ~s1 & ~s0;
    assign thirteen =  s3 &  s2 & ~s1 &  s0;
    assign fourteen =  s3 &  s2 &  s1 & ~s0;
    assign fifteen  =  s3 &  s2 &  s1 &  s0;
    
    assign da = zero | two   | three | five  | six   | seven  | eight  | nine     | ten      | fourteen | fifteen;
    assign db = zero | one   | two   | three | four  | seven  | eight  | nine     | ten      | thirteen;
    assign dc = zero | one   | three | four  | five  | six    | seven  | eight    | nine     | ten      | eleven   | thirteen ;
    assign dd = zero | two   | three | five  | six   | eight  | eleven | twelve   | thirteen | fourteen ;
    assign de = zero | two   | six   | eight | ten   | eleven | twelve | thirteen | fourteen | fifteen ;
    assign df = zero | four  | five  | six   | eight | nine   | ten    | eleven   | fourteen | fifteen ;
    assign dg = two  | three | four  | five  | six   | eight  | nine   | ten      | eleven   | twelve   | thirteen | fourteen | fifteen ;
endmodule
