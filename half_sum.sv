

 module half_sum(
  input   logic   halfsum_in1,  
  input   logic   halfsum_in2,
  output  logic   halfsum_out,
  output  logic   halfsum_nextbit_out
                 );


 assign halfsum_out         = halfsum_in1 ^ halfsum_in2;
 assign halfsum_nextbit_out = halfsum_in1 & halfsum_in2;

 
 endmodule

