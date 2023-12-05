module fifo_write(clk_fifo_i, reset, load, data_in, LD_fifo_done, data_out);
input clk_fifo_i, reset, load;
input [7:0] data_in;
output LD_fifo_done;
output [63:0] data_out;

// 8 bytes
reg [7:0] fifo0;
reg [7:0] fifo1;
reg [7:0] fifo2;
reg [7:0] fifo3;
reg [7:0] fifo4;
reg [7:0] fifo5;
reg [7:0] fifo6;
reg [7:0] fifo7; 

reg [3:0] wrptr; // wirte-pointer

reg [63:0] data_out_temp;
reg r_LD_done;

always @ (posedge clk_fifo_i)
	begin
		if (reset)
			begin
				fifo0 = 8'h00;
				fifo1 = 8'h00;
				fifo2 = 8'h00;
				fifo3 = 8'h00;
				fifo4 = 8'h00;
				fifo5 = 8'h00;
				fifo6 = 8'h00;
				fifo7 = 8'h00;
	
				wrptr = 4'b0000;
				data_out_temp = 64'h00000000;
				r_LD_done = 0;
			end
  		else
  			begin
  				if (load)
  					begin
  						if (wrptr == 4'b0000) //(wrptr == 4'b0000)//
  							begin
								fifo0 <= data_in;
								wrptr <= wrptr + 1;
							end	
						else if (wrptr == 4'b0001) //(wrptr == 4'b0001)//
							begin               
								fifo1 <= data_in;
								wrptr <= wrptr + 1;
							end
						else if (wrptr == 4'b0010) //(wrptr == 4'b0010)//
							begin               
								fifo2 <= data_in;
								wrptr <= wrptr + 1;
							end
						else if (wrptr == 4'b0011) //(wrptr == 4'b0011)//
							begin               
								fifo3 <= data_in;
								wrptr <= wrptr + 1;
							end			
						else if (wrptr == 4'b0100) //(wrptr == 4'b0100)//
							begin               
								fifo4 <= data_in;
								wrptr <= wrptr + 1;
							end
						else if (wrptr == 4'b0101) //(wrptr == 4'b0101)//
							begin               
								fifo5 <= data_in;
								wrptr <= wrptr + 1;
							end
						else if (wrptr == 4'b0110) //(wrptr == 4'b0110)//
							begin               
								fifo6 <= data_in;
								wrptr <= wrptr + 1;
							end
						else if (wrptr == 4'b0111) //(wrptr == 4'b0111)//
							begin               
								fifo7 <= data_in;
								r_LD_done <= 1;
							end
						else //(wrptr == 4'b1000)
							begin
								wrptr <= wrptr;
								fifo0 <= fifo0;
								fifo1 <= fifo1;
								fifo2 <= fifo2;
								fifo3 <= fifo3;
								fifo4 <= fifo4;
								fifo5 <= fifo5;
								fifo6 <= fifo6;
								fifo7 <= fifo7;			 			 
							end 
					end
				else
					begin
						if (r_LD_done)
						//wrptr = 4'b0000;
							data_out_temp = {fifo7, fifo6, fifo5, fifo4, fifo3, fifo2, fifo1, fifo0};
						//data_out_temp = 64'h00000000;
						//r_LD_done = 0;
						else
							data_out_temp = data_out_temp;
							
					end
			end				 
	end 				 

assign LD_fifo_done = r_LD_done;
assign data_out = data_out_temp;


endmodule