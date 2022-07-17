#                            POF 2017-2018
  
#  PROGRAMA PARA GERAÇÃO DAS ESTIMATIVAS PONTUAIS DA TABELA DE ALIMENTACAO
#                       NÍVEL GEOGRÁFICO - BRASIL 

# É preciso executar antes o arquivo "Leitura dos Microdados - R.R"
# que se encontra no arquivo compactado "Programas_de_Leitura.zip"
# Este passo é necessário para gerar os arquivos com a extensão .rds
# correspondentes aos arquivos com extensão .txt dos microdados da POF

# "....." indica a pasta/diretório de trabalho no HD local separados por "/"
# onde se encontram os arquivos .txt descompactados do arquivo Dados_aaaammdd.zip
# Exemplo: setwd("c:/POF2018/Dados_aaaammdd/")

setwd(".....") # Caminho onde se encontram as bases de dados


#  Leitura do REGISTRO - CADERNETA COLETIVA (Questionário POF 3)

caderneta_coletiva <- readRDS("CADERNETA_COLETIVA.rds")

# [1] Transformação do código do item (variável V9001) em 5 números, para ficar no mesmo padrão dos códigos que constam nos arquivos de
#     tradutores das tabelas. Esses códigos são simplificados em 5 números, pois os 2 últimos números caracterizam sinônimos ou termos 
#     regionais do produto. Todos os resultados da pesquisa são trabalhados com os códigos considerando os 5 primeiros números.
#     Por exemplo, tangerina e mexirica tem códigos diferentes quando se considera 7 números, porém o mesmo código quando se considera os 
#     5 primeiros números. 

# [2] Exclusão dos itens do REGISTRO - CADERNETA COLETIVA (POF 3) que não se referem a alimentos (grupos 86 a 89, ver cadastro de produtos). 

# [3] Anualização e expansão dos valores utilizados para a obtenção dos resultados (variável V8000_defla). 
#     a) Para anualizar, utilizamos o quesito "fator_anualizacao". Os valores são anualizados para depois se obter uma média mensal.
#     b) Para expandir, utilizamos o quesito "peso_final".
#     c) Posteriormente, o resultado é dividido por 12 para obter a estimativa mensal.
 
