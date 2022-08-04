/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/01/2022
	Aluno: Fernando Veizaga e Alanis Castro
*/

module bancoRegs(clock, data, regnumber, write, R1, R2, R3, R4, R5, R6);
	
	input clock, write;
	input [15:0] data;
	input [3:0] regnumber;
	output reg [15:0] R1, R2, R3, R4, R5, R6;
	
	initial begin
		R1 = 1;
		R2 = 2;
		R3 = 3;
		R4 = 3;
		R5 = 0;
		R6 = 0;
	end
	
	always@(posedge clock)
	begin
		if(write == 1'b1)
		begin
			case(regnumber)
				4'b0001: R1 = data;
				4'b0010: R2 = data;
				4'b0011: R3 = data;
				4'b0100: R4 = data;
				4'b0101: R5 = data;
				4'b0110: R6 = data;
			endcase
		end
	end
	
endmodule
