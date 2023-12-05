module  uart_tx(CLOCK_TX, RESET, SEND, s_tick, TX_DATA, NINTO, SO);
input CLOCK_TX, RESET;
input SEND, s_tick;  
input [7:0] TX_DATA;
output NINTO; 
output SO;
// symlbolic state declaration  
localparam [1:0]
idle = 2'b00,  
start = 2'b01,  
data = 2'b10,  
stop = 2'b11;  

// signal declaration  
reg [1:0] state_reg; 
reg [3:0] s_reg;  
reg [2:0] n_reg;  
reg [7:0] b_reg;  
reg tx_reg;
reg NINTO_temp; 

//  body
//  FSMD  n e x t - s t a t e   l o g i c   &  f u n c t i o n a l   u n i t s  
always @(posedge CLOCK_TX)
	begin
		if (RESET)  
			begin  
				state_reg <= idle;  
				s_reg <= 0;  
				n_reg <= 0;  
				b_reg <= 0;  
				tx_reg <= 1'b1; 
				NINTO_temp = 1'b0; 
			end 
		else  
			begin
				case (state_reg)  
					idle: 
						begin  
							tx_reg = 1'b1;  
								if (SEND)  
									begin  
										state_reg = start;  
										s_reg = 0;  
										b_reg = TX_DATA;
										NINTO_temp = 1'b1;  
									end
						end 
					start: 
						begin  
							tx_reg = 1'b0;  
								if (s_tick)  
									if (s_reg==15)  
										begin  
											state_reg = data;  
											s_reg = 0;  
											n_reg = 0;  
										end 
									else  
										s_reg = s_reg + 1;  
						end 
					data:  
						begin  
							tx_reg = b_reg[0]; 
								if (s_tick) 
									if (s_reg==15)  
										begin  
											s_reg = 0;  
											b_reg = b_reg >> 1;  
												if (n_reg==7) 
													state_reg = stop; 
												else  
													n_reg = n_reg + 1; 
										end 
									else  
										s_reg = s_reg + 1; 
						end 
					stop: 
						begin  
							tx_reg = 1'b1;  
								if (s_tick)  
									if (s_reg==15)  
										begin  
											state_reg = idle;  
											NINTO_temp = 1'b0;  
										end 
									else  
										s_reg = s_reg + 1; 
						end 
					default:
						begin
							state_reg <= idle;  
							s_reg <= 0;  
							n_reg <= 0;  
							b_reg <= 0;  
							tx_reg <= 1'b1; 
							NINTO_temp = 1'b0; 
						end
				endcase
			end  
	end 
//  o u t p u t  
assign SO = tx_reg;
assign NINTO = NINTO_temp;  

endmodule