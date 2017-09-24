
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2017 05:56:54 PM
// Design Name: 
// Module Name: RNG
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


module RNG(
    
    output reg [7:0] number,
    input clk
    
    );
  
  reg [25:0] state;

        always@(posedge clk)
            begin
            if(state==10000000) state<=0;
            else state <= state+1;
            end
                
        always@(state)
            number <= (state % 256);
    endmodule