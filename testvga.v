`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/25/2017 05:03:35 PM
// Design Name: 
// Module Name: testvga
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


module testvga(
    output [3:0] vgaRed,
    output [3:0] vgaGreen,
    output [3:0] vgaBlue,
    output Hsync,
    output Vsync,
    output [3:0] led,
    input [1:0] sw,
    input clk
    );
    
    reg [3:0] red, green, blue;
    reg [3:0] leds;
vga testvga(
    
        Hsync,
        Vsync,
        vgaRed,
        vgaGreen,
        vgaBlue,
        clk,
        red,
        green,
        blue
    
        );
        assign led = leds;
        always@(posedge clk)
        begin
                if(vgaRed==0 && vgaGreen==0 && vgaBlue==0) leds[0]<=1;
                else if(vgaRed==15 && vgaGreen==15 && vgaBlue==15) leds[1]<=1;
                else if(vgaRed==0 && vgaGreen==8 && vgaBlue==0) leds[2]<=1;
                else if(vgaRed==8 && vgaGreen==8 && vgaBlue==8) leds[3]<=1;
                else leds<=0;
                               
                if(sw==0)
                begin
                    red<=0;
                    green<=0;
                    blue<=0;
                 end
                 if(sw==1)
                 begin
                    red<=15;
                    green<=15;
                    blue<=15;
                 end
                 if(sw==2)
                 begin   
                    red<=0;
                    green<=8;
                    blue<=0;
                 end
                 if(sw==3)
                 begin   
                    red<=8;
                    green<=8;
                    blue<=8;
                 end
          end
endmodule