cad_coletiva <- 
  transform( subset( transform( caderneta_coletiva ,
                                codigo = trunc(V9001/100) # [1]
                                ),
                     codigo < 86001 | codigo > 89999
                     ),
             valor_mensal=(V8000_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12 # [3] 
             )
rm(caderneta_coletiva)


# Leitura do REGISTRO - DESPESA INDIVIDUAL (Questionário POF 4)

despesa_individual <- readRDS("DESPESA_INDIVIDUAL.rds")

# [1] Transformação do código do item (variável V9001) em 5 números, para ficar no mesmo padrão dos códigos que constam nos arquivos de
#     tradutores das tabelas. Esses códigos são simplificados em 5 números, pois os 2 últimos números caracterizam sinônimos ou termos 
#     regionais do produto. Todos os resultados da pesquisa são trabalhados com os códigos considerando os 5 primeiros números.

# [2] Seleção dos itens do REGISTRO - DESPESA INDIVIDUAL (POF 4) que entram na tabela de alimentação 
#     (todos do quadro 24 e códigos 41001,48018,49075,49089).   

# [3] Anualização e expansão dos valores utilizados para a obtenção dos resultados (variável V8000_defla). 
#     a) Para anualizar, utilizamos o quesito "fator_anualizacao". No caso específico dos quadros 48 e 49,
#        cujas informações se referem a valores mensais, utilizamos também o quesito V9011 (número de meses).
#        Os valores são anualizados para depois se obter uma média mensal.

#     b) Para expandir, utilizamos o quesito "peso_final".
#     c) Posteriormente, o resultado é dividido por 12 para obter a estimativa mensal. 
  
desp_individual <- 
  subset( transform( despesa_individual,
                     codigo = trunc(V9001/100) # [1]
                     ),
          QUADRO==24|codigo==41001|codigo==48018|codigo==49075|codigo==49089
          ) # [2]

desp_individual <-
  transform( desp_individual,
             valor_mensal = ifelse( QUADRO==24|QUADRO==41,
                                    (V8000_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12, 
                                    (V8000_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12
                                    ) # [3] 
             )
rm(despesa_individual)


# [1] Junção dos registros CADERNETA COLETIVA e DESPESA INDIVIDUAL, quem englobam os itens de alimentação. 

# As duas tabelas precisam ter o mesmo conjunto de variáveis
# Identificação dos nomes das variáveis das tabelas a serem juntadas:
nomes_cad <- names(cad_coletiva)
nomes_desp <- names(desp_individual)

# Identificação das variáveis exclusivas a serem incluídas na outra tabela:
incl_cad <- nomes_desp[!nomes_desp %in% nomes_cad]
incl_desp <- nomes_cad[!nomes_cad %in% nomes_desp]

# Criando uma tabela com NAs das variáveis ausentes em cada tabela
col_ad_cad <- data.frame(matrix(NA,
                                nrow(cad_coletiva),
                                length(incl_cad)))
names(col_ad_cad) <- incl_cad
col_ad_desp <- data.frame(matrix(NA,
                                nrow(desp_individual),
                                length(incl_desp)))
names(col_ad_desp) <- incl_desp

# Acrescentando as colunas ausentes em cada tabela:
cad_coletiva <- cbind(cad_coletiva ,
                      col_ad_cad)
desp_individual <- cbind( desp_individual , 
                          col_ad_desp)

# Juntando (empilhando) as tabelas com conjuntos de variáveis iguais
junta_ali <- 
  rbind( cad_coletiva , desp_individual ) # [1]


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


# [1] Leitura do arquivo de tradutor da tabela de alimentação. 
#     Este tradutor organiza os códigos de produtos pelos diferetes grupos da tabela de alimentacao.

# Execute o comando seguinte apenas se o pacote "readxl" não estiver ainda instalado:
#install.packages(readxl)

# "....." indica a pasta/diretório de trabalho no HD local separados por "/"
# onde se encontram os arquivos .xls dos tradutores das tabelas
# Exemplo: setwd("c:/POF2018/Tradutores_aaaammdd/Tradutores das Tabelas/")

setwd(".....") # ..... é o caminho para a pasta "/Tradutores_aaaammdd/Tradutores das Tabelas/"


tradutor_alimentacao <-
  readxl::read_excel("Tradutor_Alimentação.xls") # [1]


# [1] Juntando a base de dados com o tradutor da tabela de alimentação por código. 
# [2] Deletando as linhas referentes aos códigos que não tiveram frequência.

merge1 <- 
  merge( junta_ali ,
         tradutor_alimentacao ,
         by.x = "codigo" ,
         by.y = "Codigo"
         ) # [1]

merge1 <- 
  merge1[!is.na(merge1$valor_mensal), ] # [2]


# Somando os valores mensais de cada grupo de códigos, segundo cada nível, conforme consta no tradutor

soma_final_0 <- aggregate(valor_mensal~Nivel_0,data=merge1,sum)
names(soma_final_0) <- c("nivel", "soma")

soma_final_1 <- aggregate(valor_mensal~Nivel_1,data=merge1,sum)
names(soma_final_1) <- c("nivel", "soma")

soma_final_2 <- aggregate(valor_mensal~Nivel_2,data=merge1,sum)
names(soma_final_2) <- c("nivel", "soma")

soma_final_3 <- aggregate(valor_mensal~Nivel_3,data=merge1,sum)
names(soma_final_3) <- c("nivel", "soma")


# [1] Empilhando as somas obtidas no passo anterior 

soma_final <- rbind( soma_final_0 ,
                     soma_final_1 ,
                     soma_final_2 ,
                     soma_final_3
                     ) # [1]

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

indice_alimentacao <-
  readxl::read_excel("indice_Alimentacao.xls")

# Juntando o arquivo das despesas médias mensais de cada grupo de códigos com o arquivo de índice,
# para organizar os itens da tabela

merge3 <- merge(merge2,indice_alimentacao)
merge3 <- 
  merge3[ order( merge3$Indice ) , c(5,1,6,4) ] # [2]

