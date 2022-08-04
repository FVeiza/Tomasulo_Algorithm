/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/01/2022
	Aluno: Fernando Veizaga e Alanis Castro
*/

module filaInstrucoes(clock, disponivel, instOutEn, instOut);

	input clock, disponivel;
	output reg [15:0] instOut;
	output reg instOutEn;
	
	reg [15:0] fila [15:0];
	reg [15:0] pc;
	
	initial begin
		pc = 15'b0;
		instOutEn = 1'b0;
		fila[0] = 16'b0000001100010010;	//ADD R3, R1, R2	// 0000 0011 0001 0010
		fila[1] = 16'b0001010100110001;	//SUB R5, R3, R1	// 0001 0101 0011 0001
		fila[2] = 16'b0010001100000110;	//SD  R3, 0(R6)	// 0010 0011 0000 0110
		fila[3] = 16'b0000000100110010;	//ADD R1, R3, R2	// 0000 0001 0011 0010
		fila[4] = 16'b0001000101000010; 	//SUB R1, R4, R2	// 0001 0001 0100 0010
		fila[5] = 16'b0011000100000100;	//LD  R1, 0(R4)	// 0011 0001 0000 0100
		fila[6] = 16'b0010010100000100;	//SD  R5, 0(R4)	// 0010 0101 0000 0100
		fila[7] = 16'b0001001100010011;	//SUB R3, R1, R3	// 0001 0011 0001 0011
		fila[8] = 16'b0011001100000110;	//LD  R3, 0(R6)	// 0011 0011 0000 0110
		fila[9] = 16'b0011001000000100;	//LD  R2, 0(R4)	// 0011 0010 0000 0100
	end
	
	always@(posedge clock)
	begin
	
		if(disponivel == 1'b1)
		begin
			instOutEn = 1'b1;
			instOut = fila[pc];
			pc = pc + 16'b0000000000000001;
		end
		
		else begin
			instOutEn = 1'b0;
		end
	end

endmodule
