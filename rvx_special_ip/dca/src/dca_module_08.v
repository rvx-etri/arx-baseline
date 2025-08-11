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
// 2025-06-16
// Kyuseung Han (han@etri.re.kr)
// ****************************************************************************
// ****************************************************************************

`include "ervp_global.vh"
`include "ervp_axi_define.vh"
`include "dca_matrix_lsu_inst.vh"




module DCA_MODULE_08
(
  dca_port_02,
  dca_port_00,
  dca_port_01,
  dca_port_08,

  dca_port_11,

  dca_port_05,
  dca_port_12,
  dca_port_07,
  dca_port_09,

  dca_port_10,
  dca_port_13,
  dca_port_06,
  dca_port_04,
  dca_port_03
);




parameter LSU_PARA = 0;
parameter AXI_PARA = 32;
parameter MATRIX_SIZE_PARA = 4;

`include "ervp_axi_lpara.vb"
`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"

input wire dca_port_02;
input wire dca_port_00;
input wire dca_port_01;
input wire dca_port_08;

`include "dca_lsu_util.vb"
`include "dca_lsu_lpara.vb"

input wire [BW_RRESP_INFO-1:0] dca_port_11;

output wire dca_port_05;
input wire dca_port_12;
input wire [BW_MEMORY_ROW_BUFFER-1:0] dca_port_07;
input wire [BW_TXN_INFO-1:0] dca_port_09;

input wire dca_port_10;
output wire dca_port_13;
output wire [BW_MEMORY_ROW_BUFFER-1:0] dca_port_06;
output wire [BW_MEMORY_ROW_BUFFER-1:0] dca_port_04;
output wire [BW_TXN_INFO-1:0] dca_port_03;

integer i;

wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_02;
wire [`BW_DCA_MATRIX_INFO_ADDR-1:0] dca_signal_06;
wire [`BW_DCA_MATRIX_INFO_STRIDE_LS3-1:0] dca_signal_16;
wire [`BW_DCA_MATRIX_INFO_NUM_ROW_M1-1:0] dca_signal_09;
wire [`BW_DCA_MATRIX_INFO_NUM_COL_M1-1:0] dca_signal_17;
wire [`BW_DCA_MATRIX_INFO_IS_SIGNED-1:0] dca_signal_08;
wire [`BW_DCA_MATRIX_INFO_IS_FLOAT-1:0] dca_signal_07;
wire [`BW_DCA_MATRIX_INFO_ADDR_LSA_P3-1:0] dca_signal_00;

wire [MATRIX_NUM_COL-1:0] dca_signal_18;

wire [BW_BITADDR-1:0] dca_signal_03;
wire [`BW_AXI_ALEN-1:0] dca_signal_13;
wire dca_signal_15;
wire dca_signal_11;

wire [BW_BITADDR_OFFSET-1:0] dca_signal_01;

localparam  DCA_LPARA_3 = BW_MEMORY_ROW_BUFFER;
localparam  DCA_LPARA_0 = BW_BITADDR_OFFSET;

wire [DCA_LPARA_3-1:0] dca_signal_04;
wire [DCA_LPARA_0-1:0] dca_signal_14;
wire [DCA_LPARA_3-1:0] dca_signal_10;

localparam  DCA_LPARA_2 = BW_MEMORY_ROW_BUFFER;
localparam  DCA_LPARA_1 = BW_BITADDR_OFFSET;

reg [DCA_LPARA_2-1:0] dca_signal_12;
wire [DCA_LPARA_1-1:0] dca_signal_19;
wire [DCA_LPARA_2-1:0] dca_signal_20;

wire [DCA_LPARA_2-1:0] dca_signal_05;

assign {dca_signal_18, dca_signal_00, dca_signal_07, dca_signal_08, dca_signal_17, dca_signal_09, dca_signal_16, dca_signal_06, dca_signal_02} = dca_port_11;
assign {dca_signal_11, dca_signal_15, dca_signal_13, dca_signal_03} = dca_port_09;

assign dca_signal_01[BW_BITADDR_OFFSET-1:3] = LSU_SUPPORT_MULTIBYTE? dca_signal_03[BW_BITADDR-1:3] : 0;
assign dca_signal_01[2:0] = LSU_SUPPORT_SUBBYTE? dca_signal_03[2:0] : 0;

ERVP_BARREL_SHIFTER
#(
  .BW_DATA(DCA_LPARA_3),
  .BW_SHIFT_AMOUNT(DCA_LPARA_0),
  .SIGNED_AMOUNT(0),
  .PLUS_TO_LEFT(1),
  .ARITHMETIC_SHIFT(0),
  .CIRCULAR_SHIFT(0),
  .MSB_FILL_VALUE(0)
)
i_dca_instance_0
(
  .data_input(dca_signal_04),
  .shift_amount(dca_signal_14),
  .data_output(dca_signal_10)
);

assign dca_signal_04 = dca_port_07;
assign dca_signal_14 = dca_signal_01;

ERVP_BARREL_SHIFTER
#(
  .BW_DATA(DCA_LPARA_2),
  .BW_SHIFT_AMOUNT(DCA_LPARA_1),
  .SIGNED_AMOUNT(0),
  .PLUS_TO_LEFT(1),
  .ARITHMETIC_SHIFT(0),
  .CIRCULAR_SHIFT(0),
  .MSB_FILL_VALUE(0)
)
i_dca_instance_1
(
  .data_input(dca_signal_12),
  .shift_amount(dca_signal_19),
  .data_output(dca_signal_20)
);

assign dca_signal_05 = $unsigned(dca_signal_18);
always@(*)
begin
  dca_signal_12 = 0;
  for(i=0; i<DCA_LPARA_2; i=i+1)
  begin
    case(dca_signal_00)
      0:
        dca_signal_12[i] = dca_signal_05[i];
      1:
        dca_signal_12[i] = dca_signal_05[i>>1];
      2:
        dca_signal_12[i] = dca_signal_05[i>>2];
      3:
        dca_signal_12[i] = dca_signal_05[i>>3];
      4:
        dca_signal_12[i] = dca_signal_05[i>>4];
      5:
        dca_signal_12[i] = dca_signal_05[i>>5];
    endcase
  end
end
assign dca_signal_19 = dca_signal_01;

assign dca_port_05 = dca_port_10;
assign dca_port_13 = dca_port_12;
assign dca_port_06 = dca_signal_10;
assign dca_port_04 = dca_signal_20;
assign dca_port_03 = dca_port_09;

endmodule
