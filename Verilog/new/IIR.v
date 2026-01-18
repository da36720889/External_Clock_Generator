`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/30 15:53:25
// Design Name: 
// Module Name: IIR
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


module IIR#(WIDTH = 32, N = 12)(
    input wire clk,
    input wire rst_n,
    input wire signed [WIDTH-1:0] i_data,
    input wire i_valid,
    output reg signed [WIDTH - 1:0] o_data
    );
    
reg signed [WIDTH+N-1:0] Y_p1, Y,  E_scaled, X, o_data_r;
reg signed [WIDTH+N:0] E_n;

always @(*) begin
    E_n = X - Y_p1;
    E_scaled = E_n >>> N;
    Y = Y_p1 + E_scaled;
    o_data_r = X - Y;
end

always@(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
        X <= 0;
        Y_p1 <= 0;
        o_data <= 0;
    end else if(|i_data)begin
        X <= {i_data, 12'b0};
        Y_p1 <= Y;
        o_data <= o_data_r [N +:WIDTH];
    end
end


endmodule
