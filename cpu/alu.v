module alu (
    input           u,
    input           op1,
    input           op0,
    input           zx,
    input           sw,
    input   [15:0]  dat_x,
    input   [15:0]  dat_y,
    output  [15:0]  out 
);
    wire   [15:0]  chg0_x = sw ? dat_y : dat_x;
    wire   [15:0]  chg0_y = sw ? dat_x : dat_y;
    wire   [15:0]  chg1_x = zx ? 15'h0 : chg0_x;
    wire   [15:0]  chg1_y = chg0_y;
    wire   [15:0]  adder_y_pre = op0 ? 15'h1 : chg1_y;
    wire   [15:0]  adder_y = op1 ? ~adder_y_pre : adder_y_pre;
    wire   [15:0]  adder_x = chg1_x;
    wire   [15:0]  adder_sum;
    wire           adder_cout;
    assign {adder_cout, adder_sum} = adder_x + adder_y + op1;
    reg    [15:0] logic_unit_out;
    always @(*)begin
        case({op1,op0})
        2'b00:  logic_unit_out = chg1_x & chg1_y;
        2'b01:  logic_unit_out = chg1_x | chg1_y;
        2'b10:  logic_unit_out = chg1_x ^ chg1_y;
        default:logic_unit_out = ~chg1_x;
        endcase
    end
    assign out = u ? adder_sum : logic_unit_out;
endmodule