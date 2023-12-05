module fifo_read(clk_fifo_i, reset, read, data_in, RD_fifo_done, data_out);
input clk_fifo_i, reset, read;
input [63:0] data_in;
output RD_fifo_done;
output [7:0] data_out;

// 8 bytes
reg [7:0] fifo0;
reg [7:0] fifo1;
reg [7:0] fifo2;
reg [7:0] fifo3;
reg [7:0] fifo4;
reg [7:0] fifo5;
reg [7:0] fifo6;
reg [7:0] fifo7; 

reg [3:0] rdptr; // wirte-pointer

reg [7:0] data_out_temp;
reg RD_fifo_done_temp;

always @ (posedge clk_fifo_i)
	begin
		if (reset)
			begin
  				fifo0 = data_in[7:0];
				fifo1 = data_in[15:8];
				fifo2 = data_in[23:16];
				fifo3 = data_in[31:24];
				fifo4 = data_in[39:32];
				fifo5 = data_in[47:40];
				fifo6 = data_in[55:48];
				fifo7 = data_in[63:56];
	
				rdptr = 4'b0000;
				data_out_temp = 8'h00;
				RD_fifo_done_temp = 0;
			end
  		else
  			begin
  				if (read)
  					begin
  						if (rdptr == 4'b0000) //(rdptr == 4'b0000)//
  							begin
								data_out_temp <= fifo0; 
								rdptr <= rdptr + 1;
							end	
						else if (rdptr == 4'b0001) //(rdptr == 4'b0001)//
							begin               
								data_out_temp <= fifo1;
								rdptr <= rdptr + 1;
							end
						else if (rdptr == 4'b0010) //(rdptr == 4'b0010)//
							begin               
								data_out_temp <= fifo2;
								rdptr <= rdptr + 1;
							end
						else if (rdptr == 4'b0011) //(rdptr == 4'b0011)//
							begin               
								data_out_temp <= fifo3;
								rdptr <= rdptr + 1;
							end			
						else if (rdptr == 4'b0100) //(rdptr == 4'b0100)//
							begin               
								data_out_temp <= fifo4;
								rdptr <= rdptr + 1;
							end
						else if (rdptr == 4'b0101) //(rdptr == 4'b0101)//
							begin               
								data_out_temp <= fifo5;
								rdptr <= rdptr + 1;
							end
						else if (rdptr == 4'b0110) //(rdptr == 4'b0110)//
							begin
								data_out_temp <= fifo6;
								rdptr <= rdptr + 1;
							end
						else if (rdptr == 4'b0111) //(rdptr == 4'b0111)//
							begin               
								data_out_temp <= fifo7;
								RD_fifo_done_temp <= 1;
							end
						else //(rdptr == 4'b1000)
							begin
								rdptr <= rdptr;
								data_out_temp <= data_out_temp;		 			 
							end 
					end
				else
					begin
						fifo0 = data_in[7:0];
						fifo1 = data_in[15:8];
						fifo2 = data_in[23:16];
						fifo3 = data_in[31:24];
						fifo4 = data_in[39:32];
						fifo5 = data_in[47:40];
						fifo6 = data_in[55:48];
						fifo7 = data_in[63:56];	
					end
			end				 
	end 				 

assign RD_fifo_done = RD_fifo_done_temp;
assign data_out = data_out_temp;


endmodule