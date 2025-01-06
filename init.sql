--
-- CLOSE CONNECTIONS
--

DO $$
BEGIN
    PERFORM pg_terminate_backend(pg_stat_activity.pid)
    FROM pg_stat_activity
    WHERE pg_stat_activity.datname = 'code_stream' AND pid <> pg_backend_pid();
END;
$$;

--
--
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- DROP & CREATE DATABASE
--

DROP DATABASE IF EXISTS code_stream;
CREATE DATABASE code_stream WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';
ALTER DATABASE code_stream OWNER TO admin;
\connect code_stream

--
--
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;
SET default_tablespace = '';
SET default_table_access_method = heap;

--
-- CREATE TABLE
--

CREATE TABLE public.game (
    id integer NOT NULL PRIMARY KEY,
    name character varying(100) NOT NULL UNIQUE
);
ALTER TABLE public.game OWNER TO admin;

CREATE TABLE public.player (
    id integer NOT NULL PRIMARY KEY,
    nick_name character varying(25) NOT NULL UNIQUE,
    password character varying(100) NOT NULL
);
ALTER TABLE public.player OWNER TO admin;

CREATE TABLE public.code (
    id integer NOT NULL PRIMARY KEY,
    code integer NOT NULL,
    game_id integer,
    player_id integer,
    CONSTRAINT code_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE SET NULL,
    CONSTRAINT code_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(id) ON DELETE SET NULL
);
ALTER TABLE public.code OWNER TO admin;

CREATE TABLE public.game_detail (
    id integer NOT NULL PRIMARY KEY,
    game_id integer UNIQUE,
    description character varying(500) NOT NULL,
    genre character varying(25) NOT NULL,
    CONSTRAINT game_detail_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE SET NULL
);
ALTER TABLE public.game_detail OWNER TO admin;


CREATE TABLE public.player_game (
    id integer NOT NULL PRIMARY KEY,
    player_id integer,
    game_id integer,
    CONSTRAINT player_game_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE SET NULL,
    CONSTRAINT player_game_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(id) ON DELETE SET NULL
);
ALTER TABLE public.player_game OWNER TO admin;

--
-- CREATE SEQUENCE
--

CREATE SEQUENCE public.code_id
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.code_id OWNER TO admin;
ALTER SEQUENCE public.code_id OWNED BY public.code.id;

CREATE SEQUENCE public.player_game_id
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.player_game_id OWNER TO admin;
ALTER SEQUENCE public.player_game_id OWNED BY public.player_game.id;

CREATE SEQUENCE public.game_detail_id
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.game_detail_id OWNER TO admin;
ALTER SEQUENCE public.game_detail_id OWNED BY public.game_detail.id;

CREATE SEQUENCE public.code_code_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.code_code_seq OWNER TO admin;
ALTER SEQUENCE public.code_code_seq OWNED BY public.code.code;

CREATE SEQUENCE public.game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.game_id_seq OWNER TO admin;
ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;

CREATE SEQUENCE public.player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.player_id_seq OWNER TO admin;
ALTER SEQUENCE public.player_id_seq OWNED BY public.player.id;

--
-- SEQUENCE
--

ALTER TABLE ONLY public.code ALTER COLUMN id SET DEFAULT nextval('public.code_id'::regclass);
ALTER TABLE ONLY public.player_game ALTER COLUMN id SET DEFAULT nextval('public.player_game_id'::regclass);
ALTER TABLE ONLY public.game_detail ALTER COLUMN id SET DEFAULT nextval('public.game_detail_id'::regclass);
ALTER TABLE ONLY public.code ALTER COLUMN code SET DEFAULT nextval('public.code_code_seq'::regclass);
ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);
ALTER TABLE ONLY public.player ALTER COLUMN id SET DEFAULT nextval('public.player_id_seq'::regclass);

--
-- DATA
--

COPY public.code (code, game_id, player_id) FROM stdin;
\.

COPY public.game (id, name) FROM stdin;
\.

COPY public.game_detail (game_id, description, genre) FROM stdin;
\.


COPY public.player (id, nick_name, password) FROM stdin;
\.

COPY public.player_game (player_id, game_id) FROM stdin;
\.

--
-- SEQUENCE
--

SELECT pg_catalog.setval('public.code_id', 1, false);
SELECT pg_catalog.setval('public.player_game_id', 1, false);
SELECT pg_catalog.setval('public.game_detail_id', 1, false);
SELECT pg_catalog.setval('public.code_code_seq', 1, false);
SELECT pg_catalog.setval('public.game_id_seq', 1, false);
SELECT pg_catalog.setval('public.player_id_seq', 1, false);
