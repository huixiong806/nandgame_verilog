module counter (
    input           clk,
    input           rst_n,
    input           st,
    input   [15:0]  dat_x,
    output  [15:0]  out 
);
    reg [15:0] counter_reg;
    always @(posedge clk)begin
        if(!rst_n)
            counter_reg <= 0;
        else if(st)
            counter_reg <= dat_x;
        else counter_reg <= counter_reg + 1;
    end
    assign out = counter_reg;
endmodule