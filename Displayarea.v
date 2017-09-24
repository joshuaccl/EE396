`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2017 06:25:57 PM
// Design Name: 
// Module Name: Displayarea
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


module Displayarea(
    output reg show,
    input [9:0] horcount,
    input [9:0] vercount
    );
    
    always@(horcount or vercount)
    begin
        if( (horcount<784) && (horcount>143) && (vercount>34) && (vercount<515) ) show=1;
        else show=0;
    end
endmodule
