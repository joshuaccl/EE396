`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2017 12:44:15 AM
// Design Name: 
// Module Name: testtimer
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


module testtimer(

    output [2:0] led,
    input clk

    );
    
    wire elapsed;
    wire reset;
    reg [2:0] light;
    assign led=light;
    
fivesec delay(

        elapsed,
        clk,
        reset
        );
        
        always@(posedge clk)
        begin
        if(elapsed==1)
        begin
            if(light[0]==1) light[0] <=0;
            else light[0]<=1;
        end
        end
        
        
        
endmodule
