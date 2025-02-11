`define bus_width 8

module sum(
  input   logic [`bus_width - 1:0]  in1,  
  input   logic [`bus_width - 1:0]  in2,
  output  logic [`bus_width - 1:0]  out
);

logic [`bus_width - 1:0] xor_reg;
logic [`bus_width - 1:0] and_reg;
logic [`bus_width - 1:1] and2_reg;
logic [`bus_width - 1:1] or_reg;


always_comb 
  begin
    for (int block_index = 0; block_index < `bus_width; block_index++)
	  begin
	    xor_reg[block_index] = in1[block_index] ^ in2[block_index];
	    and_reg[block_index] = in1[block_index] & in2[block_index];
	    if (block_index == 1) and2_reg[1] = xor_reg[1] & and_reg[0];
	    else if (block_index > 1) and2_reg[block_index] = xor_reg[block_index] & or_reg[block_index - 1];
	    if (block_index > 0) or_reg[block_index] = and_reg[block_index] | and2_reg[block_index];
	    if (block_index == 0) out[0] = xor_reg[0];
  	    else if (block_index == 1) out[1] = and_reg[0] ^ xor_reg[1];
	    else  out[block_index] = or_reg[block_index - 1] ^ xor_reg[block_index];
	  end

  end

endmodule