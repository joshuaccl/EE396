`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2017 01:15:32 AM
// Design Name: 
// Module Name: IO
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


module IO(

    input btnC,
    input btnU,
    input btnL,
    input clk,
    output start,
    output button0,
    output button1

    );
    
    reg start;
    reg button0;
    reg button1;
    
    always@(posedge clk)
    begin
    if(btnL==1) start <=1;
    if(btnL==0) start <=0;
    if(btnC==1) 
    begin
    button0 <=1;
    button1 <=0;
    end
    if(btnU==1) 
    begin
    button1 <=1;
    button0 <=0;
    end
    end
    
    
endmodule
