# curso_pof
 
Olá!
Meu nome é Pedro Rubin, sou mestrando em Economia na UFRJ e assistente de pesquisa no IPEA.

Esse é o repositório com os códigos utilizados no curso "Utilização dos microdados da Pesquisa de Orçamentos Familiares (POF) 2017-2018 no R", que ministrei na Universidade Federal Fluminense (UFF) entre os dias 28/06 e 12/07 de 2022. O curso foi composto por 5 encontros, brevemente apresentados aqui, e contou com alunos da graduação e da pós-graduação da UFF e da UFRJ, além de professores e outros pesquisadores.

Meus contatos são:

* Email: prubincosta@gmail.com
* Twitter: [@pedrorubincosta](http://www.twitter.com/pedrorubincosta)

## Sobre o curso

Todos os arquivos necessários estão nesse repositório, exceto os microdados da POF originais em .txt, que podem ser baixados [aqui](https://www.ibge.gov.br/estatisticas/sociais/saude/24786-pesquisa-de-orcamentos-familiares-2.html?=&t=microdados). Basta descompatar e colocar esses dados na pasta dados.

* Aula 1: Introdução ao R
  * Pacotes, importação e manipulação de dados (`dplyr`), práticas de programação e como carregar e salvar os microdados da POF
* Aula 2: Despesas na POF
  * Divisão de pessoas, unidades de consumo e domicílios; códigos, categorias e variáveis de despesa; criação de um dataframe com todas as informações relativas às despesas da população
* Aula 3: Cálculos com despesas
  * Médias por família Brasil e outras subdivisões, replicação da [tabela 6715 do SIDRA](https://sidra.ibge.gov.br/Tabela/6715)
* Aula 4: Prática
  * Sem código - cada participante fez o que mais se adequava às suas necessidades e desejos com a POF
* Aula 5: Análise de dados complexos
  * Funcionamento dos pacotes `survey`e `srvyr` - como criar objetos em R que levem em conta o desenho amostral e a pós-estratificação
  * Cálculo de coeficientes de variação
  * Percentis, índice de Gini e curva de Lorenz (Renda e Despesa) 
