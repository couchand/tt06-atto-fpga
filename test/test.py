# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: MIT

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
  dut._log.info("Start")

  clock = Clock(dut.clk, 10, units="us")
  cocotb.start_soon(clock.start())

  # Reset
  dut._log.info("Reset")
  dut.ena.value = 1
  dut.ui_in.value = 0
  dut.uio_in.value = 0
  dut.rst_n.value = 0
  await ClockCycles(dut.clk, 10)
  dut.rst_n.value = 1

  assert dut.uo_out.value == 0

  dut.ui_in.value = 1
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 0
  dut.ui_in.value = 2
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 0
  dut.ui_in.value = 3
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 0
  dut.ui_in.value = 4
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 0
  dut.ui_in.value = 5
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 0
  dut.ui_in.value = 6
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 1
  dut.ui_in.value = 0
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 2
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 3
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 4
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 5
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 6
  await ClockCycles(dut.clk, 1)
  assert dut.uo_out.value == 0





  dut._log.info("Set Bit 0 X")
  dut.uio_in.value = 0x80 # X REG Bit0
  await ClockCycles(dut.clk, 1)
  dut.uio_in.value = 0x88 # AND
  await ClockCycles(dut.clk, 1)
  dut.uio_in.value = 0x00
  await ClockCycles(dut.clk, 1)

  dut._log.info("Set Bit 0 AB")
  dut.uio_in.value = 0x82 # AB REG
  await ClockCycles(dut.clk, 1)
  dut.uio_in.value = 0x10
  await ClockCycles(dut.clk, 1)
  dut.uio_in.value = 0x00
  await ClockCycles(dut.clk, 1)

  dut._log.info("Set Bit 1 X")
  dut.uio_in.value = 0x84 # X REG Bit1
  await ClockCycles(dut.clk, 1)
  dut.uio_in.value = 0x00 # ZERO
  await ClockCycles(dut.clk, 1)
  dut.uio_in.value = 0x00
  await ClockCycles(dut.clk, 1)

  dut._log.info("Test our logic")
  dut.ui_in.value = 0b00000000
  await ClockCycles(dut.clk, 6)
  assert dut.uo_out.value == 0
  dut.ui_in.value = 0b00000001
  await ClockCycles(dut.clk, 6)
  assert dut.uo_out.value == 0
  dut.ui_in.value = 0b00000010
  await ClockCycles(dut.clk, 6)
  assert dut.uo_out.value == 0
  dut.ui_in.value = 0b00000011
  await ClockCycles(dut.clk, 6)
  assert dut.uo_out.value == 1

  dut._log.info("Set Bit 0 X")
  dut.uio_in.value = 0x80
  await ClockCycles(dut.clk, 1)
  dut.uio_in.value = 0xEE
  await ClockCycles(dut.clk, 1)
  dut.uio_in.value = 0x00
  await ClockCycles(dut.clk, 1)

  dut._log.info("Test our logic")
  dut.ui_in.value = 0b00000000
  await ClockCycles(dut.clk, 6)
  assert dut.uo_out.value == 0
  dut.ui_in.value = 0b00000001
  await ClockCycles(dut.clk, 6)
  assert dut.uo_out.value == 1
  dut.ui_in.value = 0b00000010
  await ClockCycles(dut.clk, 6)
  assert dut.uo_out.value == 1
  dut.ui_in.value = 0b00000011
  await ClockCycles(dut.clk, 6)
  assert dut.uo_out.value == 1

  await ClockCycles(dut.clk, 10)
  dut._log.info("Done")
