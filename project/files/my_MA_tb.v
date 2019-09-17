`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/31 14:34:53
// Design Name: 
// Module Name: my_MA_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module my_MA_tb();

parameter SIZE=8;   
 reg [SIZE-1:0] A;
 reg [SIZE-1:0] B;
 reg [SIZE-1:0] C;
 wire [SIZE-1:0] P;
 reg resetn;
 reg clk;
 reg valid;
 wire dvalid;
 
 integer i;
 initial begin 
 clk=0;
 valid=0;
 resetn=0;
 #10;
 resetn=1;
     A=2;
     B=3;
     C=4;
     #10;
     valid=1;
     #10;
     valid=0;
    
    wait(dvalid);
     A=5;
     B=7;
     C=5;
     #10;
     valid=1;
     #10;
     valid=0;
     
     wait(dvalid);
     A=8;
     B=5;
     C=4;
     #10;
     valid=1;
     #10;
     valid=0;
     
     wait(dvalid);
     A=9;
     B=1;
     C=9;
     #10;
     valid=1;
     #10;
     valid=0;
     
     wait(dvalid);
     A=7;
     B=2;
     C=6;
     #10;
     valid=0;
     #10;
     valid=1;
 
end
  always #5 clk=~clk;
 
 my_ma #(
.SIZE(SIZE))UUT
(
     .A(A),
     .B(B),
     .C(C),
     .P(P),
     .clk(clk),
     .valid(valid),
     .dvalid(dvalid)
    
    );
   
endmodule
