
`ifndef ALU_Monitor__sv
`define ALU_Monitor__sv

`include "head.svh"

class alu_monitor extends BaseClass;
	
	virtual alu_if aif;
	mailbox mon2sb;
	alu_trans tr;
	logic [4:0] result;

	function new(string name, virtual alu_if aif, mailbox mon2sb);
		super.new(name);
		this.aif = aif;
		this.mon2sb = mon2sb;
	endfunction

	extern task main();
	extern function void get_tr();
	extern task send();

endclass

task alu_monitor::main();
	#6;
	forever
	begin
		get_tr();
		send();
		#8;
	end

endtask	

function void alu_monitor::get_tr();
	this.result = this.aif.result;
endfunction

task alu_monitor::send();
	mon2sb.put(this.result);
	info("Put result to SB from monitor");
endtask

`endif
