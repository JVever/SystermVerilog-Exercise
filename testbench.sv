`ifndef TB__sv
`define TB__sv

`include "head.svh" 
`include "environment.sv"
program Testbench(alu_if aif); 


//	function new(string name, virtual alu_if aif);
//		super.new(name);
//		this.aif = aif;
//	endfunction
	
	Env env;

	initial
	begin
		env = new("envrionment", aif);
		env.pre_main();
		env.main();
	end

endprogram

`endif
