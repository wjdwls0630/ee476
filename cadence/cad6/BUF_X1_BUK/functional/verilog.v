// Created by ihdl
module BUF_X1_BUK (A, Z);
  input A;
  output Z;

  buf(Z, A);

  specify
    (A => Z) = (0.1, 0.1);
  endspecify

endmodule
