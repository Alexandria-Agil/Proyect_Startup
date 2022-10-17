
CREATE SCHEMA alexandria AUTHORIZATION postgres;


CREATE TABLE alexandria.users (
	id serial4 NOT NULL,
	user_username text NOT NULL,
	user_password varchar(250) NOT NULL,
	email varchar(255) NOT NULL,
	avatar text NULL,
	created_on timestamp with time zone NOT NULL,
	last_login timestamp NULL,
	CONSTRAINT users_pk PRIMARY KEY (id),
	CONSTRAINT users_username_key UNIQUE (user_username)
);

CREATE TABLE alexandria.category(
    id serial PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);
/*
CREATE TABLE alexandria.files(
    id serial PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    filename VARCHAR(255) NOT NULL,
	thumbnail VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,
    cont_18 BOOLEAN NOT NULL,
    privacy BOOLEAN NOT NULL,
    account_id int NOT NULL,
	category_id int,
    FOREIGN KEY (account_id)
      REFERENCES alexandria.users (id) ON DELETE CASCADE,
    FOREIGN KEY (category_id)
      REFERENCES alexandria.category (id) ON DELETE CASCADE
);
*/
CREATE TABLE alexandria.files(
    id serial PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    filename VARCHAR(255) NOT NULL,
	thumbnail VARCHAR(255) NOT NULL,
    description VARCHAR(512) NOT NULL,
    cont_18 BOOLEAN NOT NULL,
    privacy BOOLEAN NOT NULL,
	category_id int,
    FOREIGN KEY (category_id)
      REFERENCES alexandria.category (id) ON DELETE CASCADE
);