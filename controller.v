
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
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output Hsync,
    output Vsync,
//    output reg load,
//    output reg matchgo,
//    output reg displaygo,
//    output reg [3:0] winlose,
//    output reg turn,
//    output reg fivesecreset,
//    output reg matchreset,
//    output reg halfsecreset,
    input clk,
    input btnL, //Left LED (LED1)
    input btnC, //Start
    input btnR, //Right LED (LED0)
    input [1:0] sw
    );
    
    //initialize variables
    reg [3:0] state;
    reg [2:0] shiftselect;
    reg reset;
    reg [3:0] gamestate;
    reg [3:0] currentstate;
    reg [5:0] counter;
    reg load, matchgo, matchreset, displaygo, halfsecreset, turn, fivesecreset;
    reg [3:0] winlose;
    wire [7:0] pattern;
    wire button0;
    wire button1;
    wire [7:0] onebit;
    wire fivesecelapsed;
    wire displaydone;
    wire correct;
    wire matchdone;
    wire currentbit;
    wire halfsecelapsed;
    wire [3:0] red, green, blue, vred, vgreen, vblue;
    wire h, v;
    reg [1:0] onesec;
//    assign rload=load;
//    assign rmatchgo=matchgo;
//    assign rdisplaygo=displaygo;
//    assign rwinlose=winlose;
//    assign rturn=turn;
//    assign rfivesecreset=fivesecreset;
    assign sw[0] = reset;
//    assign vgaRed = vred;
//    assign vgaGreen = vgreen;
//    assign vgaBlue = vblue;
    assign Hsync = h;
    assign Vsync = v;
    
vga ledDisplay(
    
        h,
        v,
        vgaRed,
        vgaGreen,
        vgaBlue,
        clk,
        red,
        green,
        blue
    
        ); 
    
match matcher(
    
       correct,
       matchdone,
       currentbit,
       btnR,
       btnL,
       matchgo,
       matchreset,
       clk

        );   

eighttoonemux shiftmux(
        currentbit,
        pattern,
        shiftselect
    );
            
mux button0mux(
        button0,
        ~currentbit,
        btnR,
        turn
        );
        
mux button1mux(
        button1,
        currentbit,
        btnL,
        turn
        );

display LEDS(
    
        led[1:0],
        displaydone,
        red,
        green,
        blue,
        displaygo,
        button0,
        button1,
        clk
        
        );
        
