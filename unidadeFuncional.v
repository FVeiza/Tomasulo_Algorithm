/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/01/2022
	Aluno: Fernando Veizaga e Alanis Castro
*/

module unidadeFuncional(clock, done, ufdisponivel, instr, instrEn, instrNumIn, instrNumOut, r1, r2, resultado, instrOut);
	
	input clock, instrEn;
	input [7:0] instrNumIn;
	output reg [7:0] instrNumOut;
	input [15:0] instr, r1, r2;
	output reg [15:0] resultado, instrOut;
	output reg done, ufdisponivel;
	
	integer ciclo = 0;
	
	initial begin
		done = 1'b0;
		ufdisponivel = 1'b1;
	end
	
	always@(posedge clock)
	begin
		done = 1'b0;
		
		if(ufdisponivel == 1'b1 && instrEn == 1'b1)
		begin
			$display("->Inicio da execucao da instrucao na UF.");
			ufdisponivel = 1'b0;
			ciclo = 1;
			instrNumOut = instrNumIn;
			instrOut = instr;
			$display("Instrucao a ser executada = %b,  Posicao da instrucao = %d", instrOut, instrNumOut);
			case(instr[15:12])
				4'b0000: begin resultado = r2 + r1; end					//ADD
				4'b0001: begin resultado = r2 - r1; end					//SUB
				4'b0010: begin resultado = instr[7:4] + r2; end			//SD
				4'b0011: begin resultado = instr[7:4] + r2; end			//LD
			endcase
			
		end
		
		else begin
			ciclo = ciclo + 1;
		end
		
		if(instr[15:12] == 4'b0010 || instr[15:12] == 4'b0011)
		begin
			$display("Execucao concluida");
			done = 1'b1;
			ufdisponivel = 1'b1;
			ciclo = 0;
			$display("Resultado = %b", resultado);
			$display("-----------------------------------------------------");
		end
		
		else begin
			if(ciclo == 3)
			begin
				$display("Execucao concluida");
				done = 1'b1;
				ufdisponivel = 1'b1;
				ciclo = 0;
				$display("Resultado = %b", resultado);
				$display("-----------------------------------------------------");
			end
		end
	end
	
endmodule
