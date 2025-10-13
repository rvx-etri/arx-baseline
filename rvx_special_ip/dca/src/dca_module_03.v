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




module DCA_MODULE_03
(
  dca_port_10,
  dca_port_25,
  dca_port_35,
  dca_port_11,
  dca_port_30,

  dca_port_45,
  dca_port_44,
  dca_port_23,
  dca_port_14,
  dca_port_40,
  dca_port_41,
  dca_port_22,
  dca_port_34,

  dca_port_29,
  dca_port_31,
  dca_port_02,
  dca_port_33,
  dca_port_37,
  dca_port_36,
  dca_port_07,
  dca_port_13,
  dca_port_17,
  dca_port_27,

  dca_port_03,
  dca_port_39,
  dca_port_32,
  dca_port_21,
  dca_port_00,
  dca_port_12,
  dca_port_08,
  dca_port_16,
  dca_port_20,
  dca_port_24,

  dca_port_28,
  dca_port_06,
  dca_port_42,
  dca_port_26,
  dca_port_38,
  dca_port_01,
  dca_port_05,
  dca_port_19,
  dca_port_04,
  dca_port_09,
  dca_port_15,
  dca_port_18,
  dca_port_43,
  dca_port_46
);




parameter MATRIX_SIZE_PARA = 8;
parameter TENSOR_PARA = 0;

`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"
`include "dca_include_2.vh"
`include "dca_tensor_scalar_lpara.vb"
`include "dca_tensor_dim_lpara.vb"

input wire dca_port_10;
input wire dca_port_25;
input wire dca_port_35;
input wire dca_port_11;
output wire dca_port_30;

localparam  DCA_LPARA_0 = `BW_DCA_NEUGEMM_INST;
localparam  DCA_LPARA_1 = `BW_DCA_NEUGEMM_LOG;
localparam  DCA_LPARA_5 = `BW_DCA_NEUGEMM_STATUS;

input wire dca_port_45;
input wire [DCA_LPARA_0-1:0] dca_port_44;
output wire dca_port_23;
output wire dca_port_14;
input wire dca_port_40;
output wire dca_port_41;
output wire [DCA_LPARA_1-1:0] dca_port_22;
output wire [DCA_LPARA_5-1:0] dca_port_34;

input wire dca_port_29;
output wire dca_port_31;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_02;
input wire dca_port_33;
input wire dca_port_37;
input wire dca_port_36;

output wire dca_port_07;
input wire dca_port_13;
input wire dca_port_17;
input wire [BW_TENSOR_ROW-1:0] dca_port_27;

input wire dca_port_03;
output wire dca_port_39;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_32;
input wire dca_port_21;
input wire dca_port_00;
input wire dca_port_12;

output wire dca_port_08;
input wire dca_port_16;
input wire dca_port_20;
input wire [BW_TENSOR_ROW-1:0] dca_port_24;

input wire dca_port_28;
output wire dca_port_06;
output wire [`BW_DCA_MATRIX_LSU_INST-1:0] dca_port_42;
input wire dca_port_26;
input wire dca_port_38;
input wire dca_port_01;

output wire dca_port_05;
input wire dca_port_19;
input wire dca_port_04;
input wire [BW_TENSOR_ROW-1:0] dca_port_09;
input wire dca_port_15;
output wire dca_port_18;
input wire dca_port_43;
output wire [BW_TENSOR_ROW-1:0] dca_port_46;

localparam  DCA_LPARA_6 = BW_BLOCKED_STEP_INST;
localparam  DCA_LPARA_2 = 4;

wire dca_signal_11;
wire dca_signal_41;
wire [DCA_LPARA_6-1:0] dca_signal_34;
wire dca_signal_32;
wire dca_signal_48;
wire [DCA_LPARA_6-1:0] dca_signal_46;

localparam  DCA_LPARA_3 = BW_TENSOR_ROW;
localparam  DCA_LPARA_4 = TENSOR_ZERO;

wire dca_signal_13;
wire [DCA_LPARA_3-1:0] dca_signal_42;
wire dca_signal_33;
wire [DCA_LPARA_3-1:0] dca_signal_31;
wire dca_signal_52;
wire dca_signal_60;
wire dca_signal_22;
wire [BW_TENSOR_MATRIX-1:0] dca_signal_12;
wire [BW_TENSOR_ROW-1:0] dca_signal_19;

