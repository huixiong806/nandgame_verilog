module cpu (
    input                   clk,
    input                   rst_n,
    input   [15:0]          data_ram_rdata,
    output  [15:0]          data_ram_addr,
    output                  data_ram_wen,
    output  [15:0]          data_ram_wdata,
    input   [15:0]          inst_ram_rdata,
    output  [15:0]          inst_ram_addr
);
    wire    [15:0]          dat_a;
    wire    [15:0]          dat_d;
    wire    [15:0]          dat_r;
    wire    [15:0]          dat_dref_a;
    wire                    a;
    wire                    d;
    wire                    dref_a;
    wire                    j;
    //control unit
    control_unit  U_CONTROL_UNIT (
        .instr                   ( inst_ram_rdata ),
        .dat_a                   ( dat_a        ),
        .dat_d                   ( dat_d        ),
        .dat_dref_a              ( dat_dref_a   ),
        .dat_r                   ( dat_r        ),
        .a                       ( a            ),
        .d                       ( d            ),
        .dref_a                  ( dref_a       ),
        .j                       ( j            )
    );
    //memory
    combined_memory  U_MEMORY (
        .clk                     ( clk              ),
        .rst_n                   ( rst_n            ),
        .a                       ( a                ),
        .d                       ( d                ),
        .dref_a                  ( dref_a           ),
        .dat_x                   ( dat_r            ),
        .dat_a                   ( dat_a            ),
        .dat_d                   ( dat_d            ),
        .dat_dref_a              ( dat_dref_a       ),
        .data_ram_rdata          ( data_ram_rdata   ),
        .data_ram_addr           ( data_ram_addr    ),
        .data_ram_wen            ( data_ram_wen     ),
        .data_ram_wdata          ( data_ram_wdata   )
    );
    //counter
    counter  U_COUNTER (
        .clk                     ( clk     ),
        .rst_n                   ( rst_n   ),
        .st                      ( j      ),
        .dat_x                   ( dat_a   ),
        .out                     ( inst_ram_addr )
    );
endmodule