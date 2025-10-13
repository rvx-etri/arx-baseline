// ****************************************************************************
// ****************************************************************************
// Copyright SoC Design Research Group, All rights reservxd.
// Electronics and Telecommunications Research Institute (ETRI)
// 
// THESE DOCUMENTS CONTAIN CONFIDENTIAL INFORMATION AND KNOWLEDGE
// WHICH IS THE PROPERTY OF ETRI. NO PART OF THIS PUBLICATION IS
// TO BE USED FOR ANY OTHER PURPOSE, AND THESE ARE NOT TO BE
// REPRODUCED, COPIED, DISCLOSED, TRANSMITTED, STORED IN A RETRIEVAL
// SYSTEM OR TRANSLATED INTO ANY OTHER HUMAN OR COMPUTER LANGUAGE,
// IN ANY FORM, BY ANY MEANS, IN WHOLE OR IN PART, WITHOUT THE
// COMPLETE PRIOR WRITTEN PERMISSION OF ETRI.
// ****************************************************************************
// 2025-08-27
// Kyuseung Han (han@etri.re.kr)
// ****************************************************************************
// ****************************************************************************

`include "ervp_global.vh"

`include "dca_matrix_info.vh"
`include "dca_matrix_lsu_inst.vh"
`include "dca_module_memorymap_offset.vh"



module DCA_MODULE_14
(
  dca_port_19,
  dca_port_18,
  dca_port_06,
  dca_port_07,
  dca_port_03,

  dca_port_01,
  dca_port_02,
  dca_port_21,

  dca_port_12,
  dca_port_23,
  dca_port_05,
  dca_port_00,
  dca_port_13,
  dca_port_09,
  dca_port_08,
  dca_port_16,
  dca_port_04,
  dca_port_17,

  dca_port_15,
  dca_port_11,
  dca_port_22,

  dca_port_10,
  dca_port_24,
  dca_port_20,
  dca_port_14
);



parameter MATRIX_SIZE_PARA = 8;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_include_0.vh"

input wire dca_port_19;
input wire dca_port_18;
input wire dca_port_06;
input wire dca_port_07;
output wire dca_port_03;

input wire dca_port_01;
input wire [BW_BLOCKED_STEP_INST-1:0] dca_port_02;
output wire dca_port_21;

input wire dca_port_12;
output wire dca_port_23;
input wire dca_port_05;
output wire dca_port_00;
input wire dca_port_13;
output wire dca_port_09;
input wire dca_port_08;
input wire dca_port_16;
output wire dca_port_04;
input wire dca_port_17;

output wire dca_port_15;
output wire [BW_BLOCKED_STEP_INST-1:0] dca_port_11;
input wire dca_port_22;

output wire dca_port_10;
output wire dca_port_24;
output reg dca_port_20;
output wire dca_port_14;

wire [`BW_DCA_MATRIX_MAC_OPCODE-1:0] dca_signal_03;
wire [MATRIX_NUM_COL-1:0] dca_signal_07;
wire [MATRIX_NUM_ROW-1:0] dca_signal_06;
wire dca_signal_16;

wire dca_signal_12;
wire dca_signal_11;
wire dca_signal_10;
wire dca_signal_15;
wire dca_signal_13;

localparam  DCA_LPARA_2 = 4;
reg [DCA_LPARA_2-1:0] dca_signal_14;
reg dca_signal_17;
wire dca_signal_09;

localparam  DCA_LPARA_0 = 2;
localparam  DCA_LPARA_3 = 0;
localparam  DCA_LPARA_4 = 1;
localparam  DCA_LPARA_1 = 2;

reg [DCA_LPARA_0-1:0] dca_signal_02;
wire dca_signal_08;
wire dca_signal_01;
wire dca_signal_05;
wire dca_signal_04;
wire dca_signal_00;

assign dca_port_11 = dca_port_02;

assign {dca_signal_06, dca_signal_07, dca_signal_16, dca_signal_03} = dca_port_02;

assign dca_signal_12 = dca_signal_03[`DCA_MATRIX_MAC_OPCODE_INDEX_NO_CAL];
assign dca_signal_10 = dca_signal_03[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU0_REQ];
assign dca_signal_15 = dca_signal_03[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU1_REQ];
assign dca_signal_13 = dca_signal_03[`DCA_MATRIX_MAC_OPCODE_INDEX_LSU2_REQ];
assign dca_signal_11 = dca_signal_03[`DCA_MATRIX_MAC_OPCODE_INDEX_LOAD_ACC];

