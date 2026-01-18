`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/07 14:33:36
// Design Name: 
// Module Name: tb_mzi2k_hilbert
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


module tb_mzi2k_hilbert#(WIDTH = 16)();

reg clk, rst_n, i_valid, i_enable;
wire o_valid_DC, o_valid_LPF, o_valid_HT;
reg i_valid_LPF, i_valid_HT, i_valid_ARC;

reg signed [WIDTH-1:0] i_data;
wire signed [WIDTH - 1:0] o_data;
reg signed [WIDTH-1:0] i_data_lpf;
wire signed [WIDTH*2-1:0] o_data_lpf;
reg signed [WIDTH*2-1:0] i_data_iir;
wire signed [WIDTH*2-1:0] o_data_iir;

reg signed [WIDTH*2-1:0] i_data_hilbert;
reg signed [WIDTH*2-1:0] i_data_arc_i;
reg signed [WIDTH*2-1:0] i_data_arc_r;
wire signed [WIDTH*2-1:0] o_data_hilbert_i, o_data_hilbert_r;
wire signed [WIDTH-1:0] o_data_arc;
wire o_data_trigger;

always@(*)begin
    i_data_lpf = o_data;
    i_data_iir = o_data_lpf;
    i_data_hilbert = o_data_lpf;
    i_data_arc_i = o_data_hilbert_i;
    i_data_arc_r = o_data_hilbert_r;
end

always@(*)begin
    i_valid_LPF = o_valid_DC;
    i_valid_HT = o_valid_LPF;
    i_valid_ARC = o_valid_HT;
end

DCremover uu_DCremover(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(i_data),
    .i_valid(i_valid),
    .o_data(o_data),
    .o_valid(o_valid_DC)
    );

LPF uu_lpf(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(i_data_lpf),
    .i_valid(i_valid_LPF),
    .o_data(o_data_lpf),
    .o_valid(o_valid_LPF)
    );

IIR uu_IIR(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(i_data_iir),
    .i_valid(i_valid),
    .o_data(o_data_iir)
    );

hilbert_iir uu_hilbert_iir(
    .clk(clk),
    .rst_n(rst_n),
    .i_data(i_data_hilbert),
    .i_valid(i_valid_HT),
    .o_data_i(o_data_hilbert_i),
    .o_data_r(o_data_hilbert_r),
    .o_valid(o_valid_HT)
);

arctan_unwrap uu_arctan(
    .clk(clk),
    .rst_n(rst_n),
    .i_data_woHT(i_data_arc_r),
    .i_data_wHT(i_data_arc_i),
    .i_valid(i_valid_ARC),
    .o_data(o_data_arc),
    .trigger(o_data_trigger),
    .o_ready()
);

reg [WIDTH-1:0] i_data_oct, i_data_fraction;
reg i_data_trigger;
wire [WIDTH-1:0] o_data_oct;
wire o_data_oct_valid;
always@(*)begin
    i_data_fraction = o_data_arc;
    i_data_trigger = o_data_trigger;
end

// oct_remapping uu_oct(
//     .clk(clk),
//     .rst_n(rst_n),
//     .i_data(i_data_oct),
//     .i_fraction(i_data_fraction),
//     .i_valid(i_valid),
//     .trigger(i_data_trigger),
//     .o_data(o_data_oct),
//     .o_valid(o_data_oct_valid)
//     );

reg [15: 0] k_clk_data [0:1420800];
reg [15: 0] oct_data [0:1420800];

initial $readmemh("C:/Users/yun-tien.tsai/Downloads/raw_k_clk.txt",k_clk_data);
initial $readmemh("C:/Users/yun-tien.tsai/Downloads/raw_oct_signal.txt",oct_data);

always #10 clk = ~clk;

integer i = 0;
integer output_file;
reg [10:0] counter  = 0;
always@(posedge clk)begin
    if(o_data_trigger)
    counter <= counter + 1;
end

initial begin
    output_file = $fopen("C:/Users/yun-tien.tsai/Downloads/oct_signal_mzi2k.coe", "w");
    forever begin
        @(posedge o_data_trigger);
            if(i >= 0)
            $fwrite(output_file, "%h\n", oct_data[i-70]); 
    end
end

localparam DELAY = 51;


initial begin
    clk = 0;
    rst_n = 1;
    i_valid = 0;
    i_enable = 0;
    #300;
    rst_n = 0;
    #500;
    rst_n = 1;
    #2000;
    i_valid = 1;
    i_enable = 1;

    for( i=0; i<14208; i = i + 1) begin
        i_valid = 0;
        @(negedge clk)
            i_valid <= 1;
            i_data <= k_clk_data[i];
            if(i >= DELAY) i_data_oct <= oct_data[i-DELAY];
    end

    
    i_valid = 0;


    #100;
    $finish;


end

endmodule
