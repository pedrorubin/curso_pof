# LEITURA DOS DADOS DA POF 2017-2018 - R

  
# "....." indica a pasta/diretório de trabalho no HD local separados por "/"
# onde se encontram os arquivos .txt descompactados do arquivo Dados_aaaammdd.zip
# Exemplo: setwd("c:/POF2018/Dados_aaaammdd/")

setwd(".....") 


# REGISTRO - MORADOR
  
MORADOR <- 
  read.fwf("MORADOR.txt" 
           , widths = c(2,4,1,9,2,1,2,2,1,2,2,4,3,1,1,
                        1,1,1,2,1,2,1,1,1,1,1,1,1,1,1,
                        1,1,1,1,1,2,1,1,2,1,1,2,1,1,1,
                        2,1,2,14,14,10,1,1,20,20,20,20)
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG", 
                           "COD_UPA", "NUM_DOM", "NUM_UC", "COD_INFORMANTE",
                           "V0306", "V0401", "V04021", "V04022", "V04023",
                           "V0403", "V0404", "V0405", "V0406", "V0407",
                           "V0408", "V0409", "V0410", "V0411", "V0412",
                           "V0413", "V0414", "V0415", "V0416", 
                           "V041711", "V041712", "V041721", "V041722",
                           "V041731", "V041732", "V041741", "V041742",
                           "V0418", "V0419", "V0420", "V0421", "V0422",
                           "V0423", "V0424", "V0425", "V0426", "V0427",
                           "V0428", "V0429", "V0430", "ANOS_ESTUDO",
                           "PESO", "PESO_FINAL", "RENDA_TOTAL",
                           "INSTRUCAO", "COMPOSICAO", "PC_RENDA_DISP",
                           "PC_RENDA_MONET", "PC_RENDA_NAO_MONET",
                           "PC_DEDUCAO")
           , dec="."
           )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(MORADOR,"MORADOR.rds")


# REGISTRO - DESPESA COLETIVA

DESPESA_COLETIVA <- 
  read.fwf("DESPESA_COLETIVA.txt"
           , widths = c(2,4,1,9,2,1,2,2,7,2,4,10,2,2,1
                        ,10,1,12,10,10,1,1,2,14,14,10,5)
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC", "QUADRO",
                           "SEQ", "V9001", "V9002", "V9005", "V8000",
                           "V9010", "V9011", "V9012", "V1904",
                           "V1905", "DEFLATOR", "V8000_DEFLA",
                           "V1904_DEFLA", "COD_IMPUT_VALOR",
                           "COD_IMPUT_QUANTIDADE", "FATOR_ANUALIZACAO",
                           "PESO", "PESO_FINAL", "RENDA_TOTAL","V9004")
           , dec="."
           )

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(DESPESA_COLETIVA,"DESPESA_COLETIVA.rds")


# REGISTRO - CADERNETA COLETIVA

CADERNETA_COLETIVA <- 
  read.fwf("CADERNETA_COLETIVA.txt" 
           , widths = c(2,4,1,9,2,1,2,3,7,2,10,12,10,1,2,14,14,10,
                        9,4,5,9,5
                        )
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC", "QUADRO",
                           "SEQ", "V9001", "V9002", "V8000", "DEFLATOR",
                           "V8000_DEFLA", "COD_IMPUT_VALOR",
                           "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL",
                           "RENDA_TOTAL",
                           "V9005", "V9007", "V9009", "QTD_FINAL","V9004")
           , dec="."
           )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(CADERNETA_COLETIVA,"CADERNETA_COLETIVA.rds")


# REGISTRO - DESPESA INDIVIDUAL

DESPESA_INDIVIDUAL <- 
  read.fwf("DESPESA_INDIVIDUAL.txt" 
           , widths = c(2,4,1,9,2,1,2,2,2,7,2,10,2
                        ,2,1,1,1,12,10,1,2,14,14,10,5)
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC",
                           "COD_INFORMANTE", "QUADRO", "SEQ", "V9001",
                           "V9002", "V8000", "V9010", "V9011", "V9012",
                           "V4104", "V4105", "DEFLATOR", "V8000_DEFLA",
                           "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO",
                           "PESO", "PESO_FINAL", "RENDA_TOTAL","V9004")
           , dec="."
           )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(DESPESA_INDIVIDUAL,"DESPESA_INDIVIDUAL.rds")


# REGISTRO - ALUGUEL ESTIMADO

ALUGUEL_ESTIMADO <- 
  read.fwf("ALUGUEL_ESTIMADO.txt" 
           , widths = c(2,4,1,9,2,1,2,7,2,10,2,2,12,10,1,2,14,14,10)
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC", "QUADRO",
                           "V9001", "V9002", "V8000", "V9010", "V9011",
                           "DEFLATOR", "V8000_DEFLA", "COD_IMPUT_VALOR",
                           "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL",
                           "RENDA_TOTAL")
           , dec="."
           )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(ALUGUEL_ESTIMADO,"ALUGUEL_ESTIMADO.rds")


# REGISTRO - RENDIMENTO DO TRABALHO

