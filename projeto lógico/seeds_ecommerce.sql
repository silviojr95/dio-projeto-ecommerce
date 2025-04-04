-- Seeds para pFisicas
INSERT INTO pFisicas (cpf, dataNascimento, nomeCompleto) VALUES
('12345678901', '1985-07-15', 'João Silva'),
('98765432100', '1990-03-22', 'Maria Oliveira'),
('65432198700', '1975-02-18', 'Carlos Mendes'),
('45678912311', '1988-11-05', 'Ana Santos'),
('32165498700', '1995-01-13', 'Beatriz Almeida');

-- Seeds para pJuridicas
INSERT INTO pJuridicas (cnpj, dataCriacao, razaoSocial, nomeFantasia, responsavel) VALUES
('12345678000199', '2000-12-01', 'Tech Solutions Ltda.', 'TechSol', 'Carlos Santos'),
('98765432000188', '2015-05-14', 'Fashion Store Ltda.', 'FashionStore', 'Ana Lima'),
('32165487000144', '2018-07-20', 'Food Supplies Ltda.', 'FoodSupplies', 'Rafael Souza'),
('45678912000155', '2010-09-18', 'ElectroHouse Ltda.', 'ElectroHouse', 'Paulo Ribeiro'),
('65432198000177', '2016-03-25', 'ToyWorld Ltda.', 'ToyWorld', 'Juliana Pereira');

-- Seeds para clientes
INSERT INTO clientes (endereco, tipo, cpf, cnpj) VALUES
('Rua A, 123, São Paulo', 'pFisica', '12345678901', NULL),
('Avenida B, 456, Rio de Janeiro', 'pFisica', '98765432100', NULL),
('Rua C, 789, Belo Horizonte', 'pJuridica', NULL, '12345678000199'),
('Avenida D, 1011, Porto Alegre', 'pJuridica', NULL, '98765432000188'),
('Rua E, 1213, Curitiba', 'pFisica', '65432198700', NULL);

-- Seeds para produtos
INSERT INTO produtos (nomeProduto, categoria, descricao, avaliacao, valor) VALUES
('Camiseta Básica', 'Vestuário', 'Camiseta de algodão', 4.5, 29.90),
('Smartphone X', 'Eletrônicos', 'Smartphone de última geração', 4.8, 1999.00),
('Boneca de Pano', 'Brinquedos', 'Boneca artesanal', 4.2, 39.90),
('Geladeira FrostFree', 'Eletrodomésticos', 'Geladeira moderna', 4.7, 2699.99),
('Sofá Retrátil', 'Móveis', 'Sofá confortável', 4.3, 1599.99);

-- Seeds para entregas (ajustado para refletir os pagamentos e pedidos)
INSERT INTO entregas (statusEntrega, codRastreio, empresaFrete) VALUES
('Em preparação', 'BR123456789', 'Correios'), -- Pagamento aprovado e pedido confirmado
('Postado', 'BR987654321', 'Transportadora XPTO'), -- Pagamento aprovado e pedido confirmado
('Em trânsito', 'BR456789123', 'Transportadora Alfa'), -- Pagamento aprovado e pedido confirmado
('Pagamento pendente', NULL, 'Correios'), -- Pagamento pendente
('Pagamento pendente', NULL, 'Transportadora Beta'); -- Pagamento pendente

-- Seeds para pedidos (ajustados com base nos pagamentos e entregas)
INSERT INTO pedidos (idCliente, idEntrega, statusPedido, descricaoPedido, freteValor, pagamentoEmCartao) VALUES
(1, 1, 'Confirmado', 'Pedido de camiseta e smartphone', 15.00, TRUE), -- Pagamento aprovado
(1, 2, 'Confirmado', 'Pedido adicional de boneca', 10.00, FALSE), -- Pagamento aprovado
(2, 3, 'Confirmado', 'Pedido de geladeira', 50.00, TRUE), -- Pagamento aprovado
(3, 4, 'Em processamento', 'Pedido de sofá', 40.00, FALSE), -- Pagamento pendente
(4, 5, 'Cancelado', 'Pedido pendente de vários itens', 20.00, FALSE); -- Pagamento negado

