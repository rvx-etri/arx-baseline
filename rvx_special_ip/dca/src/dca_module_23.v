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





module DCA_MODULE_23 
(
  dca_port_11,
  dca_port_10,
  dca_port_06,

  dca_port_05,
  dca_port_04,

  dca_port_00,
  dca_port_03,
  
  dca_port_09,
  dca_port_07,

  dca_port_08,
  dca_port_01,
  dca_port_02,
  dca_port_12
);





parameter DCA_GPARA_1 = 10;
parameter DCA_GPARA_0 = 10;
parameter DCA_GPARA_2 = 8;
parameter DCA_GPARA_3 = 8;

input wire dca_port_11;
input wire dca_port_10;
input wire dca_port_06;

input wire [DCA_GPARA_2-1:0] dca_port_05;
input wire [DCA_GPARA_3-1:0] dca_port_04;

input wire dca_port_00;
output wire dca_port_03;

output wire dca_port_09;
output wire dca_port_07;

output wire dca_port_08;
output wire dca_port_01;
output wire dca_port_02;
output wire dca_port_12;

localparam  DCA_LPARA_0 = 2;
localparam  DCA_LPARA_5 = 0;
localparam  DCA_LPARA_4 = 1;
localparam  DCA_LPARA_3 = 2;

reg [DCA_LPARA_0-1:0] dca_signal_09;
wire dca_signal_07;

localparam  DCA_LPARA_2 = DCA_GPARA_2;

reg [DCA_LPARA_2-1:0] dca_signal_10;
wire dca_signal_01;

wire dca_signal_18;
wire dca_signal_19;
wire [DCA_LPARA_2-1:0] dca_signal_12;
wire dca_signal_14;

localparam  DCA_LPARA_6 = DCA_GPARA_3 + 1;

reg [DCA_LPARA_6-1:0] dca_signal_16;
reg [DCA_LPARA_6-1:0] dca_signal_15;
wire dca_signal_08;
wire dca_signal_20;

wire dca_signal_03;
wire dca_signal_04;
wire [DCA_LPARA_6-1:0] dca_signal_11;
wire dca_signal_00;

localparam  DCA_LPARA_1 = `MAX(DCA_GPARA_0,DCA_GPARA_1);

wire dca_signal_13;
wire dca_signal_17;
wire [DCA_LPARA_1-1:0] dca_signal_02;

wire dca_signal_05;
wire dca_signal_06;

always@(posedge dca_port_11, negedge dca_port_10)
begin
  if(dca_port_10==0)
    dca_signal_09 <= DCA_LPARA_5;
  else if(dca_port_06)
  begin
    if(dca_port_03)
      dca_signal_09 <= DCA_LPARA_5;
    else if(dca_port_00)
      dca_signal_09 <= DCA_LPARA_3;
    else if(dca_signal_19)
      dca_signal_09 <= DCA_LPARA_4;
    else if(dca_signal_09==DCA_LPARA_4)
      dca_signal_09 <= DCA_LPARA_3;
  end
end

assign dca_signal_07 = (dca_signal_09==DCA_LPARA_3);

always@(posedge dca_port_11, negedge dca_port_10)
begin
  if(dca_port_10==0)
    dca_signal_10 <= 0;
  else if(dca_port_06)
  begin
    if(dca_port_00)
      dca_signal_10 <= dca_port_05;
    else if(dca_signal_19)
      dca_signal_10 <= (dca_signal_10>>1);
  end
end

assign dca_signal_01 = dca_signal_07 & dca_signal_10[0];

ERVP_COUNTER_WITH_ONEHOT_ENCODING
#(
  .COUNT_LENGTH(DCA_LPARA_2),
  .UP(1),
  .RESET_INDEX(0),
  .CIRCULAR(1)
)
i_dca_instance_2
(
  .clk(dca_port_11),
  .rstnn(dca_port_10),
  .enable(dca_port_06),
  .init(dca_signal_18),
  .count(dca_signal_19),
  .value(dca_signal_12),
  .is_first_count(),
  .is_last_count(dca_signal_14)
);

assign dca_signal_18 = dca_port_00;
assign dca_signal_19 = dca_signal_04 & dca_signal_00;

always@(posedge dca_port_11, negedge dca_port_10)
begin
  if(dca_port_10==0)
    dca_signal_16 <= 0;
  else if(dca_port_06)
  begin
    if(dca_port_00 || dca_signal_19)
      dca_signal_16 <= dca_port_04;
    else if(dca_signal_04)
      dca_signal_16 <= (dca_signal_16>>1);
  end
end

assign dca_signal_08 =  dca_signal_01 & dca_signal_16[0];

always@(posedge dca_port_11, negedge dca_port_10)
begin
  if(dca_port_10==0)
    dca_signal_15 <= 0;
  else if(dca_port_06)
  begin
    if(dca_port_00 || dca_signal_19)
      dca_signal_15 <= {dca_port_04,1'b 0};
    else if(dca_signal_04)
      dca_signal_15 <= (dca_signal_15>>1);
  end
end

assign dca_signal_20 = dca_signal_01 & dca_signal_15[0];

ERVP_COUNTER_WITH_ONEHOT_ENCODING
#(
  .COUNT_LENGTH(DCA_LPARA_6),
  .UP(1),
  .RESET_INDEX(0),
  .CIRCULAR(1)
)
i_dca_instance_0
(
  .clk(dca_port_11),
  .rstnn(dca_port_10),
  .enable(dca_port_06),
  .init(dca_signal_03),
  .count(dca_signal_04),
  .value(dca_signal_11),
  .is_first_count(),
  .is_last_count(dca_signal_00)
);

assign dca_signal_03 = dca_port_00 | dca_signal_19;
assign dca_signal_04 = dca_signal_07 & dca_signal_06;
assign dca_signal_05 = dca_signal_08 | dca_signal_20;
assign dca_signal_06 = dca_signal_05? dca_signal_02[DCA_LPARA_1-1] : 1;

ERVP_COUNTER_WITH_ONEHOT_ENCODING
#(
  .COUNT_LENGTH(DCA_LPARA_1),
  .UP(1),
  .RESET_INDEX(0),
  .CIRCULAR(1)
)
i_dca_instance_1
(
  .clk(dca_port_11),
  .rstnn(dca_port_10),
  .enable(dca_port_06),
  .init(dca_signal_13),
  .count(dca_signal_17),
  .value(dca_signal_02),
  .is_first_count(),
  .is_last_count()
);

assign dca_signal_13 = dca_port_00;
assign dca_signal_17 = dca_signal_05;

assign dca_port_09 = dca_signal_08 & dca_signal_02[0];
assign dca_port_07 = dca_signal_20 & dca_signal_02[0];

assign dca_port_03 = dca_signal_19 & dca_signal_14;

assign dca_port_08 = dca_signal_07 & dca_signal_00 & dca_signal_02[0];
assign dca_port_01 = dca_signal_07 & (~dca_signal_00) & dca_signal_02[0];
assign dca_port_02 = dca_signal_08 & dca_signal_02[DCA_GPARA_1-1];
assign dca_port_12 = dca_signal_20 & dca_signal_02[DCA_GPARA_0-1];

endmodule