RENDIMENTO_TRABALHO <- 
  read.fwf("RENDIMENTO_TRABALHO.txt" 
           , widths = c(2,4,1,9,2,1,2,2,1,1,7,1,1,1,1,1,1,7,7,
                        7,7,2,2,3,1,12,10,10,10,10,1,1,14,14,
                        10,4,5)
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC",
                           "COD_INFORMANTE", "QUADRO", "SUB_QUADRO",
                           "SEQ", "V9001", "V5302", "V53021", "V5303",
                           "V5304", "V5305", "V5307", "V8500", "V531112",
                           "V531122", "V531132", "V9010", "V9011",
                           "V5314", "V5315", "DEFLATOR", "V8500_DEFLA",
                           "V531112_DEFLA", "V531122_DEFLA",
                           "V531132_DEFLA", "COD_IMPUT_VALOR",
                           "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL",
                           "RENDA_TOTAL","V53011","V53061")
           , dec="."
           )

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(RENDIMENTO_TRABALHO,"RENDIMENTO_TRABALHO.rds")


# REGISTRO - OUTROS RENDIMENTOS

OUTROS_RENDIMENTOS <- 
  read.fwf("OUTROS_RENDIMENTOS.txt" 
           , widths = c(2,4,1,9,2,1,2,2,2,7,10,10,2
                        ,2,12,10,10,1,1,14,14,10
                        )
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC",
                           "COD_INFORMANTE", "QUADRO", "SEQ", "V9001",
                           "V8500", "V8501", "V9010", "V9011",
                           "DEFLATOR", "V8500_DEFLA", "V8501_DEFLA",
                           "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO",
                           "PESO", "PESO_FINAL", "RENDA_TOTAL")
           , dec="."
           )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(OUTROS_RENDIMENTOS,"OUTROS_RENDIMENTOS.rds")


# REGISTRO - DOMICILIO

DOMICILIO <- 
  read.fwf("DOMICILIO.txt" 
           , widths = c(2,4,1,9,2,1,1,1,1,2,1,1,1,1,1,1,1,1,1,2,
                        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,14,14,1
                        )
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "V0201", "V0202", 
                           "V0203", "V0204", "V0205", "V0206", "V0207",
                           "V0208", "V0209", "V02101", "V02102",
                           "V02103", "V02104", "V02105", "V02111",
                           "V02112", "V02113", "V0212", "V0213",
                           "V02141", "V02142", "V0215", "V02161", 
                           "V02162", "V02163", "V02164", "V0217", 
                           "V0219", "V0220", "V0221", "PESO",
                           "PESO_FINAL", "V6199")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(DOMICILIO,"DOMICILIO.rds")


# REGISTRO - INVENTÁRIO DE BENS DURÁVEIS

INVENTARIO <- 
  read.fwf("INVENTARIO.txt" 
           , widths = c(2,4,1,9,2,1,2,2,7,2,
                        2,4,1,14,14,10
           )
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC", "QUADRO",
                           "SEQ", "V9001", "V9005", "V9002", "V1404",
                           "V9012", "PESO", "PESO_FINAL","RENDA_TOTAL")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(INVENTARIO,"INVENTARIO.rds")


# REGISTRO - CARACTERÍSTICAS DA DIETA

CARACTERISTICAS_DIETA <- 
  read.fwf("CARACTERISTICAS_DIETA.txt" 
           , widths = c(2,4,1,9,2,1,2,1,1,1,1,
                        1,1,1,1,1,1,1,1,1,1,1,
                        1,1,1,1,3,3,14,15,10
           )
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC",
                           "COD_INFORMANTE", "V7101", "V7102",
                           "V71031", "V71032", "V71033", "V71034",
                           "V71035", "V71036", "V71037", "V71038",
                           "V7104", "V71051", "V71052", "V71053",
                           "V71054", "V71055", "V71056", "V71A01",
                           "V71A02", "V72C01", "V72C02", "PESO",
                           "PESO_FINAL", "RENDA_TOTAL")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(CARACTERISTICAS_DIETA,"CARACTERISTICAS_DIETA.rds")


# REGISTRO - CONSUMO ALIMENTAR

