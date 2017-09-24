`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2017 05:28:50 PM
// Design Name: 
// Module Name: 8to1mux
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


module eighttoonemux(
    output reg result,
    input [7:0] in,
    input [2:0] select
    );
    
    always@(in or select)
        case(select)
        0: result = in[0];
        1: result = in[1];
        2: result = in[2];
        3: result = in[3];
        4: result = in[4];
        5: result = in[5];
        6: result = in[6];
        7: result = in[7];
        endcase
endmodule