# Projeto de Banco de Dados para E-commerce

Este repositório contém um projeto completo de banco de dados para um sistema de E-commerce. O objetivo deste projeto é criar uma estrutura de banco de dados consistente, eficiente e adequada às operações de um ambiente de comércio eletrônico, além de fornecer consultas úteis para manipulação e análise de dados.

## Arquivos incluídos

O projeto está dividido em três arquivos principais:

1. **schema_ecommerce.sql**
   - Contém a estrutura (schema) do banco de dados.
   - Criação das tabelas: `pFisicas`, `pJuridicas`, `clientes`, `produtos`, `pedidos`, `entregas`, `pagamentos`, `estoques`, entre outras.
   - Definições de chaves primárias, chaves estrangeiras e constraints de integridade para manter a consistência dos dados.

2. **seeds_ecommerce.sql**
   - Popula o banco de dados com dados fictícios para simular um ambiente real de E-commerce.
   - Inclui dados para:
     - Pessoas físicas e jurídicas (clientes e fornecedores).
     - Produtos.
     - Pedidos e associações com seus respectivos itens.
     - Estoques, fornecedores e vendedores.

3. **consultas_ecommerce.sql**
   - Conjunto de consultas SQL úteis para análise e manipulação dos dados no banco.
   - Exemplos de consultas incluídas:
     - Listagem de pedidos e seus valores totais.
     - Relatórios de produtos disponíveis em estoque por fornecedor.
     - Detalhes de clientes e seus pedidos.

## Pré-requisitos

Para executar este projeto, você precisará de:
- Um servidor de banco de dados MySQL ou MariaDB instalado em sua máquina.
- Um cliente SQL, como o MySQL Workbench, DBeaver ou similar.

## Passo a passo para execução

1. **Criar o banco de dados e o schema:**
   - Execute o arquivo `schema_ecommerce.sql` para criar a estrutura do banco de dados.

2. **Popular o banco com dados:**
   - Execute o arquivo `seeds_ecommerce.sql` para adicionar os dados fictícios ao banco.

3. **Executar consultas:**
   - Utilize o arquivo `consultas_ecommerce.sql` para realizar consultas e análises nos dados.

## Funcionalidades implementadas

- Estrutura robusta para armazenar informações relacionadas a:
  - Clientes (pessoas físicas e jurídicas).
  - Produtos e suas categorias.
  - Pedidos, entregas e pagamentos.
  - Estoques e fornecedores.
  - Vendedores e seus produtos.
- Dados fictícios para simulação de operações reais de E-commerce.
- Consultas úteis para:
  - Geração de relatórios de vendas e estoque.
  - Análise de desempenho de vendedores e fornecedores.
  - Listagem detalhada de pedidos e clientes.


---

Dúvidas ou sugestões? Entre em contato!
