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


module Horizontal(

    output reg [9:0] count,
    output reg countdone,
    input clk
    
    );
    
    always@(posedge clk)
    begin
        if(count != 799)
        begin
            count <= count + 1;
            countdone<=0;
        end
        if(count == 799)
        begin
            count <= 0;
            countdone <= 1;
        end
    end    
endmodule
