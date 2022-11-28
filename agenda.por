programa
{
	inclua biblioteca Texto --> t
	inclua biblioteca Tipos --> ti
	inclua biblioteca Util --> u
	inclua biblioteca Arquivos --> a

	inteiro cont_elem = 0
	inteiro cont_novo_numero, cont_quebra_novo_numero = 0
	cadeia caixinha[100][2], caixinha_temporaria[100][2], for_sup[] = {"|txt"}, resp = ""
	cadeia linha, upload, escrita, resp_alt, novo_nome, novo_numero
	const inteiro telefone = 1, nome = 0, max_contato = 100, max_paginas = 5, max_ind_repos = 99

	funcao inicio(){
		carregar_arq_inicial()
		cadastro()
		menu()
	}

	funcao cadastro() {
		escreva("Murilo da costa simões\nRA: 1680482221038\n")
		para (inteiro contato = 0; contato < max_contato; contato++) {
			cadeia nome_entrada = leia_nome()
			cadeia telefone_entrada = leia_telefone()

			se (procura(nome_entrada, telefone_entrada) != -1) {
				escreva("Contato ja cadastrado! Digite um nome/numero diferente.\n")

				contato--
			} senao {
				caixinha[contato][nome] = nome_entrada
				caixinha[contato][telefone] = telefone_entrada
			}

			enquanto(verdadeiro){
				escreva("Deseja continuar cadastrando?[S/N]: ")
				leia(resp)
				cont_elem++
				resp = t.caixa_alta(resp)
	
				se(resp == "N"){
					contato = max_contato
					pare
				}
				
				senao se(resp == "S") pare
			}
			limpa()
		}
	}

	funcao imprimir(){
	     inteiro pagina = 0
	     logico break_op2 = verdadeiro
	     logico break = verdadeiro
	     cadeia perg_imprimir

		enquanto(break == verdadeiro){
			escreva("Ordenar os contatos por nome [1]\nListar sem ordenar[2]\nListar pela letra inicial do nome[3]\nDigite sua opção: ")
			leia(perg_imprimir)

			se(perg_imprimir == "1"){
				limpa()
				break = falso
				sort_alfabeto()
			}

		
			senao se(perg_imprimir == "2"){
				limpa()
				break = falso
				enquanto(break_op2 == verdadeiro){
					para (inteiro i = pagina * 20; i < (pagina * 20 + 20); i++) {
						se(caixinha[i][nome] == "") pare
						senao{
							escreva(caixinha[i][nome], " ", caixinha[i][telefone], "\n")
						}
						//imprime aqui
					}
					cadeia opcao
					se (pagina != 0) {
						escreva("Pagina [A]nterior")
				     }
		
			          escreva(" ")
		
			          se (pagina != max_paginas - 1) {
			          	escreva("Proxima [P]agina")
			          }
		
			          escreva("[S]air")
					
					leia(opcao)
					opcao = t.caixa_alta(opcao)
					
					se (opcao == "A" e pagina != 0) {
						limpa()
						pagina--
					}
		
					se (opcao == "P" e pagina != max_paginas - 1) {
						limpa()
						pagina++
					}
		
					se (opcao == "S") {
						limpa()
						break_op2 = falso
						pare
					}
				}
			}
				
			senao se(perg_imprimir == "3"){
				break = falso
		     	sort_inicial()
		     }
	     }
	}

	funcao cadeia leia_nome() {
		cadeia nome_entrada = ""

		enquanto(verdadeiro) {
			escreva("Digite o nome do contato: ")
			leia(nome_entrada)
			
			pare
		}

		retorne nome_entrada
	}

	funcao cadeia leia_telefone() {
		cadeia telefone_entrada = ""

		enquanto(verdadeiro) {
			escreva("Digite o telefone do contato: ")
			leia(telefone_entrada)

			telefone_entrada = t.substituir(telefone_entrada, "(", "")
			telefone_entrada = t.substituir(telefone_entrada, ")", "")
			telefone_entrada = t.substituir(telefone_entrada, "-", "")
			telefone_entrada = t.substituir(telefone_entrada, " ", "") //formata o número de telefone

  			inteiro num_caracters = t.numero_caracteres(telefone_entrada)
  			logico valido = verdadeiro

			se (num_caracters != 11) {//verificação do tamanho do número
				escreva("O numero de telefone precisa ter 11 caracteres\n")
				valido = falso //inválido
			}

			para (inteiro contem = 0; contem < num_caracters; contem++) {
				cadeia caract = t.extrair_subtexto(telefone_entrada, contem, contem + 1)

				se (caract != "1" e caract != "2" e
					caract != "3" e caract != "4" e
					caract != "5" e caract != "6" e
					caract != "7" e caract != "8" e
					caract != "9" e caract != "0") { //verificação para ver se só contém caracteres numéricos
						escreva("O numero só pode conter caracteres numericos\n")
						valido = falso
						pare
					}
			}

			se (valido) { //caso passe pela verificação dos dois, se torna válido e é retornado o número
				pare
			}

		}
		retorne telefone_entrada
	}

	funcao inteiro procura(cadeia nome_entrada, cadeia telefone_entrada) {
		inteiro achado = -1

		para (inteiro contato = 0; contato < max_contato; contato++) {
			se(nome_entrada == caixinha[contato][nome] e telefone_entrada == caixinha[contato][telefone]){// valida se achou o contato
				achado = contato
				pare
			}
		}

		retorne achado
	}

	funcao imprime_temporaria() {
		para (inteiro i = 0; i < max_contato; i++) {

			se (caixinha_temporaria[i][nome] == "") pare

			escreva(caixinha_temporaria[i][nome])
			escreva("|")
			escreva(caixinha_temporaria[i][telefone])
			escreva("\n")
		}
	}

	funcao imprime_padrao(){
		para (inteiro i = 0; i < max_contato; i++) {

			se (caixinha[i][nome] == "") pare

			escreva(caixinha[i][nome])
			escreva("|")
			escreva(caixinha[i][telefone])
			escreva("\n")
		}
	}

	funcao menu(){
		caracter resp_menu
		logico break = verdadeiro
		
		
		enquanto(break == verdadeiro){
			escreva("\nDigite [1] para listar todos os contatos\nDigite [2] para procurar um contato\nDigite [3] para apagar um contato")
			escreva("\nDigite [4] para alterar um contato\nDigite [5] para carregar/descarregar um arquivo [.txt]\nDigite [6] para sair do programa")
			escreva("\nDigite sua opção: ")
			leia(resp_menu)
			escolha(resp_menu){
				caso '1':
					limpa()
					imprimir()
				pare
				
				caso '2':
					limpa()
					procuraa()
				pare
					
				caso '3':
				 	limpa()
					apagar()
				pare
					
				caso '4':
					limpa()
					alterar()
				pare
	
				caso '5':
					limpa()
					perg_arquivo()
				pare
				
				caso '6':
					limpa()
					break = falso
				pare
					
				caso contrario:
					limpa()
			}
		}
	}

	funcao procuraa(){
		cadeia proc_nome
		inteiro cont_proc_nome = 0
		
		escreva("Digite um nome para procurar na lista de contatos: ")
		leia(proc_nome)

		para(inteiro cont_proc = 0; cont_proc < max_contato; cont_proc++){
			se(proc_nome == caixinha[cont_proc][nome]){
				escreva(caixinha[cont_proc][nome], " ", caixinha[cont_proc][telefone], "\n")
				cont_proc_nome++
			}
		}
		se(cont_proc_nome == 0){
			escreva("Cadastro não encontrado!")
		}
	}

	funcao apagar(){
		cadeia nome_ap
		cadeia repos_nome
		cadeia repos_telefone
		
		escreva("Digite o nome do contato a ser excluído: ")
		leia(nome_ap)
		
		para(inteiro nome_cont = 0; nome_cont < max_contato; nome_cont++){
			se(nome_ap == caixinha[nome_cont][nome]){
				caixinha[nome_cont][telefone] = ""
				caixinha[nome_cont][nome] = ""
				
				para(inteiro cont_nil = nome_cont; cont_nil < max_ind_repos; cont_nil++){//for com base na posição do elem q foi apagado até o num de elem na matriz
					se(caixinha[nome_cont+1][telefone] == ""){ //verifica se é vazio a próxima posição e para
						pare
					}
					
					senao{ //verifica se existe algo na proxima posição
						repos_nome = caixinha[cont_nil+1][nome]//pega o elemento da próxima posição(com base na posição que teve o elemento apagado)
						caixinha[cont_nil][nome] = repos_nome//põe na posição apagada o elemento a seguir
						repos_telefone = caixinha[cont_nil+1][telefone]//faz a mesma coisa só que com o elemento a seguir, talvez seja útil pra agilizar mas que surja + erros
						caixinha[cont_nil][telefone] = repos_telefone
					}
				}
			}
		}
		imprime_padrao()
	}

	funcao perg_arquivo(){
		caracter resp_carregar
		inteiro endereco
		inteiro pos_final_linha
		inteiro pos_caracter
		inteiro espaco_restante = max_contato - cont_elem
		logico break = verdadeiro
		
		escreva("Digite [1] para carregar um arquivo .txt\nDigite [2] para gravar os dados da matriz em um arquivo .txt\nDigite sua opção: ")
		leia(resp_carregar)
		enquanto(break == verdadeiro){
			escolha(resp_carregar){
				caso '1':
					break = falso
					endereco = a.abrir_arquivo(a.selecionar_arquivo(for_sup, falso), a.MODO_LEITURA)
					para(inteiro cont_load = cont_elem; cont_load < espaco_restante; cont_load++){
						linha = a.ler_linha(endereco)
						se(linha == ""){
							pare
						}
						senao{
							pos_final_linha = t.numero_caracteres(linha)
							pos_caracter = t.posicao_texto("|", linha, 0)
							caixinha[cont_load][nome] = t.extrair_subtexto(linha, 0, pos_caracter)
							caixinha[cont_load][telefone] = t.extrair_subtexto(linha, pos_caracter + 1, pos_final_linha)
						}
					}
					limpa()
					escreva("Contatos cadastrados com sucesso!")
				pare
	
				caso '2':
					break = falso
					endereco = a.abrir_arquivo(a.selecionar_arquivo(for_sup, falso), a.MODO_ESCRITA)
					para(inteiro cont_upload = 0; cont_upload < max_contato; cont_upload++){
						escrita = caixinha[cont_upload][nome] + "|" + caixinha[cont_upload][telefone]
						se(escrita == "null|null"){
							pare
						}
						
						senao a.escrever_linha(escrita, endereco)
					}
					a.fechar_arquivo(endereco)
					limpa()
					escreva("Contatos cadastrados com sucesso!")
				pare
			}
		}
	}

	funcao alterar(){
		cadeia alt_nome
		cadeia alt_telefone
		caracter resp_qual_dado
		logico quebra_seg_dados = verdadeiro
		
		escreva("Digite o nome e número para alterar o contato:\n")
		alt_nome = leia_nome()
		alt_telefone = leia_telefone()
		para(inteiro cont_alt = 0; cont_alt < max_contato; cont_alt++){
			
			se(alt_nome == caixinha[cont_alt][nome] e alt_telefone == caixinha[cont_alt][telefone]){ 
				enquanto(quebra_seg_dados == verdadeiro){
					escreva("O contato que deseja mudar contém os seguintes dados:\nNome: ", alt_nome, "\nTelefone: ", alt_telefone)
					escreva("\nDigite [1] para mudar o nome ou [2] para mudar o telefone: ")
					leia(resp_qual_dado)
					
					escolha(resp_qual_dado){
						caso '1':
							novo_nome = leia_nome()
							enquanto(verdadeiro){
								se(novo_nome == alt_nome){
									escreva("O nome já existe na agenda!\nDigite outro nome: ")
									leia(novo_nome)
								}
									
								senao{
									quebra_seg_dados = falso
									pare
								}
							}
							caixinha[cont_alt][nome] = novo_nome
						pare
						
						caso '2':
							novo_numero = leia_telefone()//ponto de partida
								para(cont_novo_numero = 0; cont_novo_numero < max_contato; cont_novo_numero++){
									enquanto(verdadeiro){
										se(novo_numero == alt_telefone){
											escreva("O número já existe na agenda!\nDigite outro número: ")
											leia(novo_numero)
										}
	
										senao{
											quebra_seg_dados = falso
											pare
										}
									}
									pare
								}
							caixinha[cont_alt][telefone] = novo_numero
						pare
					}
				}
			imprime_padrao()
			}
		}		
	}

	funcao sort_alfabeto(){
		cadeia aux_nome
		cadeia aux_telefone
		caracter inicial
		caracter inicial2
		inteiro cont_ordenado = 0

		para(inteiro k = 0; k < max_contato; k++){
			se(caixinha[k][telefone] != ""){
				caixinha_temporaria[k][telefone] = caixinha[k][telefone]
				caixinha_temporaria[k][nome] = caixinha[k][nome]
				cont_ordenado++
			}

			senao{
				pare
			}
		}
		para(inteiro j = 0; j < cont_ordenado-1; j++){
			para(inteiro i = 0; i < cont_ordenado-1; i++){
				
				inicial = t.obter_caracter(caixinha_temporaria[i][nome], 0)
				inicial2 = t.obter_caracter(caixinha_temporaria[i+1][nome], 0)
	
				se(inicial > inicial2){
					aux_nome = caixinha_temporaria[i][nome]
					caixinha_temporaria[i][nome] = caixinha_temporaria[i+1][nome]
					caixinha_temporaria[i+1][nome] = aux_nome
					
					aux_telefone = caixinha_temporaria[i][telefone]
					caixinha_temporaria[i][telefone] = caixinha_temporaria[i+1][telefone]
					caixinha_temporaria[i+1][telefone] = aux_telefone
					
				}
			}
		}
		imprime_temporaria()
	}

	funcao sort_inicial(){
		caracter inicial
		caracter op_inicial
		inteiro cont_indice = 0

		escreva("Digite a inicial do[s] nome[s] a ser[em] procurado: ")
		leia(op_inicial)
		para(inteiro i = 0 ; i < max_contato; i ++){
			se(caixinha[i+1][nome] == "") pare
			inicial = t.obter_caracter(caixinha[i][nome], 0)
			se(inicial == op_inicial){
				
				caixinha_temporaria[cont_indice][nome] = caixinha[i][nome]
				caixinha_temporaria[cont_indice][telefone] = caixinha[i][telefone]
				cont_indice ++
			}
		}
		imprime_temporaria()
	}

	funcao carregar_arq_inicial(){
		caracter resp_carregar
		inteiro endereco
		inteiro pos_final_linha
		inteiro pos_caracter
		inteiro espaco_restante = max_contato - cont_elem
		
		endereco = a.abrir_arquivo(a.selecionar_arquivo(for_sup, falso), a.MODO_LEITURA)
		para(inteiro cont_load = cont_elem; cont_load < espaco_restante; cont_load++){
			linha = a.ler_linha(endereco)
			se(linha == ""){
				pare
			}
			senao{
				pos_final_linha = t.numero_caracteres(linha)
				pos_caracter = t.posicao_texto("|", linha, 0)
				caixinha[cont_load][nome] = t.extrair_subtexto(linha, 0, pos_caracter)
				caixinha[cont_load][telefone] = t.extrair_subtexto(linha, pos_caracter + 1, pos_final_linha)
			}
		}
		a.fechar_arquivo(endereco)
	}

}

/* $$$ Portugol Studio $$$ 
 * 
 * Esta seção do arquivo guarda informações do Portugol Studio.
 * Você pode apagá-la se estiver utilizando outro editor.
 * 
 * @POSICAO-CURSOR = 12345; 
 * @PONTOS-DE-PARADA = ;
 * @SIMBOLOS-INSPECIONADOS = ;
 * @FILTRO-ARVORE-TIPOS-DE-DADO = inteiro, real, logico, cadeia, caracter, vazio;
 * @FILTRO-ARVORE-TIPOS-DE-SIMBOLO = variavel, vetor, matriz, funcao;
 */