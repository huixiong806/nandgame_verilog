module crossbar(
    input   [15:0]  addr,
    input   [15:0]  wdata,
    input           wen,
    output  [15:0]  rdata,
    //block ram
    output  [15:0]  bram_addr ,
    output  [15:0]  bram_wdata,
    output          bram_wen,
    input   [15:0]  bram_rdata,
    //device
    output  [15:0]  dev_addr,
    output  [15:0]  dev_wdata,
    output          dev_wen ,
    input   [15:0]  dev_rdata   
);
    wire addr_bram = addr[15:13] ==  3'b010;
    wire addr_dev  = addr[15:12] ==  4'b0111;
    assign bram_addr    =   addr;
    assign bram_wdata   =   wdata;
    assign bram_wen     =   wen && addr_bram;
    assign dev_addr     =   addr;
    assign dev_wdata    =   wdata;
    assign dev_wen      =   wen && addr_dev;
    assign rdata        =   ({16{addr_bram}} & bram_rdata)
                           |({16{addr_dev}}  & dev_rdata );
endmodule