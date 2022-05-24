// Lab 1 

// Part 1
module part_1(SW, LEDR);
	input [17:0]SW;
	output [17:0]LEDR;
	assign LEDR = SW;
endmodule

// Part 2
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

// Part 3
module part3(SW, LEDR, LEDG);
	input [17:0]SW;
	output [17:0]LEDR;
	output [2:0]LEDG;
	
	wire [2:0] S, U, V, W, X, Y, M;
	wire M00, M01, M02, M10, M11, M12, M20, M21, M22;
	
	assign S = SW[17:15]; 
	assign U = SW[14:12];
	assign V = SW[11:9];
	assign W = SW[8:6];
	assign X = SW[5:3];	
	assign Y = SW[2:0];
	assign LEDR = SW;
	assign LEDG = M;    
	
	assign M00 = (~S[0] & U[0] | S[0] & V[0]);
	assign M01 = (~S[0] & W[0] | S[0] & X[0]);
	assign M02 = (~S[1] & M00 | S[1] & M01);
	assign M10 = (~S[0] & U[1] | S[0] & V[1]);
	assign M11 = (~S[0] & W[1] | S[0] & X[1]);
	assign M12 = (~S[1] & M10 | S[1] & M11);
	assign M20 = (~S[0] & U[2] | S[0] & V[2]);
	assign M21 = (~S[0] & W[2] | S[0] & X[2]);
	assign M22 = (~S[1] & M20 | S[1] & M21);
	
	assign M[0] = (~S[2] & M02 | S[2] & Y[0]);
	assign M[1] = (~S[2] & M12 | S[2] & Y[1]);
	assign M[2] = (~S[2] & M22 | S[2] & Y[2]);
endmodule

// Part 4
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

// Part 5
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

// Part 6
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