programa
{
	inclua biblioteca Texto --> t
	inclua biblioteca Tipos --> ti
	inclua biblioteca Util --> u

	inteiro contato = 0, cada = 0, cont_ctr, cont_proc_nom = 0
	cadeia caixinha[100][2], resp = "", proc_nome, guarda_num, resp_num
	const inteiro telefone = 0, nome = 1, max_contato = 100
	logico quebra_w = verdadeiro, quebra_w1 = verdadeiro, quebra_num = verdadeiro
		
	funcao inicio(){
		enquanto(quebra_w == verdadeiro){
			para(contato = 0; contato < 100; contato++){
				escreva("Digite o nome do contato: ")
				leia(caixinha[contato][telefone])
				quebra_num = verdadeiro
				enquanto(quebra_num == verdadeiro){
					escreva("Digite o numero do contato: ")
					leia(caixinha[contato][nome])
					cont_ctr = 0
					para(cada = 0; cada < 100; cada++){
						se (caixinha[contato][telefone] != caixinha[cada][telefone] e caixinha[contato][nome] != caixinha[cada][nome]){
							quebra_num = falso
						}
						senao se(caixinha[contato][telefone] == caixinha[cada][telefone] e caixinha[contato][nome] == caixinha[cada][nome]){
							cont_ctr++
							se(cont_ctr > 1){
								escreva("Número ja cadastrado! Deseja cadastrar um outro número [1] ou cancelar o cadastro? [2]: ")
								leia(resp_num)
								se(resp_num == "1"){
									pare
								}
								senao se(resp_num == "2"){
									caixinha[contato][telefone] = ""
									caixinha[contato][nome] = ""
									contato--
									quebra_num = falso	
								}
								senao{
								}
							}
						}
					}
				}	

			quebra_w1 = verdadeiro
			enquanto(quebra_w1 == verdadeiro){
				escreva("Você deseja continuar cadastrando contatos?[S/N]: ")
				leia(resp)
				resp = t.caixa_alta(resp)
				
				se(resp == "S"){
					quebra_w1 = falso
				}
				senao se(resp == "N"){
						contato = max_contato
						quebra_w = falso
						quebra_w1 = falso
				}
				senao{	
				}
			}
			}
		}
		menu_1()
	}


		

	funcao menu_1(){
		escreva("Digite um nome para procurar na lista de contatos: ")
		leia(proc_nome)

		para(contato = 0; contato < 100; contato++){
			se(caixinha[contato][telefone] == proc_nome){
				escreva(caixinha[contato][telefone], " ", caixinha[contato][nome], " \t")
				cont_proc_nom++
			}
		}
		se(cont_proc_nom == 0){
			escreva("Cadastro não encontrado!")
		}
	}

	funcao menu_2(){
		escreva("Digite o numero o  ")
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 2312; 
 * @DOBRAMENTO-CODIGO = [11, 71];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */