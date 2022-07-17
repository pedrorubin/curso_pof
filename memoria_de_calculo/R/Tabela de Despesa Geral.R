#                            POF 2017-2018
  
#  PROGRAMA PARA GERAÇÃO DAS ESTIMATIVAS PONTUAIS DA TABELA DE DESPESA GERAL
#                       NÍVEL GEOGRÁFICO - BRASIL 

# É preciso executar antes o arquivo "Leitura dos Microdados - R.R"
# que se encontra no arquivo compactado "Programas_de_Leitura.zip"
# Este passo é necessário para gerar os arquivos com a extensão .rds
# correspondentes aos arquivos com extensão .txt dos microdados da POF

# "....." indica a pasta/diretório de trabalho no HD local separados por "/"
# onde se encontram os arquivos .txt descompactados do arquivo Dados_aaaammdd.zip
# Exemplo: setwd("c:/POF2018/Dados_aaaammdd/")

setwd(".....") # Caminho onde se encontram as bases de dados


#  Leitura do REGISTRO -  - ALUGUEL ESTIMADO 

aluguel_estimado <- readRDS("ALUGUEL_ESTIMADO.rds")


#  Anualização e expansão dos valores utilizados para a obtenção dos resultados 
#  (variável V8000_defla). 

# a) Para anualizar, utilizamos o quesito "fator_anualizacao". Neste registro, 
#    cujas informações se referem a valores mensais de alugueis, utilizamos também
#    o quesito V9011 (número de meses). 
#    Os valores são anualizados para depois se obter uma média mensal.

# b) Para expandir, utilizamos o quesito "peso_final".

