module uart(CLOCK_TX, CLOCK_RX, RESET, SEND, TX_DATA, NINTO, NINTI, RX_DATA);
input CLOCK_TX, CLOCK_RX, RESET, SEND;
input [7:0] TX_DATA;
output NINTO, NINTI;
output [7:0] RX_DATA;

wire tx, max_tick_tx, max_tick_rx;

baud_rate_generator_tx inst_baud_rate_generator_tx(CLOCK_TX, RESET, max_tick_tx);
baud_rate_generator_rx inst_baud_rate_generator_rx(CLOCK_RX, RESET, max_tick_rx);

uart_tx inst_uart_tx(CLOCK_TX, RESET, SEND, max_tick_tx, TX_DATA, NINTO, tx);
uart_rx inst_uart_rx(CLOCK_RX, RESET, tx, max_tick_rx, NINTI, RX_DATA);

endmodule