`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/12 14:31:07
// Design Name: 
// Module Name: arctan_unwrap
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


module arctan_unwrap#(WIDTH = 32, theta_WIDTH = 32, DECIMAL_WIDTH = 15)(
    input wire clk,
    input wire rst_n,
    input wire signed [WIDTH - 1 : 0] i_data_woHT,
    input wire signed [WIDTH - 1 : 0] i_data_wHT,
    input wire i_valid,
    output reg signed [DECIMAL_WIDTH : 0] o_data,
    output reg trigger,
    output reg o_ready
    );

wire signed [WIDTH:0] signal_diff;
reg signed [WIDTH:0] signal_diff_r;
reg detector;
assign signal_diff = i_data_wHT - i_data_woHT;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) signal_diff_r <= 0;
    else signal_diff_r <= signal_diff;
end
always@(*)begin
    if(signal_diff[WIDTH] != signal_diff_r[WIDTH]) detector = 1;
    else detector = 0;
end

// CORDIC 4 arctan
wire signed [2*WIDTH-1:0] combineinput;
wire signed [theta_WIDTH-1:0] o_theta;
wire signed [WIDTH-1:0] i_data_wHT_norm, i_data_woHT_norm;
assign i_data_wHT_norm = i_data_wHT;// <<< 14;
assign i_data_woHT_norm = i_data_woHT;// <<< 14;
assign combineinput = {i_data_wHT_norm, i_data_woHT_norm}; //img, real    
wire arctan_ovalid;
cordic_0 u_arctan(
    .aclk(clk), // : IN STD_LOGIC;
    .s_axis_cartesian_tvalid(1), // : IN STD_LOGIC;
    .s_axis_cartesian_tdata(combineinput),  // : IN STD_LOGIC_VECTOR(63 DOWNTO 0);
    .m_axis_dout_tvalid(arctan_ovalid),  // : OUT STD_LOGIC;
    .m_axis_dout_tdata(o_theta)    // : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);

wire signed [theta_WIDTH:0] o_theta_w;
assign o_theta_w =(o_theta[theta_WIDTH-1]) ? {o_theta[theta_WIDTH-1], 1'sb1, o_theta[theta_WIDTH-2:0]} 
                                           : {o_theta[theta_WIDTH-1], 1'sb0, o_theta[theta_WIDTH-2:0]};   // extend integer bit for unwrap comparison

reg signed [theta_WIDTH:0] o_theta_r;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n) o_theta_r <= 0;
    else o_theta_r <= o_theta_w;
end

// **************************************************************************************************************
// unwrap -- compare the difference, if over 0.5pi, compensate with 2pi
localparam FIXED_FREQ = 25; //o_theta's format: Q3.29, shift 28 make 0.5rad per trigger
wire signed [theta_WIDTH :0] theta_diff;
wire [1:0] unwrap_sig;  // 00: wo unwrap, 01: minus 2pi, 10: plus 2pi
assign theta_diff = o_theta_w - o_theta_r;
assign unwrap_sig = (theta_diff > 33'sh010000000) ? 2'b01 : ((theta_diff < -33'sh010000000) ? 2'b10 : 2'b00);
reg signed [theta_WIDTH*2:0] theta_acc;

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)theta_acc <= 0;
    else begin
        case(unwrap_sig)
        2'b01 : theta_acc <= theta_acc - 48'sh0040000000;
        2'b10 : theta_acc <= theta_acc + 48'sh0040000000;
        default : theta_acc <= theta_acc;
        endcase
    end
end

reg signed [theta_WIDTH*1 + 10:0] unwrapped_theta_w;
reg signed [theta_WIDTH*1:0] unwrapped_theta;
reg signed [theta_WIDTH*1:0] unwrapped_theta_r;

always@(*)begin
    unwrapped_theta_w = (o_theta_r + theta_acc) >>> FIXED_FREQ;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n) unwrapped_theta_r <= 0;
    else unwrapped_theta_r <= unwrapped_theta_w;
end

wire signed [theta_WIDTH*1:0] unwrapped_diff;
assign unwrapped_diff = unwrapped_theta_w - unwrapped_theta_r;

localparam K_grid = 33'sb0_000_01000_0000_0000_0000_0000_0000_0000; //33'sh01_0000000;
reg signed [theta_WIDTH*1:0] K_grid_scaled = K_grid >>> (FIXED_FREQ); //<<< (29-FIXED_FREQ);
reg signed [theta_WIDTH*1:0] diff_sum;
reg trigger_w;
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)begin
        diff_sum <= 0;
        trigger_w <= 0;
    end 
    else if(/*|i_data_woHT != 0*/i_valid)begin
        if(diff_sum >= K_grid_scaled)begin
            diff_sum <= 0 + unwrapped_diff;
            trigger_w <= 1;
        end else if(diff_sum <= -K_grid_scaled)begin
            diff_sum <= 0 + unwrapped_diff;
            trigger_w <= 1;
        end else begin
            diff_sum <= diff_sum + unwrapped_diff;
            trigger_w <= 0;
        end
    end 
end

always@(*)begin
    if(i_valid)
        trigger = trigger_w && clk;
    else trigger = 0;
end

// fixed point decimal (29-FIXED_FREQ) bits, if interpolation is needed, K_grid_scaled should pass to oct_remapping
always@(*)begin
    o_data = diff_sum[DECIMAL_WIDTH:0];
end

endmodule