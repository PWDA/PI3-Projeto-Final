DROP DATABASE PWDA;
CREATE DATABASE IF NOT EXISTS PWDA;
USE PWDA;

CREATE TABLE IF NOT EXISTS TB_EMPRESA (

PK_ID BIGINT NOT NULL AUTO_INCREMENT,
EMPRESA VARCHAR(80),
DIRETOR VARCHAR(80),
NR_CNPJ CHAR(30),
ENDERECO VARCHAR(120),
BAIRRO VARCHAR(60),
CIDADE VARCHAR(60),
UF CHAR(2),
CEP CHAR(9),
TELEFONE VARCHAR(80),
EMAIL VARCHAR(150),
TG_INATIVO TINYINT DEFAULT 0,
DH_INCLUSAO DATETIME,
DH_ALTERACAO DATETIME,
PRIMARY KEY (PK_ID)

);


CREATE TABLE IF NOT EXISTS TB_FUNCIONARIO (

PK_ID BIGINT NOT NULL AUTO_INCREMENT,
NOME  VARCHAR(100),
NRDOC CHAR(30),
TELEFONE VARCHAR(80),
DT_NASCIMENTO DATE NULL,
NACIONALIDADE CHAR(2),
ENDERECO VARCHAR(120),
BAIRRO VARCHAR(60),
CIDADE VARCHAR(80),
UF CHAR(2),
CEP CHAR(9),
EMAIL VARCHAR(150),
SEXO VARCHAR(15),
DEPARTAMENTO VARCHAR(100),
CARGO VARCHAR(100),
FK_EMPRESA BIGINT NOT NULL,
TG_PESSOA CHAR(1),
TG_INATIVO TINYINT DEFAULT 0,
DH_INCLUSAO DATETIME,
DH_ALTERACAO DATETIME,
PRIMARY KEY (PK_ID),
FOREIGN KEY (FK_EMPRESA) REFERENCES TB_EMPRESA (PK_ID)
);


CREATE TABLE IF NOT EXISTS TS_LOGIN ( 

PK_ID BIGINT NOT NULL AUTO_INCREMENT,
LOGIN VARCHAR(150),
SENHA VARCHAR(150),
PERMISSAO VARCHAR(60),
EMPRESA VARCHAR(60),
FK_FUNCIONARIO BIGINT NOT NULL,
DH_INCLUSAO DATETIME,
DH_ALTERACAO DATETIME,
TG_INATIVO TINYINT DEFAULT 0,
PRIMARY KEY (PK_ID),
FOREIGN KEY (FK_FUNCIONARIO) REFERENCES TB_FUNCIONARIO ( PK_ID )
);

CREATE TABLE IF NOT EXISTS TB_CLIENTE (

PK_ID BIGINT NOT NULL AUTO_INCREMENT,
NOME  VARCHAR(100),
NRDOC CHAR(30),
ENDERECO VARCHAR(120),
UF CHAR(2),
CIDADE VARCHAR(80),
BAIRRO VARCHAR(60),
CEP CHAR(9),
TELEFONE VARCHAR(80),
EMAIL VARCHAR(150),
TG_PESSOA CHAR(1),
TG_INATIVO TINYINT DEFAULT 0,
DH_INCLUSAO DATETIME,
DH_ALTERACAO DATETIME,
PRIMARY KEY (PK_ID)
);


CREATE TABLE IF NOT EXISTS TB_PRODUTO (

PK_ID BIGINT NOT NULL AUTO_INCREMENT,
PRODUTO  VARCHAR(100),
TIPOPROD VARCHAR(60),
QUANTIDADE NUMERIC(6),
ORIGEM VARCHAR(150),
VL_UNITARIO DECIMAL(13,2),
DESCRICAO TEXT,
TG_INATIVO TINYINT DEFAULT 0,
DH_INCLUSAO DATETIME,
DH_ALTERACAO DATETIME,
PRIMARY KEY (PK_ID)
);


