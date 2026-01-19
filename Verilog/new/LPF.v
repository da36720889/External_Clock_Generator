`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/12/30 15:52:39
// Design Name: 
// Module Name: LPF
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



module LPF#(i_WIDTH = 16, WIDTH = 32, N_TAPS = 63)(
    input wire clk,
    input wire rst_n,
    input wire signed [i_WIDTH-1:0] i_data,
    input wire i_valid,
    output reg signed [WIDTH-1:0] o_data,
    output reg o_valid
);

// reg [6:0] counter;
// always@(posedge clk or negedge rst_n)begin
//     if(!rst_n) counter <= 0;
//     else if(i_valid)begin
//         if(counter == N_TAPS) counter <= counter;
//         else counter <= counter + 1;
//     end else counter <= 0;
// end
// always@(*)begin
//     o_valid = (counter == N_TAPS) ? 1 : 0;
// end

reg signed [15+WIDTH:0] data_d1, data_d2, data_d3, data_d4, data_d5, data_d6, data_d7, data_d8,
                 data_d9, data_d10, data_d11, data_d12, data_d13, data_d14, data_d15, data_d16,
                 data_d17, data_d18, data_d19, data_d20, data_d21, data_d22, data_d23, data_d24,
                 data_d25, data_d26, data_d27, data_d28, data_d29, data_d30, data_d31, data_d32,
                 data_d33, data_d34, data_d35, data_d36, data_d37, data_d38, data_d39, data_d40,
                 data_d41, data_d42, data_d43, data_d44, data_d45, data_d46, data_d47, data_d48,
                 data_d49, data_d50, data_d51, data_d52, data_d53, data_d54, data_d55, data_d56,
                 data_d57, data_d58, data_d59, data_d60, data_d61, data_d62, data_d63;

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
        data_d1 <= i_data * 16'shFFFC;
        data_d2 <= i_data * 16'sh000A + data_d1;
        data_d3 <= i_data * 16'sh0018 + data_d2;    
        data_d4 <= i_data * 16'sh0025 + data_d3;
        data_d5 <= i_data * 16'sh002B + data_d4;
        data_d6 <= i_data * 16'sh0026 + data_d5;
        data_d7 <= i_data * 16'sh0010 + data_d6;
        data_d8 <= i_data * 16'shFFE9 + data_d7;
        data_d9 <= i_data * 16'shFFB8 + data_d8;
        data_d10 <= i_data * 16'shFF8A + data_d9;
        data_d11 <= i_data * 16'shFF71 + data_d10;
        data_d12 <= i_data * 16'shFF80 + data_d11;
        data_d13 <= i_data * 16'shFFC2 + data_d12;
        data_d14 <= i_data * 16'sh0033 + data_d13;
        data_d15 <= i_data * 16'sh00BE + data_d14;
        data_d16 <= i_data * 16'sh013D + data_d15;
        data_d17 <= i_data * 16'sh0181 + data_d16;
        data_d18 <= i_data * 16'sh015F + data_d17;
        data_d19 <= i_data * 16'sh00C0 + data_d18;
        data_d20 <= i_data * 16'shFFAC + data_d19;
        data_d21 <= i_data * 16'shFE57 + data_d20;
        data_d22 <= i_data * 16'shFD14 + data_d21;
        data_d23 <= i_data * 16'shFC4F + data_d22;
        data_d24 <= i_data * 16'shFC72 + data_d23;
        data_d25 <= i_data * 16'shFDC9 + data_d24;  
        data_d26 <= i_data * 16'sh006E + data_d25;  
        data_d27 <= i_data * 16'sh0435 + data_d26;
        data_d28 <= i_data * 16'sh08B1 + data_d27;
        data_d29 <= i_data * 16'sh0D42 + data_d28;
        data_d30 <= i_data * 16'sh1133 + data_d29;
        data_d31 <= i_data * 16'sh13DF + data_d30;
        data_d32 <= i_data * 16'sh14D1 + data_d31;
        data_d33 <= i_data * 16'sh13DF + data_d32;
        data_d34 <= i_data * 16'sh1133 + data_d33;
        data_d35 <= i_data * 16'sh0D42 + data_d34;
        data_d36 <= i_data * 16'sh08B1 + data_d35;
        data_d37 <= i_data * 16'sh0435 + data_d36;
        data_d38 <= i_data * 16'sh006E + data_d37;
        data_d39 <= i_data * 16'shFDC9 + data_d38;
        data_d40 <= i_data * 16'shFC72 + data_d39;
        data_d41 <= i_data * 16'shFC4F + data_d40;
        data_d42 <= i_data * 16'shFD14 + data_d41;
        data_d43 <= i_data * 16'shFE57 + data_d42;
        data_d44 <= i_data * 16'shFFAC + data_d43;
        data_d45 <= i_data * 16'sh00C0 + data_d44;
        data_d46 <= i_data * 16'sh015F + data_d45;
        data_d47 <= i_data * 16'sh0181 + data_d46;
        data_d48 <= i_data * 16'sh013D + data_d47;
        data_d49 <= i_data * 16'sh00BE + data_d48;
        data_d50 <= i_data * 16'sh0033 + data_d49;
        data_d51 <= i_data * 16'shFFC2 + data_d50;
        data_d52 <= i_data * 16'shFF80 + data_d51;
        data_d53 <= i_data * 16'shFF71 + data_d52;
        data_d54 <= i_data * 16'shFF8A + data_d53;
        data_d55 <= i_data * 16'shFFB8 + data_d54;
        data_d56 <= i_data * 16'shFFE9 + data_d55;
        data_d57 <= i_data * 16'sh0010 + data_d56;
        data_d58 <= i_data * 16'sh0026 + data_d57;
        data_d59 <= i_data * 16'sh002B + data_d58;
        data_d60 <= i_data * 16'sh0025 + data_d59;
        data_d61 <= i_data * 16'sh0018 + data_d60;
        data_d62 <= i_data * 16'sh000A + data_d61;
        data_d63 <= i_data * 16'shFFFC + data_d62;
    end
end

always@(*)begin
    o_data = data_d63[15 +: WIDTH];
    // o_data = data_d63[15+WIDTH-1:15];
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