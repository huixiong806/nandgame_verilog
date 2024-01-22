module instruction (
    input   [15:0]  instr,
    input   [15:0]  dat_a,
    input   [15:0]  dat_d,
    input   [15:0]  dat_dref_a,
    output  [15:0]  dat_r,
    output          a,
    output          d,
    output          dref_a,
    output          j
);
    wire [15:0]  alu_out;
    alu U_ALU(
        .u      (instr[10]),
        .op1    (instr[9]),
        .op0    (instr[8]),
        .zx     (instr[7]),
        .sw     (instr[6]),
        .dat_x  (dat_d),
        .dat_y  (instr[12] ? dat_dref_a : dat_a),
        .out    (alu_out)
    );
    condition U_CONDITION(
        .lt     (instr[2]),
        .eq     (instr[1]),
        .gt     (instr[0]),
        .dat_x  (alu_out),
        .out    (j)
    );
    assign {a,d,dref_a} = instr[5:3];
    assign dat_r = alu_out;
endmodule