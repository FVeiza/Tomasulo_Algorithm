/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/01/2022
	Aluno: Fernando Veizaga e Alanis Castro
*/

module regsMux(r1, r2, r3, r4, r5, r6, regnumber, regout);

	input [15:0] r1, r2, r3, r4, r5, r6;
	input [3:0] regnumber;
	output reg [15:0] regout;

	always@(*)
	begin
		case(regnumber)
			3'b0001: begin regout <= r1; end
			3'b0010: begin regout <= r2; end
			3'b0011: begin regout <= r3; end
			3'b0100: begin regout <= r4; end
			3'b0101: begin regout <= r5; end
			3'b0110: begin regout <= r6; end
			endcase
	end

endmodule