CREATE TABLE IF NOT EXISTS FI_VENDA (

PK_ID BIGINT NOT NULL AUTO_INCREMENT,
FK_CLIENTE BIGINT NOT NULL,
FK_VENDEDOR BIGINT NOT NULL,
FK_EMPRESA BIGINT NOT NULL,
VL_TOTAL DECIMAL(13,2),
QUANTIDADE NUMERIC(6),
TG_INATIVO TINYINT DEFAULT 0,
DH_INCLUSAO DATETIME,
DH_ALTERACAO DATETIME,
PRIMARY KEY (PK_ID),
FOREIGN KEY (FK_CLIENTE) REFERENCES TB_CLIENTE (PK_ID),
FOREIGN KEY (FK_EMPRESA) REFERENCES TB_EMPRESA (PK_ID),
FOREIGN KEY (FK_VENDEDOR) REFERENCES TS_LOGIN (PK_ID)
);


CREATE TABLE IF NOT EXISTS FI_ITEMVENDA (

PK_ID BIGINT NOT NULL AUTO_INCREMENT,
FK_VENDA BIGINT NOT NULL,
FK_PRODUTO BIGINT NOT NULL,
TG_INATIVO TINYINT DEFAULT 0,
DH_INCLUSAO DATETIME,
DH_ALTERACAO DATETIME,
PRIMARY KEY (PK_ID),
FOREIGN KEY (FK_VENDA) REFERENCES FI_VENDA ( PK_ID ),
FOREIGN KEY (FK_PRODUTO) REFERENCES TB_PRODUTO ( PK_ID )

);
-- EMPRESA
INSERT INTO TB_EMPRESA(EMPRESA,DIRETOR,NR_CNPJ,ENDERECO,BAIRRO,CIDADE,UF,CEP,TELEFONE,EMAIL,TG_INATIVO,DH_INCLUSAO)
VALUES('PWDA-SÃO PAULO','DIRETOR','69229871000188','ENDERECO 1','BAIRRO 1','CIDADE 1','UF','00000000','55554444','PWDASP@HOTMAIL.COM',0,NOW());
INSERT INTO TB_EMPRESA(EMPRESA,DIRETOR,NR_CNPJ,ENDERECO,BAIRRO,CIDADE,UF,CEP,TELEFONE,EMAIL,TG_INATIVO,DH_INCLUSAO)
VALUES('PWDA-RIO DE JANEIRO','DIRETOR 2','69229871000188','ENDERECO 1','BAIRRO 1','CIDADE 1','UF','00000000','55554444','PWDARJ@HOTMAIL.COM',0,NOW());
INSERT INTO TB_EMPRESA(EMPRESA,DIRETOR,NR_CNPJ,ENDERECO,BAIRRO,CIDADE,UF,CEP,TELEFONE,EMAIL,TG_INATIVO,DH_INCLUSAO)
VALUES('PWDA-BAHIA','DIRETOR 3','69229871000188','ENDERECO 1','BAIRRO 1','CIDADE 1','UF','00000000','55554444','PWDABH@HOTMAIL.COM',0,NOW());
INSERT INTO TB_EMPRESA(EMPRESA,DIRETOR,NR_CNPJ,ENDERECO,BAIRRO,CIDADE,UF,CEP,TELEFONE,EMAIL,TG_INATIVO,DH_INCLUSAO)
VALUES('PWDA-CAMPINA GRANDE','DIRETOR 4','69229871000188','ENDERECO 1','BAIRRO 1','CIDADE 1','UF','00000000','55554444','PWDACG@HOTMAIL.COM',0,NOW());
INSERT INTO TB_EMPRESA(EMPRESA,DIRETOR,NR_CNPJ,ENDERECO,BAIRRO,CIDADE,UF,CEP,TELEFONE,EMAIL,TG_INATIVO,DH_INCLUSAO)
VALUES('PWDA-JOINVILLE','DIRETOR 5','69229871000188','ENDERECO 1','BAIRRO 1','CIDADE 1','UF','00000000','55554444','PWDAJO@HOTMAIL.COM',0,NOW());
-- FUNCIONARIO
INSERT INTO TB_FUNCIONARIO (NOME, NRDOC, TELEFONE, DT_NASCIMENTO, NACIONALIDADE, ENDERECO, BAIRRO,CIDADE, UF, CEP, EMAIL,FK_EMPRESA, SEXO, DEPARTAMENTO, CARGO, DH_INCLUSAO, TG_INATIVO)
VALUES ('DIRETOR', '0000000000000', '0000000000', NOW(), 'BR', 'ENDERECO 1', 'BAIRRO 1', 'CIDADE 1', 'SP', '000000', 'DIRETOR@HOTMAIL.COM',1, 'M', 'DIRETORIA', 'DIRETOR', NOW(), 0);
-- FUNCIONARIO
INSERT INTO TB_FUNCIONARIO (NOME, NRDOC, TELEFONE, DT_NASCIMENTO, NACIONALIDADE, ENDERECO, BAIRRO,CIDADE, UF, CEP, EMAIL,FK_EMPRESA, SEXO, DEPARTAMENTO, CARGO, DH_INCLUSAO, TG_INATIVO)
VALUES ('DARLAN', '38110325858', '55556666', NOW(), 'BR', 'ENDERECO 2', 'BAIRRO 2', 'CIDADE 2', 'SP', '000000', 'DARLAN@HOTMAIL.COM',1, 'Masculino', 'Desenvolvimento', 'Tecnico', NOW(), 0);

