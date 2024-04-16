/*
 * Copyright (c) 2024 Andrew Dona-Couch
 * SPDX-License-Identifier: Apache-2.0
 */

module unit (
    input  wire       clk,
    input  wire       rst_n,

    input  wire [7:0] data_in,
    output reg  [7:0] data_out,

    input  wire [7:0] cfg_in
);

  reg [7:0] o;
  reg [6:0] cmd;
  reg [2:0] state;

  localparam ST_INIT = 0;
  localparam ST_LOAD_BLOCK = 1;
  localparam ST_LOAD_OUT = 2;

  wire [1:0] layer = cmd[6:5];
  wire [2:0] bits = cmd[4:2];
  wire [1:0] cfg = cmd[1:0];

  localparam CFG_X = 0;
  localparam CFG_Y = 1;
  localparam CFG_AB = 2;
  localparam CFG_CX = 3;

  wire [7:0] cfg_in_block = state == ST_LOAD_BLOCK ? cfg_in : 0;
  wire [2:0] cfg_addr_block = state == ST_LOAD_BLOCK ? bits : 0;
  wire set_x = state == ST_LOAD_BLOCK && cfg == CFG_X;
  wire set_y = state == ST_LOAD_BLOCK && cfg == CFG_Y;
  wire set_ab = state == ST_LOAD_BLOCK && cfg == CFG_AB;
  wire set_cx = state == ST_LOAD_BLOCK && cfg == CFG_CX;

  wire [7:0] x_in = data_in;
  wire [7:0] y_in = ~data_in;

  wire [7:0] x0, y0;
  word layer0 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(x_in),
    .in_y(y_in),
    .in_x_b(x_in),
    .in_y_b(y_in),
    .out_x(x0),
    .out_y(y0),
    .cfg_in(cfg_in_block),
    .cfg_addr(cfg_addr_block),
    .set_x(set_x && layer == 0),
    .set_y(set_y && layer == 0),
    .set_ab(set_ab && layer == 0),
    .set_cx(set_cx && layer == 0)
  );

  wire [7:0] x1, y1;
  word layer1 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(x0),
    .in_y(y0),
    .in_x_b(x_in),
    .in_y_b(y_in),
    .out_x(x1),
    .out_y(y1),
    .cfg_in(cfg_in_block),
    .cfg_addr(cfg_addr_block),
    .set_x(set_x && layer == 1),
    .set_y(set_y && layer == 1),
    .set_ab(set_ab && layer == 1),
    .set_cx(set_cx && layer == 1)
  );

  wire [7:0] x2, y2;
  word layer2 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(x1),
    .in_y(y1),
    .in_x_b(x_in),
    .in_y_b(y_in),
    .out_x(x2),
    .out_y(y2),
    .cfg_in(cfg_in_block),
    .cfg_addr(cfg_addr_block),
    .set_x(set_x && layer == 2),
    .set_y(set_y && layer == 2),
    .set_ab(set_ab && layer == 2),
    .set_cx(set_cx && layer == 2)
  );

  wire [7:0] x3, y3;
  word layer3 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(x2),
    .in_y(y2),
    .out_x(x3),
    .out_y(y3),
    .cfg_in(cfg_in_block),
    .cfg_addr(cfg_addr_block),
    .set_x(set_x && layer == 3),
    .set_y(set_y && layer == 3),
    .set_ab(set_ab && layer == 3),
    .set_cx(set_cx && layer == 3)
  );

  wire [7:0] res = (x3 & ~o) | (y3 & o);

  always @(posedge clk) begin
    if (!rst_n) begin
      o <= 0;
      cmd <= 0;
      state <= ST_INIT;
      data_out <= 0;
    end else begin
      data_out <= res;
      if (state == ST_LOAD_OUT) begin
        o <= cfg_in;
        state <= ST_INIT;
      end else if (state == ST_LOAD_BLOCK) begin
        state <= ST_INIT;
      end else if (cfg_in[7]) begin
        state <= ST_LOAD_BLOCK;
        cmd <= cfg_in[6:0];
      end else if (cfg_in == 8'h7F) begin
        state <= ST_LOAD_OUT;
        cmd <= cfg_in[6:0];
      end
    end
  end

endmodule
