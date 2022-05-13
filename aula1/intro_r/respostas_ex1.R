### Possíveis respostas

# 1.
# df1 <- read_csv("./aula1/exercicio/time_regiao.csv")
# df2 <- read_csv("./aula1/exercicio/classif.csv")
# 
# df_final <- df1 %>% 
#   left_join(df2, by = "posicao")
# 
# df_final %>% write_csv("./aula1/exercicio/classif_final.csv")


# 2.
# df_final <- df_final %>% 
#   mutate(pontos = vitorias*3 + empates,
#          jogos = vitorias + empates + derrotas,
#          saldo_gols = gols_pro - gols_contra)


# 3.
# df_nova_ordem <- df_final %>% 
#   arrange(pontos, saldo_gols, vitorias)
# 
# Comparar df_nova_ordem com df_final


# 4.
# df_final %>% 
#   select(time, pontos, gols_pro) %>% 
#   head(3)
# 
# 
# df_final %>% 
#   select(time, pontos, gols_pro) %>% 
#   tail(4)


# 5.
# df_final %>% 
#   filter(regiao == "sul")


# 6.
# df_final %>% 
#   summarise(total = sum(pontos),
#             media = mean(pontos),
#             mediana = median(pontos))
# 
# df_final %>% 
#   group_by(regiao) %>% 
#   summarise(total = sum(pontos),
#             media = mean(pontos),
#             mediana = median(pontos))