wire dca_signal_28;
wire dca_signal_29;
wire dca_signal_04;

wire dca_signal_57;
wire [DCA_LPARA_3-1:0] dca_signal_44;
wire dca_signal_30;
wire [DCA_LPARA_3-1:0] dca_signal_06;
wire dca_signal_25;
wire dca_signal_40;
wire dca_signal_49;
wire [BW_TENSOR_MATRIX-1:0] dca_signal_27;
wire [BW_TENSOR_ROW-1:0] dca_signal_00;

wire dca_signal_53;
wire dca_signal_36;
wire dca_signal_23;

wire dca_signal_21;
wire dca_signal_03;
wire [DCA_LPARA_3-1:0] dca_signal_02;
wire dca_signal_56;
wire [DCA_LPARA_3-1:0] dca_signal_61;
wire [MATRIX_NUM_ELEMENT-1:0] dca_signal_35;
wire [BW_TENSOR_MATRIX-1:0] dca_signal_07;
wire [BW_TENSOR_MATRIX-1:0] dca_signal_10;

wire dca_signal_43;
wire dca_signal_39;
wire dca_signal_16;

wire dca_signal_37;
wire dca_signal_55;
wire dca_signal_63;

wire dca_signal_26;
wire dca_signal_54;
wire [DCA_LPARA_3-1:0] dca_signal_62;
wire dca_signal_05;
wire [DCA_LPARA_3-1:0] dca_signal_58;
wire [MATRIX_NUM_ELEMENT-1:0] dca_signal_18;
wire [BW_TENSOR_MATRIX-1:0] dca_signal_51;
wire [BW_TENSOR_MATRIX-1:0] dca_signal_20;

wire dca_signal_59;
wire [BW_TENSOR_SCALAR-1:0] dca_signal_14;
wire [BW_TENSOR_MATRIX-1:0] dca_signal_45;
wire [BW_TENSOR_ROW-1:0] dca_signal_47;

wire dca_signal_24;
wire dca_signal_08;
wire [BW_BLOCKED_STEP_INST-1:0] dca_signal_15;
wire dca_signal_01;
wire dca_signal_38;
wire dca_signal_50;
wire dca_signal_17;

wire dca_signal_09;

ERVP_FIFO
#(
  .BW_DATA(DCA_LPARA_6),
  .DEPTH(DCA_LPARA_2)
)
i_dca_instance_04
(
	.clk(dca_port_10),
  .rstnn(dca_port_25),
	.enable(dca_port_11),
  .clear(dca_port_35),
	.wready(dca_signal_11),
	.wfull(),
	.wrequest(dca_signal_41),
	.wdata(dca_signal_34),
	.wnum(),
	.rready(dca_signal_32),
	.rempty(),
	.rrequest(dca_signal_48),
	.rdata(dca_signal_46),
	.rnum()
);

DCA_MODULE_33
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_00
(
	.dca_port_18(dca_port_10),
	.dca_port_11(dca_port_25),
  .dca_port_10(dca_port_35),
  .dca_port_14(dca_port_11),
  .dca_port_17(),

  .dca_port_19(dca_port_45),
  .dca_port_02(dca_port_44),
  .dca_port_22(dca_port_23),
  .dca_port_06(dca_signal_38),
  .dca_port_07(dca_signal_50),
  .dca_port_00(dca_signal_17),

  .dca_port_16(dca_signal_11),
  .dca_port_21(dca_signal_41),
  .dca_port_04(dca_signal_34),
  .dca_port_05(dca_port_33),
  .dca_port_20(dca_port_31),
  .dca_port_13(dca_port_02),
  .dca_port_12(dca_port_21),
  .dca_port_01(dca_port_39),
  .dca_port_09(dca_port_32),
  .dca_port_08(dca_port_26),
  .dca_port_03(dca_port_06),
  .dca_port_15(dca_port_42)
);

DCA_MATRIX_REGISTER_TYPE3
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .BW_TENSOR_SCALAR(BW_TENSOR_SCALAR),
  .BW_MOVE_DATA(DCA_LPARA_3),
  .RESET_VALUE(DCA_LPARA_4)
)
i_dca_instance_08
(
  .clk(dca_port_10),
  .rstnn(dca_port_25),

  .move_wenable(dca_signal_13),
  .move_wdata_list(dca_signal_42),
  .move_renable(dca_signal_33),
  .move_rdata_list(dca_signal_31),
  
  .shift_up(dca_signal_52),
  .shift_left(dca_signal_60),
  .transpose(dca_signal_22),
  
  .all_rdata_list2d(dca_signal_12),
  .upmost_rdata_list1d(dca_signal_19)
);

