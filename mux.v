module mux(
	result,   // Output of multiplexer
	indata0,  // Input 0
	indata1,  // Input 1
	select    // 1-bit select
	);	

output [15:0] result;
input [15:0] indata0, indata1;
input select;

reg [15:0] result;

always @(indata0 or indata1 or select)
	case(select)
	0: result = indata0;
	1: result = indata1;
	endcase

endmodule