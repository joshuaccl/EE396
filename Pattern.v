
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2017 06:14:13 PM
// Design Name: 
// Module Name: Pattern
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


module Pattern(

    output reg [7:0] bits,
    input load,
    input [7:0] onebit,
    input clk
    
    );
    
    always@ (posedge clk)
    begin
    
    if(load==1) bits <= onebit;
    else bits <= bits;
    
    end
    
endmodule
