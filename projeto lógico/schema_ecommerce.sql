-- criação e seleção do banco de dados para o cenário de E-commerce
-- drop database projeto_ecommerce_dio; 
create database projeto_ecommerce_dio;
use projeto_ecommerce_dio;

-- criar tabela pessoa física
create table pFisicas(
	cpf CHAR(11) primary key,
	dataNascimento DATE NOT NULL,
	nomeCompleto VARCHAR(45) NOT NULL,
	constraint unique_pFisica unique (cpf)
);
desc pFisicas;

-- criar tabela pessoa jurídica
create table pJuridicas(
	cnpj CHAR(14) primary key,
	dataCriacao DATE NOT NULL,
	razaoSocial VARCHAR(255) NOT NULL,
	nomeFantasia VARCHAR(45) NOT NULL,
	responsavel VARCHAR(45) NOT NULL,
	constraint unique_pJuridica unique (cnpj)
);
desc pJuridicas;

-- criar tabela cliente
create table clientes(
	idCliente INT auto_increment primary key,
	endereco VARCHAR(255) NOT NULL,
	tipo ENUM('pFisica','pJuridica'),
	cpf CHAR(11),
	cnpj CHAR(14),
	constraint fk_clientes_pFisicas foreign key (cpf) references pFisicas(cpf),
	constraint fk_clientes_pJuridicas foreign key (cnpj) references pJuridicas(cnpj)
) auto_increment = 1;
desc clientes;

-- criar tabela produto
create table produtos(
	idProduto INT auto_increment primary key,
	nomeProduto varchar(20) NOT NULL,
	categoria ENUM('Vestuário', 'Eletrônicos', 'Brinquedos', 'Alimentos e Bebidas', 'Eletrodomésticos', 'Móveis') NOT NULL,
	descricao VARCHAR(255),
	avaliacao float default 0,
	valor FLOAT NOT NULL
) auto_increment = 1;
desc produtos;

-- criar tabela entrega
create table entregas(
	idEntrega INT auto_increment primary key,
	statusEntrega ENUM('Pagamento pendente', 'Em preparação', 'Postado', 'Em trânsito', 'Entregue') default 'Pagamento pendente',
	codRastreio VARCHAR(20),
	empresaFrete VARCHAR(20) NOT NULL
) auto_increment = 1;
desc entregas;

-- criar tabela pedido
create table pedidos(
	idPedido INT auto_increment,
	idCliente INT,
	idEntrega INT,
	statusPedido ENUM('Cancelado', 'Confirmado', 'Em processamento') default 'Em processamento',
	descricaoPedido VARCHAR(255),
	freteValor FLOAT default 10,
	pagamentoEmCartao bool default false,
	primary key(idPedido, idCliente),
	constraint fk_pedidos_clientes foreign key (idCliente) references clientes(idCliente),
	constraint fk_pedidos_entregas foreign key (idEntrega) references entregas(idEntrega),
	constraint unique_pedidos unique (idPedido)
) auto_increment = 1;
desc pedidos;

-- criar tabela pagamento
create table pagamentos(
	idCliente INT,
	idPedido INT,
	formaPagamento ENUM('Boleto', 'Pix', 'Cartão', 'Dois cartões') default 'Boleto',
	statusPagamento ENUM('Pendente', 'Negado', 'Aprovado') default 'Pendente',
	primary key(idCliente, idPedido),
	constraint fk_pagamentos_clientes foreign key (idCliente) references clientes(idCliente),
	constraint fk_pagamentos_pedidos foreign key (idPedido) references pedidos(idPedido)
);
desc pagamentos;

-- criar tabela estoque
create table estoques(
	idEstoque INT auto_increment primary key,
	localEstoque VARCHAR(255) NOT NULL
) auto_increment = 1;
desc estoques;

-- criar tabela fornecedor
create table fornecedores(
	idFornecedor INT auto_increment,
	cnpj CHAR(14),
	contato VARCHAR(11) NOT NULL,
	primary key(idFornecedor, cnpj),
	constraint fk_fornecedores_pJuridicas foreign key (cnpj) references pJuridicas(cnpj),
    constraint unique_fornecedores unique (idFornecedor)
) auto_increment = 1;
desc fornecedores;

-- criar tabela vendedor terceiro
create table vendedores(
	idVendedor INT auto_increment primary key,
	cnpj CHAR(14),
	cpf CHAR(11),
	contato VARCHAR(11) NOT NULL,
	localidade VARCHAR(255) NOT NULL,
	constraint fk_vendedores_pFisicas foreign key (cpf) references pFisicas(cpf),
	constraint fk_vendedores_pJuridicas foreign key (cnpj) references pJuridicas(cnpj)
) auto_increment = 1;
desc vendedores;

-- criar tabela vendedores_produtos
create table vendedoresProdutos(
	idVendedor INT,
	idProduto INT,
	qtdProdutoV INT default 0,
	primary key(idVendedor, idProduto),
	constraint fk_vendedoresProdutos_vendedores foreign key (idVendedor) references vendedores(idVendedor),
	constraint fk_vendedoresProdutos_produtos foreign key (idProduto) references produtos(idProduto)
);
desc vendedoresProdutos;

-- criar tabela pedidos_produtos
create table pedidosProdutos(
	idPedido INT,
	idProduto INT,
	qtdProdutoP INT default 0,
	primary key(idPedido, idProduto),
	constraint fk_pedidosProdutos_pedidos foreign key (idPedido) references pedidos(idPedido),
	constraint fk_pedidosProdutos_produtos foreign key (idProduto) references produtos(idProduto)
);
desc pedidosProdutos;

-- criar tabela estoques_produtos
create table estoquesProdutos(
	idEstoque INT,
	idProduto INT,
	qtdProdutoE INT default 0,
	primary key(idEstoque, idProduto),
	constraint fk_estoquesProdutos_estoque foreign key (idEstoque) references estoques(idEstoque),
	constraint fk_estoquesProdutos_produtos foreign key (idProduto) references produtos(idProduto)
);
desc estoquesProdutos;

-- criar tabela fornecedores produtos
create table fornecedoresProdutos(
	idFornecedor INT,
	idProduto INT,
	qtdProdutoF INT default 0,
	primary key(idFornecedor, idProduto),
	constraint fk_fornecedoresProdutos_fornecedores foreign key (idFornecedor) references fornecedores(idFornecedor),
	constraint fk_fornecedoresProdutos_produtos foreign key (idProduto) references produtos(idProduto)
);
desc fornecedoresProdutos;