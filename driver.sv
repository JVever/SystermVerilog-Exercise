
`ifndef ALU_Driver__sv
`define ALU_Driver__sv

`include "head.svh"

class alu_driver extends BaseClass;
	
	mailbox tr2drv_mbx;
	virtual alu_if aif;
	alu_trans tr;

	function new(string name, virtual alu_if aif, mailbox tr2drv_mbx);
		super.new(name);
		this.tr2drv_mbx = tr2drv_mbx;
		this.aif = aif;
	endfunction

	extern task main();
	extern task get_tr();
	extern function void drive_tr();

endclass

task alu_driver::main();
	info("in main");
	forever
	begin
		get_tr();
		#3;
		drive_tr();
		this.tr.ack();
	end

endtask

task alu_driver::get_tr();
	info("Ready to get tr");
	tr2drv_mbx.get(this.tr);
	info("Get the tr from Gen");
endtask

function void alu_driver::drive_tr();
	this.aif.a = this.tr.a;
	this.aif.b = this.tr.b;
	this.aif.select = this.tr.select;
endfunction



`endif
