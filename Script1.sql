CREATE SCHEMA IF NOT EXISTS `RepassaAí` DEFAULT CHARACTER SET utf8 ;
USE `RepassaAí` ;

CREATE TABLE IF NOT EXISTS `RepassaAí`.`DOADOR` (
  `CPF` VARCHAR(13) NOT NULL,
  `NOME` VARCHAR(60) NOT NULL,
  `EMAIL` VARCHAR(100) NOT NULL,
  `SENHA` CHAR(32) NOT NULL,
  `PONTUAÇÃO` INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`CPF`))
ENGINE = InnoDB;

INSERT INTO DOADOR (CPF, NOME, EMAIL, SENHA) VALUES ('73098728812', 'Alice Paiva', 'paiva.alice@gmail.com', MD5('LuaMarte')),
													('55012636888', 'Gilberto Gil', 'gilbertinho@gmail.com', MD5('RioDeJaneiro3')),
													('59089059842', 'Gustavo Manocchio', 'manocchio@hotmail.com', MD5('pipoca12')),
													('43128078826', 'Carlos Alberto', 'carlos@gmail.com', MD5('carlithos')),
													('45025749814', 'Giovana Pires', 'gi.pires@yahoo.com', MD5('piressss7')),
													('69048967829', 'José Carvalho', 'zecarvalho@gmail.com', MD5('9087xx')),
													('72848888800', 'Roberta Miranda', 'robertxlinda@gmail.com', MD5('vaitimao6')), 
													('12345678890', 'Damaris Souza', 'damaso@hotmail.com', MD5('lalaland20')),
													('67089446879', 'Cláudio Salles', 'salles.clau@gmail.com', MD5('maria78linda')),
													('23090891293', 'João Jacques', 'jacques1000@hotmail.com', MD5('maca0091'));
                                                              
select * from DOADOR;



CREATE TABLE IF NOT EXISTS `RepassaAí`.`ENDEREÇO` (
  `CEP` CHAR(8) NOT NULL,
  `RUA` VARCHAR(100) NOT NULL,
  `NÚMERO` INT NOT NULL,
  `COMPLEMENTO` VARCHAR(10) DEFAULT NULL,
  PRIMARY KEY (`CEP`))
ENGINE = InnoDB;

INSERT INTO ENDEREÇO (CEP, RUA, NÚMERO) VALUES('02111031', 'Rua Itauna', 1050),
					                          ('02232050', 'Rua Cap. Busse', 206);
                           
select * from ENDEREÇO;


CREATE TABLE IF NOT EXISTS `RepassaAí`.`ORGANIZAÇÃO` (
  `CNPJ` VARCHAR(15) NOT NULL,
  `NOME` VARCHAR(60) NOT NULL,
  `TELEFONE` INT NOT NULL,
  `EMAIL` VARCHAR(100) NOT NULL,
  `SENHA` CHAR(32) NOT NULL,
  `CEP` CHAR(8) NULL,
  PRIMARY KEY (`CNPJ`),
  INDEX `fk_ORGANIZAÇÃO_ENDEREÇO1_idx` (`CEP` ASC),
  CONSTRAINT `fk_ORGANIZAÇÃO_ENDEREÇO1`
    FOREIGN KEY (`CEP`)
    REFERENCES `RepassaAí`.`ENDEREÇO` (`CEP`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


INSERT INTO ORGANIZAÇÃO (CNPJ, NOME, TELEFONE, EMAIL, SENHA, CEP) VALUES ('900500700800', 'Capela São Joaquim', 22421508, 'capsaoj@gmail.com', MD5('saoJoaquim299'), '02111031'),
																	     ('398029304809', 'Ajudando Todos', 23456097, 'ajudtodos@hotmail.com', MD5('melhorongsmp'), '02232050');

SELECT CNPJ, CEP from ORGANIZAÇÃO;

SELECT * FROM ORGANIZAÇÃO;


CREATE TABLE IF NOT EXISTS `RepassaAí`.`TIPO_DOAÇÃO` (
  `CÓDIGO` INT NOT NULL auto_increment,
  `TIPO` VARCHAR(45) NOT NULL,
  `PONTUAÇÃO` INT NOT NULL,
  PRIMARY KEY (`CÓDIGO`))
ENGINE = InnoDB;

INSERT INTO TIPO_DOAÇÃO (TIPO, PONTUAÇÃO) VALUES ('Alimentos', 5),
											     ('Higiene Pessoal', 4),
												 ('Roupas', 4), 
											     ('Móveis', 4), 
											     ('Material Escolar', 3),
											     ('Livros', 3), 
											     ('Eletrônicos', 2);
                                               
SELECT * FROM TIPO_DOAÇÃO;


CREATE TABLE IF NOT EXISTS `RepassaAí`.`DOAÇÕES_ACEITAS` (
  `CÓDIGO` INT NOT NULL,
  `CNPJ` VARCHAR(15) NOT NULL,
  INDEX `fk_TIPO_DOAÇÃO_has_ORGANIZAÇÃO_ORGANIZAÇÃO1_idx` (`CNPJ` ASC),
  INDEX `fk_TIPO_DOAÇÃO_has_ORGANIZAÇÃO_TIPO_DOAÇÃO_idx` (`CÓDIGO` ASC),
  CONSTRAINT `fk_TIPO_DOAÇÃO_has_ORGANIZAÇÃO_TIPO_DOAÇÃO`
    FOREIGN KEY (`CÓDIGO`)
    REFERENCES `RepassaAí`.`TIPO_DOAÇÃO` (`CÓDIGO`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_TIPO_DOAÇÃO_has_ORGANIZAÇÃO_ORGANIZAÇÃO1`
    FOREIGN KEY (`CNPJ`)
    REFERENCES `RepassaAí`.`ORGANIZAÇÃO` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO DOAÇÕES_ACEITAS (CNPJ, CÓDIGO) VALUES ('900500700800', 1),
                                                  ('900500700800', 2), 
                                                  ('398029304809', 2),
                                                  ('398029304809', 4),
                                                  ('398029304809', 5);

SELECT * FROM DOAÇÕES_ACEITAS;

CREATE TABLE IF NOT EXISTS `RepassaAí`.`DOAÇÃO` (
  `PRODUTO` VARCHAR(45) NOT NULL,
  `QUANTIDADE` VARCHAR(45) NOT NULL,
  `CPF` VARCHAR(13) NOT NULL,
  `CNPJ` VARCHAR(15) NOT NULL,
  `DATA` DATE NOT NULL,
  `UNIDADE_MEDIDA` ENUM('kg', 'caixa(s)', 'peça(s)', 'g', 'pacote(s)') NOT NULL,
  INDEX `fk_DOAÇÃO_DOADOR1_idx` (`CPF` ASC),
  INDEX `fk_DOAÇÃO_ORGANIZAÇÃO1_idx` (`CNPJ` ASC),
  CONSTRAINT `fk_DOAÇÃO_DOADOR1`
    FOREIGN KEY (`CPF`)
    REFERENCES `RepassaAí`.`DOADOR` (`CPF`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DOAÇÃO_ORGANIZAÇÃO1`
    FOREIGN KEY (`CNPJ`)
    REFERENCES `RepassaAí`.`ORGANIZAÇÃO` (`CNPJ`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO DOAÇÃO(CPF, CNPJ, DATA, PRODUTO, QUANTIDADE, UNIDADE_MEDIDA) VALUES ('59089059842', '900500700800', '2019-09-17', 'Arroz', 5, 'kg');

SELECT * FROM DOAÇÃO;