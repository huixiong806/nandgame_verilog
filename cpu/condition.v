module condition (
    input               lt,
    input               eq,
    input               gt,
    input signed [15:0] dat_x,
    output              out 
);
    wire less_than_zero = dat_x[15];
    wire equal_to_zero = dat_x == 0;
    wire greater_than_zero = !(less_than_zero || equal_to_zero);
    assign out = (lt & less_than_zero)
                |(eq & equal_to_zero)
                |(gt & greater_than_zero); 
endmodule