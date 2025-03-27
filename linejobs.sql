CREATE DATABASE linejobs;

CREATE TABLE usuario (
id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
email VARCHAR(255) UNIQUE NOT NULL,
senha VARCHAR(255) NOT NULL,
telefone VARCHAR(21) UNIQUE NOT NULL,
tipo ENUM('CANDIDATO', 'EMPRESA') NOT NULL,
data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE empresa (
id_empresa BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_usuario BIGINT UNSIGNED UNIQUE NOT NULL,
cnpj VARCHAR(18) UNIQUE NOT NULL,
razao_social VARCHAR(255) NOT NULL,
nome_empresa VARCHAR(255),
setor VARCHAR(100),
endereco TEXT,
FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE candidato (
id_candidato BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_usuario BIGINT UNSIGNED UNIQUE NOT NULL,
experiencia TEXT,
habilidades TEXT,
github VARCHAR(255) UNIQUE,
linkedin VARCHAR(255) UNIQUE,
FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE vaga (
id_vaga BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_empresa BIGINT UNSIGNED NOT NULL,
titulo VARCHAR(255) NOT NULL,
descricao TEXT NOT NULL,
requisitos TEXT,
localizacao VARCHAR(255),
modalidade VARCHAR(50),
tipo_contrato VARCHAR(50),
salario DECIMAL(10,2),
status ENUM('ABERTA', 'FECHADA') DEFAULT 'ABERTA',
data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_empresa) REFERENCES empresa(id_empresa) ON DELETE CASCADE
);

CREATE TABLE candidatura (
id_candidatura BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_candidato BIGINT UNSIGNED NOT NULL,
id_vaga BIGINT UNSIGNED NOT NULL,
status ENUM('EM_ANALISE', 'ACEITA', 'REJEITADA') DEFAULT 'EM_ANALISE',
data_aplicacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_candidato) REFERENCES candidato(id_candidato) ON DELETE CASCADE,
FOREIGN KEY (id_vaga) REFERENCES vaga(id_vaga) ON DELETE CASCADE
);

CREATE TABLE favorito (
id_favorito BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_candidato BIGINT UNSIGNED NOT NULL,
id_vaga BIGINT UNSIGNED NOT NULL,
data_favorito TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_candidato) REFERENCES candidato(id_candidato) ON DELETE CASCADE,
FOREIGN KEY (id_vaga) REFERENCES vaga(id_vaga) ON DELETE CASCADE
);

CREATE TABLE mensagem (
id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_remetente BIGINT UNSIGNED NOT NULL,
id_destinatario BIGINT UNSIGNED NOT NULL,
mensagem TEXT NOT NULL,
data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
lida BOOLEAN DEFAULT FALSE,
FOREIGN KEY (id_remetente) REFERENCES usuario(id) ON DELETE CASCADE,
FOREIGN KEY (id_destinatario) REFERENCES usuario(id) ON DELETE CASCADE
);

CREATE TABLE recuperacao_senha (
id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
id_usuario BIGINT UNSIGNED NOT NULL,
token VARCHAR(255) UNIQUE NOT NULL, -- Código único para redefinir senha
expiracao TIMESTAMP NOT NULL, -- Data de expiração do token
usado BOOLEAN DEFAULT FALSE, -- Indica se o token já foi utilizado
data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (id_usuario) REFERENCES usuario(id) ON DELETE CASCADE
);