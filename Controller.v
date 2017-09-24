
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2017 02:05:07 AM
// Design Name: 
// Module Name: Controller
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


module Controller(
    
    output [6:0] seg,
    output [3:0] an,
    output [1:0] led,
    output turn,
    output state,
    output load,
    output matchgo,
    output displaygo,
    input clk,
    input btnL,
    input btnC,
    input btnU
//    input start,
//    input win,
//    input lose,
//    input elapsed,
//    input fivesecelapsed
    
    );
wire done;    
wire win;
wire lose;
wire button0;
wire button1;
wire bits;
wire onebit;
reg [2:0] winlose;
reg [1:0] state;
wire elapsed;
reg turn;
reg load;
reg displaygo;
reg matchgo;
reg reset;

match matcher(
    
        win,
        lose,
        done,
        matchgo,
        turn,
        bits,
        btnC,
        btnU,
        clk

        );   

IO interface(

    btnC,
    btnU,
    btnL,
    clk,
    start,
    button0,
    button1

    );
    wire displaydone;
LEDS display(
    
        led[1:0],
        bits,
        displaydone,
        button0,
        button1,
        turn,
        displaygo,
        clk
        
        );
        
Pattern stateregister(
        
            bits,
            load,
            onebit,
            clk
            
            );
            
RNG rng(
                
                onebit,
                clk
                
                );  
                
                
message yeahlose(
                    clk,
                    winlose,
                    seg,
                    an
                    );

halfsec waiter(
            elapsed,
            clk,
            reset
            );
            
     wire fivesecelapsed;
     reg fivesecreset;    
        
fivesec pause(
            fivesecelapsed,
            clk,
            fivesecreset
            );
                                            
always@(posedge clk)
begin
    case(state)
        0: begin //idle state
           turn<=0;
           winlose<=1;
           if(start==1) 
           begin
           state<=1;
           load<=1;
           end
           displaygo<=0;
           matchgo<=0;
           fivesecreset<=1;
           end
        1: begin //game display
           fivesecreset<=0;
           turn<=0;
           load<=0;
           displaygo<=1;
           matchgo<=0;
           winlose<=1;
           if(displaydone==1)
           begin
            state<=2;
            fivesecreset<=1;
           end
           end
        2: begin //user match
           turn<=1;
           load<=0;
           displaygo<=1;
           matchgo<=1;
           winlose<=1;
           fivesecreset<=0;
           if(done==1)
           begin
           state<=3;
           fivesecreset<=1;
           end
           end
        3: begin //display result
           if(win==1) winlose<=4;
           if(lose==1) winlose<=2;
           turn<=0;
           load<=0;
           displaygo<=0;
           matchgo<=0;
           fivesecreset<=0;
           if(fivesecelapsed==1) state<=0;
           end
         endcase
     end                          
endmodule
