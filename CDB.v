/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/01/2022
	Aluno: Fernando Veizaga e Alanis Castro
*/

module CDB(clock, proximaInstr, instrucaoOut, cdbdin, cdbdout, r1, r2, r3, r4, r5, r6);

	input clock;
	
	output wire [15:0] proximaInstr, instrucaoOut, cdbdout, r1, r2, r3, r4, r5,r6;
	output reg [15:0] cdbdin;
	
	reg [3:0] regnumber;
	reg memwrite, regwrite;
	reg [15:0] CDBdatain, memdatain; 
	reg [3:0] memin;
	
	wire instInEn, instOutEn, disponivel, done;
	wire [15:0] R1, R2, R3, R4, R5, R6, regout, CDBdataout, proxInstr, instr, instOut, memout;
	
	initial begin
		memwrite = 1'b0;
		regwrite = 1'b0;
		regnumber = 4'b0000;
		CDBdatain = 16'b0;
	end
	
	filaInstrucoes fila(clock, disponivel, instInEn, proxInstr);
	
	estacaoReserva estacao(clock, proxInstr, instInEn, R1, R2, R3, R4, R5, R6, disponivel, instr, instOutEn, CDBdataout, instOut, done, proximaInstr, instrucaoOut, cdbdout, r1, r2, r3, r4, r5, r6);
	
	bancoRegs banco(clock, CDBdatain, regnumber, regwrite, R1, R2, R3, R4, R5, R6);
	
	memDados memoria(memin, memwrite, memdatain, memout);
	
	regsMux RZ(R1, R2, R3, R4, R5, R6, instOut[11:8], regout);
	
	always@(posedge done)
	begin
	
		regwrite = 1'b0;
		memwrite = 1'b0;
		cdbdin = CDBdatain;
	
		if(instOut[15:12] == 4'b0000 || instOut[15:12] == 4'b0001)		//ADD e SUB
		begin
			CDBdatain = CDBdataout;
			regnumber = instOut[11:8];
			regwrite = 1'b1;
		end
		
		else if(instOut[15:12] == 4'b0010)		//SD
		begin
			memin = CDBdataout[3:0];
			memdatain = regout;
			memwrite = 1'b1;
		end
		
		else if(instOut[15:12] == 4'b0011)		//LD
		begin
			memin = CDBdataout[3:0];
			CDBdatain = memout;
			regnumber = instOut[11:8];
			regwrite = 1'b1;
		end
		
	end
	
endmodule
