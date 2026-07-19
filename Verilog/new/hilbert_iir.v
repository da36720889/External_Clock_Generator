`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/07 15:16:52
// Design Name: 
// Module Name: hilbert_iir
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


module hilbert_iir#(WIDTH = 16, COE_WIDTH = 16)(
    input wire clk,
    input wire rst_n,
    input wire signed [WIDTH-1:0] i_data,
    input wire i_valid,
    output reg signed [WIDTH - 1:0] o_data_i,
    output reg signed [WIDTH - 1:0] o_data_r,
    output reg o_valid
);

localparam i_coef1 = 16'sh31EC;
localparam i_coef2 = 16'sh71FF;
localparam r_coef1 = 16'sh0F70;
localparam r_coef2 = 16'sh54D7;

// reg for input
reg signed [WIDTH-1:0] i_data_r;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) i_data_r <= 0;
    else i_data_r <= i_data;
end

// rename input for real, imagine part
reg signed [WIDTH-1:0] im_data;
wire signed [WIDTH-1:0] re_data;
assign re_data = i_data_r;
always@(posedge clk or negedge rst_n)begin  // imaginary part delay 1 clk
    if(!rst_n) im_data <= 0;
    else im_data <= i_data_r;
end

reg signed [WIDTH-1:0] im_first_result_r, re_first_result_r;
/////////////////////////////////////////////////////////////////////////////////////////
// calculate for first part of imag part 
reg signed [WIDTH+COE_WIDTH:0] im_mul1_o;
reg signed [WIDTH-1:0] im_sub1_o, im_add1_d0, im_add1_d1, im_add1_d2;
reg signed [WIDTH-1:0] im_first_result;

always@(*)begin
    im_sub1_o = im_add1_d2 - im_data;
    im_mul1_o = (im_sub1_o * i_coef1) >>> 15;
    im_add1_d0 = im_mul1_o + im_data;
    im_first_result = im_add1_d2 + im_mul1_o;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        im_add1_d1 <= 0;
        im_add1_d2 <= 0;
    end else begin
        im_add1_d1 <= im_add1_d0;
        im_add1_d2 <= im_add1_d1;
    end
end
/////////////////////////////////////////////////////////////////////////////////////////
// calculate for second part of imag part 
reg signed [WIDTH+COE_WIDTH:0] im_mul2_o;
reg signed [WIDTH-1:0] im_sub2_o, im_add2_d0, im_add2_d1, im_add2_d2;
reg signed [WIDTH-1:0] im_result_r;

always@(*)begin
    im_sub2_o = im_add2_d2 - im_first_result_r;
    im_mul2_o = (im_sub2_o * i_coef2) >>> 15;
    im_add2_d0 = im_mul2_o + im_first_result_r;
    im_result_r = im_add2_d2 + im_mul2_o;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        im_add2_d1 <= 0;
        im_add2_d2 <= 0;
    end else begin
        im_add2_d1 <= im_add2_d0;
        im_add2_d2 <= im_add2_d1;
    end
end
/////////////////////////////////////////////////////////////////////////////////////////
// calculate for first part of real part 
reg signed [WIDTH+COE_WIDTH:0] re_mul1_o;
reg signed [WIDTH-1:0] re_sub1_o, re_add1_d0, re_add1_d1, re_add1_d2;
reg signed [WIDTH-1:0] re_first_result;

always@(*)begin
    re_sub1_o = re_add1_d2 - re_data;
    re_mul1_o = (re_sub1_o * r_coef1) >>> 15;
    re_add1_d0 = re_mul1_o + re_data;
    re_first_result = re_add1_d2 + re_mul1_o;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        re_add1_d1 <= 0;
        re_add1_d2 <= 0;
    end else begin
        re_add1_d1 <= re_add1_d0;
        re_add1_d2 <= re_add1_d1;
    end
end
/////////////////////////////////////////////////////////////////////////////////////////
// calculate for second part of real part 
reg signed [WIDTH+COE_WIDTH:0] re_mul2_o;
reg signed [WIDTH-1:0] re_sub2_o, re_add2_d0, re_add2_d1, re_add2_d2;
reg signed [WIDTH-1:0] re_result_r;

always@(*)begin
    re_sub2_o = re_add2_d2 - re_first_result_r;
    re_mul2_o = (re_sub2_o * r_coef2) >>> 15;
    re_add2_d0 = re_mul2_o + re_first_result_r;
    re_result_r = re_add2_d2 + re_mul2_o;
end
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        re_add2_d1 <= 0;
        re_add2_d2 <= 0;
    end else begin
        re_add2_d1 <= re_add2_d0;
        re_add2_d2 <= re_add2_d1;
    end
end
///////////////////////////////////////////////////////////////////////////////////////
// pipeline for first and second part of calculation
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        im_first_result_r <= 0;
        re_first_result_r <= 0;
    end else begin
        im_first_result_r <= im_first_result;
        re_first_result_r <= re_first_result;
    end
end
///////////////////////////////////////////////////////////////////////////////////////
reg signed [WIDTH - 1:0] o_data_i_r, o_data_r_r;    // hold time violation, add additional registers
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        o_data_i_r <= 0;
        o_data_r_r <= 0;
        o_data_i <= 0;
        o_data_r <= 0;
    end else begin
        o_data_i_r <= im_result_r;
        o_data_r_r <= re_result_r;
        o_data_i <= o_data_i_r;
        o_data_r <= o_data_r_r;
    end
end

// ** IIR do not have regular latency can be count, here use nearest delay
reg i_valid_d1, i_valid_d2, i_valid_d3, i_valid_d4, i_valid_d5, i_valid_d6, i_valid_d7,
         i_valid_d8, i_valid_d9, i_valid_d10, i_valid_d11;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        i_valid_d1 <= 0;
        i_valid_d2 <= 0;
        i_valid_d3 <= 0;
        i_valid_d4 <= 0;
        i_valid_d5 <= 0;
        i_valid_d6 <= 0;
        i_valid_d7 <= 0;
        i_valid_d8 <= 0;
        i_valid_d9 <= 0;
        i_valid_d10 <= 0;
        i_valid_d11 <= 0;
    end else begin
        i_valid_d1 <= i_valid;
        i_valid_d2 <= i_valid_d1;
        i_valid_d3 <= i_valid_d2;
        i_valid_d4 <= i_valid_d3;
        i_valid_d5 <= i_valid_d4;
        i_valid_d6 <= i_valid_d5;
        i_valid_d7 <= i_valid_d6;
        i_valid_d8 <= i_valid_d7;
        i_valid_d9 <= i_valid_d8;
        i_valid_d10 <= i_valid_d9;
        i_valid_d11 <= i_valid_d10;
    end
end
always@(*)begin
    o_valid = i_valid_d11;
end

endmodule
