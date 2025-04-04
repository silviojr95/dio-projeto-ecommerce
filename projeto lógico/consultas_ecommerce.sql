-- Overview dos pedidos 
select 
    ped.idPedido,
    ped.statusPedido, 
    ped.descricaoPedido, 
    ped.freteValor, 
    ped.pagamentoEmCartao,
    pag.formaPagamento, 
    pag.statusPagamento, 
    ent.statusEntrega, 
    ent.codRastreio, 
    ent.empresaFrete, 
    coalesce(pf.nomeCompleto, pj.razaoSocial) as nome_cliente, 
    cli.tipo  
from pedidos ped
join clientes cli on ped.idCliente = cli.idCliente
left join pFisicas pf on cli.cpf = pf.cpf
left join pJuridicas pj on cli.cnpj = pj.cnpj
left join pagamentos pag on ped.idPedido = pag.idPedido
left join entregas ent on ped.idEntrega = ent.idEntrega;

-- Overview dos pedidos filtrando apenas entregas por
-- empresas de frete que não seja Correios e ordenando por empresa de frete
select 
    ped.idPedido,
    ped.statusPedido, 
    ped.descricaoPedido, 
    ped.freteValor, 
    ped.pagamentoEmCartao,
    pag.formaPagamento, 
    pag.statusPagamento, 
    ent.statusEntrega, 
    ent.codRastreio, 
    ent.empresaFrete, 
    coalesce(pf.nomeCompleto, pj.razaoSocial) as nome_cliente, 
    cli.tipo  
from pedidos ped
join clientes cli on ped.idCliente = cli.idCliente
left join pFisicas pf on cli.cpf = pf.cpf
left join pJuridicas pj on cli.cnpj = pj.cnpj
left join pagamentos pag on ped.idPedido = pag.idPedido
left join entregas ent on ped.idEntrega = ent.idEntrega
where ent.empresaFrete != 'Correios'
order by ent.empresaFrete;

-- Produtos por pedido, com respectivos preços unitários, quantidade e preço total
select
	ped.idPedido as 'ID do pedido',
    prod.nomeProduto as Produto,
    format(prod.valor, 2, 'pt_BR') as 'Preço unitário',
    pedP.qtdProdutoP as Quantidade,
    format(prod.valor * pedP.qtdProdutoP, 2, 'pt_BR') as 'Preço total'
from pedidosProdutos pedP
join produtos prod on pedP.idProduto = prod.idProduto
left join pedidos ped on pedP.idPedido = ped.idPedido
order by ped.idPedido asc;

-- Valor total por pedido, com número de itens, status e cliente
select
    ped.idPedido as 'ID do pedido',
    sum(pedP.qtdProdutoP) as 'Nº de itens no pedido',
    format(coalesce(sum(prod.valor * pedP.qtdProdutoP), 0) + ped.freteValor, 2, 'pt_BR') as 'Valor do pedido (BRL)',
    ped.statusPedido as 'Status do pedido',
    coalesce(pf.nomeCompleto, pj.razaoSocial) as Cliente, 
    cli.tipo
from pedidos ped
left join pedidosProdutos pedP on ped.idPedido = pedP.idPedido
left join produtos prod on pedP.idProduto = prod.idProduto
left join clientes cli on ped.idCliente = cli.idCliente
left join pFisicas pf on cli.cpf = pf.cpf
left join pJuridicas pj on cli.cnpj = pj.cnpj
group by ped.idPedido;

-- Valor total por pedido, com número de itens, status e cliente
-- filtrando valor do pedido > 1000
select
	pedP.idPedido as 'ID do pedido',
    sum(pedP.qtdProdutoP) as 'Nº de itens no pedido',
    format(sum(prod.valor * pedP.qtdProdutoP) + ped.freteValor, 2, 'pt_BR') as Valor,
    ped.statusPedido as 'Status do pedido',
    coalesce(pf.nomeCompleto, pj.razaoSocial) as Cliente, 
    cli.tipo
from pedidosProdutos pedP
join pedidos ped on pedP.idPedido = ped.idPedido
left join produtos prod on pedP.idProduto = prod.idProduto
left join clientes cli on ped.idCliente = cli.idCliente
left join pFisicas pf on cli.cpf = pf.cpf
left join pJuridicas pj on cli.cnpj = pj.cnpj
group by ped.idPedido
having sum(Valor) > 1000;

-- Respostas às perguntas propostas pela DIO, abaixo:

-- 1. Quantos pedidos foram feitos por cada cliente?
select 
    coalesce(pf.nomeCompleto, pj.razaoSocial) as Cliente, 
    count(ped.idPedido) as 'Nº de pedidos'
from pedidos ped
join clientes cli on ped.idCliente = cli.idCliente
left join pFisicas pf on cli.cpf = pf.cpf
left join pJuridicas pj on cli.cnpj = pj.cnpj
group by Cliente;

-- 2. Algum vendedor também é fornecedor?
select 
    coalesce(pf.nomeCompleto, pj.razaoSocial) as Vendedor,
    case 
		when f.idFornecedor > 0 then 'Sim'
        else 'Não'
	end as 'É fornecedor?'
from vendedores v
left join fornecedores f on v.cnpj = f.cnpj
left join pJuridicas pj on v.cnpj = pj.cnpj
left join pFisicas pf on v.cpf = pf.cpf;

-- 3. Relação de produtos fornecedores e estoques
select 
	p.idProduto as 'ID do produto',
    p.nomeProduto as 'Produto',
    pj.razaoSocial as 'Fornecedor',
    e.localEstoque as 'Estoque',
    eP.qtdProdutoE as 'Quantidade em estoque'
from fornecedores f
join fornecedoresProdutos fP on f.idFornecedor = fP.idFornecedor
left join produtos p on fP.idProduto = p.idProduto
left join estoquesProdutos eP on fP.idProduto = eP.idProduto
left join estoques e on eP.idEstoque = e.idEstoque
left join pJuridicas pj on f.cnpj = pj.cnpj;

-- 4. Relação de nomes dos fornecedores e nomes dos produtos
select 
	pj.razaoSocial as 'Fornecedor',
    p.nomeProduto as 'Produto'
from fornecedores f
join fornecedoresProdutos fP on f.idFornecedor = fP.idFornecedor
left join produtos p on fP.idProduto = p.idProduto
left join pJuridicas pj on f.cnpj = pj.cnpj;
