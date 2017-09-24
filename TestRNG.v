
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/31/2017 06:24:44 PM
// Design Name: 
// Module Name: TestRNG
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


module TestRNG(
    output [6:0] seg,
    output an,
    input btnC,
    input reset,
    input clk
    );
    
    reg [6:0] seg;
    reg an;
    reg state;
    reg bit;
    wire elapsed;
    wire reset;
    
halfsec timer(

    elapsed,
    clk,
    reset
    
    );
    
    
    always@(posedge clk)
            begin
            an<=0;
            if(elapsed==1)
            begin
                if(state==1) state <=0;
                else state<=1;
            end
            end
    
    always@(posedge clk)
            begin
            if(btnC==1)
            bit<=state;
            end
            
    always@(posedge clk)
            begin
            if(bit==1) seg<= 7'b1111001;
            else if(bit==0) seg<= 7'b1000000;
            end
            
endmodule 