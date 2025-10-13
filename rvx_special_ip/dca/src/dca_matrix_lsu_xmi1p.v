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
`include "ervp_axi_define.vh"
`include "dca_matrix_lsu_inst.vh"



module DCA_MATRIX_LSU_XMI1P
(
  clk,
  rstnn,
  clear,
  enable,
  busy,

  inst_wvalid,
  inst_wdata,
  inst_wready,
  inst_decode_finish,
  inst_execute_finish,

  load_tensor_row_wvalid,
  load_tensor_row_wlast,
  load_tensor_row_wdata,
  load_tensor_row_wready,

  store_tensor_row_rvalid,
  store_tensor_row_rlast,
  store_tensor_row_rready,
  store_tensor_row_rdata,

  slxqdready,
  slxqvalid,
  slxqlast,
  slxqwrite,
  slxqlen,
  slxqsize,
  slxqburst,
  slxqwstrb,
  slxqwdata,
  slxqaddr,
  slxqburden,
  slxydready,
  slxyvalid,
  slxylast,
  slxywreply,
  slxyresp,
  slxyrdata,
  slxyburden
);



parameter LSU_PARA = 0;
parameter AXI_PARA = 32;
parameter BW_LPI_BURDEN = 1;
parameter MATRIX_SIZE_PARA = 4;
parameter TENSOR_PARA = 0;

`include "ervp_axi_lpara.vb"
`include "dca_matrix_dim_util.vb"
`include "dca_matrix_dim_lpara.vb"

input wire clk;
input wire rstnn;
input wire clear;
input wire enable;
output wire busy;

localparam  DCA_LPARA_0 = `BW_DCA_MATRIX_LSU_INST;

input wire inst_wvalid;
input wire [DCA_LPARA_0-1:0] inst_wdata;
output wire inst_wready;
output wire inst_decode_finish;
output wire inst_execute_finish;

`include "dca_tensor_scalar_lpara.vb"
`include "dca_tensor_dim_lpara.vb"

output wire load_tensor_row_wvalid;
output wire load_tensor_row_wlast;
output wire [BW_TENSOR_ROW-1:0] load_tensor_row_wdata;
input wire load_tensor_row_wready;

output wire store_tensor_row_rvalid;
output wire store_tensor_row_rlast;
input wire store_tensor_row_rready;
input wire [BW_TENSOR_ROW-1:0] store_tensor_row_rdata;

input wire [(2)-1:0] slxqdready;
output wire slxqvalid;
output wire slxqlast;
output wire slxqwrite;
output wire [`BW_AXI_ALEN-1:0] slxqlen;
output wire [`BW_AXI_ASIZE-1:0] slxqsize;
output wire [`BW_AXI_ABURST-1:0] slxqburst;
output wire [(BW_AXI_DATA/8)-1:0] slxqwstrb;
output wire [BW_AXI_DATA-1:0] slxqwdata;
output wire [BW_AXI_ADDR-1:0] slxqaddr;
output wire [BW_LPI_BURDEN-1:0] slxqburden;

output wire [(2)-1:0] slxydready;
input wire slxyvalid;
input wire slxylast;
input wire slxywreply;
input wire [`BW_AXI_RESP-1:0] slxyresp;
input wire [BW_AXI_DATA-1:0] slxyrdata;
input wire [BW_LPI_BURDEN-1:0] slxyburden;

wire dca_signal_27;

`include "lpit_function.vb"
`include "lpixm_function.vb"

localparam  BW_LPIXM_ADDR = BW_AXI_ADDR;
localparam  BW_LPIXM_DATA = BW_AXI_DATA;

`include "lpixm_lpara.vb"

wire [2-1:0] dca_signal_13;
wire dca_signal_15;
wire dca_signal_28;
wire dca_signal_16;
wire dca_signal_20;
wire [BW_LPI_QDATA-1:0] dca_signal_08;
wire [2-1:0] dca_signal_02;
wire dca_signal_18;
wire dca_signal_09;
wire dca_signal_25;
wire [BW_LPI_YDATA-1:0] dca_signal_05;

wire [2-1:0] dca_signal_17;
wire dca_signal_26;
wire dca_signal_21;
wire dca_signal_07;
wire dca_signal_24;
wire [BW_LPI_QDATA-1:0] dca_signal_06;
wire [2-1:0] dca_signal_22;
wire dca_signal_04;
wire dca_signal_00;
wire dca_signal_01;
wire [BW_LPI_YDATA-1:0] dca_signal_12;

wire dca_signal_14;
wire dca_signal_23;
wire dca_signal_11;
wire dca_signal_19;
wire [BW_LPI_QDATA-1:0] dca_signal_03;

wire dca_signal_10;

`include "dca_lsu_util.vb"
`include "dca_lsu_lpara.vb"
`include "motype_lpara.vb"