always@(posedge dca_port_19, negedge dca_port_18)
begin
  if(dca_port_18==0)
    dca_signal_14 <= 1;
  else
  begin
    if(dca_port_04 & dca_signal_09)
      ;
    else if(dca_signal_09)
      dca_signal_14 <= dca_signal_14>>1;
    else if(dca_port_04)
      dca_signal_14 <= dca_signal_14<<1;
  end
end

assign dca_signal_09 = dca_port_17 & ((dca_port_01 & dca_signal_11)? dca_signal_17 : 1);

always@(posedge dca_port_19, negedge dca_port_18)
begin
  if(dca_port_18==0)
    dca_signal_17 <= 0;
  else if(dca_port_01 && dca_signal_11)
  begin
    if(dca_port_20)
      dca_signal_17 <= 0;
    else if(dca_port_17)
      dca_signal_17 <= 1;
  end
end

always@(posedge dca_port_19 or negedge dca_port_18)
begin
  if(~dca_port_18)
    dca_signal_02 <= DCA_LPARA_3;
  else if(dca_port_06)
    dca_signal_02 <= DCA_LPARA_3;
  else if(dca_port_07)
    case(dca_signal_02)
      DCA_LPARA_3:
        if(dca_signal_08)
          dca_signal_02 <= DCA_LPARA_4;
      DCA_LPARA_4:
        if(dca_signal_05)
          dca_signal_02 <= DCA_LPARA_1;
        else if(dca_signal_01)
          dca_signal_02 <= DCA_LPARA_3;
      DCA_LPARA_1:
        if(dca_port_14)
          dca_signal_02 <= DCA_LPARA_3;
    endcase
end

assign dca_signal_08 = (dca_signal_02==DCA_LPARA_3) & dca_port_01 & (~dca_signal_12) & (dca_signal_10? dca_port_12 : 1) & (dca_signal_15? dca_port_05 : 1) & dca_port_08 & (dca_signal_13? (dca_port_16 & (~dca_signal_14[DCA_LPARA_2-1])) : 1);
assign dca_signal_01 = (dca_signal_02==DCA_LPARA_4) & dca_port_22 & (~dca_signal_16);
assign dca_signal_05 = (dca_signal_02==DCA_LPARA_4) & dca_port_22 & dca_signal_16;
assign dca_port_14 = (dca_signal_02==DCA_LPARA_1) & (dca_signal_14[0] | (dca_signal_14[1] & dca_signal_09));

assign dca_port_10 = dca_signal_08 & dca_signal_10;
assign dca_port_24 = dca_signal_08 & dca_signal_15;

always@(*)
begin
  dca_port_20 = 0;
  if(dca_port_01)
  begin
    if(dca_signal_12 && dca_signal_11 && dca_port_13)
      dca_port_20 = 1;
  end
end

assign dca_signal_00 = dca_port_20;
assign dca_signal_04 = dca_port_22 | dca_signal_00;

assign dca_port_15 = dca_signal_08;
assign dca_port_23  = dca_signal_04 & dca_signal_10;
assign dca_port_00  = dca_signal_04 & dca_signal_15;
assign dca_port_09  = dca_signal_04 & dca_signal_11;
assign dca_port_04 = dca_signal_04 & dca_signal_13;
assign dca_port_21 = dca_signal_04;

assign dca_port_03 = (dca_signal_02!=DCA_LPARA_3);

endmodule
