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




module DCA_MODULE_18
(
  dca_port_00,
  dca_port_09,
  
  dca_port_04,
  dca_port_02,
  dca_port_07,  

  dca_port_01,
  dca_port_06,
  dca_port_08,
  dca_port_03,
  dca_port_05
);




parameter TENSOR_PARA = 0;

`include "dca_tensor_scalar_lpara.vb"

input wire dca_port_00, dca_port_09;
input wire dca_port_04;
input wire dca_port_02;
input wire dca_port_07;

input wire dca_port_01;
input wire [BW_TENSOR_SCALAR-1:0] dca_port_06;
input wire [BW_TENSOR_SCALAR-1:0] dca_port_08;
output wire dca_port_03;
output wire [BW_TENSOR_SCALAR-1:0] dca_port_05;

localparam  DCA_LPARA_0 = 5;
localparam  DCA_LPARA_1 = TENSOR_BW_SIGNIFICAND + DCA_LPARA_0;
localparam  DCA_LPARA_2 = `MAX(TENSOR_BW_INTEGER, DCA_LPARA_1) + 1;

reg signed [DCA_LPARA_2-1:0] dca_signal_19;
reg signed [DCA_LPARA_2-1:0] dca_signal_24;
reg signed [DCA_LPARA_2-1:0] dca_signal_16;
wire signed [DCA_LPARA_2+1-1:0] dca_signal_12;

wire signed [TENSOR_BW_INTEGER-1:0] dca_signal_23;
wire signed [TENSOR_BW_INTEGER-1:0] dca_signal_07;
wire signed [TENSOR_BW_INTEGER-1:0] dca_signal_06;
wire signed [TENSOR_BW_INTEGER-1:0] dca_signal_13;

wire dca_signal_20;
wire dca_signal_01;

wire [BW_TENSOR_SCALAR-1:0] dca_signal_03;
wire [TENSOR_BW_EXPONENT-1:0] dca_signal_08;
wire [DCA_LPARA_1-1:0] dca_signal_11;
wire [DCA_LPARA_1-1:0] dca_signal_10;

wire [DCA_LPARA_1-1:0] dca_signal_05;
wire [DCA_LPARA_1-1:0] dca_signal_18;
wire dca_signal_02;
wire [DCA_LPARA_1+1-1:0] dca_signal_04;

wire dca_signal_15;
wire dca_signal_22;

wire [BW_TENSOR_SCALAR-1:0] dca_signal_21;
wire [TENSOR_BW_EXPONENT-1:0] dca_signal_09;
wire [DCA_LPARA_1+1-1:0] dca_signal_17;

wire dca_signal_14;
wire [BW_TENSOR_SCALAR-1:0] dca_signal_00;

assign dca_signal_23 = dca_port_06;
assign dca_signal_07 = dca_port_02? (~dca_port_08) : dca_port_08;
assign dca_signal_06 = dca_port_02;

`ifdef PACT_SUPPORT_FLOAT32

always@(*)
begin
  dca_signal_19 = $signed(dca_signal_23);
  dca_signal_24 = $signed(dca_signal_07);
  dca_signal_16 = dca_signal_06;
  if(dca_port_07)
  begin
    dca_signal_19 = $signed(dca_signal_05);
    dca_signal_24 = $signed(dca_signal_18);
    dca_signal_16 = dca_signal_02;
  end
  else
  begin
    dca_signal_19 = $signed(dca_signal_23);
    dca_signal_24 = $signed(dca_signal_07);
    dca_signal_16 = dca_signal_06;
  end
end

assign dca_signal_12 = dca_signal_19 + dca_signal_24 + dca_signal_16;

assign dca_signal_13 = dca_signal_12;

PACT_FADDER_PIPELINE1
#(
  .TENSOR_BW_SIGNIFICAND_EXTENDED(DCA_LPARA_1)
)
i_dca_instance_1
(
  .clk(dca_port_00),
  .rstnn(dca_port_09),
  .enable(dca_port_04),

  .is_sub(dca_port_02),
  .in_valid(dca_port_01),
  .in_input0_float(dca_port_06),
  .in_input1_float(dca_port_08),

  .out_valid_early_case(dca_signal_20),
  .out_valid_normal_case(dca_signal_01),

  .out_early_output0(dca_signal_03),
  .out_muxed_exponent(dca_signal_08),
  .out_input0_significand(dca_signal_11),
  .out_input1_significand(dca_signal_10)
);

PACT_FADDER_PIPELINE2
#(
  .TENSOR_BW_SIGNIFICAND_EXTENDED(DCA_LPARA_1)
)
i_dca_instance_0
(
  .clk(dca_port_00),
  .rstnn(dca_port_09),
  .enable(dca_port_04),

  .in_valid_early_case(dca_signal_20),
  .in_valid_normal_case(dca_signal_01),

  .in_early_output0(dca_signal_03),
  .in_muxed_exponent(dca_signal_08),
  .in_input0_significand(dca_signal_11),
  .in_input1_significand(dca_signal_10),

  .out_adder_input0(dca_signal_05),
  .out_adder_input1(dca_signal_18),
  .out_adder_carryin(dca_signal_02),
  .in_adder_output0(dca_signal_04),
  
  .out_valid_early_case(dca_signal_15),
  .out_valid_normal_case(dca_signal_22),
  
  .out_early_output0(dca_signal_21),
  .out_muxed_exponent(dca_signal_09),
  .out_added_significand(dca_signal_17)
);

assign dca_signal_04 = dca_signal_12;

PACT_FADDER_PIPELINE3
#(
  .TENSOR_BW_SIGNIFICAND_EXTENDED(DCA_LPARA_1)
)
i_dca_instance_2
(
  .clk(dca_port_00),
  .rstnn(dca_port_09),
  .enable(dca_port_04),

  .in_valid_early_case(dca_signal_15),
  .in_valid_normal_case(dca_signal_22),  
  .in_early_output0(dca_signal_21),
  .in_muxed_exponent(dca_signal_09),
  .in_added_significand(dca_signal_17),

  .out_valid(dca_signal_14),
  .out_result(dca_signal_00)
);

assign dca_port_03 = (dca_port_07)? dca_signal_14 : dca_port_01;
assign dca_port_05 = (dca_port_07)? dca_signal_00 : $unsigned(dca_signal_13);

`else 

assign dca_port_03 = dca_port_01;
assign dca_port_05 = $signed(dca_signal_23) + $signed(dca_signal_07) + dca_signal_06;

`endif 

endmodule
