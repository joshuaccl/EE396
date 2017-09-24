//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2017 01:32:01 AM
// Design Name: 
// Module Name: match
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


module match(

    output win,
    output lose,
    output done,
    input start,
    input turn,
    input pattern,
    input io0,
    input io1,
    input clk
    
    );
    wire fivesecelapsed;
    reg win=0;
    reg lose=0;
    reg [1:0] state=0;
    reg reset;
    reg done=0;
    
fivesec timelimit(
        fivesecelapsed,
        clk,
        reset
        );
        
    always@ (posedge clk)
    begin
        if(start==1) 
        begin
        reset<=1;
            if(state==0)
            begin
                reset<=0;
                if(io0==1) state<=1;
                else if(io1==1) state<=2;
                else if(fivesecelapsed==1) state<=3;
                else state<=0;
            end
            if(state==1)
            begin
            if(pattern==0) win<=1;
            else lose<=1;
            done<=1;
            end
            if(state==2)
            begin
            if(pattern==1) win<=1;
            else lose<=1;
            done<=1;
            end
            if(state==3)
            begin
            lose<=1;
            done<=1;
            end
        end   
    end          
endmodule
