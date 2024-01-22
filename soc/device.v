module device(
    input           clk,
    input           rst_n,
    input   [11:0]  addr,
    input   [15:0]  wdata,
    input           wen,
    output  [15:0]  rdata,
    input   [15:0]  switches,
    output  [15:0]  leds
);
    reg [15:0] leds_reg;
    //0x7ff0-0x8fff leds 
    always @(posedge clk)begin
        if(!rst_n)
            leds_reg <= 16'h0000;
        else if(wen && addr[11:4] == 8'hff)
            leds_reg[addr[3:0]] <= wdata[0];
    end
    //0x7fe0-0x7fef switches
    assign rdata = (addr[11:4] == 8'hfe) ? {15'h0,switches[addr[3:0]]} : 16'h0;
    assign leds = leds_reg;
endmodule