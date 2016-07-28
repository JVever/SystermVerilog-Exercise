`ifndef env_sv
`define env_sv

`include "head.svh"
`include "driver.sv"
`include "monitor.sv"
`include "ref_model.sv"
`include "SB.sv"
`include "transGen.sv"

class Env extends BaseClass;

	virtual alu_if aif;
	alu_driver adriver;
	alu_monitor amonitor;
	transGen atransgen;
	ref_model aref;
	Scoreboard aSB;

	mailbox gen2drv, gen2ref, ref2sb, mon2sb;

	function new(string name, virtual alu_if aif);
		super.new(name);
		this.aif = aif;
	endfunction

	extern function void pre_main();
	extern task main();


endclass

function void Env::pre_main();
	gen2drv = new();
	gen2ref = new();
	ref2sb = new();
	mon2sb = new();
	adriver = new("driver", aif, gen2drv);
	atransgen = new("generator", gen2drv, gen2ref);
	aref = new("reference model", gen2ref, ref2sb);
	amonitor = new("monitor", aif, mon2sb);
	aSB = new("Scoreboard", ref2sb, mon2sb);
endfunction

task Env::main();
	fork
		atransgen.main();
		adriver.main();
		amonitor.main();
		aref.main();
		aSB.main();
	join
endtask	

`endif
