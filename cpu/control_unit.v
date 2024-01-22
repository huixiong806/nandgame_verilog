module control_unit (
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
    wire [15:0] alu_instr_dat_r;
    wire        alu_instr_a;
    wire        alu_instr_d;
    wire        alu_instr_dref_a;
    wire        alu_instr_j;
    instruction U_INSTRUCTION(
        .instr      (instr),
        .dat_a      (dat_a),
        .dat_d      (dat_d),
        .dat_dref_a (dat_dref_a),
        .dat_r      (alu_instr_dat_r),
        .a          (alu_instr_a),
        .d          (alu_instr_d),
        .dref_a     (alu_instr_dref_a),
        .j          (alu_instr_j)
    );
    assign a        = instr[15] ? alu_instr_a      : 1;
    assign d        = instr[15] ? alu_instr_d      : 0;
    assign dref_a   = instr[15] ? alu_instr_dref_a : 0;
    assign dat_r    = instr[15] ? alu_instr_dat_r  : instr;
    assign j        = instr[15] ? alu_instr_j      : 0;
endmodule