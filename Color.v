module color(
	output reg [3:0] vgRed,
	output reg [3:0] vgGreen,
	output reg [3:0] vgBlue,
	input [3:0] r,
	input [3:0] g,
	input [3:0] b,
	input select
	);


always @(r or g or b or select)
	case(select)
	0: begin
	       vgRed = 0;
	       vgGreen=0;
	       vgBlue=0;
	   end
	1: begin
	       vgRed=r;
	       vgGreen=g;
	       vgBlue=b;
	   end
	endcase

endmodule