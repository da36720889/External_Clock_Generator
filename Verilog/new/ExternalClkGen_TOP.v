`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/08 09:32:43
// Design Name: 
// Module Name: ExternalClkGen_TOP
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


module ExternalClkGen_TOP#(WIDTH = 16)(
    input wire clk,
    input wire rst_n,
    input wire [WIDTH-1:0] i_data,
    input wire i_valid,
    output reg o_trigger,
    output reg o_valid 
    );

reg [WIDTH-1:0] i_data_r;
reg i_valid_r;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) begin
        i_data_r <= 0;
        i_valid_r <= 0;
    end else begin
        i_data_r <= i_data;
        i_valid_r <= i_valid;
    end
end

reg [WIDTH-1:0] i_DC;
reg signed [WIDTH-1:0] i_LPF;
reg signed [WIDTH*2-1:0] i_IIR, i_HILBERT, i_ARCTAN_i, i_ARCTAN_r;
wire signed [WIDTH-1:0] o_DC;
wire signed [WIDTH*2-1:0] o_LPF, o_IIR, o_HILBERT_i, o_HILBERT_r;
wire trigger_w;

reg i_valid_LPF, i_valid_HT, i_valid_ARC;
wire o_valid_DC, o_valid_LPF, o_valid_HT;

always@(*)begin
    i_DC = i_data_r;
    i_LPF = o_DC;
    // i_IIR = o_LPF;
    // i_HILBERT = o_IIR;
    i_HILBERT = o_LPF;
    i_ARCTAN_i = o_HILBERT_i;
    i_ARCTAN_r = o_HILBERT_r;

    i_valid_LPF = o_valid_DC;
    i_valid_HT = o_valid_LPF;
    i_valid_ARC = o_valid_HT;
end

// always@(posedge clk or negedge rst_n)begin
//     if(!rst_n) o_trigger <= 0;
//     else o_trigger <= trigger_w;
// end
always@(*)begin
    o_trigger = trigger_w;
end

DCremover u_DCremover(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(i_DC),
    .i_valid(i_valid_r),
    .o_data(o_DC),
    .o_valid(o_valid_DC)
    );
    

LPF u_lpf(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(i_LPF),
    .i_valid(i_valid_LPF),
    .o_data(o_LPF),
    .o_valid(o_valid_LPF)
    );

// IIR u_IIR(
//     .clk(clk),
//     .rst_n(rst_n),
//     .i_data(i_IIR),
//     .i_valid(i_valid),
//     .o_data(o_IIR)
//     );

hilbert_iir uu_hilbert_iir(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(i_HILBERT),
    .i_valid(i_valid_HT),
    .o_data_i(o_HILBERT_i),
    .o_data_r(o_HILBERT_r),
    .o_valid(o_valid_HT)
);

arctan_unwrap uu_arctan_unwrap(
    .clk(clk),
    .rst_n(rst_n),
    .i_data_woHT(i_ARCTAN_r),
    .i_data_wHT(i_ARCTAN_i),
    .i_valid(i_valid_ARC),
    .o_data(),
    .trigger(trigger_w),
    .o_ready()
);

endmodule
