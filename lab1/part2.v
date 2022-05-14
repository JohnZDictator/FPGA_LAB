module part_2(SW, LEDR, LEDG);
	input [17:0]SW;
	output [17:0]LEDR;
	output [7:0]LEDG;
	
	wire s;
	wire [7:0] x, y, M;
		
	assign LEDR = SW;
	assign LEDG = M;
	
	assign s = SW[17];
	assign x = SW[7:0];
	assign y = SW[15:8];
	
	assign M[0] = (~s & x[0] | s & y[0]);
	assign M[1] = (~s & x[1] | s & y[1]);
	assign M[2] = (~s & x[2] | s & y[2]);
	assign M[3] = (~s & x[3] | s & y[3]);
	assign M[4] = (~s & x[4] | s & y[4]);
	assign M[5] = (~s & x[5] | s & y[5]);
	assign M[6] = (~s & x[6] | s & y[6]);
	assign M[7] = (~s & x[7] | s & y[7]);

endmodule