assign dca_signal_33 = 0;
assign dca_signal_22 = 0;

DCA_MATRIX_LOAD2MREG
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_10
(
  .clk(dca_port_10),
  .rstnn(dca_port_25),
  .clear(dca_port_35),
  .enable(dca_port_11),
  .busy(dca_signal_28),

  .load_tensor_row_wready(dca_port_07),
  .load_tensor_row_wvalid(dca_port_13),
  .load_tensor_row_wlast(dca_port_17),
  .load_tensor_row_wdata(dca_port_27),

  .mreg_move_wenable(dca_signal_13),
  .mreg_move_wdata_list1d(dca_signal_42),

  .loadreg_rready(dca_signal_29),
  .loadreg_rrequest(dca_signal_04)
);

DCA_MATRIX_REGISTER_TYPE3
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .BW_TENSOR_SCALAR(BW_TENSOR_SCALAR),
  .BW_MOVE_DATA(DCA_LPARA_3),
  .RESET_VALUE(DCA_LPARA_4)
)
i_dca_instance_03
(
  .clk(dca_port_10),
  .rstnn(dca_port_25),

  .move_wenable(dca_signal_57),
  .move_wdata_list(dca_signal_44),
  .move_renable(dca_signal_30),
  .move_rdata_list(dca_signal_06),
  
  .shift_up(dca_signal_25),
  .shift_left(dca_signal_40),
  .transpose(dca_signal_49),
  
  .all_rdata_list2d(dca_signal_27),
  .upmost_rdata_list1d(dca_signal_00)
);

assign dca_signal_30 =0;
assign dca_signal_49 = 0;

DCA_MATRIX_LOAD2MREG
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_12
(
  .clk(dca_port_10),
  .rstnn(dca_port_25),
  .clear(dca_port_35),
  .enable(dca_port_11),
  .busy(dca_signal_53),

  .load_tensor_row_wready(dca_port_08),
  .load_tensor_row_wvalid(dca_port_16),
  .load_tensor_row_wlast(dca_port_20),
  .load_tensor_row_wdata(dca_port_24),

  .mreg_move_wenable(dca_signal_57),
  .mreg_move_wdata_list1d(dca_signal_44),

  .loadreg_rready(dca_signal_36),
  .loadreg_rrequest(dca_signal_23)
);

DCA_MATRIX_REGISTER_TYPE5
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .BW_TENSOR_SCALAR(BW_TENSOR_SCALAR),
  .RESET_VALUE(DCA_LPARA_4)
)
i_dca_instance_06
(
  .clk(dca_port_10),
  .rstnn(dca_port_25),

  .init(dca_signal_21),

  .move_wenable(dca_signal_03),
  .move_wdata_list(dca_signal_02),
  .move_renable(dca_signal_56),
  .move_rdata_list(dca_signal_61),

  .all_wenable_list2d(dca_signal_35),
  .all_wdata_list2d(dca_signal_07),
  .all_rdata_list2d(dca_signal_10)
);

DCA_MATRIX_LOAD2MREG
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_07
(
  .clk(dca_port_10),
  .rstnn(dca_port_25),
  .clear(dca_port_35),
  .enable(dca_port_11),
  .busy(dca_signal_43),

  .load_tensor_row_wready(dca_port_05),
  .load_tensor_row_wvalid(dca_port_19),
  .load_tensor_row_wlast(dca_port_04),
  .load_tensor_row_wdata(dca_port_09),

  .mreg_move_wenable(dca_signal_03),
  .mreg_move_wdata_list1d(dca_signal_02),

  .loadreg_rready(dca_signal_39),
  .loadreg_rrequest(dca_signal_16)
);

