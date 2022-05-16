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