module  uart_rx(CLOCK_RX, RESET, SI, s_tick, NINTI, RX_DATA);
input CLOCK_RX, RESET;  
input SI, s_tick; // s_tick = max_tick, asserts when count reaches 163 
output NINTI;  
output [7:0] RX_DATA;

//  s y m b o l i c   s t a t e   d e c l a r a t i o n  
localparam [1:0]
idle = 2'b00,  
start = 2'b01,  
data = 2'b10,  
stop = 2'b11;
  
//  s i g n a l   d e c l a r a t i o n  
reg [1:0] state_reg; 
reg [3:0] s_reg; 
reg [2:0] n_reg; 
reg [7:0] b_reg;
reg NINTI_temp; 

//  body 
//  FSMD  n e x t - s t a t e   l o g i c  
always @(posedge CLOCK_RX) 
	begin
		if (RESET)
			begin
				state_reg <= idle;  
				s_reg <= 0;
				n_reg <= 0;
				b_reg <= 0;
				NINTI_temp = 1'b1;
			end 
		else  
			begin
				case (state_reg)  
					idle: 
						if (~SI)
							begin
								state_reg = start;
								s_reg = 0;  
							end 
					start: 
						if (s_tick)
							if (s_reg==7)  
								begin  
									state_reg = data;  
									s_reg = 0;  
									n_reg = 0;
									NINTI_temp = 1'b0;  
								end 
							else  
								s_reg = s_reg + 1;  
					data: 
						if (s_tick)  
							if (s_reg==15)  
								begin  
									s_reg = 0;  
									b_reg = {SI, b_reg [7:1]}; 
										if (n_reg == 7) 
											begin 
												state_reg = stop;
												NINTI_temp = 1'b1;
											end 
										else  
											n_reg = n_reg + 1;  
								end 
							else  
								s_reg = s_reg + 1;  	
					stop:  
						if (s_tick)  
							if (s_reg == 15) 
								begin  
									state_reg = idle;    
								end 
							else  
								s_reg = s_reg + 1; 
					default:
						begin
							state_reg <= idle;  
							s_reg <= 0;
							n_reg <= 0;
							b_reg <= 0;
							NINTI_temp = 1'b1;
						end
				endcase
			end  
	end 
//  o u t p u t  
assign RX_DATA = b_reg; 
assign NINTI = NINTI_temp; 
 
endmodule