-- CLIENTE
INSERT INTO TB_CLIENTE (NOME, NRDOC, ENDERECO, UF, CIDADE, BAIRRO, CEP, TELEFONE, EMAIL, TG_PESSOA, TG_INATIVO, DH_INCLUSAO)
VALUES('DARLAN','36552519044', 'ENDERECO 1', 'UF', 'CIDADE 1', 'BAIRRO 1', '00000000','55554444','DARLAN@HOTMAIL.COM','F',0,NOW());

INSERT INTO TB_CLIENTE (NOME, NRDOC, ENDERECO, UF, CIDADE, BAIRRO, CEP, TELEFONE, EMAIL, TG_PESSOA, TG_INATIVO, DH_INCLUSAO)
VALUES('WESLEY','50261857037', 'ENDERECO 2', 'UF', 'CIDADE 2', 'BAIRRO 2', '00000000','55554444','WESLEY@HOTMAIL.COM','F',0,NOW());

INSERT INTO TB_CLIENTE (NOME, NRDOC, ENDERECO, UF, CIDADE, BAIRRO, CEP, TELEFONE, EMAIL, TG_PESSOA, TG_INATIVO, DH_INCLUSAO)
VALUES('ALISON LTDA','02111092000102', 'ENDERECO 3', 'UF', 'CIDADE 3', 'BAIRRO 3', '00000000','55554444','ALISON@HOTMAIL.COM','J',0,NOW());
-- LOGIN
INSERT INTO TS_LOGIN (LOGIN, SENHA, PERMISSAO, EMPRESA, FK_FUNCIONARIO, DH_INCLUSAO,TG_INATIVO)
VALUES ('DIRETOR', '$2a$10$Ky/EnXKD9GPjaPpdHwsxauVGITi54Iuqd6xRSivoYaa.tKcfIUMIW', 'DIRETOR', 'PWDA SÃO PAULO', 1, NOW(), 0);
-- LOGIN
INSERT INTO TS_LOGIN (LOGIN, SENHA, PERMISSAO, EMPRESA, FK_FUNCIONARIO, DH_INCLUSAO,TG_INATIVO)
VALUES ('DARLAN', '$2a$10$Ky/EnXKD9GPjaPpdHwsxauVGITi54Iuqd6xRSivoYaa.tKcfIUMIW', 'Técnico', 'PWDA SÃO PAULO', 1, NOW(), 0);
-- PRODUTOS
INSERT INTO TB_PRODUTO (PRODUTO, TIPOPROD, QUANTIDADE, ORIGEM, VL_UNITARIO, DESCRICAO, TG_INATIVO, DH_INCLUSAO)
VALUES ('ZENFONE 4','ATIVO CIRCULANTE', 500,'SÃO PAULO',1268,'DESCRIÇÃO',0,NOW());
INSERT INTO TB_PRODUTO (PRODUTO, TIPOPROD, QUANTIDADE, ORIGEM, VL_UNITARIO, DESCRICAO, TG_INATIVO, DH_INCLUSAO)
VALUES ('Computador Hawkeye Intel Core I3 4GB HD 500GB','ATIVO CIRCULANTE', 500, 'SÃO PAULO',1299,'DESCRIÇÃO',0,NOW());
INSERT INTO TB_PRODUTO (PRODUTO, TIPOPROD, QUANTIDADE, ORIGEM, VL_UNITARIO, DESCRICAO, TG_INATIVO, DH_INCLUSAO)
VALUES ('Apple iPad Prata','ATIVO CIRCULANTE', 500,'SÃO PAULO',2500,'DESCRIÇÃO',0,NOW());
INSERT INTO TB_PRODUTO (PRODUTO, TIPOPROD, QUANTIDADE, ORIGEM, VL_UNITARIO, DESCRICAO, TG_INATIVO, DH_INCLUSAO)
VALUES ('Monitor LG 29 Full HD','ATIVO CIRCULANTE', 500, 'SÃO PAULO',1599,'DESCRIÇÃO',0,NOW());
INSERT INTO TB_PRODUTO (PRODUTO, TIPOPROD, QUANTIDADE, ORIGEM, VL_UNITARIO, DESCRICAO, TG_INATIVO, DH_INCLUSAO)
VALUES ('Smartphone Samsung Galaxy S8','ATIVO CIRCULANTE', 500, 'SÃO PAULO',1299,'DESCRIÇÃO',0,NOW());
-- VENDAS
INSERT INTO FI_VENDA(FK_CLIENTE, FK_VENDEDOR, FK_EMPRESA, VL_TOTAL, QUANTIDADE, TG_INATIVO, DH_INCLUSAO)
VALUES(1,1,1,7500,3,0,NOW());
INSERT INTO FI_VENDA(FK_CLIENTE, FK_VENDEDOR, FK_EMPRESA, VL_TOTAL, QUANTIDADE, TG_INATIVO, DH_INCLUSAO)
VALUES(2,1,1,2898,2,0,NOW());
INSERT INTO FI_VENDA(FK_CLIENTE, FK_VENDEDOR, FK_EMPRESA, VL_TOTAL, QUANTIDADE, TG_INATIVO, DH_INCLUSAO)
VALUES(3,1,1,4197,3,0,NOW());
INSERT INTO FI_VENDA(FK_CLIENTE, FK_VENDEDOR, FK_EMPRESA, VL_TOTAL, QUANTIDADE, TG_INATIVO, DH_INCLUSAO)
VALUES(1,1,1,5072,4,0,NOW());
INSERT INTO FI_VENDA(FK_CLIENTE, FK_VENDEDOR, FK_EMPRESA, VL_TOTAL, QUANTIDADE, TG_INATIVO, DH_INCLUSAO)
VALUES(2,1,1,7500,3,0,NOW());

