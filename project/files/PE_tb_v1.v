`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/05/31 15:24:10
// Design Name: 
// Module Name: PE_tb_v1
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


module PE_tb_v1(

    );
    parameter L_RAM_SIZE = 3;
    parameter SIZE=8;
    

reg aclk;
reg [L_RAM_SIZE-1:0] addr;
reg [SIZE-1:0] ain_mem [2**L_RAM_SIZE-1:0];
reg [SIZE-1:0] din_mem [2**L_RAM_SIZE-1:0];
reg we;
reg valid;
reg [SIZE-1:0] ain;
reg [SIZE-1:0] din;
wire dvalid;
wire [SIZE-1:0] dout;
reg aresetn;

integer i;
initial begin
  $readmemh("D:/Maryam/Documents/2019-1/hwd/project/ain.txt", ain_mem);
  $readmemh("D:/Maryam/Documents/2019-1/hwd/project/din.txt", din_mem);
  aclk = 0;
  aresetn=0;
  #10;
  addr = 0;
  valid = 0;
  we = 1;
  din = din_mem[0];
  aresetn=1;
  for(i=0; i<16; i=i+1) begin
    #10;
    addr = addr+1;
    din = din_mem[addr];
  end
  #10;
  addr = 0;
  valid = 1;
  we = 0;
  ain = ain_mem[0];
  #20;
  valid = 0;
  for(i=0; i<16; i=i+1) begin
    wait(dvalid==1);

    addr = addr+1;
    ain = ain_mem[addr];
    
    #10
    valid = 1;
    
    #10
    valid = 0;
    
  end
end

always #5 aclk = ~aclk;

my_pe_v1 #(
    .SIZE(SIZE),
    .L_RAM_SIZE(L_RAM_SIZE)
    ) PE
(
    .aclk(aclk),
    .aresetn(aresetn),
    .ain(ain),
    .din(din),
    .addr(addr),
    .we(we),
    .valid(valid),
    .dvalid(dvalid),
    .dout(dout)
    );

endmodule
