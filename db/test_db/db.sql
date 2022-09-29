--CREACION DE TABLA
CREATE TABLE account (
	account_id serial PRIMARY KEY,
	username VARCHAR (50) UNIQUE NOT NULL,
	psswd VARCHAR (50) NOT NULL,
	email VARCHAR(255) UNIQUE NOT NULL,
  profile_link VARCHAR(255),
	created_on TIMESTAMP NOT NULL,
    last_login TIMESTAMP 
);

CREATE TABLE category(
    category_id serial PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);

CREATE TABLE pdf(
    pdf_id serial PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    link VARCHAR(255) NOT NULL,
    summary VARCHAR(512) NOT NULL,
    cont_18 BOOLEAN NOT NULL,
    privacy BOOLEAN NOT NULL,
    account_id int NOT NULL,
	  category_id int NOT NULL,
    FOREIGN KEY (account_id)
      REFERENCES account (account_id) ON DELETE CASCADE,
    FOREIGN KEY (category_id)
      REFERENCES category (category_id) ON DELETE CASCADE
);

CREATE TABLE reviews(
    reviews_id serial PRIMARY KEY,
    calification INTEGER NOT NULL,
    review VARCHAR(512) NOT NULL,
    account_id int NOT NULL,
	  pdf_id int NOT NULL,
    FOREIGN KEY (account_id)
      REFERENCES account (account_id) ON DELETE CASCADE,
    FOREIGN KEY (pdf_id)
      REFERENCES pdf (pdf_id) ON DELETE CASCADE
);

CREATE TABLE readstate(
    readstate_id serial PRIMARY KEY,
    last_page INTEGER NOT NULL,
    account_id int NOT NULL,
	  pdf_id int NOT NULL,
    FOREIGN KEY (account_id)
      REFERENCES account (account_id) ON DELETE CASCADE,
    FOREIGN KEY (pdf_id)
      REFERENCES pdf (pdf_id) ON DELETE CASCADE
);

CREATE TABLE auth(
    auth_id serial PRIMARY KEY,
    account_id int NOT NULL,
	  pdf_id int NOT NULL,
    FOREIGN KEY (account_id)
      REFERENCES account (account_id) ON DELETE CASCADE,
    FOREIGN KEY (pdf_id)
      REFERENCES pdf (pdf_id) ON DELETE CASCADE
);

CREATE TABLE sub(
    sub_id serial PRIMARY KEY,
    account_id int NOT NULL,
	  follower_account_id int NOT NULL,
    FOREIGN KEY (account_id)
      		REFERENCES account (account_id) ON DELETE CASCADE,
    FOREIGN KEY (follower_account_id)
      		REFERENCES account (account_id) ON DELETE CASCADE
);

CREATE TABLE list(
    list_id serial PRIMARY KEY,
    title VARCHAR(128) NOT NULL,
    account_id int NOT NULL,
    FOREIGN KEY (account_id)
      REFERENCES account (account_id) ON DELETE CASCADE
);

CREATE TABLE content(
    content_id serial PRIMARY KEY,
    list_id int NOT NULL,
    pdf_id int NOT NULL,
    FOREIGN KEY (list_id)
      REFERENCES list (list_id) ON DELETE CASCADE,
    FOREIGN KEY (pdf_id)
      REFERENCES pdf (pdf_id) ON DELETE CASCADE
);

--DATOS DE PRUEBA
INSERT INTO account(username, psswd, email, profile_link, created_on, last_login) VALUES
	('pedro', 'pedro', 'pedro@gmail.com', 'www.google.cl', CURRENT_DATE, CURRENT_DATE),
	('juan', 'diego', 'juan@gmail.com', 'www.google.cl', CURRENT_DATE, CURRENT_DATE),
	('diego', 'juan', 'diego@gmail.com', 'www.google.cl', CURRENT_DATE, CURRENT_DATE);
	
INSERT INTO category(title) VALUES
	('deportes'),
	('juegos'),
	('musica'),
	('educacion'),
	('arte'),
	('politica')
	
INSERT INTO pdf(title, link, summary, cont_18, privacy, account_id, category_id) VALUES
	('Historia de Cristiano Ronaldo', 'cr7.com', 'Una historia sobre el mismisimo', TRUE, FALSE, 1, 1),
	('Analisis al Dark Souls', 'ds.com', 'Una critica acerca de este juego', FALSE, FALSE, 1, 2),
	('Ayudantia Intro a la Mecanica', 'fisica.cl', 'Pauta de la ayudantia de ayer', FALSE, TRUE, 2, 4),
	('Curiosidades del arte medioevo', 'arte.com', 'Lee unas increibles curiosidades sobre el arte en la edad media', FALSE, FALSE, 3, 5);
	

--CONSULTAS
----1) Mostrar Todos los PDFS publicos con info relevante
SELECT pdf.title, pdf.summary, pdf.cont_18, account.username, category.title 
FROM pdf, account, category WHERE
pdf.account_id = account.account_id AND category.category_id = pdf.category_id AND pdf.privacy = false
