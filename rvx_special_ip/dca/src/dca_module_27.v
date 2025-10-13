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



module DCA_MODULE_27
(
  dca_port_20,
  dca_port_09,
  dca_port_23,
  dca_port_04,
  dca_port_08,

  dca_port_07,
  dca_port_21,
  dca_port_15,

  dca_port_24,
  dca_port_10,
  dca_port_11,
  dca_port_02,
  dca_port_05,
  dca_port_00,
  dca_port_14,
  dca_port_17,
  dca_port_18,
  dca_port_16,

  dca_port_01,
  dca_port_03,
  dca_port_13,

  dca_port_19,
  dca_port_22,
  dca_port_06,
  dca_port_12
);



parameter MATRIX_SIZE_PARA = 8;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_include_3.vh"

input wire dca_port_20;
input wire dca_port_09;
input wire dca_port_23;
input wire dca_port_04;
output wire dca_port_08;

input wire dca_port_07;
input wire [BW_BLOCKED_STEP_INST-1:0] dca_port_21;
output wire dca_port_15;

input wire dca_port_24;
output wire dca_port_10;
input wire dca_port_11;
output wire dca_port_02;
input wire dca_port_05;
output wire dca_port_00;
input wire dca_port_14;
input wire dca_port_17;
output wire dca_port_18;
input wire dca_port_16;

output wire dca_port_01;
output wire [BW_BLOCKED_STEP_INST-1:0] dca_port_03;
input wire dca_port_13;

output wire dca_port_19;
output wire dca_port_22;
output reg dca_port_06;
output wire dca_port_12;

wire [`BW_DCA_NEURGEMM_OPCODE-1:0] dca_signal_00;
wire [MATRIX_MAX_DIM-1:0] dca_signal_02;
wire dca_signal_07;
wire dca_signal_15;
wire dca_signal_10;
wire [MATRIX_NUM_COL-1:0] dca_signal_19;
wire [MATRIX_NUM_ROW-1:0] dca_signal_06;
wire dca_signal_17;

wire dca_signal_03;
wire dca_signal_05;
wire dca_signal_11;
wire dca_signal_20;
wire dca_signal_18;

localparam  DCA_LPARA_3 = 4;
reg [DCA_LPARA_3-1:0] dca_signal_14;
reg dca_signal_01;
wire dca_signal_04;

localparam  DCA_LPARA_1 = 2;
localparam  DCA_LPARA_0 = 0;
localparam  DCA_LPARA_4 = 1;
localparam  DCA_LPARA_2 = 2;

reg [DCA_LPARA_1-1:0] dca_signal_09;
wire dca_signal_13;
wire dca_signal_21;
wire dca_signal_12;
wire dca_signal_16;
wire dca_signal_08;

assign dca_port_03 = dca_port_21;

assign {dca_signal_06, dca_signal_19, dca_signal_17, dca_signal_10, dca_signal_15, dca_signal_07, dca_signal_02, dca_signal_00} = dca_port_21;

assign dca_signal_03 = dca_signal_00[`DCA_NEURGEMM_OPCODE_INDEX_NO_CAL];
assign dca_signal_11 = dca_signal_00[`DCA_NEURGEMM_OPCODE_INDEX_LSU0_REQ];
assign dca_signal_20 = dca_signal_00[`DCA_NEURGEMM_OPCODE_INDEX_LSU1_REQ];
assign dca_signal_18 = dca_signal_00[`DCA_NEURGEMM_OPCODE_INDEX_LSU2_REQ];
assign dca_signal_05 = dca_signal_00[`DCA_NEURGEMM_OPCODE_INDEX_LOAD_ACC];

always@(posedge dca_port_20, negedge dca_port_09)
begin
  if(dca_port_09==0)
    dca_signal_14 <= 1;
  else
  begin
    if(dca_port_18 & dca_signal_04)
      ;
    else if(dca_signal_04)
      dca_signal_14 <= dca_signal_14>>1;
    else if(dca_port_18)
      dca_signal_14 <= dca_signal_14<<1;
  end
end

assign dca_signal_04 = dca_port_16 & ((dca_port_07 & dca_signal_05)? dca_signal_01 : 1);

always@(posedge dca_port_20, negedge dca_port_09)
begin
  if(dca_port_09==0)
    dca_signal_01 <= 0;
  else if(dca_port_07 && dca_signal_05)
  begin
    if(dca_port_06)
      dca_signal_01 <= 0;
    else if(dca_port_16)
      dca_signal_01 <= 1;
  end
end

always@(posedge dca_port_20 or negedge dca_port_09)
begin
  if(~dca_port_09)
    dca_signal_09 <= DCA_LPARA_0;
  else if(dca_port_23)
    dca_signal_09 <= DCA_LPARA_0;
  else if(dca_port_04)
    case(dca_signal_09)
      DCA_LPARA_0:
        if(dca_signal_13)
          dca_signal_09 <= DCA_LPARA_4;
      DCA_LPARA_4:
        if(dca_signal_12)
          dca_signal_09 <= DCA_LPARA_2;
        else if(dca_signal_21)
          dca_signal_09 <= DCA_LPARA_0;
      DCA_LPARA_2:
        if(dca_port_12)
          dca_signal_09 <= DCA_LPARA_0;
    endcase
end

assign dca_signal_13 = (dca_signal_09==DCA_LPARA_0) & dca_port_07 & (~dca_signal_03) & (dca_signal_11? dca_port_24 : 1) & (dca_signal_20? dca_port_11 : 1) & dca_port_14 & (dca_signal_18? (dca_port_17 & (~dca_signal_14[DCA_LPARA_3-1])) : 1);
assign dca_signal_21 = (dca_signal_09==DCA_LPARA_4) & dca_port_13 & (~dca_signal_17);
assign dca_signal_12 = (dca_signal_09==DCA_LPARA_4) & dca_port_13 & dca_signal_17;
assign dca_port_12 = (dca_signal_09==DCA_LPARA_2) & (dca_signal_14[0] | (dca_signal_14[1] & dca_signal_04));

assign dca_port_19 = dca_signal_13 & dca_signal_11;
assign dca_port_22 = dca_signal_13 & dca_signal_20;

always@(*)
begin
  dca_port_06 = 0;
  if(dca_port_07)
  begin
    if(dca_signal_03 && dca_signal_05 && dca_port_05)
      dca_port_06 = 1;
  end
end

assign dca_signal_08 = dca_port_06;
assign dca_signal_16 = dca_port_13 | dca_signal_08;

assign dca_port_01 = dca_signal_13;
assign dca_port_10  = dca_signal_16 & dca_signal_11;
assign dca_port_02  = dca_signal_16 & dca_signal_20;
assign dca_port_00  = dca_signal_16 & dca_signal_05;
assign dca_port_18 = dca_signal_16 & dca_signal_18;
assign dca_port_15 = dca_signal_16;

assign dca_port_08 = (dca_signal_09!=DCA_LPARA_0);

endmodule
