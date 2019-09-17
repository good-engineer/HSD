`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/31 14:20:34
// Design Name: 
// Module Name: my_ma
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


module my_ma #(
parameter SIZE=8

    )(
    input [SIZE-1:0] A,
    input [SIZE-1:0] B,
    input [SIZE-1:0] C,
    output [SIZE-1:0] P,
    input resetn,
    input clk,
    input valid,
    output dvalid
    
    );
    reg[SIZE-1:0] result;
    reg temp=0;
    assign P=result;
    assign dvalid=temp;
    
    always @(posedge clk) begin
        if(!resetn)
           result<=0;
        else begin
           if (valid)begin
              result <= C + A*B;
              temp <= 1;
            end
            else begin
              result <= result ;
              temp <=0;
            end
        end
        
    end

endmodule
