module sum(
  input   logic [7:0]  in1,  
  input   logic [7:0]  in2,
  output  logic [7:0]  out
);

logic reg1_xor;
logic reg2_xor;
logic reg3_xor;
logic reg4_xor;
logic reg5_xor;
logic reg6_xor;
logic reg7_xor;
logic reg8_xor;

logic reg1_and;
logic reg2_and;
logic reg3_and;
logic reg4_and;
logic reg5_and;
logic reg6_and;
logic reg7_and;
logic reg8_and;

logic reg2_and2;
logic reg3_and2;
logic reg4_and2;
logic reg5_and2;
logic reg6_and2;
logic reg7_and2;
logic reg8_and2;

logic reg2_or;
logic reg3_or;
logic reg4_or;
logic reg5_or;
logic reg6_or;
logic reg7_or;
logic reg8_or;

always_comb 
begin
  reg1_xor = in1[0] ^ in2[0];
  reg2_xor = in1[1] ^ in2[1];
  reg3_xor = in1[2] ^ in2[2];
  reg4_xor = in1[3] ^ in2[3];
  reg5_xor = in1[4] ^ in2[4];
  reg6_xor = in1[5] ^ in2[5];
  reg7_xor = in1[6] ^ in2[6];
  reg8_xor = in1[7] ^ in2[7];

  reg1_and = in1[0] & in2[0];
  reg2_and = in1[1] & in2[1];
  reg3_and = in1[2] & in2[2];
  reg4_and = in1[3] & in2[3];
  reg5_and = in1[4] & in2[4];
  reg6_and = in1[5] & in2[5];
  reg7_and = in1[6] & in2[6];
  reg8_and = in1[7] & in2[7];

  reg2_and2 = reg2_xor & reg1_and;
  reg3_and2 = reg3_xor & reg2_and2;
  reg4_and2 = reg4_xor & reg3_and2;
  reg5_and2 = reg5_xor & reg4_and2;
  reg6_and2 = reg6_xor & reg5_and2;
  reg7_and2 = reg7_xor & reg6_and2;
  reg8_and2 = reg8_xor & reg7_and2;

  reg2_or = reg2_and | reg2_and2;
  reg3_or = reg3_and | reg3_and2;
  reg4_or = reg4_and | reg4_and2;
  reg5_or = reg5_and | reg5_and2;
  reg6_or = reg6_and | reg6_and2;
  reg7_or = reg7_and | reg7_and2;
  reg8_or = reg8_and | reg8_and2;

  out[0] = reg1_xor;
  out[1] = reg1_and ^ reg2_xor;
  out[2] = reg2_or ^ reg3_xor;
  out[3] = reg3_or ^ reg4_xor;
  out[4] = reg4_or ^ reg5_xor;
  out[5] = reg5_or ^ reg6_xor;
  out[6] = reg6_or ^ reg7_xor;
  out[7] = reg7_or ^ reg8_xor;
end

endmodule

