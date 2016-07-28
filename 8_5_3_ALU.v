`timescale 1ns/1ns

module ALU(a, b, select, result);
	input [3:0] a, b;
	input [2:0] select;
	output reg [4:0] result;

	always@(a, b, select)
	begin
		result = ALU_f(a, b, select);
	end

	function [4:0] ALU_f(input [3:0] a, b, input [2:0] select);
		case(select)
			3'b000: ALU_f = a;
			3'b001: ALU_f = a + b;
			3'b010: ALU_f = a - b;
			3'b011: ALU_f = a / b;
			3'b100: ALU_f = a % 3;
			3'b101: ALU_f = a << 1;
			3'b110: ALU_f = a >> 1;
			3'b111: ALU_f = (a > b) ? 1 : 0;
			default: $display("Invalid select");
		endcase
	endfunction

endmodule
