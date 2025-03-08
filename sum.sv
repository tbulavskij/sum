 `include "half_sum.sv"

 parameter BUS_WIDTH = 32;

 module sum(
  input   logic [BUS_WIDTH - 1:0]  sum_in1,  
  input   logic [BUS_WIDTH - 1:0]  sum_in2,
  output  logic [BUS_WIDTH - 1:0]  sum_out,
  output  logic                    sum_nextbit_out
            );

 logic [BUS_WIDTH*2 - 1:0] halfsum_in1;
 logic [BUS_WIDTH*2 - 1:0] halfsum_in2;
 logic [BUS_WIDTH*2 - 1:0] halfsum_out;
 logic [BUS_WIDTH*2 - 1:0] halfsum_nextbit_out;
 

 generate       
  genvar genindex; 
   for (genindex = 0; genindex < BUS_WIDTH*2 - 1; genindex++) begin 
    .half_sum u1(
	.halfsum_in1         (halfsum_in1[genindex]),
    .halfsum_in2         (halfsum_in2[genindex]),
	.halfsum_out         (halfsum_out[genindex]),
	.halfsum_nextbit_out (halfsum_nextbit_out[genindex])
      );
   end
  endgenerate

 always_comb begin
  for (int block_index = 0; block_index < BUS_WIDTH*2; block_index+=2) begin
   if (block_index == 0) begin
    halfsum_in1[block_index] = sum_in1[block_index];
    halfsum_in2[block_index] = sum_in2[block_index];
    sum_out[block_index]     = halfsum_out[block_index];
   end
   else if (block_index == 2) begin
    halfsum_in1[block_index-1]  = sum_in1[block_index/2];
    halfsum_in2[block_index-1]  = sum_in2[block_index/2];
    halfsum_in1[block_index]    = halfsum_nextbit_out[block_index-2];
	halfsum_in2[block_index]    = halfsum_out[block_index - 1];
    sum_out[block_index/2]		= halfsum_out[block_index];	 
   end
   else begin
    halfsum_in1[block_index-1]  = sum_in1[block_index/2];
    halfsum_in2[block_index-1]  = sum_in2[block_index/2];
    halfsum_in1[block_index]    = halfsum_nextbit_out[block_index-2] |  halfsum_nextbit_out[block_index-3];
    halfsum_in2[block_index]    = halfsum_out[block_index - 1];
    sum_out[block_index/2]		= halfsum_out[block_index];	 
   end
  end
  sum_nextbit_out = halfsum_nextbit_out[BUS_WIDTH*2 - 2] |  halfsum_nextbit_out[BUS_WIDTH*2 - 3];
 end
endmodule