-- Seeds para pagamentos (ajustados para refletir os pedidos)
INSERT INTO pagamentos (idCliente, idPedido, formaPagamento, statusPagamento) VALUES
(1, 1, 'Cartão', 'Aprovado'),
(1, 2, 'Pix', 'Aprovado'),
(2, 3, 'Boleto', 'Aprovado'),
(3, 4, 'Cartão', 'Pendente'),
(4, 5, 'Cartão', 'Negado');

-- Seeds para estoques
INSERT INTO estoques (localEstoque) VALUES
('São Paulo - Centro de Distribuição'),
('Rio de Janeiro - Armazém Regional'),
('Belo Horizonte - Depósito Central'),
('Curitiba - Centro de Estoque'),
('Porto Alegre - Armazém Secundário');

-- Seeds para estoquesProdutos
INSERT INTO estoquesProdutos (idEstoque, idProduto, qtdProdutoE) VALUES
(1, 1, 200), -- Camiseta Básica em São Paulo
(1, 2, 150), -- Smartphone X em São Paulo
(2, 3, 300), -- Boneca de Pano no Rio de Janeiro
(3, 4, 100), -- Geladeira FrostFree em Belo Horizonte
(4, 5, 250); -- Sofá Retrátil em Curitiba

-- Seeds para fornecedores (refletindo coerência com produtos fornecidos)
INSERT INTO fornecedores (cnpj, contato) VALUES
('12345678000199', '11987654321'), -- Tech Solutions fornece eletrônicos
('98765432000188', '21976543210'), -- Fashion Store fornece vestuário
('65432198000177', '51987654321'), -- ToyWorld fornece brinquedos
('45678912000155', '41987654321'), -- ElectroHouse fornece eletrodomésticos
('32165487000144', '31987654321'); -- Food Supplies fornece produtos variados

-- Seeds para fornecedoresProdutos (associações corrigidas)
INSERT INTO fornecedoresProdutos (idFornecedor, idProduto, qtdProdutoF) VALUES
(1, 2, 300), -- Tech Solutions fornece Smartphone X
(2, 1, 500), -- Fashion Store fornece Camiseta Básica
(3, 3, 700), -- ToyWorld fornece Boneca de Pano
(4, 4, 200), -- ElectroHouse fornece Geladeira FrostFree
(4, 5, 150); -- ElectroHouse fornece Sofá Retrátil

-- Seeds para vendedores
INSERT INTO vendedores (cnpj, cpf, contato, localidade) VALUES
('12345678000199', NULL, '11912345678', 'São Paulo - Zona Norte'),
(NULL, '98765432100', '21987654321', 'Rio de Janeiro - Centro'),
('45678912000155', NULL, '31965432100', 'Belo Horizonte - Pampulha'),
('98765432000188', NULL, '41954321098', 'Curitiba - Batel'),
(NULL, '65432198700', '51943210987', 'Porto Alegre - Moinhos de Vento');

-- Seeds para vendedoresProdutos (refletindo coerência com vendedores)
INSERT INTO vendedoresProdutos (idVendedor, idProduto, qtdProdutoV) VALUES
(1, 2, 100), -- Tech Solutions vende Smartphone X
(2, 1, 200), -- Fashion Store vende Camiseta Básica
(3, 3, 150), -- ToyWorld vende Boneca de Pano
(4, 4, 50), -- ElectroHouse vende Geladeira FrostFree
(5, 5, 75); -- Vendedor independente vende Sofá Retrátil

-- Seeds para pedidosProdutos (associados realisticamente aos pedidos)
INSERT INTO pedidosProdutos (idPedido, idProduto, qtdProdutoP) VALUES
(1, 1, 2), -- Pedido 1 inclui 2 unidades de Camiseta Básica
(1, 2, 1), -- Pedido 1 também inclui 1 unidade de Smartphone X
(2, 3, 3), -- Pedido 2 inclui 3 unidades de Boneca de Pano
(3, 4, 1), -- Pedido 3 inclui 1 unidade de Geladeira FrostFree
(4, 5, 2), -- Pedido 4 inclui 2 unidades de Sofá Retrátil
(5, 3, 1); -- Pedido 5 inclui 1 unidade de Boneca de Pano