DCA_MATRIX_LSU_LPI2P
#(
  .LSU_PARA(LSU_PARA),
  .AXI_PARA(AXI_PARA),
  .BW_LPI_BURDEN(BW_LPI_BURDEN),
  .MATRIX_SIZE_PARA(MATRIX_SIZE_PARA),
  .TENSOR_PARA(TENSOR_PARA)
)
i_dca_instance_0
(
  .clk(clk),
  .rstnn(rstnn),
  .clear(clear),
  .enable(enable),
  .busy(busy),

  .inst_wvalid(inst_wvalid),
  .inst_wdata(inst_wdata),
  .inst_wready(inst_wready),
  .inst_is_write(dca_signal_27),
  .inst_decode_finish(inst_decode_finish),
  .inst_execute_finish(inst_execute_finish),

  .load_tensor_row_wvalid(load_tensor_row_wvalid),
  .load_tensor_row_wlast(load_tensor_row_wlast),
  .load_tensor_row_wdata(load_tensor_row_wdata),
  .load_tensor_row_wready(load_tensor_row_wready),

  .store_tensor_row_rvalid(store_tensor_row_rvalid),
  .store_tensor_row_rlast(store_tensor_row_rlast),
  .store_tensor_row_rready(store_tensor_row_rready),
  .store_tensor_row_rdata(store_tensor_row_rdata),

  .read_slxqdready(dca_signal_13),
  .read_slxqvalid(dca_signal_15),
  .read_slxqhint(dca_signal_28),
  .read_slxqlast(dca_signal_16),
  .read_slxqafy(dca_signal_20),
  .read_slxqdata(dca_signal_08),
  .read_slxydready(dca_signal_02),
  .read_slxyvalid(dca_signal_18),
  .read_slxyhint(dca_signal_09),
  .read_slxylast(dca_signal_25),
  .read_slxydata(dca_signal_05),

  .write_slxqdready(dca_signal_17),
  .write_slxqvalid(dca_signal_26),
  .write_slxqhint(dca_signal_21),
  .write_slxqlast(dca_signal_07),
  .write_slxqafy(dca_signal_24),
  .write_slxqdata(dca_signal_06),
  .write_slxydready(dca_signal_22),
  .write_slxyvalid(dca_signal_04),
  .write_slxyhint(dca_signal_00),
  .write_slxylast(dca_signal_01),
  .write_slxydata(dca_signal_12)
);

assign dca_signal_13 = (WRITE_SUPPORTED&dca_signal_27)? 0 : slxqdready;
assign dca_signal_17 = (WRITE_SUPPORTED&dca_signal_27)? slxqdready : 0;

assign dca_signal_14 = (WRITE_SUPPORTED&dca_signal_27)? dca_signal_26 : dca_signal_15;
assign dca_signal_23 = (WRITE_SUPPORTED&dca_signal_27)? dca_signal_21 : dca_signal_28;
assign dca_signal_11 = (WRITE_SUPPORTED&dca_signal_27)? dca_signal_07 : dca_signal_16;
assign dca_signal_19 = (WRITE_SUPPORTED&dca_signal_27)? dca_signal_24 : dca_signal_20;
assign dca_signal_03 = (WRITE_SUPPORTED&dca_signal_27)? dca_signal_06 : dca_signal_08;

assign slxqvalid = dca_signal_14;
assign slxqlast = dca_signal_11;
assign {slxqburden,slxqwrite,slxqlen,slxqsize,slxqburst,slxqwstrb,slxqwdata,slxqaddr} = dca_signal_03;

assign dca_signal_10 = WRITE_SUPPORTED & slxywreply;

assign slxydready = dca_signal_10? dca_signal_22 : dca_signal_02;

assign dca_signal_18 = (~dca_signal_10) & slxyvalid;
assign dca_signal_09 = 0;
assign dca_signal_25 = slxylast;
assign dca_signal_05 = {slxyburden,slxywreply,slxyresp,slxyrdata};

assign dca_signal_04 = (dca_signal_10) & slxyvalid;
assign dca_signal_00 = 0;
assign dca_signal_01 = slxylast;
assign dca_signal_12 = {slxyburden,slxywreply,slxyresp,slxyrdata};

endmodule
