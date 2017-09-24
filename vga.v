`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2017 01:25:17 AM
// Design Name: 
// Module Name: vga
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


module vga(

    output reg hs,
    output reg vs,
    output reg [3:0] gaRed,
    output reg [3:0] gaGreen,
    output reg [3:0] gaBlue,
    input clk,
    input [3:0] re,
    input [3:0] gr,
    input [3:0] bl

    );
    
    wire horsync, versync;
    wire [3:0] muxred, muxgreen, muxblue;
    wire pixelClock;
    wire [9:0] hcount, vcount;
    wire horizontalcountdone;
    wire showcolor;
    
Pixel clock(
        pixelClock,
        clk
        );
        
Horizontal HorizontalCounter(
        
            hcount,
            horizontalcountdone,
            pixelClock
            
            );        
            
Vertical VerticalCounter(
            
                vcount,
                horsync,
                pixelClock
                
                );  
                
Horsync HorizontalComparator(
                
                    horsync,
                    hcount
                
                    );          
Versync VerticalComparator(
        
                    versync,
                    vcount
                    
                    );
                
Displayarea DisplayComparator(

                    showcolor,
                    horcount,
                    vercount
                   
                    );
                    
color colormux(
                    muxred,
                    muxgreen,
                    muxblue,
                    re,
                    gr,
                    bl,
                    showcolor
                    
                    );

    always@(posedge clk)
    begin
        gaRed <= muxred;
        gaGreen <= muxgreen;
        gaBlue <= muxblue;
        hs <= horsync;
        vs <= versync;
    end
endmodule
