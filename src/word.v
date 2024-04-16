/*
 * Copyright (c) 2024 Andrew Dona-Couch
 * SPDX-License-Identifier: Apache-2.0
 */

module word (
    input  wire       clk,
    input  wire       rst_n,

    input  wire [7:0] in_x,
    input  wire [7:0] in_y,
    input  wire [7:0] in_x_b,
    input  wire [7:0] in_y_b,
    output wire [7:0] out_x,
    output wire [7:0] out_y,

    input  wire [7:0] cfg_in,
    input  wire [2:0] cfg_addr,
    input  wire       set_x,
    input  wire       set_y,
    input  wire       set_ab,
    input  wire       set_cx
);

  assign out_x = {x7, x6, x5, x4, x3, x2, x1, x0};
  assign out_y = {y7, y6, y5, y4, y3, y2, y1, y0};

  wire x0, y0;
  block #(.INDEX(0)) block0 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .in_x_b(in_x_b),
    .in_y_b(in_y_b),
    .in_x_c(out_x),
    .in_y_c(out_y),
    .out_x(x0),
    .out_y(y0),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 0),
    .set_y(set_y & cfg_addr == 0),
    .set_ab(set_ab & cfg_addr == 0),
    .set_cx(set_cx & cfg_addr == 0)
  );

  wire x1, y1;
  block #(.INDEX(1)) block1 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .in_x_b(in_x_b),
    .in_y_b(in_y_b),
    .in_x_c(out_x),
    .in_y_c(out_y),
    .out_x(x1),
    .out_y(y1),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 1),
    .set_y(set_y & cfg_addr == 1),
    .set_ab(set_ab & cfg_addr == 1),
    .set_cx(set_cx & cfg_addr == 1)
  );

  wire x2, y2;
  block #(.INDEX(2)) block2 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .in_x_b(in_x_b),
    .in_y_b(in_y_b),
    .in_x_c(out_x),
    .in_y_c(out_y),
    .out_x(x2),
    .out_y(y2),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 2),
    .set_y(set_y & cfg_addr == 2),
    .set_ab(set_ab & cfg_addr == 2),
    .set_cx(set_cx & cfg_addr == 2)
  );

  wire x3, y3;
  block #(.INDEX(3)) block3 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .in_x_b(in_x_b),
    .in_y_b(in_y_b),
    .in_x_c(out_x),
    .in_y_c(out_y),
    .out_x(x3),
    .out_y(y3),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 3),
    .set_y(set_y & cfg_addr == 3),
    .set_ab(set_ab & cfg_addr == 3),
    .set_cx(set_cx & cfg_addr == 3)
  );

  wire x4, y4;
  block #(.INDEX(4)) block4 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .in_x_b(in_x_b),
    .in_y_b(in_y_b),
    .in_x_c(out_x),
    .in_y_c(out_y),
    .out_x(x4),
    .out_y(y4),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 4),
    .set_y(set_y & cfg_addr == 4),
    .set_ab(set_ab & cfg_addr == 4),
    .set_cx(set_cx & cfg_addr == 4)
  );

  wire x5, y5;
  block #(.INDEX(5)) block5 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .in_x_b(in_x_b),
    .in_y_b(in_y_b),
    .in_x_c(out_x),
    .in_y_c(out_y),
    .out_x(x5),
    .out_y(y5),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 5),
    .set_y(set_y & cfg_addr == 5),
    .set_ab(set_ab & cfg_addr == 5),
    .set_cx(set_cx & cfg_addr == 5)
  );

  wire x6, y6;
  block #(.INDEX(6)) block6 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .in_x_b(in_x_b),
    .in_y_b(in_y_b),
    .in_x_c(out_x),
    .in_y_c(out_y),
    .out_x(x6),
    .out_y(y6),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 6),
    .set_y(set_y & cfg_addr == 6),
    .set_ab(set_ab & cfg_addr == 6),
    .set_cx(set_cx & cfg_addr == 6)
  );

  wire x7, y7;
  block #(.INDEX(7)) block7 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .in_x_b(in_x_b),
    .in_y_b(in_y_b),
    .in_x_c(out_x),
    .in_y_c(out_y),
    .out_x(x7),
    .out_y(y7),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 7),
    .set_y(set_y & cfg_addr == 7),
    .set_ab(set_ab & cfg_addr == 7),
    .set_cx(set_cx & cfg_addr == 7)
  );

endmodule
