programa
{
	inclua biblioteca Texto --> t
	inclua biblioteca Tipos --> ti
	inclua biblioteca Util --> u
	inclua biblioteca Arquivos --> a

	inteiro cont_contato = 0, cont_num = 0, cont_proc_nom = 0, nome_cont = 0, cont_proc = 0, cont_nil = 0, cont_elem = 0, cont_upload, cont_ctr, cont_a, elem_restantes, endereco
	inteiro pos_final_linha, pos_caracter, cont_download, cont_alt, cont_existe_alt = 0, cont_novo_nome, cont_quebra_novo_nome = 0, cont_novo_numero, cont_quebra_novo_numero = 0
	inteiro cont_procurar_nome, cont_achou_nome = 0
	cadeia caixinha[100][2], for_sup[] = {"|txt"}, resp = "", proc_nome, guarda_num, resp_num, resp_menu, nome_ap, repos_1 = "", repos_2 = "", repos_nil = "", nil = ""
	cadeia linha, resp_carregar, upload, escrita, resp_alt, resp_qual_dado, novo_nome, novo_numero, indice
	const inteiro telefone = 0, nome = 1, max_contato = 100
	logico quebra_w = verdadeiro, quebra_w1 = verdadeiro, quebra_w2 = verdadeiro, quebra_num = verdadeiro, quebra_novo_nome = verdadeiro, quebra_novo_numero = verdadeiro
	logico quebra_alt = verdadeiro, quebra_perg_numero = verdadeiro, quebra_perg_nome = verdadeiro, quebra_menu = verdadeiro
	funcao inicio(){
		cadastro()
	}
		
	funcao cadastro(){
		enquanto(quebra_w == verdadeiro){
			para(cont_contato = 0; cont_contato < 100; cont_contato++){
				escreva("Digite o nome do contato: ")
				leia(caixinha[cont_contato][telefone])
				quebra_num = verdadeiro
				enquanto(quebra_num == verdadeiro){
					escreva("Digite o numero do contato: ")
					leia(caixinha[cont_contato][nome])
					cont_ctr = 0
					para(cont_num = 0; cont_num < 100; cont_num++){
						se(caixinha[cont_contato][telefone] == caixinha[cont_num][telefone] e caixinha[cont_contato][nome] == caixinha[cont_num][nome]){
							cont_ctr++
							se(cont_ctr > 1){
								quebra_w2 = verdadeiro
								enquanto(quebra_w2 == verdadeiro){
									escreva("Número ja cadastrado! Deseja cadastrar um outro número [1] ou cancelar o cadastro? [2]: ")
									leia(resp_num)
									se(resp_num == "1"){
										quebra_w2 = falso
										cont_num = max_contato
									}
									senao se(resp_num == "2"){
										caixinha[cont_contato][telefone] = ""
										caixinha[cont_contato][nome] = ""
										cont_contato--
										quebra_num = falso
										quebra_w2 = falso
									}
								}
							}
						}
						senao se(caixinha[cont_contato][telefone] != caixinha[cont_num][telefone] e caixinha[cont_contato][nome] != caixinha[cont_num][nome]){
							quebra_num = falso
						}
					}
				}
			
				quebra_w1 = verdadeiro
				enquanto(quebra_w1 == verdadeiro){
					escreva("Você deseja continuar cadastrando contatos?[S/N]: ")
					cont_elem++
					leia(resp)
					resp = t.caixa_alta(resp)
					
					se(resp == "S"){
						quebra_w1 = falso
					}
					senao se(resp == "N"){
						cont_num = max_contato
						cont_contato = max_contato
						quebra_num = falso
						quebra_w = falso
						quebra_w1 = falso
					}
				}
			}
		}
		
		escreva("Digite [1] para listar todos os contatos \nDigite [2] para procurar um contato \nDigite [3] para apagar um contato \nDigite [4] para alterar um contato")
		escreva("\nDigite sua opção: ")
		leia(resp_menu)
		enquanto(quebra_menu == verdadeiro){
			se(resp_menu == "2"){
				quebra_menu = falso
				procura()
			}
			senao se(resp_menu == "3"){
				quebra_menu = falso
				apagar()
			}
			senao se(resp_menu == "4"){
				quebra_menu = falso
				alterar()
			}
			senao{
				escreva("Número inválido, digite novamente uma das opções: ")
				leia(resp_menu)
			}
		}
	}


		

	funcao procura(){
		escreva("Digite um nome para procurar na lista de contatos: ")
		leia(proc_nome)
		
		escreva("O índice do nome procurado é: ", procurar_nome(proc_nome),"\n")
		escreva(caixinha[cont_proc][telefone], " ", caixinha[cont_proc][nome], " \t")
	}

	funcao apagar(){
		escreva("Digite o nome do contato a ser excluído: ")
		leia(nome_ap)
		para(nome_cont = 0; nome_cont < cont_elem; nome_cont++){
			se(nome_ap == caixinha[nome_cont][telefone]){
				caixinha[nome_cont][telefone] = ""
				caixinha[nome_cont][nome] = ""
				se(caixinha[nome_cont+1][telefone] == ""){//verifica se é vazio a próxima posição e para
					pare
				}
				senao{ //verifica se existe algo na proxima posição
					para(cont_nil = nome_cont; cont_nil < cont_elem; cont_nil++){//for com base na posição do elem q foi apagado até o num de elem na matriz
						repos_1 = caixinha[cont_nil+1][telefone]//pega o elemento da próxima posição(com base na posição que teve o elemento apagado)
						caixinha[cont_nil][telefone] = repos_1//põe na posição apagada o elemento a seguir
						repos_2 = caixinha[cont_nil+1][nome]//faz a mesma coisa só que com o elemento a seguir, talvez seja útil pra agilizar mas que surja + erros
						caixinha[cont_nil][nome] = repos_2
					}
				}
			}
		}
		para(cont_a = 0; cont_a < cont_elem; cont_a++){
			escreva(caixinha[cont_a][telefone], " ", caixinha[cont_a][nome], " ")
		}
		escreva(caixinha[1][0], caixinha[1][1])
	}

	funcao carregar_arquivo(){
		escreva("Digite [1] para carregar um arquivo .txt\nDigite [2] para gravar os dados da matriz em um arquivo .txt")
		leia(resp_carregar)
		se(resp_carregar == "1"){
			elem_restantes = max_contato - cont_elem //contar com vista na matriz pois pode diferir caso feito um upload via .txt
			endereco = a.abrir_arquivo(a.selecionar_arquivo(for_sup, falso), a.MODO_LEITURA)
			para(cont_download = cont_elem; cont_download < elem_restantes; cont_download++){
				linha = a.ler_linha(endereco)
				se(linha == ""){
					pare
				}
				senao{
					pos_final_linha = t.numero_caracteres(linha) - 1 
					pos_caracter = t.posicao_texto("|", linha, 0)
					caixinha[cont_download][telefone] = t.extrair_subtexto(linha, 0, pos_caracter)
					caixinha[cont_download][nome] = t.extrair_subtexto(linha, pos_caracter + 1, pos_final_linha)
				}
			}
		}
		senao se(resp_carregar == "2"){
			endereco = a.abrir_arquivo(a.selecionar_arquivo(for_sup, falso), a.MODO_ESCRITA)
			para(cont_upload = 0; cont_upload < max_contato; cont_upload++){
				escrita = caixinha[cont_upload][telefone] + "|" + caixinha[cont_upload][nome]
				se(escrita == "null|null"){
					pare
				}
				senao{
					a.escrever_linha(escrita, endereco)//jogar tudo dentro do escrever
				}
			}
			a.fechar_arquivo(endereco)
		}
	}

	funcao alterar(){
		escreva("Digite o número de telefone para alterar o contato: ")
		leia(resp_alt)
		para(cont_alt = 0; cont_alt < max_contato; cont_alt++){
			cont_existe_alt++
			se(resp_alt == caixinha[cont_alt][nome]){ //achar um jeito de quebrar caso não ache o contato
				escreva("O contato que deseja mudar contém os seguintes dados:\nNome: ", caixinha[cont_alt][telefone], "\nTelefone: ", caixinha[cont_alt][nome])
				enquanto(quebra_alt == verdadeiro){
					escreva("\nDigite [1] para mudar o nome ou [2] para mudar o telefone: ")
					leia(resp_qual_dado)
					cont_existe_alt --
					se(resp_qual_dado == "1"){
						quebra_alt = falso
						escreva("Digite o novo nome: ")
						leia(novo_nome)
						enquanto(quebra_novo_nome == verdadeiro){
							para(cont_novo_nome = 0; cont_novo_nome < max_contato; cont_novo_nome++){
								enquanto(quebra_perg_nome == verdadeiro){
									se(novo_nome == caixinha[cont_novo_nome][telefone]){
										escreva("O nome já existe na agenda!\nDigite outro nome: ")
										leia(novo_nome)
									}
									senao{
										cont_quebra_novo_nome++
										se(cont_quebra_novo_nome == 99){
											quebra_novo_nome = falso
											quebra_perg_nome = falso
										}
									}
								}
							}
						}
						caixinha[cont_alt][telefone] = novo_nome
					}
					senao se(resp_qual_dado == "2"){
						quebra_alt = falso
						escreva("Digite o novo número de telefone: ")
							leia(novo_numero)
							enquanto(quebra_novo_numero == verdadeiro){
								para(cont_novo_numero = 0; cont_novo_numero < max_contato; cont_novo_numero++){
									enquanto(quebra_perg_numero == verdadeiro){
										se(novo_numero == caixinha[cont_novo_numero][nome]){
											escreva("O número já existe na agenda!\nDigite outro número: ")
											leia(novo_numero)
										}
									
										senao{
											cont_quebra_novo_numero++
											se(cont_quebra_novo_numero == 100){
												quebra_perg_numero = falso
												quebra_novo_numero = falso
											}
										}
									}
								}
							}
							caixinha[cont_alt][nome] = novo_numero
					}
				}
			}
			senao se(cont_existe_alt == 100){
				escreva("Número de telefone não encontrado!")
			}
		}
	}
	
	funcao cadeia procurar_nome(cadeia nome_procurar){
		para(cont_procurar_nome = 0; cont_procurar_nome < max_contato; cont_procurar_nome++){
			se(caixinha[cont_procurar_nome][telefone] == nome_procurar){
				indice = cont_procurar_nome + " " + telefone
				cont_achou_nome++
			}
		}
		se(cont_achou_nome == 0){
			indice = "-1"
		}
		retorne indice
	}
}
/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 3677; 
 * @DOBRAMENTO-CODIGO = [19, 112, 138, 172];
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */