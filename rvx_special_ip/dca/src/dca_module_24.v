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

`include "dca_matrix_info.vh"
`include "dca_matrix_lsu_inst.vh"
`include "dca_module_memorymap_offset.vh"




module DCA_MODULE_24
(
  dca_port_10,
  dca_port_16,
  dca_port_17,
  dca_port_08,
  dca_port_07,

  dca_port_09,
  dca_port_00,
  dca_port_15,
  dca_port_06,

  dca_port_04,
  dca_port_05,
  dca_port_01,
  dca_port_12,
  dca_port_13,
  dca_port_11,
  dca_port_03,
  dca_port_02,
  dca_port_14
);




parameter MATRIX_SIZE_PARA = 8;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_include_0.vh"

input wire dca_port_10;
input wire dca_port_16;
input wire dca_port_17;
input wire dca_port_08;
output wire dca_port_07;

localparam  DCA_LPARA_4 = `BW_DCA_MRU_INST;

input wire dca_port_09;
input wire [DCA_LPARA_4-1:0] dca_port_00;
output wire dca_port_15;
input wire dca_port_06;

input wire dca_port_04;
output wire dca_port_05;
output wire [BW_BLOCKED_STEP_INST-1:0] dca_port_01;

input wire dca_port_12;
output wire dca_port_13;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_11;

input wire dca_port_03;
output wire dca_port_02;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_14;

wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_15;
wire [`BW_DCA_MATRIX_INFO_ALIGNED-1:0] dca_signal_05;
wire [`BW_DCA_MRU_OPCODE-1:0] dca_signal_25;

wire dca_signal_31;
wire dca_signal_09;
wire dca_signal_04;

wire dca_signal_01;
wire [`BW_DCA_MATRIX_INFO-1:0] dca_signal_11;
wire dca_signal_28;
wire dca_signal_40;
wire dca_signal_10;
wire dca_signal_22;
wire [`BW_DCA_MATRIX_INFO-1:0] dca_signal_36;
wire dca_signal_30;
wire dca_signal_32;
wire dca_signal_19;
wire dca_signal_16;
wire dca_signal_27;
wire dca_signal_37;

wire dca_signal_33;
wire [`BW_DCA_MATRIX_INFO-1:0] dca_signal_14;
wire dca_signal_34;
wire dca_signal_07;
wire dca_signal_03;
wire dca_signal_06;
wire [`BW_DCA_MATRIX_INFO-1:0] dca_signal_02;
wire dca_signal_17;
wire dca_signal_21;
wire dca_signal_08;
wire dca_signal_39;
wire dca_signal_38;
wire dca_signal_13;

wire dca_signal_35;

wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_18;
wire [`BW_DCA_MATRIX_LSU_INST_OPCODE-1:0] dca_signal_26;

localparam  DCA_LPARA_1 = 1;
localparam  DCA_LPARA_0 = 0;
localparam  DCA_LPARA_2 = 1;

reg [DCA_LPARA_1-1:0] dca_signal_20;
wire dca_signal_29;
wire dca_signal_24;
wire dca_signal_00;

localparam  DCA_LPARA_3 = 3;

reg [DCA_LPARA_3-1:0] dca_signal_12;
wire dca_signal_23;
wire dca_signal_41;

assign {dca_signal_25, dca_signal_05, dca_signal_15} = dca_port_00;

assign dca_signal_31 = dca_signal_25[`DCA_MRU_OPCODE_INDEX_TRANSPOSE];
assign dca_signal_09 = dca_signal_25[`DCA_MRU_OPCODE_INDEX_LSU0_REQ];
assign dca_signal_04 = 1;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_1
(
  .clk(dca_port_10),
  .rstnn(dca_port_16),
  .clear(dca_port_17),
  .enable(dca_signal_01),

  .matrix_info(dca_signal_11),
  .init(dca_signal_28),
  .is_col_first(dca_signal_40),
  .iterate(dca_signal_10),
  .go_next_base(dca_signal_22),

  .block_info(dca_signal_36),
  .is_first_x(dca_signal_30),
  .is_last_x(dca_signal_32),
  .is_first_y(dca_signal_19),
  .is_last_y(dca_signal_16),
  .is_first_element(dca_signal_27),
  .is_last_element(dca_signal_37),
  .valid_row_list(),
  .valid_col_list()
);

assign dca_signal_01 = dca_port_08 & dca_signal_09;
assign dca_signal_11 = dca_signal_15;
assign dca_signal_28 = dca_signal_29;
assign dca_signal_40 = 1;
assign dca_signal_10 = dca_signal_00;
assign dca_signal_22 = dca_signal_00 & dca_signal_32;

DCA_MATRIX_SPLITER
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_0
(
  .clk(dca_port_10),
  .rstnn(dca_port_16),
  .clear(dca_port_17),
  .enable(dca_signal_33),

  .matrix_info(dca_signal_14),
  .init(dca_signal_34),
  .is_col_first(dca_signal_07),
  .iterate(dca_signal_03),
  .go_next_base(dca_signal_06),

  .block_info(dca_signal_02),
  .is_first_x(dca_signal_17),
  .is_last_x(dca_signal_21),
  .is_first_y(dca_signal_08),
  .is_last_y(dca_signal_39),
  .is_first_element(dca_signal_38),
  .is_last_element(dca_signal_13),
  .valid_row_list(),
  .valid_col_list()
);

assign dca_signal_33 = dca_port_08 & dca_signal_04;
assign dca_signal_14 = dca_signal_05;
assign dca_signal_34 = dca_signal_29;
assign dca_signal_07 = ~dca_signal_31;
assign dca_signal_03 = dca_signal_00;
assign dca_signal_06 = dca_signal_00 & dca_signal_21;

assign dca_signal_35 = dca_signal_13;

always@(posedge dca_port_10, negedge dca_port_16)
begin
  if(dca_port_16==0)
    dca_signal_20 <= DCA_LPARA_0;
  else if(dca_port_08)
    case(dca_signal_20)
      DCA_LPARA_0:
        if(dca_signal_29)
          dca_signal_20 <= DCA_LPARA_2;
      DCA_LPARA_2:
        if(dca_signal_24)
          dca_signal_20 <= DCA_LPARA_0;
    endcase
end
assign dca_signal_29 = (dca_signal_20==DCA_LPARA_0) & dca_port_09;
assign dca_signal_24 = dca_signal_00 & dca_signal_35;

always@(posedge dca_port_10, negedge dca_port_16)
begin
  if(dca_port_16==0)
    dca_signal_12 <= 1;
  else if(dca_signal_41)
  begin
    if(dca_signal_00 & dca_signal_23)
      ;
    else
      dca_signal_12 <= dca_signal_12>>1;
  end
  else if(dca_signal_00 & dca_signal_23)
    dca_signal_12 <= dca_signal_12<<1;
end
assign dca_signal_23 = dca_signal_09;
assign dca_signal_41 = dca_port_06;
assign dca_port_15 = dca_signal_24;

assign dca_signal_00 = dca_port_04 & dca_port_05;
assign dca_port_05 = (dca_signal_20==DCA_LPARA_2) & dca_port_04 & (dca_signal_09? dca_port_12 : 1) & (dca_signal_04? dca_port_03 : 1) & ((dca_signal_23)? (~dca_signal_12[DCA_LPARA_3-1]) : 1);
assign dca_port_01 = {dca_signal_35, dca_signal_25};

assign dca_port_13 = dca_port_05 & dca_signal_09;
assign dca_port_02 = dca_port_05 & dca_signal_04;
assign dca_signal_18 = `DCA_MATRIX_LSU_INST_OPCODE_READ;
assign dca_signal_26 = `DCA_MATRIX_LSU_INST_OPCODE_WRITE;
assign dca_port_11 = {dca_signal_36, dca_signal_18};
assign dca_port_14 = {dca_signal_02, dca_signal_26};

assign dca_port_07 = (dca_signal_20==DCA_LPARA_2);

endmodule
