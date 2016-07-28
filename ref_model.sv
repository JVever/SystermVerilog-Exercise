`ifndef Ref_model__sv
`define Ref_model__sv

`include "head.svh"

class ref_model extends BaseClass;
	mailbox Gen2Ref;
	mailbox Ref2SB;
	alu_trans tr;
	logic [4:0] result;

	function new(string name, mailbox Gen2Ref, mailbox Ref2SB);
		super.new(name);
		this.Gen2Ref = Gen2Ref;
		this.Ref2SB = Ref2SB;
	endfunction

	extern task main();
	extern task receive_tr();
	extern function void calc();
	extern function void send();
endclass


task ref_model::main();
	forever
	begin
		receive_tr();
		calc();
		send();
	end
endtask

task ref_model::receive_tr();
	info("Ready to get tr in Ref_model");
	Gen2Ref.get(this.tr);
	info("Get tr from Gen in Ref_model");
endtask

function void ref_model::calc();
	case(tr.select)
		3'b000: result = tr.a;
		3'b001: result = tr.a + tr.b;
		3'b010: result = tr.a - tr.b;
		3'b011: result = tr.a / tr.b;
		3'b100: result = tr.a % 3;
		3'b101: result = tr.a * 2;
		3'b110: result = tr.a / 2;
		3'b111: result = (tr.a > tr.b) ? 1 : 0;
		default: info("Invalid select");
	endcase
endfunction

function void ref_model::send();
	Ref2SB.put(result);
	info("Put the result to SB from ref_model");
endfunction


`endif
