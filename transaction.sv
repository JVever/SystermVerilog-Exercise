
`ifndef ALU_TRANS__SV
`define ALU_TRANS__SV

`include "head.svh"
class alu_trans extends BaseClass;
	
	function new(string name = "tr");
		super.new(name);
	endfunction

	rand logic [3:0] a, b;
	rand logic [2:0] select;

	event acknowledge;

	extern task display();
	extern task ack();
	extern task wait_ack();

endclass

task alu_trans::display();
	$display($time, name, " : ","a = %h, b = %h, select = %d", a, b ,select);
endtask

task alu_trans::ack();
	info("trigger acknowledge");
	-> acknowledge;
endtask

task alu_trans::wait_ack();
	info("wait for ack");
	@acknowledge;
endtask

`endif
