/*
	CEFET-MG
	Disciplina de Laboratório de Arquitetura e Organização de Computadores II
	Data: 11/01/2022
	Aluno: Fernando Veizaga e Alanis Castro
*/

module estacaoReserva(clock, instr, instrInEn, r1, r2, r3, r4, r5, r6, disponivel, instrOut, instrOutEn, resultado, instrDone, done, instrucao, instrucaoOut, res, re1, re2, re3, re4, re5, re6);

	input clock, instrInEn;
	input [15:0] instr, r1, r2, r3, r4, r5, r6;
	output reg instrOutEn;
	output reg [15:0] instrOut;
	output wire [15:0] resultado;
	output wire [15:0] instrDone;
	output wire done;
	output disponivel;
	output reg [15:0] instrucao, instrucaoOut, res, re1, re2, re3, re4, re5, re6;
	
	reg [7:0] busy, instrNumIn;
	reg [3:0] regsrenom[7:0];
	reg [3:0] Qj[7:0];
	reg [3:0] Qk[7:0];
	reg [2:0] numInstrPronta;
	reg stop;
	reg [15:0] tabelaInstr[7:0];
	 	
	wire ufdisponivel;
	wire [7:0] instrNumOut;
	wire [15:0] rx, ry;
	
	integer i, j;
	
	assign disponivel = ~busy[1] | ~busy[2] | ~busy[3] | ~busy[4] | ~busy[5] | ~busy[6] | ~busy[7];
	
	unidadeFuncional unfun(clock, done, ufdisponivel, instrOut, instrOutEn, instrNumIn, instrNumOut, rx, ry, resultado, instrDone);
	
	regsMux RX(r1, r2, r3, r4, r5, r6, instrOut[7:4], rx);
	
	regsMux RY(r1, r2, r3, r4, r5, r6, instrOut[3:0], ry);
	
	initial begin
		for(j = 0; j <= 7; j = j + 1)
		begin
			regsrenom[j] = 0;
			busy[j] = 0;
			Qj[i] = 0;
			Qk[i] = 0;
		end
		stop = 1'b0;
		numInstrPronta = 3'b000;
	end
	
	always@(posedge clock)
	begin
		instrOut = 16'b0;
		instrOutEn = 1'b0;
		
		instrucao = instr;
		instrucaoOut = instrOut;
		res = resultado;
		re1 = r1;
		re2 = r2;
		re3 = r3;
		re4 = r4;
		re5 = r5;
		re6 = r6;
		
		if(instrInEn == 1'b1)
		begin
			$display("->Comeca a checagem:");
			for(i = 1; i < 8; i = i + 1)
			begin
				
				if(busy[i] == 1'b0 && stop == 1'b0)
				begin
					$display("A tabela possui uma posicao livre.");
					$display("Armazenando instrucao e sua posicao...");
					busy[i] = 1'b1;
					tabelaInstr[i][15:0] = instr[15:0];
					$display("Posicao na tabela=%d, Instrucao = %b", i, tabelaInstr[i][15:0]);
					
					if(tabelaInstr[i][15:12] == 4'b0000 || tabelaInstr[i][15:12] == 4'b0001)
					begin
						$display("Verificando dependencias e fazendo a renomeacao...");
						Qj[i] = regsrenom[instr[7:4]];
						Qk[i] = regsrenom[instr[3:0]];
						regsrenom[instr[11:8]] = i;
						$display("Qj = %b , Qk = %b, RZ = %b", regsrenom[instr[7:4]], regsrenom[instr[3:0]], regsrenom[instr[11:8]]);
					end
					
					else begin
						$display("Verificando dependencias e fazendo a renomeacao...");
						Qj[i] = 4'b0000;
						Qk[i] = regsrenom[instr[3:0]];
						regsrenom[instr[11:8]] = i;
						$display("Qj = %b , Qk = %b, RZ = %b", regsrenom[instr[7:4]], regsrenom[instr[3:0]], regsrenom[instr[11:8]]);
					end
					stop = 1'b1;
				end
			end
		end
		
		for(i = 7; i >= 1; i = i - 1)
		begin
			if(Qj[i]== 4'b0000 && Qk[i]== 4'b0000 && busy[i]==1 && stop == 1'b1)
			begin
				$display("Procurando instrucoes prontas para serem executadas...");
				$display("Instrucao pronta encontrada. Posicao na tabela=%d", i);
				stop = 1'b0;
				numInstrPronta = i;
				instrNumIn = i;
			end
		end
		
		if(done == 1'b1)
		begin
			$display("Liberando a posicao na tabela da instrucao pronta...");
			busy[instrNumOut] = 0;
			$display("Posicao da instrucao pronta a ser liberada = %d", instrNumOut);
			for(i = 1; i < 8; i = i + 1)
			begin
			
				if(Qj[i] == regsrenom[instrOut[11:8]])
				begin
					Qj[i] = 4'b0000;
				end
				
				if(Qk[i] == regsrenom[instrOut[11:8]])
				begin
					Qk[i] = 4'b0000;
				end
			end
			
			regsrenom[instrOut[11:8]] = 0;
		end
		
		if(numInstrPronta >= 1 && numInstrPronta <= 7 && ufdisponivel == 1)
		begin
			$display("Numero da instrucao que sera enviada para a UF=%d", numInstrPronta);
			instrOut = tabelaInstr[numInstrPronta];
			instrOutEn = 1'b1;
		end
		$display("-----------------------------------------------------");
	end

endmodule
