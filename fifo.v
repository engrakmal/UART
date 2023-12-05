module fifo(clk_fifo_i, reset, load, read, data_in, LD_fifo_done, RD_fifo_done, data_out);
input clk_fifo_i, reset, load, read;
input [7:0] data_in;
output LD_fifo_done;
output RD_fifo_done;
output [7:0] data_out;

wire [63:0] data_63;

fifo_write inst_fifo_write(clk_fifo_i, reset, load, data_in, LD_fifo_done, data_63);
fifo_read inst_fifo_read(clk_fifo_i, reset, read, data_63, RD_fifo_done, data_out);

endmodule