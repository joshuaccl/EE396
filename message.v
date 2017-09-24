//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/07/2017 03:28:35 PM
// Design Name: 
// Module Name: message
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


module message(
    input clk,
    input [3:0] sw,
    output [6:0] seg,
    output [3:0] an
    );
    
    wire strobe_out;
    reg [1:0] an_out;
    reg [3:0] an_select;
    reg [6:0] letter;
    
    strobe play(strobe_out, clk);
    
    always@(posedge clk)
        if(strobe_out == 1) an_out <= an_out + 1;
    
    always@(sw)
    begin
        if(sw[2] == 1) // Displayed: YEAH
        begin
            case(an_out)
                0: begin
                   an_select = 3'b0111; 
                   letter = 7'b0010001;
                   end
                1: begin
                   an_select = 4'b1011;
                   letter = 7'b0000110;
                   end 
                2: begin
                   an_select = 4'b1101;
                   letter = 7'b0001000;
                   end
                3: begin
                   an_select = 4'b1110;
                   letter = 7'b0001001;
                   end
            endcase
        end
        else if(sw[1] == 1) // Displayed: LOSE
        begin
            case(an_out)
            0: begin
               an_select = 3'b0111; 
               letter = 7'b1000111;
               end
            1: begin
               an_select = 4'b1011;
               letter = 7'b1000000;
               end 
            2: begin
               an_select = 4'b1101;
               letter = 7'b0010010;
               end
            3: begin
               an_select = 4'b1110;
               letter = 7'b0000110;
               end
            endcase
        end
        else if(sw[0] == 1) //Displayed: PLAY
        begin
            case(an_out)
            0: begin
               an_select = 3'b0111; 
               letter = 7'b0001100;
               end
            1: begin
               an_select = 4'b1011;
               letter = 7'b1000111;
               end 
            2: begin
               an_select = 4'b1101;
               letter = 7'b0001000;
               end
            3: begin
               an_select = 4'b1110;
               letter = 7'b0010001;
               end
            endcase
       end
       else if(sw[3] == 1) an_select=4'b1111; //Turn off display
       else
       begin
            an_select = 4'b1111;
            letter = 7'b1111111;
       end    
    end
    
    assign seg = letter;
    assign an = an_select;
    
endmodule


module strobe(
    output display,
    input clk
    );
    
    reg elapsed;
    reg [25:0] state;
    
    always@(posedge clk)
        if(state == 250000) state <= 0;
        else state <= state + 1;
        
    always@(state)
        if(state == 250000) elapsed = 1; 
        else elapsed = 0;
        
    assign display = elapsed;

endmodule
