
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