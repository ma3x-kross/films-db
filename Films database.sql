DROP TABLE IF EXISTS films;

CREATE TABLE films
(
	film_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
	title varchar(64) NOT NULL,
	production_year smallint NOT NULL, 
	description text,
	budget numeric DEFAULT 0,
	marketing numeric DEFAULT 0,
	box_office_usa numeric DEFAULT 0,
	box_office_world numeric  DEFAULT 0,
	premiere_ru date,
	premiere_world date NOT NULL,
	dvd_release date,
	age_limit smallint DEFAULT 0,
	mpaa_rating varchar(5) DEFAULT 'G',
	
	CONSTRAINT PK_films_film_id PRIMARY KEY(film_id),
	CONSTRAINT CHK_films_budget CHECK (budget >= 0),
	CONSTRAINT CHK_films_marketing CHECK (marketing >= 0),
	CONSTRAINT CHK_films_age_limit CHECK (age_limit >= 0),
	CONSTRAINT CHK_films_mpaa_rating CHECK (mpaa_rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17'))
	
);

-- INSERT INTO films(title, production_year, premiere_world) VALUES ('Зеленая миля', 1999, '1999-12-06')
-- RETURNING * ;

DROP TABLE IF EXISTS countries;

CREATE TABLE countries
(
	country_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
	country_name varchar(64) NOT NULL,
	
	CONSTRAINT PK_countries_country_id PRIMARY KEY (country_id)
);

-- INSERT INTO countries (country_name) VALUES ('США');

DROP TABLE IF EXISTS films_countries;

CREATE TABLE films_countries
(
	films_countries_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
	film_id int,
	country_id int,
	
	CONSTRAINT PK_films_countries_films_countries_id PRIMARY KEY (films_countries_id),
	CONSTRAINT FK_films_countries_film_id FOREIGN KEY (film_id) REFERENCES films(film_id),
	CONSTRAINT FK_films_countries_country_id FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

-- INSERT INTO films_countries (film_id, country_id) VALUES (1, 1);

DROP TABLE IF EXISTS persons;

CREATE TABLE persons
(
	person_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
	first_name varchar(64) NOT NULL,
	last_name varchar(64) NOT NULL,
	birthday date NOT NULL,
	bio text,
	
	CONSTRAINT PK_persons_person_id PRIMARY KEY (person_id)	
);

-- INSERT INTO persons (first_name, last_name, birthday) VALUES ('Том', 'Хэнкс', '1956-07-09') RETURNING * ;

DROP TABLE IF EXISTS films_persons;

CREATE TABLE films_persons
(
	films_persons_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
	film_id int,
	person_id int,
	films_role varchar(64) NOT NULL,
	
	CONSTRAINT PK_films_persons_films_persons_id PRIMARY KEY (films_persons_id),
	CONSTRAINT FK_films_persons_film_id FOREIGN KEY (film_id) REFERENCES films(film_id),
	CONSTRAINT FK_films_persons_person_id FOREIGN KEY (person_id) REFERENCES persons(person_id)
);

-- INSERT INTO films_persons(film_id, person_id, films_role) VALUES
-- (1, 1, 'Актер') RETURNING *;

DROP TABLE IF EXISTS genres;

CREATE TABLE genres
(
	genre_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
	genre_name varchar NOT NULL,
	
	CONSTRAINT PK_genres_genre_id PRIMARY KEY (genre_id)
);

-- INSERT INTO genres(genre_name) VALUES ('драма'),('фэнтези'),('криминал') RETURNING *;

DROP TABLE IF EXISTS films_genres;

CREATE TABLE films_genres
(
	film_genre_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
	film_id int,
	genre_id int,
	
	CONSTRAINT PK_films_genres_film_genre_id PRIMARY KEY (film_genre_id),
	CONSTRAINT FK_films_genres_film_id FOREIGN KEY (film_id) REFERENCES films(film_id),
	CONSTRAINT FK_films_genres_genre_id FOREIGN KEY (genre_id) REFERENCES genres(genre_id)
);

-- INSERT INTO films_genres(film_id, genre_id) VALUES (1, 1), (1, 2), (1, 3) RETURNING *;

DROP TABLE IF EXISTS viewers;

CREATE TABLE viewers
(
	viewers_id int GENERATED ALWAYS AS IDENTITY NOT NULL,
	film_id int,
	country_id int,
	quantity int DEFAULT 0,
	
	CONSTRAINT PK_viewers_viewers_id PRIMARY KEY (viewers_id),
	CONSTRAINT FK_viewers_film_id FOREIGN KEY (film_id) REFERENCES films(film_id),
	CONSTRAINT FK_viewers_country_id FOREIGN KEY (country_id) REFERENCES countries(country_id),
	CONSTRAINT CHK_viewers_quantity CHECK (quantity >= 0)
);

-- INSERT INTO viewers (film_id, country_id, quantity) VALUES (1, 1, 26000000) RETURNING *;







