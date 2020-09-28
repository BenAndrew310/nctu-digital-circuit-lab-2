`timescale 1ns / 1ps

module mmult(
	input clk, // Clock signal.
	input reset_n, // Reset signal (negative logic).
	input enable, // Activation signal for matrix
	// multiplication (tells the circuit
	// that A and B are ready for use).
	input [0:9*8-1] A_mat, // A matrix.
	input [0:9*8-1] B_mat, // B matrix.
	output valid, // Signals that the output is valid
	// to read.
	output reg [0:9*17-1] C_mat // The result of A x B.
);

reg v;
integer i,row_number=0,column_number=0;
assign valid = v;

always @ (posedge clk, reset_n) begin
	if (enable) begin
		v <= 0;
		C_mat[0:16]    <= A_mat[0:7]*B_mat[0:7]     +  A_mat[8:15]*B_mat[24:31]      +  A_mat[16:23]*B_mat[48:55];
        C_mat[17:33]   <= A_mat[0:7]*B_mat[8:15]    +  A_mat[8:15]*B_mat[32:39]      +  A_mat[16:23]*B_mat[56:63];
        C_mat[34:50]   <= A_mat[0:7]*B_mat[16:23]   +  A_mat[8:15]*B_mat[40:47]      +  A_mat[16:23]*B_mat[64:71];
        
        #10
        v <= 0; 
        C_mat[51:67]   <= A_mat[24:31]*B_mat[0:7]   +  A_mat[32:39]*B_mat[24:31]     +  A_mat[40:47]*B_mat[48:55];
        C_mat[68:84]   <= A_mat[24:31]*B_mat[8:15]  +  A_mat[32:39]*B_mat[32:39]     +  A_mat[40:47]*B_mat[56:63];
        C_mat[85:101]  <= A_mat[24:31]*B_mat[16:23] +  A_mat[32:39]*B_mat[40:47]     +  A_mat[40:47]*B_mat[64:71];
        
        #10
        v <= 0;
        C_mat[102:118] <= A_mat[48:55]*B_mat[0:7]   +  A_mat[56:63]*B_mat[24:31]     +  A_mat[64:71]*B_mat[48:55];
        C_mat[119:135] <= A_mat[48:55]*B_mat[8:15]  +  A_mat[56:63]*B_mat[32:39]     +  A_mat[64:71]*B_mat[56:63];
        C_mat[136:152] <= A_mat[48:55]*B_mat[16:23] +  A_mat[56:63]*B_mat[40:47]     +  A_mat[64:71]*B_mat[64:71];
		
		#10
		v <= 1;
	end

end

endmodule