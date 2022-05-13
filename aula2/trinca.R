# indice <- readxl::read_xls("./memoria_de_calculo/Indice_Despesa.xls") %>% 
#   clean_names()

pof_despcol <- read_rds("./dados/pof_despesa_coletiva.rds") %>% 
  mutate(codigo = floor(as.numeric(V9001)/100))

pof_despcol %>% 
  filter(is.na(V9011) == F) %>%
  distinct(QUADRO)

tradutor <- readxl::read_xls("./tradutores/Tradutor_Despesa_Geral.xls") %>% 
  clean_names()

cadastro <- readxl::read_xls("./documentacao/Cadastro de Produtos.xls", 
                             col_types = "text") %>% 
  clean_names() %>% 
  mutate(codigo_do_produto = str_sub(codigo_do_produto, 1, -3),
         codigo_do_produto = as.numeric(codigo_do_produto)) %>% 
  distinct(codigo_do_produto, .keep_all = T)

produtos <- full_join(cadastro, tradutor, by = c("codigo_do_produto" = "codigo"))
# produtos %>% filter(codigo_do_produto == 19001) %>% View()

produtos %>% group_by(codigo_do_produto) %>% mutate(x = n()) %>% filter(x > 1) %>% View()
