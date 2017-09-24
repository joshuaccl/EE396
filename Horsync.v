`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2017 06:09:45 PM
// Design Name: 
// Module Name: Horsync
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


module Horsync(

    output reg horizontalsync,
    input [9:0] state

    );
    
    always@(state)
    begin
        if(state>95) horizontalsync=0;
        if(state<96) horizontalsync=1;
    end
endmodule
