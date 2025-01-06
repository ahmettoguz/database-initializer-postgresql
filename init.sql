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
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2

-- Started on 2025-01-06 22:54:10 UTC

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

DROP DATABASE IF EXISTS code_stream;
--
-- TOC entry 3416 (class 1262 OID 18436)
-- Name: code_stream; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE code_stream WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE code_stream OWNER TO admin;

\connect code_stream

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
-- TOC entry 217 (class 1259 OID 18437)
-- Name: code; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.code (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    game_id integer,
    player_id integer
);


ALTER TABLE public.code OWNER TO admin;

--
-- TOC entry 218 (class 1259 OID 18440)
-- Name: code_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.code_id
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.code_id OWNER TO admin;

--
-- TOC entry 3417 (class 0 OID 0)
-- Dependencies: 218
-- Name: code_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.code_id OWNED BY public.code.id;


--
-- TOC entry 219 (class 1259 OID 18441)
-- Name: game; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.game (
    id integer NOT NULL,
    name character varying(100) NOT NULL
);


ALTER TABLE public.game OWNER TO admin;

--
-- TOC entry 220 (class 1259 OID 18444)
-- Name: game_detail; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.game_detail (
    id integer NOT NULL,
    game_id integer,
    description character varying(500) NOT NULL,
    genre character varying(25) NOT NULL
);


ALTER TABLE public.game_detail OWNER TO admin;

--
-- TOC entry 221 (class 1259 OID 18449)
-- Name: game_detail_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.game_detail_id
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_detail_id OWNER TO admin;

--
-- TOC entry 3418 (class 0 OID 0)
-- Dependencies: 221
-- Name: game_detail_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.game_detail_id OWNED BY public.game_detail.id;


--
-- TOC entry 222 (class 1259 OID 18450)
-- Name: game_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.game_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.game_id_seq OWNER TO admin;

--
-- TOC entry 3419 (class 0 OID 0)
-- Dependencies: 222
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;


--
-- TOC entry 223 (class 1259 OID 18451)
-- Name: player; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.player (
    id integer NOT NULL,
    nick_name character varying(25) NOT NULL,
    password character varying(100) NOT NULL
);


ALTER TABLE public.player OWNER TO admin;

--
-- TOC entry 224 (class 1259 OID 18454)
-- Name: player_game; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.player_game (
    id integer NOT NULL,
    player_id integer,
    game_id integer
);


ALTER TABLE public.player_game OWNER TO admin;

--
-- TOC entry 225 (class 1259 OID 18457)
-- Name: player_game_id; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.player_game_id
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.player_game_id OWNER TO admin;

--
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 225
-- Name: player_game_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.player_game_id OWNED BY public.player_game.id;


--
-- TOC entry 226 (class 1259 OID 18458)
-- Name: player_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.player_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.player_id_seq OWNER TO admin;

--
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 226
-- Name: player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.player_id_seq OWNED BY public.player.id;


--
-- TOC entry 3230 (class 2604 OID 18459)
-- Name: code id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.code ALTER COLUMN id SET DEFAULT nextval('public.code_id'::regclass);


--
-- TOC entry 3231 (class 2604 OID 18460)
-- Name: game id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);


--
-- TOC entry 3232 (class 2604 OID 18461)
-- Name: game_detail id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_detail ALTER COLUMN id SET DEFAULT nextval('public.game_detail_id'::regclass);


--
-- TOC entry 3233 (class 2604 OID 18462)
-- Name: player id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player ALTER COLUMN id SET DEFAULT nextval('public.player_id_seq'::regclass);


--
-- TOC entry 3234 (class 2604 OID 18463)
-- Name: player_game id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player_game ALTER COLUMN id SET DEFAULT nextval('public.player_game_id'::regclass);


--
-- TOC entry 3401 (class 0 OID 18437)
-- Dependencies: 217
-- Data for Name: code; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.code (id, code, game_id, player_id) FROM stdin;
1	ABC123	1	1
2	DEF456	1	1
3	GHI789	1	1
4	JKL012	1	1
5	MNO345	2	1
6	PQR678	2	1
7	STU901	2	1
8	VWX234	4	2
9	YZA567	4	2
10	BCD890	4	2
\.


