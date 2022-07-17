#                            POF 2017-2018
  
#  PROGRAMA PARA GERAÇÃO DA ESTIMATIVA PONTUAL DO ITEM VARIAÇÃO PATRIMONIAL
#                       NÍVEL GEOGRÁFICO - BRASIL 

# É preciso executar antes o arquivo "Leitura dos Microdados - R.R"
# que se encontra no arquivo compactado "Programas_de_Leitura.zip"
# Este passo é necessário para gerar os arquivos com a extensão .rds
# correspondentes aos arquivos com extensão .txt dos microdados da POF

# "....." indica a pasta/diretório de trabalho no HD local separados por "/"
# onde se encontram os arquivos .txt descompactados do arquivo Dados_aaaammdd.zip
# Exemplo: setwd("c:/POF2018/Dados_aaaammdd/")

setwd(".....") # Caminho onde se encontram as bases de dados


# Leitura do REGISTRO - OUTROS RENDIMENTOS

outros_rendimentos <- readRDS("OUTROS_RENDIMENTOS.rds")

#   Anualização e expansão dos valores de deduções utilizados para a obtenção
#   dos resultados (variável V850_defla).

# a) Para anualizar, utilizamos o quesito "fator_anualizacao". No caso específico 
#    do quadro 54, cujas informações se referem a valores mensais, utilizamos também
#    o quesito V9011 (número de meses).
#    Os valores são anualizados para depois se obter uma média mensal.

# b) Para expandir, utilizamos o quesito "peso_final".

# c) Posteriormente, o resultado é dividido por 12 para obter a estimativa mensal. 

outros_rend <-
  transform( outros_rendimentos,
             codigo = trunc( V9001/100 ) ,
             valor_mensal = ifelse( QUADRO==54,
                                    (V8500_DEFLA*V9011*FATOR_ANUALIZACAO*PESO_FINAL)/12, 
                                    (V8500_DEFLA*FATOR_ANUALIZACAO*PESO_FINAL)/12 
                                    ) 
             ) [ , c( "COD_UPA" , "NUM_DOM" , "NUM_UC" , "COD_INFORMANTE" , "codigo" , "valor_mensal" ) ]

rm(outros_rendimentos)



# Parte 1 – Para cada Unidade de Consumo (UC), soma dos valores referentes aos códigos:
# 55008, 55010, 55016, 55020 a 55026, 55035, 55037, 55044, 55053 e 5506

codigos <-
  subset( outros_rend ,
          codigo == 55008 |
            codigo == 55010 | 
            codigo == 55016 |
            codigo == 55020 |
            codigo == 55021 |
            codigo == 55022 |
            codigo == 55023 |
            codigo == 55024 |
            codigo == 55025 |
            codigo == 55026 |
            codigo == 55035 |
            codigo == 55037 |
            codigo == 55044 |
            codigo == 55053 |
            codigo == 55061 
          ) 

parte1 <- sum( codigos$valor_mensal )



# Parte 2 - Para cada informante, calcular as seguintes diferenças:
# Código 57001 – Código 56001 (só considerar quando a diferença for > 0)
# Código 57002 – Código 56002 (só considerar quando a diferença for > 0)
# Código 57003 – Código 56003 (só considerar quando a diferença for > 0)
# Código 57004 – Código 56004 (só considerar quando a diferença for > 0)

# O resultado final da parte 2 é a soma das diferenças maiores que 0.

# Calculando a diferença entre os códigos 57001 e 56001

cod57001 <-
  subset( outros_rend ,
          codigo == 57001
          ) 
arquivo57001 <- aggregate( valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC + COD_INFORMANTE , 
                           data = cod57001 ,
                           sum )
