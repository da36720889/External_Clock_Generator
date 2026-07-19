`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/01/21 09:30:11
// Design Name: 
// Module Name: LPF_fixed
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


module LPF_fixed#(i_WIDTH = 16, WIDTH = 16, N_TAPS = 63, COE_DEC_WIDTH = 15)(
    input wire clk,
    input wire rst_n,
    input wire signed [i_WIDTH-1:0] i_data,
    input wire i_valid,
    output reg signed [WIDTH-1:0] o_data,
    output reg o_valid
);

reg signed [i_WIDTH-1:0] i_data_r;
reg i_valid_r;
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        i_data_r <= 0;
        i_valid_r <= 0;
    end else begin
        i_data_r <= i_data;
        i_valid_r <= i_valid;
    end
end

reg signed [i_WIDTH+5:0] data_d1, data_d2, data_d3, data_d4, data_d5, data_d6, data_d7, data_d8,
                 data_d9, data_d10, data_d11, data_d12, data_d13, data_d14, data_d15, data_d16,
                 data_d17, data_d18, data_d19, data_d20, data_d21, data_d22, data_d23, data_d24,
                 data_d25, data_d26, data_d27, data_d28, data_d29, data_d30, data_d31, data_d32,
                 data_d33, data_d34, data_d35, data_d36, data_d37, data_d38, data_d39, data_d40,
                 data_d41, data_d42, data_d43, data_d44, data_d45, data_d46, data_d47, data_d48,
                 data_d49, data_d50, data_d51, data_d52, data_d53, data_d54, data_d55, data_d56,
                 data_d57, data_d58, data_d59, data_d60, data_d61, data_d62, data_d63;

reg signed [i_WIDTH+16-1:0] N1, N2, N3, N4, N5, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16, N17,
                         N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31, N32, 
                         N33, N34, N35, N36, N37, N38, N39, N40, N41, N42, N43, N44, N45, N46, N47, 
                         N48, N49, N50, N51, N52, N53, N54, N55, N56, N57, N58, N59, N60, N61, N62, N63;

always@(*)begin
    N1 = (i_data_r * 16'shFFFC) >>> COE_DEC_WIDTH;
    N2 = (i_data_r * 16'sh000A) >>> COE_DEC_WIDTH;
    N3 = (i_data_r * 16'sh0018) >>> COE_DEC_WIDTH;
    N4 = (i_data_r * 16'sh0025) >>> COE_DEC_WIDTH;
    N5 = (i_data_r * 16'sh002B) >>> COE_DEC_WIDTH;
    N6 = (i_data_r * 16'sh0026) >>> COE_DEC_WIDTH;
    N7 = (i_data_r * 16'sh0010) >>> COE_DEC_WIDTH;
    N8 = (i_data_r * 16'shFFE9) >>> COE_DEC_WIDTH;
    N9 = (i_data_r * 16'shFFB8) >>> COE_DEC_WIDTH;
    N10 = (i_data_r * 16'shFF8A) >>> COE_DEC_WIDTH;
    N11 = (i_data_r * 16'shFF71) >>> COE_DEC_WIDTH;
    N12 = (i_data_r * 16'shFF80) >>> COE_DEC_WIDTH;
    N13 = (i_data_r * 16'shFFC2) >>> COE_DEC_WIDTH;
    N14 = (i_data_r * 16'sh0033) >>> COE_DEC_WIDTH;
    N15 = (i_data_r * 16'sh00BE) >>> COE_DEC_WIDTH;
    N16 = (i_data_r * 16'sh013D) >>> COE_DEC_WIDTH;
    N17 = (i_data_r * 16'sh0181) >>> COE_DEC_WIDTH;
    N18 = (i_data_r * 16'sh015F) >>> COE_DEC_WIDTH;
    N19 = (i_data_r * 16'sh00C0) >>> COE_DEC_WIDTH;
    N20 = (i_data_r * 16'shFFAC) >>> COE_DEC_WIDTH;
    N21 = (i_data_r * 16'shFE57) >>> COE_DEC_WIDTH;
    N22 = (i_data_r * 16'shFD14) >>> COE_DEC_WIDTH;
    N23 = (i_data_r * 16'shFC4F) >>> COE_DEC_WIDTH;
    N24 = (i_data_r * 16'shFC72) >>> COE_DEC_WIDTH;
    N25 = (i_data_r * 16'shFDC9) >>> COE_DEC_WIDTH;
    N26 = (i_data_r * 16'sh006E) >>> COE_DEC_WIDTH;
    N27 = (i_data_r * 16'sh0435) >>> COE_DEC_WIDTH;
    N28 = (i_data_r * 16'sh08B1) >>> COE_DEC_WIDTH;
    N29 = (i_data_r * 16'sh0D42) >>> COE_DEC_WIDTH;
    N30 = (i_data_r * 16'sh1133) >>> COE_DEC_WIDTH;
    N31 = (i_data_r * 16'sh13DF) >>> COE_DEC_WIDTH;
    N32 = (i_data_r * 16'sh14D1) >>> COE_DEC_WIDTH;
    N33 = (i_data_r * 16'sh13DF) >>> COE_DEC_WIDTH;
    N34 = (i_data_r * 16'sh1133) >>> COE_DEC_WIDTH;
    N35 = (i_data_r * 16'sh0D42) >>> COE_DEC_WIDTH;
    N36 = (i_data_r * 16'sh08B1) >>> COE_DEC_WIDTH;
    N37 = (i_data_r * 16'sh0435) >>> COE_DEC_WIDTH;
    N38 = (i_data_r * 16'sh006E) >>> COE_DEC_WIDTH;
    N39 = (i_data_r * 16'shFDC9) >>> COE_DEC_WIDTH;
    N40 = (i_data_r * 16'shFC72) >>> COE_DEC_WIDTH;
    N41 = (i_data_r * 16'shFC4F) >>> COE_DEC_WIDTH;
    N42 = (i_data_r * 16'shFD14) >>> COE_DEC_WIDTH;
    N43 = (i_data_r * 16'shFE57) >>> COE_DEC_WIDTH;
    N44 = (i_data_r * 16'shFFAC) >>> COE_DEC_WIDTH;
    N45 = (i_data_r * 16'sh00C0) >>> COE_DEC_WIDTH;
    N46 = (i_data_r * 16'sh015F) >>> COE_DEC_WIDTH;
    N47 = (i_data_r * 16'sh0181) >>> COE_DEC_WIDTH;
    N48 = (i_data_r * 16'sh013D) >>> COE_DEC_WIDTH;
    N49 = (i_data_r * 16'sh00BE) >>> COE_DEC_WIDTH;
    N50 = (i_data_r * 16'sh0033) >>> COE_DEC_WIDTH;
    N51 = (i_data_r * 16'shFFC2) >>> COE_DEC_WIDTH;
    N52 = (i_data_r * 16'shFF80) >>> COE_DEC_WIDTH;
    N53 = (i_data_r * 16'shFF71) >>> COE_DEC_WIDTH;
    N54 = (i_data_r * 16'shFF8A) >>> COE_DEC_WIDTH;
    N55 = (i_data_r * 16'shFFB8) >>> COE_DEC_WIDTH;
    N56 = (i_data_r * 16'shFFE9) >>> COE_DEC_WIDTH;
    N57 = (i_data_r * 16'sh0010) >>> COE_DEC_WIDTH;
    N58 = (i_data_r * 16'sh0026) >>> COE_DEC_WIDTH;
    N59 = (i_data_r * 16'sh002B) >>> COE_DEC_WIDTH;
    N60 = (i_data_r * 16'sh0025) >>> COE_DEC_WIDTH;
    N61 = (i_data_r * 16'sh0018) >>> COE_DEC_WIDTH;
    N62 = (i_data_r * 16'sh000A) >>> COE_DEC_WIDTH;
    N63 = (i_data_r * 16'shFFFC) >>> COE_DEC_WIDTH;
end

always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        data_d1 <= 0;
        data_d2 <= 0;
        data_d3 <= 0;
        data_d4 <= 0;
        data_d5 <= 0;
        data_d6 <= 0;
        data_d7 <= 0;
        data_d8 <= 0;
        data_d9 <= 0;
        data_d10 <= 0;
        data_d11 <= 0;
        data_d12 <= 0;
        data_d13 <= 0;
        data_d14 <= 0;
        data_d15 <= 0;
        data_d16 <= 0;
        data_d17 <= 0;
        data_d18 <= 0;
        data_d19 <= 0;
        data_d20 <= 0;
        data_d21 <= 0;
        data_d22 <= 0;
        data_d23 <= 0;
        data_d24 <= 0;
        data_d25 <= 0;
        data_d26 <= 0;
        data_d27 <= 0;
        data_d28 <= 0;
        data_d29 <= 0;
        data_d30 <= 0;
        data_d31 <= 0;
        data_d32 <= 0;
        data_d33 <= 0;
        data_d34 <= 0;
        data_d35 <= 0;
        data_d36 <= 0;
        data_d37 <= 0;
        data_d38 <= 0;
        data_d39 <= 0;
        data_d40 <= 0;
        data_d41 <= 0;
        data_d42 <= 0;
        data_d43 <= 0;
        data_d44 <= 0;
        data_d45 <= 0;
        data_d46 <= 0;
        data_d47 <= 0;
        data_d48 <= 0;
        data_d49 <= 0;
        data_d50 <= 0;
        data_d51 <= 0;
        data_d52 <= 0;
        data_d53 <= 0;
        data_d54 <= 0;
        data_d55 <= 0;
        data_d56 <= 0;
        data_d57 <= 0;
        data_d58 <= 0;  
        data_d59 <= 0;
        data_d60 <= 0;
        data_d61 <= 0;
        data_d62 <= 0;
        data_d63 <= 0;
    end else begin
        // Fc = 8.15MHz
        data_d1 <= N1;
        data_d2 <= N2 + data_d1;
        data_d3 <= N3 + data_d2;    
        data_d4 <= N4 + data_d3;
        data_d5 <= N5 + data_d4;
        data_d6 <= N6 + data_d5;
        data_d7 <= N7 + data_d6;
        data_d8 <= N8 + data_d7;
        data_d9 <= N9 + data_d8;
        data_d10 <= N10 + data_d9;
        data_d11 <= N11 + data_d10;
        data_d12 <= N12 + data_d11;
        data_d13 <= N13 + data_d12;
        data_d14 <= N14 + data_d13;
        data_d15 <= N15 + data_d14;
        data_d16 <= N16 + data_d15;
        data_d17 <= N17 + data_d16;
        data_d18 <= N18 + data_d17;
        data_d19 <= N19 + data_d18;
        data_d20 <= N20 + data_d19;
        data_d21 <= N21 + data_d20;
        data_d22 <= N22 + data_d21;
        data_d23 <= N23 + data_d22;
        data_d24 <= N24 + data_d23;
        data_d25 <= N25 + data_d24;
        data_d26 <= N26 + data_d25;
        data_d27 <= N27 + data_d26;
        data_d28 <= N28 + data_d27;
        data_d29 <= N29 + data_d28;
        data_d30 <= N30 + data_d29;
        data_d31 <= N31 + data_d30;
        data_d32 <= N32 + data_d31;
        data_d33 <= N33 + data_d32;
        data_d34 <= N34 + data_d33;
        data_d35 <= N35 + data_d34;
        data_d36 <= N36 + data_d35;
        data_d37 <= N37 + data_d36;
        data_d38 <= N38 + data_d37;
        data_d39 <= N39 + data_d38;
        data_d40 <= N40 + data_d39;
        data_d41 <= N41 + data_d40;
        data_d42 <= N42 + data_d41;
        data_d43 <= N43 + data_d42;
        data_d44 <= N44 + data_d43;
        data_d45 <= N45 + data_d44;
        data_d46 <= N46 + data_d45;
        data_d47 <= N47 + data_d46;
        data_d48 <= N48 + data_d47;
        data_d49 <= N49 + data_d48;
        data_d50 <= N50 + data_d49;
        data_d51 <= N51 + data_d50;
        data_d52 <= N52 + data_d51;
        data_d53 <= N53 + data_d52;
        data_d54 <= N54 + data_d53;
        data_d55 <= N55 + data_d54;
        data_d56 <= N56 + data_d55;
        data_d57 <= N57 + data_d56;
        data_d58 <= N58 + data_d57;
        data_d59 <= N59 + data_d58;
        data_d60 <= N60 + data_d59;
        data_d61 <= N61 + data_d60;
        data_d62 <= N62 + data_d61;
        data_d63 <= N63 + data_d62;
    end
end

always@(*)begin
    o_data = data_d63[0 +: WIDTH];
end

reg i_valid_d1, i_valid_d2, i_valid_d3, i_valid_d4, i_valid_d5, i_valid_d6, i_valid_d7, i_valid_d8,
    i_valid_d9, i_valid_d10, i_valid_d11, i_valid_d12, i_valid_d13, i_valid_d14, i_valid_d15, i_valid_d16,
    i_valid_d17, i_valid_d18, i_valid_d19, i_valid_d20, i_valid_d21, i_valid_d22, i_valid_d23, i_valid_d24,
    i_valid_d25, i_valid_d26, i_valid_d27, i_valid_d28, i_valid_d29, i_valid_d30, i_valid_d31, i_valid_d32;
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
        i_valid_d12 <= 0;
        i_valid_d13 <= 0;
        i_valid_d14 <= 0;
        i_valid_d15 <= 0;
        i_valid_d16 <= 0;
        i_valid_d17 <= 0;
        i_valid_d18 <= 0;
        i_valid_d19 <= 0;
        i_valid_d20 <= 0;
        i_valid_d21 <= 0;
        i_valid_d22 <= 0;
        i_valid_d23 <= 0;
        i_valid_d24 <= 0;
        i_valid_d25 <= 0;
        i_valid_d26 <= 0;
        i_valid_d27 <= 0;
        i_valid_d28 <= 0;
        i_valid_d29 <= 0;
        i_valid_d30 <= 0;
        i_valid_d31 <= 0;
        i_valid_d32 <= 0;
    end else begin
        i_valid_d1 <= i_valid_r;
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
        i_valid_d12 <= i_valid_d11;
        i_valid_d13 <= i_valid_d12;
        i_valid_d14 <= i_valid_d13;
        i_valid_d15 <= i_valid_d14;
        i_valid_d16 <= i_valid_d15;
        i_valid_d17 <= i_valid_d16;
        i_valid_d18 <= i_valid_d17;
        i_valid_d19 <= i_valid_d18;
        i_valid_d20 <= i_valid_d19;
        i_valid_d21 <= i_valid_d20;
        i_valid_d22 <= i_valid_d21;
        i_valid_d23 <= i_valid_d22;
        i_valid_d24 <= i_valid_d23;
        i_valid_d25 <= i_valid_d24;
        i_valid_d26 <= i_valid_d25;
        i_valid_d27 <= i_valid_d26;
        i_valid_d28 <= i_valid_d27;
        i_valid_d29 <= i_valid_d28;
        i_valid_d30 <= i_valid_d29;
        i_valid_d31 <= i_valid_d30;
        i_valid_d32 <= i_valid_d31;
    end
end
always@(*)begin
    o_valid = i_valid_d32;
end



endmodule
