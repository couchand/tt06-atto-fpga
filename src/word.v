/*
 * Copyright (c) 2024 Andrew Dona-Couch
 * SPDX-License-Identifier: Apache-2.0
 */

module word (
    input  wire       clk,
    input  wire       rst_n,

    input  wire [7:0] in_x,
    input  wire [7:0] in_y,
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
  block block0 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .out_x(x0),
    .out_y(y0),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 0),
    .set_y(set_y & cfg_addr == 0),
    .set_ab(set_ab & cfg_addr == 0),
    .set_cx(set_cx & cfg_addr == 0)
  );

  wire x1, y1;
  block block1 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .out_x(x1),
    .out_y(y1),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 1),
    .set_y(set_y & cfg_addr == 1),
    .set_ab(set_ab & cfg_addr == 1),
    .set_cx(set_cx & cfg_addr == 1)
  );

  wire x2, y2;
  block block2 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .out_x(x2),
    .out_y(y2),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 2),
    .set_y(set_y & cfg_addr == 2),
    .set_ab(set_ab & cfg_addr == 2),
    .set_cx(set_cx & cfg_addr == 2)
  );

  wire x3, y3;
  block block3 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .out_x(x3),
    .out_y(y3),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 3),
    .set_y(set_y & cfg_addr == 3),
    .set_ab(set_ab & cfg_addr == 3),
    .set_cx(set_cx & cfg_addr == 3)
  );

  wire x4, y4;
  block block4 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .out_x(x4),
    .out_y(y4),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 4),
    .set_y(set_y & cfg_addr == 4),
    .set_ab(set_ab & cfg_addr == 4),
    .set_cx(set_cx & cfg_addr == 4)
  );

  wire x5, y5;
  block block5 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .out_x(x5),
    .out_y(y5),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 5),
    .set_y(set_y & cfg_addr == 5),
    .set_ab(set_ab & cfg_addr == 5),
    .set_cx(set_cx & cfg_addr == 5)
  );

  wire x6, y6;
  block block6 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .out_x(x6),
    .out_y(y6),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 6),
    .set_y(set_y & cfg_addr == 6),
    .set_ab(set_ab & cfg_addr == 6),
    .set_cx(set_cx & cfg_addr == 6)
  );

  wire x7, y7;
  block block7 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(in_x),
    .in_y(in_y),
    .out_x(x7),
    .out_y(y7),
    .cfg_in(cfg_in),
    .set_x(set_x & cfg_addr == 7),
    .set_y(set_y & cfg_addr == 7),
    .set_ab(set_ab & cfg_addr == 7),
    .set_cx(set_cx & cfg_addr == 7)
  );

endmodule