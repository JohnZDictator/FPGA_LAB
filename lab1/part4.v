module part4(SW, LEDR, HEX0);
	input [2:0] SW;
	output [2:0] LEDR;
	output [6:0] HEX0;
	
	wire c2, c1, c0;
	assign c2 = SW[2];
	assign c1 = SW[1];
	assign c0 = SW[0];
	assign LEDR = SW;
	reg blank;
	
	always @(SW)
	begin
		if(SW > 3'b011)
			blank = 0;
		else
			blank = 1;
	end
	 
	assign HEX0[0] = ~(c0 & blank); //~c0; 
	assign HEX0[1] = ~((~c1 & ~c0 | c1 & c0) & blank); //~(~c1&~c0 | ~c1 & c0); 
	assign HEX0[2] = ~((~c1 & ~c0 | c1 & c0) & blank); //~(~c1&~c0 | c1&c0);
 	assign HEX0[3] = ~((c1 | c0) & blank); //~(c1 | c0); 
	assign HEX0[4] = ~(1 & blank); //~1; 
	assign HEX0[5] = ~(1 & blank); //~1; 
	assign HEX0[6] = ~(~c1 & blank); //~(~c1); 
endmodule
