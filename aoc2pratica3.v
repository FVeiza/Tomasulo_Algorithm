/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/01/2022
	Aluno: Fernando Veizaga e Alanis Castro
*/

module aoc2pratica3(clock);

	input clock;
	wire [15:0] proxInstr, instrOut, CDBdin, CDBdout, r1, r2, r3, r4, r5, r6;

	CDB cdb(clock, proxInstr, instrOut, CDBdin, CDBdout, r1, r2, r3, r4, r5, r6);

endmodule
