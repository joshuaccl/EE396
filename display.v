`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2017 05:36:20 PM
// Design Name: 
// Module Name: display
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


module display(
//    output [2:0] led,
//    input [2:0] sw,
//    input btnR,
//    input btnL,
//    input btnC,
//    input clk
//   output [1:0] led,
   output reg [1:0] leds,
   output reg done,
   output reg [3:0] red,
   output reg [3:0] green,
   output reg [3:0] blue,
   input go,
   input light0,
   input light1,
   input clk

    );
    
//    reg [1:0] leds;
//    reg done;
//    assign led[1:0] = leds;
//    assign go = btnC;
//    assign light0=sw[0];
//    assign light1=sw[1];
//    assign led[2]=done;
    reg reset;
    reg [2:0] state;
    
    
halfsec blink(
        elapsed,
        clk,
        reset
    
        );
          
    always@(posedge clk)
    begin
      case(state)
      0:begin
            red<=0;
            green<=0;
            blue<=0;
            leds<=0;
            reset<=1;
            done<=0;
            if(go==0) state<=0;
            else if(go==1) state<=1;
        end
      1:begin //wait state
            leds<=0;
            red<=0;
            green<=0;
            blue<=0;
            reset<=1;
            done<=0;
            if(go==0) state<=0;
            else if(go==1)
            begin
                if(light0==0 && light1==0) state<=1;
                else if(light0==1 && light1==0) state<=2;
                else if(light0==0 && light1==1) state<=3;
                else if(light0==1 && light1==1) state<=1;
            end
         end
      2:begin //button0 pressed
            leds[1:0]<=1;
            red<=0;
            green<=8;
            blue<=0;
            reset<=0;
            done<=0;
            if(go==0) state<=0;
            else if(go==1)
            begin
                if(elapsed==1) state<=4;
                else if(elapsed==0) state<=2;
            end
        end
      3:begin //button1 pressed
            leds[1:0]<=2;
            red<=15;
            green<=15;
            blue<=15;
            reset<=0;
            done<=0;
            if(go==0) state<=0;
            else if(go==1)
            begin
                if(elapsed==1) state<=4;
                else if(elapsed==0) state<=3;
            end
         end
       4:begin //done displaying
            red<=0;
            green<=0;
            blue<=0;
            leds<=0;
            reset<=0;
            done<=1;
            if(go==0) state<=0;
            else if(go==1)state<=0;
         end
    endcase
end
endmodule