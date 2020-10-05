`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/30/2020 07:44:36 PM
// Design Name: 
// Module Name: mmult
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


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
    
    reg val=0;
    reg flag=0;
    integer i,row_number=0,column_number=0;
    
    assign valid = val;
    
    always @ (posedge clk, reset_n) begin
        if(!enable||!reset_n) begin
            C_mat[0:152] <= 0;
            flag <= 0;
            row_number = 0;
            column_number = 0;
        end
        val <= 0;
        if (enable) begin
            for (i=0;i<9;i=i+1)
                begin
                    C_mat[i*17 +: 17] <= A_mat[24*row_number +: 8]*B_mat[8*column_number +: 8] + A_mat[24*row_number+8 +: 8]*B_mat[8*column_number+24 +: 8] + A_mat[24*row_number+16 +: 8]*B_mat[8*column_number+48 +: 8];
                    column_number=column_number+1;
                    if (i%3==2) begin
                        row_number=row_number+1;
                        column_number=0;
                    end
                    if (i==8) flag=1;
                end
        end
    end
    
    always @ (posedge flag) begin
        val <= 1;
        flag <= 0;
    end
    
endmodule
