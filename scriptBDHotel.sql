-- Script de criação do banco de dados para hotelaria com tipos de dados e relacionamentos

--  tabela hospedes
CREATE TABLE hospedes (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(150) NOT NULL,
    data_nascimento DATE NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
    sexo ENUM('M', 'F', 'Outro') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--  tabela endereco
CREATE TABLE endereco (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    hospede_id BIGINT UNSIGNED NOT NULL,
    logradouro VARCHAR(255) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    bairro VARCHAR(100) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado CHAR(2) NOT NULL,
    cep CHAR(8) NOT NULL,
    complemento VARCHAR(100),
    FOREIGN KEY (hospede_id) REFERENCES hospedes(id) ON DELETE CASCADE
);

--  tabela contato
CREATE TABLE contato (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    hospede_id BIGINT UNSIGNED NOT NULL,
    telefone VARCHAR(15) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    FOREIGN KEY (hospede_id) REFERENCES hospedes(id) ON DELETE CASCADE
);

--  tabela quartos
CREATE TABLE quartos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(5) NOT NULL UNIQUE,
    tipo ENUM('Solteiro', 'Duplo', 'Luxo', 'Presidencial') NOT NULL,
    capacidade TINYINT UNSIGNED NOT NULL,
    preco_diaria DECIMAL(10, 2) NOT NULL,
    status ENUM('Disponível', 'Ocupado', 'Manutenção') NOT NULL
);

--  tabela reservas
CREATE TABLE reservas (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    hospede_id BIGINT UNSIGNED NOT NULL,
    quarto_id BIGINT UNSIGNED NOT NULL,
    data_entrada DATETIME NOT NULL,
    data_saida DATETIME NOT NULL,
    status ENUM('Confirmada', 'Cancelada', 'Concluída') NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (hospede_id) REFERENCES hospedes(id) ON DELETE CASCADE,
    FOREIGN KEY (quarto_id) REFERENCES quartos(id) ON DELETE CASCADE
);

--  tabela servicos_adicionais
CREATE TABLE servicos_adicionais (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    preco DECIMAL(10, 2) NOT NULL
);

--  tabela hospede_servico (relacionamento N:N entre hospedes e servicos_adicionais)
CREATE TABLE hospede_servico (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    hospede_id BIGINT UNSIGNED NOT NULL,
    servico_id BIGINT UNSIGNED NOT NULL,
    data_solicitacao DATETIME NOT NULL,
    quantidade TINYINT UNSIGNED NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (hospede_id) REFERENCES hospedes(id) ON DELETE CASCADE,
    FOREIGN KEY (servico_id) REFERENCES servicos_adicionais(id) ON DELETE CASCADE
);

--  tabela pagamentos
CREATE TABLE pagamentos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    reserva_id BIGINT UNSIGNED,
    hospede_servico_id BIGINT UNSIGNED,
    metodo_pagamento ENUM('Cartão', 'Dinheiro', 'Pix', 'Boleto') NOT NULL,
    valor DECIMAL(10, 2) NOT NULL,
    data_pagamento DATETIME NOT NULL,
    status ENUM('Pago', 'Pendente', 'Cancelado') NOT NULL,
    FOREIGN KEY (reserva_id) REFERENCES reservas(id) ON DELETE CASCADE,
    FOREIGN KEY (hospede_servico_id) REFERENCES hospede_servico(id) ON DELETE CASCADE
);
