`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/25/2019 12:39:07 PM
// Design Name: 
// Module Name: tb_mype_pv1
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


module tb_mype_pv1();
parameter L_RAM_SIZE = 4;
parameter AIN_FILE = "/csehome/Maryam/mype_pv1/mype_pv1.srcs/constrs_1/imports/data_v1/ain.txt";
parameter DIN_FILE = "/csehome/Maryam/mype_pv1/mype_pv1.srcs/constrs_1/imports/data_v1/din.txt";

reg aclk;
reg aresetn;
reg [L_RAM_SIZE-1:0] addr;
reg [7:0] ain_mem [2**L_RAM_SIZE-1:0];
reg [7:0] din_mem [2**L_RAM_SIZE-1:0];
reg we;
//reg valid;
reg [7:0] ain;
reg [7:0] din;
reg subtract;
//wire dvalid;
wire [7:0] dout;
wire [47:0] pcout;

//assign dout = 0;
//assign pcout = 0;

integer i;
initial begin
  $readmemh(AIN_FILE, ain_mem);
  $readmemh(DIN_FILE , din_mem);
  aresetn = 0;
  #10;
  aresetn = 1;
  aclk = 0;
  addr = 0;
  we = 1;
  subtract = 0;
  din = din_mem[addr];
  #10;
  we=0;
  ain = ain_mem[addr];
  #10;
  /*
  aclk = 0;
  addr = 0;
  //valid = 0;
  we = 1;
  subtract = 0;
  din = din_mem[0];
  for(i=0; i<16; i=i+1) begin
    #10;
    addr = addr+1;
    din = din_mem[addr];
  end
  #10;
  addr = 0;
  //valid = 1;
  we = 0;
  ain = ain_mem[0];
  #10;
  //valid = 0;
  for(i=0; i<15; i=i+1) begin
    //wait(dvalid==1);
    addr = addr+1;
    ain = ain_mem[addr];
    #10;
    //valid = 1;
    //#10
    //valid = 0; 
  end
  */
end

always #5 aclk = ~aclk;

my_pe_pv1 #(
4
) PE (
  .aclk(aclk),
  .aresetn(aresetn),
  .ain(ain),
  .din(din),
  .addr(addr),
  .we(we),
//  .valid(valid),
  .subtract(subtract),
//  .dvalid(dvalid),
  .dout(dout),
  .pcout(pcout)
);


endmodule
