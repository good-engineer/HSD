`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2019 11:01:00 AM
// Design Name: 
// Module Name: mype_v1
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


module mype_v1 #(
        parameter L_RAM_SIZE = 6
    )
    (
        // clk/reset
        input aclk,
        input aresetn,
        
        // port A
        //input [31:0] ain,
        input [7:0] ain,
        
        // peram -> port B 
        //input [31:0] din,
        input [7:0] din,
        input [L_RAM_SIZE-1:0]  addr,
        input we,
        
        // integrated valid signal
        input valid,
        input subtract,
        // computation result
        output dvalid,
        //output [31:0] dout
        output [7:0] dout,
        output [47:0] pcout
    );

    wire avalid = valid;
    wire bvalid = valid;
    wire cvalid = valid;
    
    // peram: PE's local RAM -> Port B
    //reg [31:0] bin;
    reg [7:0] bin;
    //(* ram_style = "block" *) reg [31:0] peram [0:2**L_RAM_SIZE - 1];
    (* ram_style = "block" *) reg [7:0] peram [0:2**L_RAM_SIZE - 1];
    always @(posedge aclk)
        if (we)
            peram[addr] <= din;
        else
            bin <= peram[addr];
    
    //reg [31:0] dout_fb;
    reg [7:0] dout_fb;
    always @(posedge aclk)
        if (!aresetn)
            dout_fb <= 'd0;
        else
            if (dvalid)
                dout_fb <= dout;
            else
                dout_fb <= dout_fb;
    
    xbip_multadd_0(
        .CLK (aclk), 
        .CE (we), //uncertain
        .SCLR (!aresetn),
        .A(ain),
        .B(bin), 
        .C(dout_fb),
        .SUBTRACT(subtract), 
        .P (dout), 
        .PCOUT (pcout) //result    
     );
endmodule
