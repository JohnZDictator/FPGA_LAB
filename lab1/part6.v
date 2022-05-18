module part6(SW, LEDR, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input [17:0] SW;
	output [17: 0] LEDR;
	output [6: 0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;
	
	wire [2:0] M7, M6, M5, M4, M3, M2, M1, M0, blank;
	assign LEDR = SW;
	
	assign blank = 3'b100;
	
	mux_3bit_8to1 m0(SW[17:15], SW[11:9], SW[8:6], SW[5:3], SW[2:0], blank, blank, blank, SW[14:12], M0);
	char_7seg h0(M0, HEX0);
	
	mux_3bit_8to1 m1(SW[17:15], SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], blank, blank, blank, M1);
	char_7seg h1(M1, HEX1);
	
	mux_3bit_8to1 m2(SW[17:15], blank, SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], blank, blank, M2);
	char_7seg h2(M2, HEX2);
	
	mux_3bit_8to1 m3(SW[17:15], blank, blank, SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], blank, M3);
	char_7seg h3(M3, HEX3);
	
	mux_3bit_8to1 m4(SW[17:15], blank, blank, blank, SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], M4);
	char_7seg h4(M4, HEX4);
	
	mux_3bit_8to1 m5(SW[17:15], SW[2:0], blank, blank, blank, SW[14:12], SW[11:9], SW[8:6], SW[5:3], M5);
	char_7seg h5(M5, HEX5);
	
	mux_3bit_8to1 m6(SW[17:15], SW[5:3], SW[2:0], blank, blank, blank, SW[14:12], SW[11:9], SW[8:6], M6);
	char_7seg h6(M6, HEX6);
	
	mux_3bit_8to1 m7(SW[17:15], SW[8:6], SW[5:3], SW[2:0], blank, blank, blank, SW[14:12], SW[11:9], M7);
	char_7seg h7(M7, HEX7);
endmodule

module mux_3bit_8to1(s, a, b, c, u, v, w, x, y, M);
	input [2:0] s, a, b, c, u, v, w, x, y;
	output [2:0] M;	
	
	wire [5:0] M0, M1, M2;
	
	assign M0[0] = (~s[0]&u[0] | s[0]&v[0]);
	assign M0[1] = (~s[0]&w[0] | s[0]&x[0]);
	assign M0[2] = (~s[0]&y[0] | s[0]&a[0]);
	assign M0[3] = (~s[0]&b[0] | s[0]&c[0]);
	assign M0[4] = (~s[1]&M0[0] | s[1]&M0[1]);	
	assign M0[5] = (~s[1]&M0[2] | s[1]&M0[3]);
	
	assign M1[0] = (~s[0]&u[1] | s[0]&v[1]);
	assign M1[1] = (~s[0]&w[1] | s[0]&x[1]);
	assign M1[2] = (~s[0]&y[1] | s[0]&a[1]);
	assign M1[3] = (~s[0]&b[1] | s[0]&c[1]);
	assign M1[4] = (~s[1]&M1[0] | s[1]&M1[1]);
	assign M1[5] = (~s[1]&M1[2] | s[1]&M1[3]);
	
	assign M2[0] = (~s[0]&u[2] | s[0]&v[2]);
	assign M2[1] = (~s[0]&w[2] | s[0]&x[2]);
	assign M2[2] = (~s[0]&y[2] | s[0]&a[2]);
	assign M2[3] = (~s[0]&b[2] | s[0]&c[2]);
	assign M2[4] = (~s[1]&M2[0] | s[1]&M2[1]);
	assign M2[5] = (~s[1]&M2[2] | s[1]&M2[3]);
	
	assign M[0] = (~s[2]&M0[4] | s[2]&M0[5]);
	assign M[1] = (~s[2]&M1[4] | s[2]&M1[5]);
	assign M[2] = (~s[2]&M2[4] | s[2]&M2[5]);
endmodule

module char_7seg(c, Display);	
	input [2:0] c;
	output [6:0] Display;
	
	reg blank;
	always @(c)
	begin
		if(c > 3'b011)
			blank = 0;
		else
			blank = 1;
	end
	
	assign Display[0] = ~((c[2] | c[0]) & blank);
	assign Display[1] = ~((c[2] | ~c[1]&~c[0] | c[1]&c[0]) & blank);
	assign Display[2] = ~((c[2] | ~c[1]&~c[0] | c[1]&c[0]) & blank);
	assign Display[3] = ~((c[2] | c[1] | c[0]) & blank);
	assign Display[4] = ~(1 & blank);
	assign Display[5] = ~(1 & blank);
	assign Display[6] = ~(~c[1] & blank);
endmodule