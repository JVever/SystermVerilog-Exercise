
`ifndef BaseClass__sv
`define BaseClass__sv

class BaseClass;
	string name;

	function new(string name);
		this.name = name;
	endfunction
	
	function void info(string message);
		$display($time, "--INFO--", name, " : ", message);
	endfunction

endclass

`endif