Pattern stateregister(
        
            pattern,
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
                    
fivesec pause(
            fivesecelapsed,
            clk,
            fivesecreset
            );        
                 
halfsec shortpause(
                halfsecelapsed,
                clk,
                halfsecreset
                );
                                           
always@(posedge clk)
begin
    case(state)
        0:begin //Idle state
             winlose<=1;
             displaygo<=0;
             matchgo<=0;
             matchreset<=0;
             turn<=0;
             load<=0;
             gamestate<=7;
             currentstate<=0;
             counter<=0;
             shiftselect<=0;
             fivesecreset<=1;
             halfsecreset<=1;
             if(reset==1) state<=0;
             else if(reset==0 && btnC==1)
             begin //load the random number
                     load<=1;
                     state<=1;
             end
             else state<=0;
          end
         1:begin //display bits to user
                winlose<=8;
                displaygo<=1;
                matchgo<=0;
                matchreset<=0;
                turn<=0;
                load<=0;
                fivesecreset<=1;
                halfsecreset<=1;
                if(reset==1) state<=0;
                else if(reset==0)
                begin
                    if(displaydone==1)
                    begin
                    displaygo<=0;
                    counter<=counter+1;
                    state<=7;
                    end
                    else state<=1;
                end
           end
          2:begin //user turn to match 
                 winlose<=8;
                 displaygo<=1;
                 matchgo<=1;
                 matchreset<=0;
                 turn<=1;
                 load<=0; 
                 fivesecreset<=0; 
                 halfsecreset<=1;
                 if(reset==1) state<=0;
                 else if(reset==0)
                 begin
                    if(matchdone==1 && displaydone==1)
                    begin
                        if(correct==1) 
                        begin
                            displaygo<=0;
                            matchreset<=1;
                            matchgo<=0;
                            state<=8;
                            counter<=counter+1;
                        end    
                        else if(correct==0) state<=4;
                    end
                    else if(fivesecelapsed==1) state<=4;
                    else state<=2;
                 end
            end
          3:begin //win state
                 displaygo<=0;
                 winlose<=4;
                 matchgo<=0;
                 matchreset<=1;
                 turn<=0;
                 load<=0;
                 fivesecreset<=1;
                 halfsecreset<=1;
                 if(reset==1) state<=0;
                 else 
                 begin
                    state<=5;
                    fivesecreset<=1;
                 end
            end
          4:begin//lose state
                 displaygo<=0;
                 winlose<=2;
                 matchgo<=0;
                 matchreset<=1;
                 turn<=0;
                 load<=0;
                 fivesecreset<=1;
                 halfsecreset<=1;
                 if(reset==1) state<=0;
                 else
                 begin
                    state<=6;
                    fivesecreset<=1;
                 end
            end
          5:begin//5 second idle stage for win
                 fivesecreset<=0;
                 displaygo<=0;
                 matchgo<=0;
                 matchreset<=1;
                 winlose<=4;
                 turn<=0;
                 load=0;
                 halfsecreset<=1;
                 if(reset==1) state<=0;
                 else if(reset==0)
                 begin
                    if(fivesecelapsed==1)state<=0;
                    else state<=5;
                 end
            end
          6:begin //5 second idle stage for lose
                matchgo<=0;
                matchreset<=1;
                fivesecreset<=0;
                displaygo<=0;
                winlose<=2;
                turn<=0;
                load=0;
                halfsecreset<=1;
                if(reset==1) state<=0;
                else if(reset==0)
                begin
                    if(fivesecelapsed==1) state<=0;
                    else state<=6;
                end
           end
          7:begin //check state of game for displaying bits
                matchgo<=0;
                matchreset<=1;
                fivesecreset<=1;
                displaygo<=0;
                winlose<=8;
                turn<=1;
                load=0;
                halfsecreset<=1;
                if(reset==1) state<=0;
                else if(reset==0) 
                begin
                    if(counter>currentstate)
                    begin
                        state<=2;
                        counter<=0;
                        shiftselect<=0;
                    end
                    else 
                    begin
                        state<=10;
                        shiftselect<=counter;
                    end
                end 
            end
          8:begin//check match state of game
                matchgo<=0;
                matchreset<=1;
                fivesecreset<=1;
                displaygo<=0;
                winlose<=8;
                turn<=1;
                load<=0;
                halfsecreset<=1;
                if(reset==1) state<=0;
                else if(reset==0)
                begin
                    if(counter>gamestate) state<=3;
                    else if(counter>currentstate) 
                    begin
                        state<=9;
                        counter<=0;
                        shiftselect<=0;
                        currentstate<=currentstate+1;
                        onesec<=0;
                    end
                    else
                    begin
                        state<=2;
                        shiftselect<=counter;
                    end
                end
            end
          9:begin//delay between game states
                matchgo<=0;
                matchreset<=1;
                fivesecreset<=1;
                displaygo<=0;
                winlose<=8;
                turn<=0;
                load<=0;
                halfsecreset<=0;
                if(reset==1) state<=0;
                else if(reset==0)
                begin
                    if(onesec==3) state<=1;
                    else state<=9;
                    if(halfsecelapsed==1) onesec<=onesec+1;
                end
            end
          10:begin //delay between display states
                matchgo<=0;
                matchreset<=1;
                fivesecreset<=1;
                displaygo<=0;
                winlose<=8;
                turn<=0;
                load<=0;
                halfsecreset<=0;
                if(reset==1) state<=0;
                else if(reset==0)
                begin
                    if(halfsecelapsed==1) state<=1;
                    else state<=10;
                end
             end
       endcase
    end     
endmodule