module combined_memory (
    input           clk,
    input           rst_n,
    input           a,
    input           d,
    input           dref_a,
    input   [15:0]  dat_x,
    output  [15:0]  dat_a,
    output  [15:0]  dat_d,
    output  [15:0]  dat_dref_a,
    //memory
    output  [15:0]          data_ram_addr,
    input   [15:0]          data_ram_rdata,
    output                  data_ram_wen,
    output  [15:0]          data_ram_wdata
);
    reg [15:0] a_reg;
    reg [15:0] d_reg;
    always @(posedge clk)begin
        if(!rst_n)
            a_reg <= 0;
        else if(a)
            a_reg <= dat_x;
    end
    always @(posedge clk)begin
        if(!rst_n)
            d_reg <= 0;
        else if(d)
            d_reg <= dat_x;
    end
    assign data_ram_addr = a_reg;
    assign data_ram_wen  = dref_a;
    assign data_ram_wdata = dat_x;
    assign dat_dref_a    = data_ram_rdata;
    assign dat_d = d_reg;
    assign dat_a = a_reg;
endmodule