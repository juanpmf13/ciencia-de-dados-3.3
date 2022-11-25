USE ecomerce;

SHOW TABLES;

-- inserindo clientes
DESC clients;
INSERT INTO clients(Fname,Minit,Lname,CPF,Address) 
VALUES('JOÃO','G','Maravilha','12345678912','kasildes'),
('Pedro','G','bixa','22345678912','kasildes2'),
('flavia','P','Bahiana','32345678912','kasildes')
; 
SELECT * FROM clients;

-- inserindo produto

desc product;

INSERT INTO product (Pname,pdescription,category,avaliação, valor, size)
	VALUES('Fone','produto auricular','Eletronic',4,3.9,NULL),
    ('Boneca','produto infantil','Brinquedo',10,99.9,NULL),
    ('cama','cama para casal','Moveis',8,999.9,NULL)
    ;

SELECT * FROM product;
-- inserindo orders

DESC orders;

INSERT INTO orders(idOrderClient, idOrderPayment,orderStatus, orderDescription,sendValue,paymentcash) 
	VALUE(1,NULL, DEFAULT ,'Compra presencial', 3.9, 'cartão'),
    (2,NULL, DEFAULT ,'online', 999.9, 'boleto'),
    (3,NULL, DEFAULT,'Compra presencial', 99.9, 'cartão')
    ;

SELECT * FROM orders;

-- INSERINDO product order

DESC productorder;

INSERT INTO productorder 
	VALUES(1,1,3,default),
	(2,2,5,default),
    (3,3,200,default)
    ;
    
SELECT * FROM productorder;

-- inserindo seller
desc seller;

INSERT INTO seller(socialName, abstractName,CNPJ,CPF, contact,location) 
	VALUES ("SOL BRINQUEDOS",null,'123456789012345','111111111','22312312312','Tangua'),
    ("moveis da serra",NULL,'223456789012345','211111111','32312312312','São paulo'),
    ("Eletronicos Gambiarra",NULL,'323456789012345','311111111','42312312312','C. cidade')
    ;

SELECT * FROM seller;

-- inserindo productseller

desc productseller;

INSERT INTO productseller(idPseller,idProduct,prodQuantity)   
	VALUES(1,2,100),
    (3,1,200),
    (2,3,400)
    ;

SELECT * FROM productseller;

-- INSERINDO VALORES DE productstorage

desc productstorage;

INSERT INTO productstorage(storageLocation,quantity)
	VALUES('RJ', 1000),
    ('SP',500),
    ('BH', 300)
    ;

SELECT * FROM productstorage;

-- INSERINDO EM storagelocation

INSERT INTO storagelocation(idLproduct,idLstorage,location)
	VALUES (1,1,'tangua'),
    (2,2,'25 de março'),
    (3,3,'cidade alta')
    ;

SELECT *  FROM storagelocation;


-- INSERINDO SUPPLIER
desc supplier;

INSERT INTO supplier(socialName, CNPJ, contact)
	VALUES('Helena brinquedos','333333333333333','99999999999'),
    ('marcio moveis','433333333333333','89999999999'),
    ('Rau Eletronicos','533333333333333','79999999999')
    ;

SELECT * FROM supplier;


-- inserindo em prudct supllier
desc productsupplier;

INSERT INTO productsupplier(idPsSupplier,idPsProduct,quantity)
	VALUES (3,1, 400),
    (1,2,500),
    (2,3,50)
    ;
select * from  productseller pseller, productsupplier psupplier  where pseller.idProduct=psupplier.idPsProduct order by idProduct;

select * from  productseller pseller, productsupplier psupplier  where pseller.idProduct=psupplier.idPsProduct  HAVING (prodQuantity> 150) order by idProduct ;

create VIEW JUNÇÃO AS SELECT * FROM productseller AS p  INNER JOIN productsupplier AS ps ON 	p.idProduct= ps.idPsProduct;

SELECT * FROM  JUNÇÃO;






