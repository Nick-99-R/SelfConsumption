-- Database: postgres

-- DROP DATABASE IF EXISTS postgres;

CREATE DATABASE postgres
    WITH
    OWNER = flutterdb_admin
    ENCODING = 'UTF8'
    LC_COLLATE = 'C.UTF-8'
    LC_CTYPE = 'C.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
	
GRANT pg_read_server_files To flutterdb_admin;
	
create table users(
	id serial,
	email VARCHAR(255) primary key default '',
	password VARCHAR(255) default '',
	anteil double precision
);

update users set anteil = 5 where id = 1;

select * from users order by id;
drop table users;

create table verbrauchsdaten(
	id integer,
	FOREIGN KEY (users.id) REFERENCES users(users.id), 
	consumption double precision,
	time TIMESTAMPTZ not NULL
);

TRUNCATE verbrauchsdaten;

select create_hypertable('verbrauchsdaten', 'time');

insert into verbrauchsdaten(time, id, consumption)
select
	time,
	id,
	round((random()*(100/5)+0)::Numeric, 4) AS consumption
from
	generate_series(now() - interval '30 day', now(), interval '15 minutes') AS g1(time),
	generate_series(1,1000,1) as g2(id);

select * from verbrauchsdaten;

drop table verbrauchsdaten;

create table erzeugungsdaten(
	--id integer,
	--FOREIGN KEY(users.id) REFERENCES users (users.id),
	time double precision,
	erzeugung double precision
	--time TIMESTAMPTZ not NULL
);

copy erzeugungsdaten From 'C:/Users/nickr/Documents/FH/Semester_7/Bachelor/irr_data.csv'  DELIMITER ',';

--TRUNCATE erzeugungsdaten;

--select create_hypertable('erzeugungsdaten', 'time');

-- insert into erzeugungsdaten(time, id, erzeugung)
-- select
-- 	time,
-- 	id,
-- 	round((random()*(100-0)+0)::Numeric, 4) AS consumption
-- from
-- 	generate_series(now() - interval '30 day', now(), interval '15 minutes') AS g1(time),
-- 	generate_series(1,1000,1) as g2(id);
	
select * from erzeugungsdaten;

drop table erzeugungsdaten;
			
COMMENT ON DATABASE postgres
    IS 'default administrative connection database';