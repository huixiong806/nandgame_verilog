//~ `New testbench
`timescale  1ns / 1ps

module tb_soc;

// soc Parameters
parameter PERIOD  = 10;


// soc Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 1 ;
reg   [15:0]  switches                     = 0 ;

// soc Outputs
wire  [15:0]  leds                         ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*100) rst  =  0;
end

soc  u_soc (
    .clk                     ( clk             ),
    .rst                     ( rst             ),
    .switches                ( switches   [15:0] ),

    .leds                    ( leds     [15:0] )
);

initial
begin
    #(10000 * PERIOD)
    $finish;
end

endmodule