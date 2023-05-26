-- Apagando SCHEMAS criados com o mesmo nome caso existam / Banco de dados com mesmo nome caso existam / usuários com mesmo nome caso existam--

 DROP SCHEMA lojas CASCADE;
 DROP DATABASE IF EXISTS uvv;
 DROP USER  IF EXISTS giovanni;
 
 -- Criação do usuário que irá manipular o banco de dados uvv--
 CREATE  USER giovanni WITH
 ENCRYPTED PASSWORD 'psete'
 CREATEDB CREATEROLE login;

--Criação do Banco de Dados UVV--
  CREATE DATABASE uvv
  OWNER = giovanni
  TEMPLATE = template0
  encoding = UTF8
  LC_COLLATE = 'pt_BR.UTF-8'
  LC_CTYPE = 'pt_BR.UTF-8'
  ALLOW_CONNECTIONS = true;
 
  \c "host=localhost dbname=uvv user=giovanni password=psete"
  
 --Criação da SCHEMA e alterando ela para o OWNER giovanni--
  CREATE SCHEMA lojas;
  ALTER SCHEMA lojas OWNER TO giovanni;
  --Criação da tabela produtos, tendo comentários sobre a tabela e sobre as colunas--
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
    CONSTRAINT produto_id_pk PRIMARY KEY (produto_id)
);
COMMENT ON TABLE lojas.produtos IS 'Tabela com as informações dos produtos, como nome e preço.';
COMMENT ON COLUMN lojas.produtos.produto_id IS 'Coluna com o ID identificador dos produtos.';
COMMENT ON COLUMN lojas.produtos.nome IS 'Coluna com os nomes dos produtos.';
COMMENT ON COLUMN lojas.produtos.preco_unitario IS 'Coluna com o preço dos produtos.';
COMMENT ON COLUMN lojas.produtos.detalhes IS 'Coluna com os detalhes dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem IS 'Coluna com as imagens dos produtos.';
COMMENT ON COLUMN lojas.produtos.imagem_mime_type IS 'Coluna com identificador de mídia da imagem.';
COMMENT ON COLUMN lojas.produtos.imagem_arquivo IS 'Coluna com os tipos de arquivos que as imagens estão.';
COMMENT ON COLUMN lojas.produtos.imagem_charset IS 'Coluna com o charset das imagens.';
COMMENT ON COLUMN lojas.produtos.imagem_ultima_atualizacao IS 'Coluna com a data da última atualização da imagem do produto.';
 --Criação das tabelas lojas com comentários sobre as colunas e a tabela em si--
 CREATE TABLE lojas.lojas (
    loja_id NUMERIC(38) NOT NULL,
    nome VARCHAR(255) NOT NULL,
    endereco_web VARCHAR(100),
    endereco_fisico VARCHAR(512),
    latitude NUMERIC,
    longitude NUMERIC,
    logo BYTEA,
    logo_mime_type VARCHAR(512),
    logo_arquivo VARCHAR(512),
    logo_charset VARCHAR(512),
    logo_ultima_atualizacao DATE,
    CONSTRAINT loja_id_pk PRIMARY KEY (loja_id)
);
COMMENT ON TABLE lojas.lojas IS 'Tabela com informações das lojas.';
COMMENT ON COLUMN lojas.lojas.loja_id IS 'Coluna com o ID de identificação das lojas.';
COMMENT ON COLUMN lojas.lojas.nome IS 'Coluna com o nome das lojas.';
COMMENT ON COLUMN lojas.lojas.endereco_web IS 'Coluna com informação do endereço web da loja.';
COMMENT ON COLUMN lojas.lojas.endereco_fisico IS 'Coluna com informações do endereço físico da loja.';
COMMENT ON COLUMN lojas.lojas.latitude IS 'Coluna com informação da posição de latitude da loja.';
COMMENT ON COLUMN lojas.lojas.longitude IS 'Coluna com informação da posição de longitude da loja.';
COMMENT ON COLUMN lojas.lojas.logo IS 'Coluna com a logo da loja.';
COMMENT ON COLUMN lojas.lojas.logo_mime_type IS 'Coluna com a identificação da logo.';
COMMENT ON COLUMN lojas.lojas.logo_arquivo IS 'Coluna com o tipo de arquivo da logo.';
COMMENT ON COLUMN lojas.lojas.logo_charset IS 'Coluna com o charset da logo.';
COMMENT ON COLUMN lojas.lojas.logo_ultima_atualizacao IS 'Coluna com a data da última atualização da logo.';
 --Criação da tabela estoques com comentários das colunas e da tabela--
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

 --Criação da tabela clientes com comentários das colunas e da tabela--
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

  --Criação da tabela de envios com os comentários da coluna e da tabela--
 CREATE TABLE lojas.envios (
                envio_id NUMERIC(38) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                endereco_entrega VARCHAR(512) NOT NULL,
                status_envios VARCHAR(15) NOT NULL,
                 CONSTRAINT fk_envios_lojas FOREIGN KEY (loja_id) REFERENCES lojas.lojas (loja_id) ON DELETE NO ACTION ON UPDATE NO ACTION,
                 CONSTRAINT envios_pk PRIMARY KEY (envio_id),
                 CONSTRAINT chk_envios_status CHECK (status_envios IN ('ENVIADO', 'CRIADO', 'TRANSITO', 'ENTREGUE'))
);
COMMENT ON TABLE lojas.envios IS 'Tabela com as informações dos envios que as lojas fizeram para os clientes.';
COMMENT ON COLUMN lojas.envios.envio_id IS 'Coluna com ID identificador do envio que a loja fez.';
COMMENT ON COLUMN lojas.envios.loja_id IS 'Coluna com o ID de identificação das lojas.';
COMMENT ON COLUMN lojas.envios.cliente_id IS 'Coluna que é a primary key da tabela, com o ID dos clientes da loja';
COMMENT ON COLUMN lojas.envios.endereco_entrega IS 'Coluna com as informações dos endereços que devem ser entregues os pedidos.';
COMMENT ON COLUMN lojas.envios.status_envios IS 'Coluna com os status dos envios.';

 --Criação da tabela de pedidos com o comentário da tabela e das colunas--
 CREATE TABLE lojas.pedidos (
                pedido_id NUMERIC(38) NOT NULL,
                data_hora TIMESTAMP NOT NULL,
                cliente_id NUMERIC(38) NOT NULL,
                status_pedido VARCHAR(15) NOT NULL,
                loja_id NUMERIC(38) NOT NULL,
                CONSTRAINT cliente_id PRIMARY KEY (pedido_id),
                CONSTRAINT chk_status_pedido CHECK (status_pedido IN ('CANCELADO','COMPLETO','ABERTO','PAGO','REEMBOLSADO','ENVIADO'))
);