--
-- TOC entry 3403 (class 0 OID 18441)
-- Dependencies: 219
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.game (id, name) FROM stdin;
1	Genshin Impact
2	League of Legends
3	Fortnite
4	Alex Legends
5	Minecraft
6	Call of Duty: Warzone
7	Valorant
8	Cyberpunk 2077
9	FIFA 21
10	The Witcher 3
\.


--
-- TOC entry 3404 (class 0 OID 18444)
-- Dependencies: 220
-- Data for Name: game_detail; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.game_detail (id, game_id, description, genre) FROM stdin;
1	1	An open-world action role-playing game developed by miHoYo.	Action, RPG
2	2	Multiplayer online battle arena game developed by Riot Games.	MOBA
3	3	Battle royale game developed by Epic Games.	Battle Royale
4	4	Multiplayer first-person shooter game developed by Respawn Entertainment.	FPS
5	5	Sandbox video game developed by Mojang Studios.	Sandbox
6	6	Battle royale game developed by Infinity Ward.	Battle Royale
7	7	Tactical shooter game developed by Riot Games.	Tactical Shooter
8	8	Open-world role-playing game developed by CD Projekt.	RPG, Action
9	9	Football simulation video game developed by EA Sports.	Sports
10	10	Action role-playing game developed by CD Projekt Red.	RPG
\.


--
-- TOC entry 3407 (class 0 OID 18451)
-- Dependencies: 223
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.player (id, nick_name, password) FROM stdin;
1	starlight	secret
2	blizzard	secret
3	phantom	secret
4	viper	secret
5	neon	secret
6	maverick	secret
7	zenith	secret
8	tornado	secret
9	raven	secret
10	spectrum	secret
\.


--
-- TOC entry 3408 (class 0 OID 18454)
-- Dependencies: 224
-- Data for Name: player_game; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.player_game (id, player_id, game_id) FROM stdin;
1	1	1
2	1	2
3	1	3
4	2	4
5	2	5
6	2	6
7	3	7
8	3	8
9	3	9
10	3	10
\.


--
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 218
-- Name: code_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.code_id', 10, true);


--
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 221
-- Name: game_detail_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.game_detail_id', 10, true);


--
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 222
-- Name: game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.game_id_seq', 10, true);


--
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 225
-- Name: player_game_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.player_game_id', 10, true);


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 226
-- Name: player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.player_id_seq', 10, true);


--
-- TOC entry 3236 (class 2606 OID 18465)
-- Name: code code_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.code
    ADD CONSTRAINT code_pkey PRIMARY KEY (id);


--
-- TOC entry 3242 (class 2606 OID 18467)
-- Name: game_detail game_detail_game_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_detail
    ADD CONSTRAINT game_detail_game_id_key UNIQUE (game_id);


--
-- TOC entry 3244 (class 2606 OID 18469)
-- Name: game_detail game_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_detail
    ADD CONSTRAINT game_detail_pkey PRIMARY KEY (id);


--
-- TOC entry 3238 (class 2606 OID 18471)
-- Name: game game_name_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key UNIQUE (name);


--
-- TOC entry 3240 (class 2606 OID 18473)
-- Name: game game_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 2606 OID 18475)
-- Name: player_game player_game_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player_game
    ADD CONSTRAINT player_game_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 18477)
-- Name: player player_nick_name_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_nick_name_key UNIQUE (nick_name);


--
-- TOC entry 3248 (class 2606 OID 18479)
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (id);


--
-- TOC entry 3251 (class 2606 OID 18480)
-- Name: code code_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.code
    ADD CONSTRAINT code_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE SET NULL;


--
-- TOC entry 3252 (class 2606 OID 18485)
-- Name: code code_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.code
    ADD CONSTRAINT code_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(id) ON DELETE SET NULL;


--
-- TOC entry 3253 (class 2606 OID 18490)
-- Name: game_detail game_detail_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_detail
    ADD CONSTRAINT game_detail_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE SET NULL;


--
-- TOC entry 3254 (class 2606 OID 18495)
-- Name: player_game player_game_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player_game
    ADD CONSTRAINT player_game_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE SET NULL;


--
-- TOC entry 3255 (class 2606 OID 18500)
-- Name: player_game player_game_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player_game
    ADD CONSTRAINT player_game_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(id) ON DELETE SET NULL;


-- Completed on 2025-01-06 22:54:11 UTC

--
-- PostgreSQL database dump complete
--

