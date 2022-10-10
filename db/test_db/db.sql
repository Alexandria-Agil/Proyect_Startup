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

CREATE TABLE report(
    report_id serial PRIMARY KEY,
    reason VARCHAR(255) NOT NULL,
    pdf_id int NOT NULL,
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

INSERT INTO auth(account_id, pdf_id) VALUES
  (2,7)

INSERT INTO reviews(calification, review, account_id, pdf_id) VALUES
  (4, 'Esta generalmente bien', 3, 5),
  (3, 'Esta decente', 4, 5),
  (1, 'Esta muy mal todo', 2, 7)

INSERT INTO readstate(last_page, pdf_id, account_id) VALUES
  (23, 6, 2)

INSERT INTO sub(account_id, follower_account_id) VALUES
  (2, 3),
  (2, 4),
  (3, 2)

--CONSULTAS
----1) Mostrar Todos los PDFS publicos con info relevante
SELECT pdf.title, pdf.summary, pdf.cont_18, account.username, category.title 
FROM pdf, account, category WHERE
pdf.account_id = account.account_id AND category.category_id = pdf.category_id AND pdf.privacy = false

----2) Mostrar todos los PDFS de un usuario
--- PARA ESTE PDF SE USA EL USUARIO 2
SELECT pdf.title, pdf.summary, pdf.cont_18, account.username, category.title 
FROM pdf, account, category WHERE
pdf.account_id = account.account_id AND category.category_id = pdf.category_id AND account.account_id = 2 

----3) Mostrar un PDF en especifico del usuario
--- PARA ESTE PDF SE USA EL USUARIO pedro y el titulo "Analisis al Dark Souls" O se usa el id
SELECT DISTINCT pdf.title, pdf.summary, pdf.link, pdf.cont_18, account.username, category.title 
FROM pdf, account, category
WHERE ((pdf.title = 'Analisis al Dark Souls' AND account.username = 'pedro')
OR (pdf.pdf_id = 6)) AND pdf.category_id = category.category_id AND pdf.account_id = account.account_id

----4) MOSTRAR LOS PDFS PRIVADOS LOS CUALES TENGO ACCESO (Y los mios)
--- PARA ESTE USUARIO SE USARA EL USUARIO 2
SELECT DISTINCT c1.title, c1.summary, c1.cont_18, c1.category, c2.username FROM 
(SELECT pdf.title as title, pdf.summary as summary, pdf.cont_18 as cont_18, 
account.username as username, category.title as category, pdf.account_id AS pdf_user_id
FROM pdf, account, category, auth WHERE pdf.category_id = category.category_id AND
account.account_id = 2 AND ((account.account_id = pdf.account_id)
OR (auth.account_id = account.account_id AND pdf.pdf_id = auth.pdf_id))) AS c1 
INNER JOIN (SELECT pdf.account_id AS pdf_user_id, 
account.username as username FROM pdf, account WHERE pdf.account_id = account.account_id) AS c2
ON c1.pdf_user_id = c2.pdf_user_id

----5) BUSCAR PDFS POR FILTRO
---FILTROS: Titulo, Resumen, Creador, Categoria, +18
---En est ejemplo: Curiosidades, Lee, diego, arte, false
SELECT pdf.title, pdf.summary, pdf.cont_18, account.username, category.title
FROM pdf, account, category
WHERE pdf.title LIKE '%Curiosidades%' AND pdf.summary LIKE '%Lee%' AND pdf.cont_18 = false 
AND pdf.category_id = category.category_id AND category.title = 'arte' 
AND account.account_id = pdf.account_id AND account.username = 'diego'

----6) LEER REVIEWS DE UN PDF
---EN ESTE EJEMPLO SE USA EL PDF 7
SELECT reviews.calification, reviews.review, account.username FROM reviews, pdf, account WHERE
pdf.pdf_id = 7 AND reviews.pdf_id = pdf.pdf_id AND reviews.account_id = account.account_id

----7) PROMEDIO DE REVIEWS DE UN PDF
---EN ESTE EJEMPLO SE USA EL PDF 7
SELECT AVG(reviews.calification) FROM reviews, pdf, account WHERE
pdf.pdf_id = 7 AND reviews.pdf_id = pdf.pdf_id AND reviews.account_id = account.account_id

----8) MOSTRAR READSTATE DE UN PDF
---EN ESTE EJEMPLO SE USA LA CUENTA 2 Y EL PDF 6
SELECT readstate.last_page FROM readstate, account, pdf WHERE
pdf.pdf_id = 6 AND account.account_id = 2 AND readstate.pdf_id = pdf.pdf_id AND
account.account_id = readstate.account_id

----9) MOSTRAR REPORTES
SELECT pdf.title, report.reason, account.username FROM report, account, pdf WHERE
account.account_id = pdf.account_id AND pdf.pdf_id  = report.pdf_id

----10) MOSTRAR SEGUIDORES
SELECT account.username, account.email, account.profile_link FROM account, sub
WHERE sub.account_id = 2 AND sub.follower_account_id = account.account_id

----11) MOSTRAR CANTIDAD DE SEGUIDORES
SELECT COUNT(*) FROM account, sub
WHERE sub.account_id = 2 AND sub.follower_account_id = account.account_id

----12) MOSTRAR MI LISTAS DE PDFS
SELECT list.title FROM list, account
WHERE account.account_id = 2 AND account.account_id = list.account_id

----13) MOSTRAR LISTA ESPECIFICA
SELECT pdf.title, pdf.summary, pdf.cont_18, account.username, category.title 
FROM pdf, list, account, category, content
WHERE list.list_id = 1 AND list.list_id = content.list_id AND content.pdf_id = pdf.pdf_id
AND pdf.category_id = category.category_id AND account.account_id = pdf.account_id

----14) MOSTRAR PERFIL
SELECT account.username, account.email, account.profile_link FROM account
WHERE account_id = 2
