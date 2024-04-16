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

  wire [7:0] x0 = data_in;
  wire [7:0] y0 = ~data_in;

  wire [7:0] x1, y1;
  word layer1 (
    .clk(clk),
    .rst_n(rst_n),
    .in_x(x0),
    .in_y(y0),
    .out_x(x1),
    .out_y(y1),
    .cfg_in(cfg_in_block),
    .cfg_addr(cfg_addr_block),
    .set_x(set_x),
    .set_y(set_y),
    .set_ab(set_ab),
    .set_cx(set_cx)
  );

  wire [7:0] res = (x1 & ~o) | (y1 & o);

  always @(posedge clk) begin
    if (!rst_n) begin
      o <= 0;
      cmd <= 0;
      state <= ST_INIT;
      data_out <= 0;
    end else begin
      data_out <= res;
      if (state == ST_LOAD_OUT) begin
        o <= cmd;
        state <= ST_INIT;
      end else if (state == ST_LOAD_BLOCK) begin
        state <= ST_INIT;
      end else if (cfg_in[7]) begin
        state <= ST_LOAD_BLOCK;
        cmd <= cfg_in;
      end else if (cfg_in == 8'h7F) begin
        state <= ST_LOAD_OUT;
        cmd <= cfg_in;
      end
    end
  end

endmodule
