module soc (
    input                   clk,
    input                   rst,
    input   [15:0]          switches,
    output  [15:0]          leds
);
    // cpu Inputs
    wire            clk_soc;
    wire            rst_n;
    wire   [15:0]   data_ram_rdata;
    wire   [15:0]   inst_ram_rdata;

    // cpu Outputs
    wire   [15:0]   data_ram_addr;
    wire            data_ram_wen;
    wire   [15:0]   data_ram_wdata;
    wire   [15:0]   inst_ram_addr;

    assign rst_n = ~rst;
    cpu U_CPU (
        .clk                     ( clk_soc          ),
        .rst_n                   ( rst_n            ),
        .data_ram_rdata          ( data_ram_rdata   ),
        .inst_ram_rdata          ( inst_ram_rdata   ),
        .data_ram_addr           ( data_ram_addr    ),
        .data_ram_wen            ( data_ram_wen     ),
        .data_ram_wdata          ( data_ram_wdata   ),
        .inst_ram_addr           ( inst_ram_addr    )
    );


    //0x0000-0x3fff
    //0000 0000 0000 0000
    //0011 1111 1111 1111
    distributed_rom U_INST_RAM(
        .a                       ( inst_ram_addr[13:0]  ),
        .spo                     ( inst_ram_rdata       )
    );
    
    //0x4000-0x5fff
    //0100 0000 0000 0000
    //0101 1111 1111 1111
    wire   [15:0]   bram_addr;
    wire            bram_wen;
    wire   [15:0]   bram_wdata;
    wire   [15:0]   bram_rdata;
    
    distributed_ram U_DATA_RAM(
        .clk                     ( clk_soc              ),
        .a                       ( bram_addr[12:0]      ),
        .d                       ( bram_wdata           ),
        .we                      ( bram_wen             ),
        .spo                     ( bram_rdata           )
    );

    //0x7000-0x7fff
    //0111 0000 0000 0000
    //0111 1111 1111 1111
    wire   [15:0]   dev_addr;
    wire            dev_wen;
    wire   [15:0]   dev_wdata;
    wire   [15:0]   dev_rdata;
    device U_DEVICE(
        .clk                     ( clk_soc              ),
        .rst_n                   ( rst_n                ),
        .addr                    ( dev_addr[11:0]       ),
        .wdata                   ( dev_wdata            ),
        .wen                     ( dev_wen              ),
        .rdata                   ( dev_rdata            ),
        .leds                    ( leds                 ),
        .switches                ( switches             )
    );

    //crossbar
    crossbar U_CROSSBAR(
        .addr                    ( data_ram_addr        ),
        .wdata                   ( data_ram_wdata       ),
        .wen                     ( data_ram_wen         ),
        .rdata                   ( data_ram_rdata      ),

        .bram_addr               ( bram_addr            ),
        .bram_wdata              ( bram_wdata           ),
        .bram_wen                ( bram_wen             ),
        .bram_rdata              ( bram_rdata           ),

        .dev_addr                ( dev_addr             ),
        .dev_wdata               ( dev_wdata            ),
        .dev_wen                 ( dev_wen              ),
        .dev_rdata               ( dev_rdata            )
    );

    clk_wiz_0 U_CLK_PLL(
        .clk_in1(clk),
        .clk_out1(clk_soc)
    );
endmodule