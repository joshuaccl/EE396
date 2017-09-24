`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2017 05:44:36 PM
// Design Name: 
// Module Name: Horizontal
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


module Vertical(

    output [9:0] count,
    input enable,
    input clk
    
    );
    reg [9:0] state;
    assign count = state;
    always@(posedge clk)
    begin
      if(enable==1)
      begin  
        if(state != 524)
        begin
            state <= state + 1;
        end
        if(state == 524)
        begin
            state <= 0;
        end
      end
      else if (enable==0) state <= state;
    end    
endmodule