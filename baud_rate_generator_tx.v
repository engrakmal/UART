module baud_rate_generator_tx(clk, reset, max_tick); //mod_216_counter
input clk, reset; 
output max_tick;  // maxtick = s_tick, 1*max_tick = 163*q
//output [7:0] q; //[7:0] // acutual no of tick
// s i g n a l   d e c l a r a t i o n  
reg [7:0] r_reg;  // [7:0]
wire [7:0] r_next; // [7:0]
 
//  body 
//  r e g i s t e r  
always @(posedge clk, posedge reset)
	if(reset)
		r_reg <= 0;  
	else  
		r_reg <= r_next;
		  
//  n e x t - s t a t e   l o g i c  
assign r_next = (r_reg==(108))?0:r_reg + 1; // if r_reg=162, then r_next=0, else r_next=r_reg+1;
//  o u t p u t   l o g i c  
//assign q = r_reg;  
assign max_tick = (r_reg==(108))?1'b1:1'b0; // if r_reg=162, then max_tick=1, else max_tick=0;

endmodule

