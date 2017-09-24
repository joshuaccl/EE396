`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2017 06:17:47 PM
// Design Name: 
// Module Name: Versync
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


module Versync(
    output reg verticalsync,
    input [9:0] state
    );
    
    always@(state)
    begin
        if(state==0 || state==1) verticalsync=1;
        else verticalsync=0;
    end 
endmodule
