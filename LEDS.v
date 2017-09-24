`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2017 01:22:53 AM
// Design Name: 
// Module Name: LEDS
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


module LEDS(

    output [1:0] led,
    output done,
    input gameposition,
    input userposition0,
    input userposition1,
    input turn,
    input start,
    input clk
    
    );
    
    reg [1:0] led;
    reg done;
        
    always@(posedge clk)
    begin
    if(start==1)
    begin
    case(turn)
    0: begin //game's turn
       if(gameposition==0) led <= 1;
       if(gameposition==1) led <= 2;
       
       end
    1: begin //user's turn
       if(userposition0==1) led <= 1;
       if(userposition1==1) led <= 2;
       end
    endcase
    end
    end
endmodule
