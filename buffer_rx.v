module buffer_rx(CLOCK, RESET, READ, Rx_Data_In, Rx_Data_Out);
input CLOCK, RESET, READ;
input [7:0] Rx_Data_In;
output [7:0] Rx_Data_Out;

reg [7:0] buffer;

always @(posedge CLOCK)
	begin
		if (RESET)
			buffer = 8'h00;
		else if (READ)
			buffer = Rx_Data_In;
		else
			buffer = buffer;
	end
	
assign 	Rx_Data_Out = buffer;
endmodule