# c) Posteriormente, o resultado é dividido por 12 para obter a estimativa mensal.
  
  
alu_estimado <- 
  transform( aluguel_estimado,
             valor_mensal=(V8000_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12 # [3] 
             )[ , c( "V9001" , "valor_mensal" ) ]
rm(aluguel_estimado)


# Leitura do REGISTRO - DESPESA COLETIVA

despesa_coletiva <- readRDS("DESPESA_COLETIVA.rds")

#   Anualização e expansão dos valores utilizados para a obtenção dos resultados
#   (variáveis V8000_defla e V1904_defla). O quesito V1904_defla se refere a despesa 
#   com "INSS e Outras Contribuições Trabalhistas", que é utilizado no grupo 
#   "Outras despesas correntes".

# a) Para anualizar, utilizamos o quesito "fator_anualizacao". No caso específico 
#    dos quadros 10 e 19, cujas informações se referem a valores mensais, utilizamos
#    também o quesito V9011 (número de meses).
#    Os valores são anualizados para depois se obter uma média mensal.

# b) Para expandir, utilizamos o quesito "peso_final".

# c) Posteriormente, o resultado é dividido por 12 para obter a estimativa mensal. 
  
  
desp_coletiva <- 
  transform( despesa_coletiva,
             valor_mensal = ifelse( QUADRO==10|QUADRO==19,
                                    (V8000_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12, 
                                    (V8000_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12
                                    ) , 
             inss_mensal=(V1904_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12
  )[ , c( "V9001" , "valor_mensal" , "inss_mensal" ) ]

rm(despesa_coletiva)


#  Leitura do REGISTRO - CADERNETA COLETIVA (Questionário POF 3)

caderneta_coletiva <- readRDS("CADERNETA_COLETIVA.rds")

# Anualização e expansão dos valores utilizados para a obtenção dos resultados 
# (variável V8000_defla). 

# a) Para anualizar, utilizamos o quesito "fator_anualizacao". Os valores são
#    anualizados para depois se obter uma média mensal.

# b) Para expandir, utilizamos o quesito "peso_final".

# c) Posteriormente, o resultado é dividido por 12 para obter a estimativa mensal.

cad_coletiva <- 
  transform( caderneta_coletiva,
             valor_mensal=(V8000_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12
             )[ , c( "V9001" , "valor_mensal" ) ]
rm(caderneta_coletiva)


# Leitura do REGISTRO - DESPESA INDIVIDUAL 

despesa_individual <- readRDS("DESPESA_INDIVIDUAL.rds")

#   Anualização e expansão dos valores utilizados para a obtenção dos resultados 
#   (variável V8000_defla). 

# a) Para anualizar, utilizamos o quesito "fator_anualizacao". No caso específico 
#    dos quadros 44, 47, 48, 49 e 50, cujas informações se referem a valores mensais, 
#    utilizamos também o quesito V9011 (número de meses).
#    Os valores são anualizados para depois se obter uma média mensal.

# b) Para expandir, utilizamos o quesito "peso_final".

# c) Posteriormente, o resultado é dividido por 12 para obter a estimativa mensal.

desp_individual <-
  transform( despesa_individual,
             valor_mensal = ifelse( QUADRO==44|QUADRO==47|QUADRO==48|QUADRO==49|QUADRO==50,
                                    (V8000_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12, 
                                    (V8000_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12
                                    )
             )[ , c( "V9001" , "valor_mensal" ) ]
rm(despesa_individual)


# Leitura do REGISTRO - RENDIMENTO DO TRABALHO

rendimento_trabalho <- readRDS("RENDIMENTO_TRABALHO.rds")

#   Anualização e expansão dos valores de deduções com "Previdência Pública",
#   "Imposto de Renda" e "Iss e Outros Impostos" utilizados para a obtenção 
#   dos resultados (variáveis V531112_defla, V531122_defla e V531132_defla).
#   Estes quesitos são utilizados no grupo "Outras despesas correntes". 

# a) Para anualizar, utilizamos o quesito "fator_anualizacao". No caso específico
#    deste registro, cujas informações se referem a valores mensais, utilizamos
#    também o quesito V9011 (número de meses).
#    Os valores são anualizados para depois se obter uma média mensal.

# b) Para expandir, utilizamos o quesito "peso_final".

# c) Posteriormente, o resultado é dividido por 12 para obter a estimativa mensal.
  
rend_trabalho <-
  transform( rendimento_trabalho,
             prev_pub_mensal=(V531112_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12,
             imp_renda_mensal=(V531122_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12,
             iss_mensal=(V531132_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12
             )[ , c( "V9001" , "prev_pub_mensal" , "imp_renda_mensal" , "iss_mensal" ) ]
rm(rendimento_trabalho)


# Leitura do REGISTRO - OUTROS RENDIMENTOS

outros_rendimentos <- readRDS("OUTROS_RENDIMENTOS.rds")


#   Anualização e expansão dos valores de deduções utilizados para a obtenção
#   dos resultados (variável V8501_defla).Este quesito é utilizado no grupo
#   "Outras despesas correntes".

# a) Para anualizar, utilizamos o quesito "fator_anualizacao". No caso específico 
#    do quadro 54, cujas informações se referem a valores mensais, utilizamos também
#    o quesito V9011 (número de meses).
#    Os valores são anualizados para depois se obter uma média mensal.

# b) Para expandir, utilizamos o quesito "peso_final".

# c) Posteriormente, o resultado é dividido por 12 para obter a estimativa mensal. 

outros_rend <-
  transform( outros_rendimentos,
             deducao_mensal = ifelse( QUADRO==54,
                                      (V8501_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12, 
                                      (V8501_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12 
                                    ) 
             ) [ , c( "V9001" , "deducao_mensal" ) ]
rm(outros_rendimentos)


# [1] Junção dos registros, que englobam os itens componentes da tabela de despesa geral. 

# [2] Transformação do código do item (variável V9001) em 5 números, para ficar no mesmo
#     padrão dos códigos que constam nos arquivos de tradutores das tabelas. Esses códigos
#     são simplificados em 5 números, pois os 2 últimos números caracterizam sinônimos
#     ou termos regionais do produto. Todos os resultados da pesquisa são trabalhados 
#     com os códigos considerando os 5 primeiros números. Por exemplo, tangerina e mexirica
#     tem códigos diferentes quando se considera 7 números, porém o mesmo código quando
#     se considera os 5 primeiros números.

desp_coletiva_n <- cbind( desp_coletiva , NA , NA , NA , NA )
names(desp_coletiva_n) <- c( names( desp_coletiva) , 
                             "prev_pub_mensal" , "imp_renda_mensal" , "iss_mensal" , "deducao_mensal" )
rm(desp_coletiva)

cad_coletiva_n <- cbind( cad_coletiva , NA , NA , NA , NA , NA )
names(cad_coletiva_n) <- c( names( cad_coletiva) , 
                            "inss_mensal" , "prev_pub_mensal" , "imp_renda_mensal" , "iss_mensal" , "deducao_mensal" )
rm(cad_coletiva)

desp_individual_n <- cbind( desp_individual , NA , NA , NA , NA , NA )
names(desp_individual_n) <- c( names( desp_individual) , 
                            "inss_mensal" , "prev_pub_mensal" , "imp_renda_mensal" , "iss_mensal" , "deducao_mensal" )
rm(desp_individual)

alu_estimado_n <- cbind( alu_estimado , NA , NA , NA , NA , NA )
names(alu_estimado_n) <- c( names( alu_estimado) , 
                            "inss_mensal" , "prev_pub_mensal" , "imp_renda_mensal" , "iss_mensal" , "deducao_mensal" )
rm(alu_estimado)

rend_trabalho_n <- cbind( rend_trabalho[,1] , NA , NA , rend_trabalho[,2:4] , NA )
names(rend_trabalho_n) <- c( "V9001" , "valor_mensal" , "inss_mensal" , "prev_pub_mensal" , "imp_renda_mensal" , "iss_mensal" , "deducao_mensal" )
rm(rend_trabalho)

outros_rend_n <- data.frame( cbind( outros_rend[,1] , NA , NA , NA , NA , NA , outros_rend[,2] ) )
names(outros_rend_n) <- c( "V9001" , "valor_mensal" , "inss_mensal" , "prev_pub_mensal" , "imp_renda_mensal" , "iss_mensal" , "deducao_mensal" )
rm(outros_rend)

junta <- 
  rbind( desp_coletiva_n , 
         cad_coletiva_n , 
         desp_individual_n ,
         alu_estimado_n ,
         rend_trabalho_n ,
         outros_rend_n ) # [1]

rm( desp_coletiva_n , 
    cad_coletiva_n , 
    desp_individual_n ,
    alu_estimado_n ,
    rend_trabalho_n ,
    outros_rend_n
  )

junta <- 
  transform( junta ,
             codigo = trunc(V9001/100) 
             )[ , 2:8 ]


# Leitura do REGISTRO - MORADOR, necessário para o cálculo do número de UC's expandido.
# Vale ressaltar que este é o único registro dos microdados que engloba todas as UC's

# Extraindo todas as UC's do arquivo de morador

morador_uc <- 
  unique( 
    readRDS( 
      "MORADOR.rds" 
    ) [ ,
        c( "UF","ESTRATO_POF","TIPO_SITUACAO_REG","COD_UPA","NUM_DOM","NUM_UC",
           "PESO_FINAL"
        ) # Apenas variáveis com informações das UC's no arquivo "MORADOR.rds"
        ] ) # Apenas um registro por UC

# Calculando o número de UC's expandido 
# A cada domicílio é associado um peso_final e este é também associado a cada uma de suas unidades de consumo 
# Portanto, o total de unidades de consumo (familias) expandido, é o resultado da soma dos pesos_finais a elas associados

soma_familia <- sum( morador_uc$PESO_FINAL )


# Leitura do arquivo de tradutor da tabela de despesa geral. 
# Este tradutor organiza os códigos de produtos pelos diferetes
# grupos da tabela de despesa geral.

# Descomente e execute o comando seguinte apenas se o pacote "readxl" não estiver ainda instalado:
# install.packages("readxl")

# "....." indica a pasta/diretório de trabalho no HD local separados por "/"
# onde se encontram os arquivos .xls dos tradutores das tabelas
# Exemplo: setwd("c:/POF2018/Tradutores_aaaammdd/Tradutores das Tabelas/")

setwd(".....") # ..... é o caminho para a pasta "/Tradutores_aaaammdd/Tradutores das Tabelas/"

tradutor_despesa <-
  readxl::read_excel("Tradutor_Despesa_Geral.xls") 


# Juntando a base de dados com o tradutor da tabela de despesa geral por código.

# Descomenta e execute o comando seguinte apenas se o pacote "sqldf" não estiver ainda instalado:
# install.packages("sqldf")

junta_tradutor <-
  sqldf::sqldf("SELECT a.*,
               b.variavel,
               b.nivel_0,
               b.nivel_1,
               b.nivel_2,
               b.nivel_3,
               b.nivel_4,
               b.nivel_5
               from junta as a 
               left join tradutor_despesa as b
               on a.codigo = b.codigo"
               )

# Criação da variável resultante "valor" que receberá os valores das variáveis de acordo
# com o grupo de despesa ao qual o código esteja associado. A maioria dos grupos da tabela
# utiliza o quesito V8000_DEFLA, referente a valores de despesas/aquisições dos produtos 
# e serviços. Já o grupo "Outras despesas correntes", além do quesito V8000_DEFLA, também
# utiliza os quesitos INSS (V1904_DEFLA)e deduções (V531112_DEFLA, V531122_DEFLA, 
#                                                   V531132_DEFLA ou V8501_DEFLA)

merge1 <- 
  transform( junta_tradutor ,
             valor = ifelse( Variavel == 'V8000_DEFLA' , 
                             valor_mensal , 
                             ifelse( Variavel == 'V1904_DEFLA' , 
                                     inss_mensal ,
                                     ifelse( Variavel == 'V531112_DEFLA' , 
                                             prev_pub_mensal ,
                                             ifelse( Variavel == 'V531122_DEFLA' , 
                                                     imp_renda_mensal ,
                                                     ifelse( Variavel == 'V531132_DEFLA' , 
                                                             iss_mensal ,
                                                             ifelse( Variavel == 'V8501_DEFLA' , 
                                                                     deducao_mensal ,
                                                                     NA
                                                                     )
                                                             )
                                                     )
                                             )
                                     )
                             )
             )
merge1 <- merge1[!is.na(merge1$valor), ] 
rm( junta, junta_tradutor , tradutor_despesa)

# Somando os valores mensais de cada grupo de códigos, segundo cada nível, conforme consta no tradutor

soma_final_0 <- aggregate(valor~Nivel_0,data=merge1,sum)
names(soma_final_0) <- c("nivel", "soma")

soma_final_1 <- aggregate(valor~Nivel_1,data=merge1,sum)
names(soma_final_1) <- c("nivel", "soma")

soma_final_2 <- aggregate(valor~Nivel_2,data=merge1,sum)
names(soma_final_2) <- c("nivel", "soma")

soma_final_3 <- aggregate(valor~Nivel_3,data=merge1,sum)
names(soma_final_3) <- c("nivel", "soma")

soma_final_4 <- aggregate(valor~Nivel_4,data=merge1,sum)
names(soma_final_4) <- c("nivel", "soma")

soma_final_5 <- aggregate(valor~Nivel_5,data=merge1,sum)
names(soma_final_5) <- c("nivel", "soma")


# [1] Empilhando as somas obtidas no passo anterior 
# [2] Criação da variável a=1 que será utilizada posteriomente para 
#     juntar com arquivo de número de unidades de consumo (familias) expandido

soma_final <- rbind( soma_final_0 ,
                     soma_final_1 ,
                     soma_final_2 ,
                     soma_final_3 ,
                     soma_final_4 ,
                     soma_final_5
                     ) # [1]
rm(soma_final_0,soma_final_1, soma_final_2, 
   soma_final_3, soma_final_4, soma_final_5)

soma_final <-
  transform( soma_final ,
             a = 1) # [2]

# Calculando a despesa média mensal de cada grupo de códigos, segundo cada nível, conforme consta no tradutor

merge2 <- data.frame( soma_final , soma_familia=soma_familia )
merge2 <- 
  transform( merge2 ,
             media_mensal = round( soma / soma_familia , 2 ) )


# Leitura do arquivo de índice que determina a posição que cada linha deve ficar na tabela final
# O arquivo de índice é apenas um arquivo auxiliar, criado para associar os resultado gerados com a ordem de apresentacao
# da tabela de resultados

# "....." indica a pasta/diretório de trabalho no HD local separados por "/"
# onde se encontram os arquivos .xls dos índices das tabelas
# Exemplo: setwd("c:/POF2018/Memoria_de_Calculo_aaaammdd/Memória de Cálculo/")

setwd(".....") # ..... é o caminho onde se encontra a pasta "/Memoria_de_Calculo_aaaammdd/Memória de Cálculo/"

indice_despesa <-
  readxl::read_excel("indice_Despesa.xls")

# Juntando o arquivo das despesas médias mensais de cada grupo de códigos com o arquivo de índice,
# para organizar os itens da tabela

merge3 <- merge(merge2,indice_despesa, by.x="nivel", by.y="NIVEL")
merge3 <- 
  merge3[ order( merge3$INDICE ) , c(6,1,7,5) ] 