INSERT INTO FI_VENDA(FK_CLIENTE, FK_VENDEDOR, FK_EMPRESA, VL_TOTAL, QUANTIDADE, TG_INATIVO, DH_INCLUSAO)
VALUES(1,1,2,1299,1,0,CAST('2018-12-01 00:49:54' AS DATETIME));
INSERT INTO FI_VENDA(FK_CLIENTE, FK_VENDEDOR, FK_EMPRESA, VL_TOTAL, QUANTIDADE, TG_INATIVO, DH_INCLUSAO)
VALUES(2,1,2,1299,1,0,CAST('2018-12-01 00:49:54' AS DATETIME));

INSERT INTO FI_VENDA(FK_CLIENTE, FK_VENDEDOR, FK_EMPRESA, VL_TOTAL, QUANTIDADE, TG_INATIVO, DH_INCLUSAO)
VALUES(3,1,3,1299,1,0,CAST('2018-12-01 00:49:54' AS DATETIME));
INSERT INTO FI_VENDA(FK_CLIENTE, FK_VENDEDOR, FK_EMPRESA, VL_TOTAL, QUANTIDADE, TG_INATIVO, DH_INCLUSAO)
VALUES(3,1,3,1299,1,0,CAST('2018-12-01 00:49:54' AS DATETIME));
-- ITENS VENDA
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(1,3,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(1,4,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(1,4,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(2,4,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(2,5,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(3,4,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(3,2,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(3,2,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(4,1,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(4,1,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(4,1,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(4,1,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(5,3,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(5,3,0,NOW());
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(5,3,0,NOW());

INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(6,5,0,CAST('2018-12-01 00:49:54' AS DATETIME));
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(7,2,0,CAST('2018-12-01 00:49:54' AS DATETIME));

INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(8,5,0,CAST('2018-12-01 00:49:54' AS DATETIME));
INSERT INTO FI_ITEMVENDA(FK_VENDA,FK_PRODUTO,TG_INATIVO,DH_INCLUSAO)
VALUES(9,2,0,CAST('2018-12-01 00:49:54' AS DATETIME));
