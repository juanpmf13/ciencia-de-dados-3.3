-- criação de banco de dados para cenario eecomerce

-- DROP DATABASE ecomerce;

CREATE DATABASE ecomerce;
USE ecomerce;

-- criando tabela clients
CREATE TABLE Clients(
	idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Minit VARCHAR(3),
    Lname VARCHAR(20),
    CPF char(11) NOT NULL,
    Address VARCHAR(30),
    CONSTRAINT unique_cpf_client UNIQUE(CPF)
);

ALTER TABLE Clients AUTO_INCREMENT =1;

desc Clients;
-- criando tabela produto
CREATE TABLE Product(
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10) NOT NULL,
    Pdescription VARCHAR(20),
    category ENUM('Eletronic','Vestimenta','Brinquedo','Moveis')NOT NULL,
    avaliação FLOAT DEFAULT 0,
    Valor FLOAT NOT NULL,
    size VARCHAR(10)
);

-- criando tabela payment obs, depois criar tabela cartão? 

CREATE TABLE Payments(
    idPayment INT,
    typePayment ENUM('boleto', 'cartão', 'dois cartões'),
    informaçãoFormaPagamento VARCHAR(255),
    limitAvailable FLOAT,
    PRIMARY KEY( idPayment)
);
-- criando tabela pedido
--  removido temporariamente

CREATE TABLE Entrega(
	idEntrega INT PRIMARY KEY,
    entregaStatus ENUM('Entregue','Em andamento'),
    numeroRasteio VARCHAR(50)
);

CREATE TABLE Orders(
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    idOrderEntrega INT,
    idOrderPayment INT,
    orderStatus ENUM('Cancelado','Confirmado','Processamento') default 'Processamento',
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentcash ENUM('cartão','boleto','dois cartões'),
    CONSTRAINT fk_ordes_payments FOREIGN KEY(idOrderPayment) REFERENCES Payments(idPayment),
    CONSTRAINT fk_order_client FOREIGN KEY(idOrderClient) REFERENCES Clients(idClient)
			ON UPDATE CASCADE,
	CONSTRAINT fk_order_rastreio FOREIGN KEY(idOrderEntrega) REFERENCES Entrega(idEntrega)
    
);
desc Orders;

-- criando tabela estoque

CREATE TABLE productStorage(
	idProductStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT default 0
);
-- criando tabela fornecedor

CREATE TABLE supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    socialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(15)NOT NULL,
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_supplier UNIQUE (CNPJ)
);
-- criando tabela vendedor

CREATE TABLE seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
    socialName VARCHAR(255) NOT NULL,
    abstractName VARCHAR(255),
    CNPJ CHAR(15)NOT NULL,
    CPF CHAR(9) NOT NULL,
    contact CHAR(11) NOT NULL,
    location VARCHAR(255) NOT NULL,
    CONSTRAINT unique_CNPJ_seller UNIQUE (CNPJ),
    CONSTRAINT unique_CPF_supplier UNIQUE (CPF)
);
-- criando tabela produtos/Vendedor

CREATE TABLE productSeller(
	idPseller INT ,
    idProduct INT ,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY(idPseller,idProduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idProduct) REFERENCES Product(idProduct)
);

desc productSeller;

-- criando tabela produto pedido

CREATE TABLE productOrder(
	idPOproduct INT ,
    idPOorder INT ,
    prodQuantity INT DEFAULT 1,
    poStatus ENUM('Disponivel','Sem estoque') DEFAULT 'Disponivel',
    PRIMARY KEY(idPOproduct,idPOorder),
    CONSTRAINT fk_productorder_seller FOREIGN KEY (idPOproduct) REFERENCES PRODUCT(idProduct),
    CONSTRAINT fk_productorder_product FOREIGN KEY (idPOorder) REFERENCES orders(idOrder)
);


-- criando tabela produto estoque

CREATE TABLE storageLocation(
	idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_storage_location_product FOREIGN KEY (idLproduct) REFERENCES product(idProduct),
    CONSTRAINT fk_storage_location_storage FOREIGN KEY (idLstorage) REFERENCES productStorage(idProductStorage)
);

-- criando tabela produto fornecedor

CREATE TABLE productSupplier(
	idPsSupplier INT,
    idPsProduct INT,
    quantity INT NOT NULL,
    PRIMARY KEY (idPsSupplier,idPsProduct),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES supplier(idSupplier) ,
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPsProduct) REFERENCES Product(idProduct)
);

show tables;

