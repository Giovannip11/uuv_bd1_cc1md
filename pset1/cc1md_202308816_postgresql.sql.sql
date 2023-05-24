CREATE USER Giovanni;
CREATE DATABASE UVV;
CREATE SCHEMA lojas;

ALTER SCHEMA lojas OWNER TO Giovanni;
CREATE TABLE lojas.produtos (
    produto_id NUMERIC(38) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    preco_unitario NUMERIC(10,2),
    detalhes BYTEA,
    imagem BYTEA,
    imagem_mime_type VARCHAR(512),
    imagem_arquivo VARCHAR(512),
    imagem_charset VARCHAR(512),
    imagem_ultima_atualizacao DATE,
    CONSTRAINT produto_id PRIMARY KEY (produto_id)
);
COMMENT ON TABLE lojas.produtos IS 'Tabela com as informações dos produtos, como nome e preço.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Coluna com o ID identificador dos produtos.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Coluna com os nomes dos produtos.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Coluna com o preço dos produtos.';
COMMENT ON COLUMN lojas.detalhes IS 'Coluna com os detalhes dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Coluna com as imagens dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Coluna com identificador de mídia da imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Coluna com os tipos de arquivos que a as imagens estão. ';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Coluna com o charset das imagens.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Coluna com a data da ultima atualização da imagem do produto.';


CREATE TABLE lojas.lojas (
                loja_id NUMERIC(38) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                endereço_web VARCHAR(100),
                endereço_fisico VARCHAR(512),
                latitude NUMERIC,
                longitude NUMERIC,
                logo BYTEA,
                logo_mime_type VARCHAR(512),
                logo_arquivo VARCHAR(512),
                logo_charset VARCHAR(512),
                logo_ultima_atualizacao DATE,
                CONSTRAINT loja_id PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas.lojas IS 'Tabela com informaçoes das lojas';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Coluna com o ID de identificação das lojas.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Coluna com o nome das lojas.';
COMMENT ON COLUMN lojas.lojas.endereço_web IS 'Coluna com infomação do endereço de web da loja.';
COMMENT ON COLUMN lojas.lojas.endereço_fisico IS 'Coluna com informações do endereço físico da loja.';
COMMENT ON COLUMN lojas.sql.lojas.latitude IS 'Coluna com informação da posição de latitude da loja.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Coluna com informação da posição de longitude da loja.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Coluna com a logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Coluna com a identificar da logo.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Coluna com o tipo de arquivo da logo.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Coluna com o charset da logo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Coluna com a data da ultima atualização da logo.';


CREATE TABLE lojas.estoques (
                estoque_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                CONSTRAINT estoques_id PRIMARY KEY (estoque_id)
);
COMMENT ON TABLE lojas.estoques IS 'Tabela com os estoques das lojas.';
COMMENT ON COLUMN lojas.estoques.estoque_id IS 'Coluna com ID de identificação dos estoques.';
COMMENT ON COLUMN lojas.estoques.loja_id IS 'Coluna com o ID de identificação das lojas.';
COMMENT ON COLUMN lojas.estoques.produto_id IS 'Coluna com o ID identificador dos produtos.';
COMMENT ON COLUMN lojas.estoques.quantidade IS 'Coluna que mostra informação da quantidade de estoque.';


CREATE TABLE lojas.clientes (
                cliente_id NUMERIC(38) NOT NULL,
                email VARCHAR(255) NOT NULL,
                nome VARCHAR(255) NOT NULL,
                telefone VARCHAR(20),
                telefone2 VARCHAR(20),
                telefone3 VARCHAR(20),
                CONSTRAINT cliente_id PRIMARY KEY (cliente_id)
);
COMMENT ON TABLE lojas.clientes IS 'Tabela com informação dos clientes';
COMMENT ON COLUMN lojas.clientes.cliente_id IS 'Coluna que é a primary key da tabela, com o ID dos clientes da loja';
COMMENT ON COLUMN lojas.clientes.email IS 'Coluna com os emails dos clientes da loja';
COMMENT ON COLUMN lojas.clientes.nome IS 'Coluna com os nomes dos clientes da loja.';
COMMENT ON COLUMN lojas.clientes.telefone IS 'Coluna com os números de telefone dos clientes.';
COMMENT ON COLUMN lojas.clientes.telefone2 IS 'Coluna com os segundos números de telefone dos clientes para meio de contato';
COMMENT ON COLUMN lojas.clientes.telefone3 IS 'Coluna com o terceiro número de contato com o cliente.';


CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereço_entrega VARCHAR(512) NOT NULL,
                status VARCHAR(15) NOT NULL,
                CONSTRAINT envio_id PRIMARY KEY (envio_id)
);
COMMENT ON TABLE lojas.envios IS 'Tabela com as informações dos envios que as lojas fizeram para os clientes.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Coluna com ID identificador do envio que a loja fez.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Coluna com o ID de identificação das lojas.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Coluna que é a primary key da tabela, com o ID dos clientes da loja';
COMMENT ON COLUMN lojas.envios.endereço_entrega IS 'Coluna com as informações dos endereços que devem ser entregues os pedidos.';
COMMENT ON COLUMN lojas.envios.status IS 'Coluna com os status dos envios.';


CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT cliente_id PRIMARY KEY (pedido_id)
);
COMMENT ON TABLE lojas.pedidos IS 'Tabela com as informações dos pedidos dos clientes e das lojas utilizadas.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Primary key da coluna, com objetivo de identificar o ID do pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Coluna com a data e hora da realizaçao do pedido ';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Coluna que é a primary key da tabela, com o ID dos clientes da loja';
COMMENT ON COLUMN lojas.pedidos.status IS 'Coluna com os status do pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Coluna com o ID de identificação das lojas.';


CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preço_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY (pedido_id, produto_id)
);
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela com os pedidos dos itens.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Primary key da coluna, com objetivo de identificar o ID do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Coluna com o ID identificador dos produtos.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Coluna com os números da linha do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preço_unitario IS 'Coluna com o preço dos preços dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Coluna com a quantidade de itens pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Coluna com ID identificador do envio que a loja fez.';


ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