CONSUMO_ALIMENTAR <- 
  read.fwf("CONSUMO_ALIMENTAR.txt" 
           , widths = c(2,4,1,9,2,1,2,2,2,4,2,7,3,
                        2,1,1,1,1,1,1,1,1,1,1,1,1,
                        1,1,2,2,7,9,6,14,14,14,14,
                        14,14,14,14,14,14,14,14,
                        14,14,14,14,14,14,14,14,
                        14,14,14,14,14,14,14,14,
                        14,14,15,10,15,1
           )
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC",
                           "COD_INFOR,MANTE", "QUADRO", "SEQ",
                           "V9005", "V9007", "V9001", "V9015",
                           "V9016", "V9017", "V9018", "V9019",
                           "V9020", "V9021", "V9022", "V9023",
                           "V9024", "V9025", "V9026", "V9027",
                           "V9028", "V9029", "V9030",
                           "COD_UNIDADE_MEDIDA_FINAL",
                           "COD_PREPARACAO_FINAL", "GRAMATURA1",
                           "QTD", "COD_TBCA", "ENERGIA_KCAL",
                           "ENERGIA_KJ", "PTN", "CHOTOT", "FIBRA",
                           "LIP", "COLEST", "AGSAT", "AGMONO",
                           "AGPOLI", "AGTRANS", "CALCIO", "FERRO",
                           "SODIO", "MAGNESIO", "FOSFORO", "POTASSIO",
                           "COBRE", "ZINCO", "VITA_RAE", "TIAMINA",
                           "RIBOFLAVINA", "NIACINA", "PIRIDOXAMINA",
                           "COBALAMINA", "VITD", "VITE", "VITC",
                           "FOLATO", "PESO", "PESO_FINAL",
                           "RENDA_TOTAL", "DIA_SEMANA", "DIA_ATIPICO")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(CONSUMO_ALIMENTAR,"CONSUMO_ALIMENTAR.rds")


# REGISTRO - CONDIÇÕES DE VIDA

CONDICOES_VIDA <- 
  read.fwf("CONDICOES_VIDA.txt" 
           , widths = c(2,4,1,9,2,1,2,1,6,5,1,1,1,1,1,
                        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                        1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
                        1,1,1,1,1,1,1,14,14,10)
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC", "COD_INFORMANTE",
                           "V6101", "V6102", "V6103", "V61041", "V61042",
                           "V61043", "V61044", "V61045", "V61046", 
                           "V61051", "V61052", "V61053", "V61054",
                           "V61055", "V61056", "V61057", "V61058",
                           "V61061", "V61062", "V61063", "V61064",
                           "V61065", "V61066", "V61067", "V61068",
                           "V61069", "V610610", "V610611", "V61071",
                           "V61072", "V61073", "V6108", "V6109",
                           "V6110", "V6111", "V6112", "V6113", "V6114",
                           "V6115", "V6116", "V6117", "V6118", "V6119",
                           "V6120", "V6121", "PESO", "PESO_FINAL",
                           "RENDA_TOTAL")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(CONDICOES_VIDA,"CONDICOES_VIDA.rds")


# REGISTRO - RESTRIÇÃO DE PRODUTOS OU SERVIÇOS DE SAÚDE

RESTRICAO_PRODUTOS_SERVICOS_SAUDE <- 
  read.fwf("RESTRICAO_PRODUTOS_SERVICOS_SAUDE.txt" 
           , widths = c(2,4,1,9,2,1,2,2,
                        2,7,1,14,14,10)
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC",
                           "COD_INFORMANTE", "QUADRO", "SEQ","V9001",
                           "V9013", "PESO", "PESO_FINAL", "RENDA_TOTAL")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(RESTRICAO_PRODUTOS_SERVICOS_SAUDE,"RESTRICAO_PRODUTOS_SERVICOS_SAUDE.rds")


# REGISTRO - SERVIÇOS NÃO MONETÁRIOS/POF 2

SERVICO_NAO_MONETARIO_POF2 <- 
  read.fwf("SERVICO_NAO_MONETARIO_POF2.txt" 
           , widths = c(2,4,1,9,2,1,2,2,7,2,10,2,2,10,
                        1,12,10,10,1,2,14,14,10,5)
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC", "QUADRO",
                           "SEQ", "V9001", "V9002", "V8000", "V9010",
                           "V9011", "V1904", "V1905", "DEFLATOR",
                           "V8000_DEFLA", "V1904_DEFLA", "COD_IMPUT_VALOR",
                           "FATOR_ANUALIZACAO", "PESO", "PESO_FINAL",
                           "RENDA_TOTAL","V9004")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(SERVICO_NAO_MONETARIO_POF2,"SERVICO_NAO_MONETARIO_POF2.rds")


# REGISTRO - SERVIÇOS NÃO MONETÁRIOS/POF 4

SERVICO_NAO_MONETARIO_POF4 <- 
  read.fwf("SERVICO_NAO_MONETARIO_POF4.txt" 
           , widths = c(2,4,1,9,2,1,2,2,2,7,2,10,2,2,
                        1,1,12,10,1,2,14,14,10,5)
           , na.strings=c(" ")
           , col.names = c("UF", "ESTRATO_POF", "TIPO_SITUACAO_REG",
                           "COD_UPA", "NUM_DOM", "NUM_UC", 
                           "COD_INFORMANTE", "QUADRO", "SEQ",
                           "V9001", "V9002", "V8000", "V9010", "V9011",
                           "V4104", "V4105", "DEFLATOR", "V8000_DEFLA",
                           "COD_IMPUT_VALOR", "FATOR_ANUALIZACAO",
                           "PESO", "PESO_FINAL", "RENDA_TOTAL","V9004")
           , dec="."
  )   

# Armazena no HD local arquivo serializado para leituras futuras
saveRDS(SERVICO_NAO_MONETARIO_POF4,"SERVICO_NAO_MONETARIO_POF4.rds")
