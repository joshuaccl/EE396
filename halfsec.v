`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2017 12:21:49 AM
// Design Name: 
// Module Name: halfsec
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


module halfsec(
    output Y,
    input clk,
    input reset

    );
    
    reg elapsed;
    reg[25:0] state;
    always@(posedge clk)
        if(reset==1) state<=0;
            else if(state==25000000) state <=0;
            else state <= state+1;
            
    always@(state)
        if(state == 25000000) elapsed = 1;
            else elapsed = 0;
    
    assign Y = elapsed;
    
endmodule