DCA_MATRIX_MREG2STORE
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .BW_TENSOR_SCALAR(BW_TENSOR_SCALAR)
)
i_dca_instance_01
(
  .clk(dca_port_10),
  .rstnn(dca_port_25),
  .clear(dca_port_35),
  .enable(dca_port_11),
  .busy(dca_signal_37),

  .storereg_wready(dca_signal_55),
  .storereg_wrequest(dca_signal_63),

  .mreg_move_renable(dca_signal_56),
  .mreg_move_rdata_list1d(dca_signal_61),

  .store_tensor_row_rvalid(dca_port_15),
  .store_tensor_row_rready(dca_port_18),
  .store_tensor_row_rlast(dca_port_43),
  .store_tensor_row_rdata(dca_port_46)
);

DCA_MATRIX_REGISTER_TYPE5
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .BW_TENSOR_SCALAR(BW_TENSOR_SCALAR),
  .RESET_VALUE(DCA_LPARA_4)
)
i_dca_instance_05
(
  .clk(dca_port_10),
  .rstnn(dca_port_25),

  .init(dca_signal_26),

  .move_wenable(dca_signal_54),
  .move_wdata_list(dca_signal_62),
  .move_renable(dca_signal_05),
  .move_rdata_list(dca_signal_58),

  .all_wenable_list2d(dca_signal_18),
  .all_wdata_list2d(dca_signal_51),
  .all_rdata_list2d(dca_signal_20)
);

assign dca_signal_54 = 0;
assign dca_signal_62 = 0;
assign dca_signal_05 = 0;

DCA_MATRIX_REGISTER_CONSTANT
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .BW_TENSOR_SCALAR(BW_TENSOR_SCALAR)
)
i_dca_instance_11
(
  .clk(dca_port_10),
  .rstnn(dca_port_25),

  .scalar_wenable(dca_signal_59),
  .scalar_wdata(dca_signal_14),
  
  .all_rdata_list2d(dca_signal_45),
  .upmost_rdata_list1d(dca_signal_47)
);

assign dca_signal_14 = dca_signal_00[BW_TENSOR_SCALAR-1-:BW_TENSOR_SCALAR];

DCA_MODULE_04
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_02
(
  .dca_port_15(dca_port_10),
  .dca_port_13(dca_port_25),
  .dca_port_06(dca_port_35),
  .dca_port_09(dca_port_11),
  .dca_port_11(dca_signal_24),

  .dca_port_19(dca_signal_08),
  .dca_port_05(dca_signal_15),
  .dca_port_14(dca_signal_01),

  .dca_port_17(dca_signal_12),
  .dca_port_10(dca_signal_52),
  .dca_port_07(dca_signal_60),

  .dca_port_00(dca_signal_27),
  .dca_port_22(dca_signal_25),
  .dca_port_20(dca_signal_40),

  .dca_port_16(dca_signal_59),
  .dca_port_01(dca_signal_45),

  .dca_port_08(dca_signal_10),
  .dca_port_04(dca_signal_21),
  .dca_port_18(dca_signal_35),
  .dca_port_21(dca_signal_07),

  .dca_port_02(dca_signal_20),
  .dca_port_12(dca_signal_18),
  .dca_port_03(dca_signal_51)
);

DCA_MODULE_10
#(
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA)
)
i_dca_instance_09
(
  .dca_port_22(dca_port_10),
  .dca_port_15(dca_port_25),
  .dca_port_06(dca_port_35),
  .dca_port_16(dca_port_11),
  .dca_port_08(dca_signal_09),

  .dca_port_14(dca_signal_32),
  .dca_port_07(dca_signal_46),
  .dca_port_20(dca_signal_48),

  .dca_port_00(dca_signal_29),
  .dca_port_10(dca_signal_04),
  .dca_port_18(dca_signal_36),
  .dca_port_17(dca_signal_23),
  .dca_port_02(dca_signal_39),
  .dca_port_11(dca_signal_16),
  .dca_port_23(dca_signal_55),
  .dca_port_13(dca_signal_55),
  .dca_port_09(dca_signal_63),
  .dca_port_19(dca_port_01),

  .dca_port_04(dca_signal_08),
  .dca_port_24(dca_signal_15),
  .dca_port_21(dca_signal_01),

  .dca_port_01(dca_signal_38),
  .dca_port_05(dca_signal_50),
  .dca_port_03(dca_signal_17),
  .dca_port_12(dca_port_14)
);

assign dca_port_41 = 0;
assign dca_port_22 = 0;
assign dca_port_34 = 0;
assign dca_port_30 = dca_port_45 | dca_signal_32 | dca_signal_09;

endmodule
