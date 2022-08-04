/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/01/2022
	Aluno: Fernando Veizaga e Alanis Castro
*/

module memDados(addr, write, datain, dataout);

	input [3:0] addr;
	input write;
	input [15:0] datain;
	output reg [15:0] dataout;
	
	reg [15:0] memoria[15:0];
	
	initial begin
		dataout = 16'b0;
		memoria[0][15:0] = 16'b0000000000000111;
		memoria[1][15:0] = 16'b0000000000000011;
		memoria[2][15:0] = 16'b0000000000000001;
		memoria[3][15:0] = 16'b0000000000000101;
		memoria[4][15:0] = 16'b0000000000000111;
	end
	
	always@(*)
	begin
		dataout = 16'b0;
		if(write == 1'b1)
		begin
			memoria[addr] = datain;
		end
		else begin
			dataout = memoria[addr];
		end
	end

endmodule