names(arquivo57001) <- c( "cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "soma57001" )


cod56001 <-
  subset( outros_rend ,
          codigo == 56001
  ) 
arquivo56001 <- aggregate( valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC + COD_INFORMANTE , 
                           data = cod56001 ,
                           sum )
names(arquivo56001) <- c( "cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "soma56001" )


merge1 <-
  subset(
    transform(
      merge( arquivo57001 ,
             arquivo56001 , 
             all.x = T , 
             all.y = T ) ,
      dif1 = ifelse( is.na(soma57001) , 0 , soma57001 ) - ifelse( is.na(soma56001) , 0 , soma56001 )
    )[ , c("cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "dif1")] ,
    dif1 > 0
  )
arquivo1 <- sum(merge1$dif1)

# Calculando a diferença entre os códigos 57002 e 56002

cod57002 <-
  subset( outros_rend ,
          codigo == 57002
  ) 
arquivo57002 <- aggregate( valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC + COD_INFORMANTE , 
                           data = cod57002 ,
                           sum )
names(arquivo57002) <- c( "cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "soma57002" )


cod56002 <-
  subset( outros_rend ,
          codigo == 56002
  ) 
arquivo56002 <- aggregate( valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC + COD_INFORMANTE , 
                           data = cod56002 ,
                           sum )
names(arquivo56002) <- c( "cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "soma56002" )


merge2 <-
  subset(
    transform(
      merge( arquivo57002 ,
             arquivo56002 , 
             all.x = T , 
             all.y = T ) ,
      dif2 = ifelse( is.na(soma57002) , 0 , soma57002 ) - ifelse( is.na(soma56002) , 0 , soma56002 )
    )[ , c("cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "dif2")] ,
    dif2 > 0
  )
arquivo2 <- sum(merge2$dif2)

# Calculando a diferença entre os códigos 57003 e 56003

cod57003 <-
  subset( outros_rend ,
          codigo == 57003
  ) 
arquivo57003 <- aggregate( valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC + COD_INFORMANTE , 
                           data = cod57003 ,
                           sum )
names(arquivo57003) <- c( "cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "soma57003" )


cod56003 <-
  subset( outros_rend ,
          codigo == 56003
  ) 
arquivo56003 <- aggregate( valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC + COD_INFORMANTE , 
                           data = cod56003 ,
                           sum )
names(arquivo56003) <- c( "cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "soma56003" )


merge3 <-
  subset(
    transform(
      merge( arquivo57003 ,
             arquivo56003 , 
             all.x = T , 
             all.y = T ) ,
      dif3 = ifelse( is.na(soma57003) , 0 , soma57003 ) - ifelse( is.na(soma56003) , 0 , soma56003 )
    )[ , c("cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "dif3")] ,
    dif3 > 0
  )
arquivo3 <- sum(merge3$dif3)

# Calculando a diferença entre os códigos 57004 e 56004

cod57004 <-
  subset( outros_rend ,
          codigo == 57004
  ) 
arquivo57004 <- aggregate( valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC + COD_INFORMANTE , 
                           data = cod57004 ,
                           sum )
names(arquivo57004) <- c( "cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "soma57004" )


cod56004 <-
  subset( outros_rend ,
          codigo == 56004
  ) 
arquivo56004 <- aggregate( valor_mensal ~ COD_UPA + NUM_DOM + NUM_UC + COD_INFORMANTE , 
                           data = cod56004 ,
                           sum )
names(arquivo56004) <- c( "cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "soma56004" )


merge4 <-
  subset(
    transform(
      merge( arquivo57004 ,
             arquivo56004 , 
             all.x = T , 
             all.y = T ) ,
      dif4 = ifelse( is.na(soma57004) , 0 , soma57004 ) - ifelse( is.na(soma56004) , 0 , soma56004 )
    )[ , c("cod_upa" , "num_dom" , "num_uc" , "cod_informante" , "dif4")] ,
    dif4 > 0
  )
arquivo4 <- sum(merge4$dif4)

# Juntando os arquivos das diferenças (somando-as)

parte2 <- arquivo1+arquivo2+arquivo3+arquivo4

# Somando os valores das partes 1 e 2

soma_final <- parte1+parte2


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

# Calculando o rendimento não monetário médio mensal (resultado final)

media_final <- 
  data.frame( media_mensal = soma_final / soma_familia )

