`ifndef SB__sv
`define SB__sv
		
`include "head.svh"

class Scoreboard extends BaseClass;
	mailbox ref2sb, mon2sb;
//	logic [4:0] exp_result[$], real_result[$];
	logic [4:0] e_result, r_result;

	function new(string name, mailbox ref2sb, mailbox mon2sb);
		super.new(name);
		this.ref2sb = ref2sb;
		this.mon2sb = mon2sb;
	endfunction

	extern task main();
	extern task get_exp();
	extern task get_real();
	extern function void check_data();

endclass

task Scoreboard::main();
	repeat(`Ntimes)
	begin
		get_exp();
		get_real();
		check_data();
	end
	info("TEST PASS");
	$finish;
endtask

task Scoreboard::get_exp();
	ref2sb.get(e_result);
//	info("Get the expect result");
endtask

task Scoreboard::get_real();
	mon2sb.get(r_result);
//	info("Get the real result");
endtask

function void Scoreboard::check_data();
	if(e_result != r_result)
	begin
		$display("e_result = %d, r_result = %d", e_result, r_result);
		info("Real result do not match with expect result");
		$finish;
	end
	else
		$display("e_result = %d, r_result = %d", e_result, r_result);
endfunction

`endif
