`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/05 08:52:18
// Design Name: 
// Module Name: DCremover
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


module DCremover#(WIDTH = 16)(
    input wire clk,
    input wire rst_n,
    input wire [WIDTH-1:0] i_data,
    input wire i_valid,
    output reg signed [WIDTH-1:0] o_data,
    output reg o_valid
    );

reg signed [WIDTH+16:0] i_data_r, o_data_w, o_data_r;

localparam Alpha = 16'sh7000;   //Q1.15 1 - 1>>12
reg signed [WIDTH+16:0] inter_add, inter_add_d1, inter_mul, inout_add, inout_sub;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) i_data_r <= 0;
    else if(i_valid)i_data_r <= {1'b0, i_data, 16'd0};
    else i_data_r <= i_data_r;
end

always@(*)begin
    // inter_mul = (inter_add_d1[15]) ? ((inter_add_d1[WIDTH+16-1:16]+1) * Alpha) : (inter_add_d1[WIDTH+16-1:16] * Alpha);
    inter_mul = inter_add_d1 * Alpha >>> 16;
    inter_add = i_data_r + inter_mul;
    
end

always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        inter_add_d1 <= 0;
        inout_add <= 0;
        inout_sub <= 0;
    end else if(i_valid)begin
        inter_add_d1 <= inter_add;
        inout_add <= inter_add;
        inout_sub <= inter_add_d1;
    end
end

always@(*)begin
    o_data_w = inout_add - inout_sub;
    o_data = o_data_r >>> 15;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) o_data_r <= 0;
    else o_data_r <= o_data_w;
end

reg i_valid_d1, i_valid_d2, i_valid_d3;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        i_valid_d1 <= 0;
        i_valid_d2 <= 0;
        i_valid_d3 <= 0;
    end else begin
        i_valid_d1 <= i_valid;
        i_valid_d2 <= i_valid_d1;
        i_valid_d3 <= i_valid_d2;
    end
end
always@(*)begin
    o_valid = i_valid_d3;
end

endmodule
