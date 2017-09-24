module Pixel(
        output reg pixelClock,
        input clk
        );
        reg [1:0] state;
        always@(posedge clk)
        begin
            if(state==0) 
            begin
                state<=1;
                pixelClock<=0;
            end
            if(state==1) 
            begin
                pixelClock<=0;
                state<=2;
            end
            if(state==2)
            begin
                pixelClock<=1;
                state<=3;
            end
            if(state==3)
            begin
                pixelClock<=1;
                state<=0;
            end
        end
endmodule