COMMENT ON TABLE lojas.pedidos IS 'Tabela com as informações dos pedidos dos clientes e das lojas utilizadas.';
COMMENT ON COLUMN lojas.pedidos.pedido_id IS 'Primary key da coluna, com objetivo de identificar o ID do pedido.';
COMMENT ON COLUMN lojas.pedidos.data_hora IS 'Coluna com a data e hora da realizaçao do pedido ';
COMMENT ON COLUMN lojas.pedidos.cliente_id IS 'Coluna que é a primary key da tabela, com o ID dos clientes da loja';
COMMENT ON COLUMN lojas.pedidos.status_pedido IS 'Coluna com os status do pedido';
COMMENT ON COLUMN lojas.pedidos.loja_id IS 'Coluna com o ID de identificação das lojas.';
 --Criação da tabela pedidos_itens com os comentários da tabela e das colunas--
 CREATE TABLE lojas.pedidos_itens (
                pedido_id NUMERIC(38) NOT NULL,
                produto_id NUMERIC(38) NOT NULL,
                numero_da_linha NUMERIC(38) NOT NULL,
                preco_unitario NUMERIC(10,2) NOT NULL,
                quantidade NUMERIC(38) NOT NULL,
                envio_id NUMERIC(38) NOT NULL,
                CONSTRAINT pedido_id PRIMARY KEY ( pedido_id,produto_id)
);
COMMENT ON TABLE lojas.pedidos_itens IS 'Tabela com os pedidos dos itens.';
COMMENT ON COLUMN lojas.pedidos_itens.pedido_id IS 'Primary key da coluna, com objetivo de identificar o ID do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.produto_id IS 'Coluna com o ID identificador dos produtos.';
COMMENT ON COLUMN lojas.pedidos_itens.numero_da_linha IS 'Coluna com os números da linha do pedido.';
COMMENT ON COLUMN lojas.pedidos_itens.preco_unitario IS 'Coluna com o preço dos preços dos pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.quantidade IS 'Coluna com a quantidade de itens pedidos.';
COMMENT ON COLUMN lojas.pedidos_itens.envio_id IS 'Coluna com ID identificador do envio que a loja fez.';

--A FK produto_id foi adicionada na tabela de pedidos_itens
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT produtos_pedidos_itens_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--A FK do produto_id foi adicionada na tabela de estoques--
ALTER TABLE lojas.estoques ADD CONSTRAINT produtos_estoques_fk
FOREIGN KEY (produto_id)
REFERENCES lojas.produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--A FK loja_id foi adicionada na tabela pedidos--
ALTER TABLE lojas.pedidos ADD CONSTRAINT lojas_pedidos_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--A FK loja_id foi adicionada na tabela envios--
ALTER TABLE lojas.envios ADD CONSTRAINT lojas_envios_fk
FOREIGN KEY (loja_id)
REFERENCES lojas.lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--A Fk loja_id foi adicionada na tabela estoques
ALTER TABLE lojas.estoques ADD CONSTRAINT lojas_estoques_fk
FOREIGN KEY (loja_id)
REFERENCES lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--A FK cliente_id foi adicionada na tabela pedidos--
ALTER TABLE lojas.pedidos ADD CONSTRAINT clientes_pedidos_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--A FK envios foi adicionada na tabela envios--
ALTER TABLE lojas.envios ADD CONSTRAINT clientes_envios_fk
FOREIGN KEY (cliente_id)
REFERENCES lojas.clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--A Fk envio_id foi adicionada na tabela pedidos_itens--
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT envios_pedidos_itens_fk
FOREIGN KEY (envio_id)
REFERENCES lojas.envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
--A Fk pedido_id foi adicionada na tabela pedidos_itens
ALTER TABLE lojas.pedidos_itens ADD CONSTRAINT pedidos_pedidos_itens_fk
FOREIGN KEY (pedido_id)
REFERENCES lojas.pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

  
