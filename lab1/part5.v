module part5(SW, HEX4, HEX3, HEX2, HEX1, HEX0);
	input [17:0] SW;
	output [6:0] HEX4;
	output [6:0] HEX3;
	output [6:0] HEX2;
	output [6:0] HEX1;
	output [6:0] HEX0;
	
	wire [2:0] M4, M3, M2, M1, M0;
	
	// >> HEX4 Display
	mux_3bit_5to1 m4(SW[17:15], SW[14:12], SW[11:9], SW[8:6], SW[5:3], SW[2:0], M4);
	char_7seg H4(M4, HEX4);
	
	// >> HEX3 Display
	mux_3bit_5to1 m3(SW[17:15], SW[11:9], SW[8:6], SW[5:3], SW[2:0], SW[14:12], M3);
	char_7seg H3(M3, HEX3);

	// >> HEX2 Display
	mux_3bit_5to1 m2(SW[17:15], SW[8:6], SW[5:3], SW[2:0], SW[14:12], SW[11:9], M2);
	char_7seg H2(M2, HEX2);
	
	// >> HEX1 Display
	mux_3bit_5to1 m1(SW[17:15], SW[5:3], SW[2:0], SW[14:12], SW[11:9], SW[8:6], M1);
	char_7seg H1(M1, HEX1);
	
	// >> HEX0 Display
	mux_3bit_5to1 m0(SW[17:15], SW[2:0], SW[14:12], SW[11:9], SW[8:6], SW[5:3], M0);
	char_7seg H0(M0, HEX0);
endmodule

module mux_3bit_5to1(s, u ,v, w, x, y, M);
	input [2:0] s, u, v, w, x, y;
	output [2:0]M;
	
	wire m00, m01, m02, m10, m11, m12, m20, m21, m22;
	
	assign m00 = (~s[0] & u[0] | s[0] & v[0]);
	assign m01 = (~s[0] & w[0] | s[0] & x[0]);
	assign m02 = (~s[1] & m00 | s[1] & m01);
	assign m10 = (~s[0] & u[1] | s[0] & v[1]);
	assign m11 = (~s[0] & w[1] | s[0] & x[1]);
	assign m12 = (~s[1] & m10 | s[1] & m11);
	assign m20 = (~s[0] & u[2] | s[0] & v[2]);
	assign m21 = (~s[0] & w[2] | s[0] & x[2]);
	assign m22 = (~s[1] & m20 | s[1] & m21);
	
	assign M[0] = (~s[2] & m02 | s[2] & y[0]);
	assign M[1] = (~s[2] & m12 | s[2] & y[1]);
	assign M[2] = (~s[2] & m22 | s[2] & y[2]);
endmodule

module char_7seg(c, Display);
	input wire [2:0] c;
	output wire [6:0] Display;
	
	reg blank;
	always @(c)
	begin
		if(c > 3'b100)
			blank = 0;
		else
			blank = 1;
	end
   
	assign Display[0] = ~(c[0] & blank);
	assign Display[1] = ~((~c[1]&~c[0] | c[1]&c[0]) & blank);
	assign Display[2] = ~((~c[1]&~c[0] | c[1]&c[0]) & blank);
	assign Display[3] = ~((c[1] | c[0]) & blank);
	assign Display[4] = ~(1 & blank);
	assign Display[5] = ~(1 & blank);
	assign Display[6] = ~(~c[1] & blank);
endmodule
