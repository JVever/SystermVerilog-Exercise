`timescale 1ns/1ns
`include "testbench.sv"

module top;

	alu_if aluif0();
	ALU alu0(aluif0.a, aluif0.b, aluif0.select, aluif0.result);
	Testbench test_alu(aluif0);

endmodule
