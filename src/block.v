/*
 * Copyright (c) 2024 Andrew Dona-Couch
 * SPDX-License-Identifier: Apache-2.0
 */

module block #(
    parameter INDEX = 0
) (
    input  wire       clk,
    input  wire       rst_n,

    input  wire [7:0] in_x,
    input  wire [7:0] in_y,
    output wire       out_x,
    output wire       out_y,

    input  wire [7:0] cfg_in,
    input  wire       set_x,
    input  wire       set_y,
    input  wire       set_ab,
    input  wire       set_cx
);

  reg data_x, data_y;
  reg [7:0] x, y, ab, cx;

  wire x_async = cx[6];
  wire y_async = cx[7];

  wire a_y = ab[3];
  wire [2:0] a_bits = ab[2:0];
  wire a = a_y ? in_y[a_bits] : in_x[a_bits];

  wire b_y = ab[7];
  wire [2:0] b_bits = ab[6:4];
  wire b = b_y ? in_y[b_bits] : in_x[b_bits];

  wire c_y = cx[3];
  wire [2:0] c_bits = cx[2:0];
  wire c = c_y ? in_y[c_bits] : in_x[c_bits];

  wire [2:0] lut_bits = {c, b, a};
  wire lut_x = x[lut_bits];
  wire lut_y = y[lut_bits];

  assign out_x = x_async ? lut_x : data_x;
  assign out_y = y_async ? lut_y : data_y;

  always @(posedge clk) begin
    if (!rst_n) begin
      x <= 8'hAA;
      y <= 0;
      ab <= (INDEX << 4) | INDEX;
      cx <= INDEX;
      data_x <= 0;
      data_y <= 0;
    end else begin
      data_x <= lut_x;
      data_y <= lut_y;

      if (set_x) begin
        x <= cfg_in;
      end else if (set_y) begin
        y <= cfg_in;
      end else if (set_ab) begin
        ab <= cfg_in;
      end else if (set_cx) begin
        cx <= cfg_in;
      end
    end
  end

endmodule
