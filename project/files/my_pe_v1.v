`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/31 15:08:27
// Design Name: 
// Module Name: my_pe_v1
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


module my_pe_v1 #(
    parameter SIZE = 8,
    parameter L_RAM_SIZE=3
    )
(
    input aclk,
    input aresetn,
    input [SIZE-1:0] ain,
    input [SIZE-1:0] din,
    input [L_RAM_SIZE-1:0] addr,
    input we,
    input valid,
    output dvalid,
    output [SIZE-1:0] dout
    );
    reg [SIZE-1:0] bin;
    (*ram_style = "block" *) reg [SIZE-1:0] peram [0:2**L_RAM_SIZE-1];
    
    always @(posedge aclk)
        if(we)
            peram[addr] <= din;
        else
            bin <= peram[addr];
    
    reg [SIZE-1:0] dout_fb;
    always @(posedge aclk)
        if(!aresetn)
            dout_fb <= 'd0;
        else
            if(dvalid)
                dout_fb <= dout;
            else
                dout_fb <= dout_fb;
    
    my_ma MA (
        .A(ain),
        .B(bin),
        .C(dout_fb),
        .P(dout),
        .resetn(aresetn),
        .clk(aclk),
        .valid(valid),
        .dvalid(dvalid)
    );  
endmodule
