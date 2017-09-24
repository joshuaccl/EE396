`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2017 01:35:01 AM
// Design Name: 
// Module Name: fivesec
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


module fivesec(
    output reg fivesecelapsed,
    input clk,
    input resetfivesec
    );
    
    wire elapsed;
    reg reset;
    reg [3:0] state;

    
halfsec delay(
    elapsed,
    clk,
    reset
    );
    
    always@(posedge clk)
    begin
        if(resetfivesec==1) 
        begin
            state<=0;
            reset<=1;
            fivesecelapsed<=0;
        end
        else 
        begin
            reset<=0;
            if(elapsed==1) state<=state+1;
        
            if(state==10) 
            begin
                 state<=0;
                 fivesecelapsed<=1;
            end
            else fivesecelapsed<=0;
        end
    end
    
endmodule
