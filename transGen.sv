//J 
//add coverpoint

`include "head.svh"

class transGen extends BaseClass;

	alu_trans tr;
	mailbox tr2drv_mbx;
	mailbox refmodel_mbx;

	covergroup CovPort;
		a: coverpoint tr.a;
		b: coverpoint tr.b;
		c: coverpoint tr.select;
		cross a, b, c;
	endgroup

	function new(string name, mailbox tr2drv_mbx, mailbox refmodel_mbx);
		super.new(name);
		CovPort = new();
		this.tr2drv_mbx = tr2drv_mbx;
		this.refmodel_mbx = refmodel_mbx;
	endfunction

	extern task main();
	extern function void randmize_trans(alu_trans tr);
	extern function void send_trans(alu_trans tr);
endclass

task transGen::main();
	repeat(`Ntimes)
	begin
		tr = new();
		randmize_trans(this.tr);
		this.tr.display();
		send_trans(this.tr);
		tr.wait_ack();
		CovPort.sample();
		#5;
	end
	info("All tr has been sent");
endtask

function void transGen::randmize_trans(alu_trans tr);
	info("Now randomize tr");
	tr.randomize();
endfunction

function void transGen::send_trans(alu_trans tr);
	info("Now send tr to driver and reference model");
	tr2drv_mbx.put(tr);
	refmodel_mbx.put(tr);
endfunction
