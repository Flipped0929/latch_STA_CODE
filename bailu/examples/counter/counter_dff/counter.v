`timescale 1ns / 1ps

module counter (
    input wire clk,
    input wire rst_n,
    input wire en,
    output wire [3:0] count
);

reg [3:0] count_o;

// 低有效异步复位优先于计数使能。
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        count_o <= 4'd0;
    end else if (en) begin
        count_o <= count_o + 4'd1;
    end
end

assign count = count_o;

endmodule
