
module test_ALU;
	reg [3:0] a, b;
	reg [2:0] select;
	wire [4:0] result;

	ALU alu0(a, b, select, result);

	initial
	begin
		a = 0;
		b = 0; 
		select = 0;
		#10;
		a = 7;
		b = 4;
		repeat(9)
		begin
			select <= select + 1;
			#5;
		end
		a = 10;
		b = 15;
		repeat(9)
		begin
			select <= select + 1;
			#5;
		end
	end

endmodule

