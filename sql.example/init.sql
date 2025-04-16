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
-- TOC entry 217 (class 1259 OID 16461)
-- Name: code; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.code (
    id integer NOT NULL,
    code character varying(10) NOT NULL,
    game_id integer,
    player_id integer,
    is_active boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.code OWNER TO admin;

--
-- TOC entry 218 (class 1259 OID 16465)
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
-- TOC entry 3420 (class 0 OID 0)
-- Dependencies: 218
-- Name: code_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.code_id OWNED BY public.code.id;


--
-- TOC entry 219 (class 1259 OID 16466)
-- Name: game; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.game (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    is_deleted boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.game OWNER TO admin;

--
-- TOC entry 220 (class 1259 OID 16470)
-- Name: game_detail; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.game_detail (
    id integer NOT NULL,
    game_id integer,
    description character varying(500) NOT NULL,
    genre character varying(25) NOT NULL,
    is_deleted boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.game_detail OWNER TO admin;

--
-- TOC entry 221 (class 1259 OID 16476)
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
-- TOC entry 3421 (class 0 OID 0)
-- Dependencies: 221
-- Name: game_detail_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.game_detail_id OWNED BY public.game_detail.id;


--
-- TOC entry 222 (class 1259 OID 16477)
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
-- TOC entry 3422 (class 0 OID 0)
-- Dependencies: 222
-- Name: game_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.game_id_seq OWNED BY public.game.id;


--
-- TOC entry 223 (class 1259 OID 16478)
-- Name: player; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.player (
    id integer NOT NULL,
    nick_name character varying(25) NOT NULL,
    password character varying(100) NOT NULL,
    is_deleted boolean NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.player OWNER TO admin;

--
-- TOC entry 224 (class 1259 OID 16482)
-- Name: player_game; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.player_game (
    id integer NOT NULL,
    player_id integer,
    game_id integer
);


ALTER TABLE public.player_game OWNER TO admin;

--
-- TOC entry 225 (class 1259 OID 16485)
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
-- TOC entry 3423 (class 0 OID 0)
-- Dependencies: 225
-- Name: player_game_id; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.player_game_id OWNED BY public.player_game.id;


--
-- TOC entry 226 (class 1259 OID 16486)
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
-- TOC entry 3424 (class 0 OID 0)
-- Dependencies: 226
-- Name: player_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.player_id_seq OWNED BY public.player.id;


--
-- TOC entry 3230 (class 2604 OID 16487)
-- Name: code id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.code ALTER COLUMN id SET DEFAULT nextval('public.code_id'::regclass);


--
-- TOC entry 3232 (class 2604 OID 16488)
-- Name: game id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game ALTER COLUMN id SET DEFAULT nextval('public.game_id_seq'::regclass);


--
-- TOC entry 3234 (class 2604 OID 16489)
-- Name: game_detail id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_detail ALTER COLUMN id SET DEFAULT nextval('public.game_detail_id'::regclass);


--
-- TOC entry 3236 (class 2604 OID 16490)
-- Name: player id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player ALTER COLUMN id SET DEFAULT nextval('public.player_id_seq'::regclass);


--
-- TOC entry 3238 (class 2604 OID 16491)
-- Name: player_game id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player_game ALTER COLUMN id SET DEFAULT nextval('public.player_game_id'::regclass);


--
-- TOC entry 3405 (class 0 OID 16461)
-- Dependencies: 217
-- Data for Name: code; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.code (id, code, game_id, player_id, is_active, created_at, updated_at) FROM stdin;
1	ABC123	1	1	t	2025-01-09 13:50:24	2025-01-09 13:50:24
2	DEF456	1	1	t	2025-01-09 13:50:24	2025-01-09 13:50:24
3	GHI789	1	1	t	2025-01-09 13:50:24	2025-01-09 13:50:24
4	JKL012	1	1	t	2025-01-09 13:50:24	2025-01-09 13:50:24
5	MNO345	2	1	t	2025-01-09 13:50:24	2025-01-09 13:50:24
6	PQR678	2	1	t	2025-01-09 13:50:24	2025-01-09 13:50:24
7	STU901	2	1	t	2025-01-09 13:50:24	2025-01-09 13:50:24
8	VWX234	4	2	t	2025-01-09 13:50:24	2025-01-09 13:50:24
9	YZA567	4	2	t	2025-01-09 13:50:24	2025-01-09 13:50:24
10	BCD890	4	2	t	2025-01-09 13:50:24	2025-01-09 13:50:24
\.


--
-- TOC entry 3407 (class 0 OID 16466)
-- Dependencies: 219
-- Data for Name: game; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.game (id, name, is_deleted, created_at, updated_at) FROM stdin;
1	Genshin Impact	f	2025-01-09 13:50:24	2025-01-09 13:50:24
2	League of Legends	f	2025-01-09 13:50:24	2025-01-09 13:50:24
3	Fortnite	f	2025-01-09 13:50:24	2025-01-09 13:50:24
4	Alex Legends	f	2025-01-09 13:50:24	2025-01-09 13:50:24
5	Minecraft	f	2025-01-09 13:50:24	2025-01-09 13:50:24
6	Call of Duty: Warzone	f	2025-01-09 13:50:24	2025-01-09 13:50:24
7	Valorant	f	2025-01-09 13:50:24	2025-01-09 13:50:24
8	Cyberpunk 2077	f	2025-01-09 13:50:24	2025-01-09 13:50:24
9	FIFA 21	f	2025-01-09 13:50:24	2025-01-09 13:50:24
10	The Witcher 3	f	2025-01-09 13:50:24	2025-01-09 13:50:24
\.

--
-- TOC entry 3408 (class 0 OID 16470)
-- Dependencies: 220
-- Data for Name: game_detail; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.game_detail (id, game_id, description, genre, is_deleted, created_at, updated_at) FROM stdin;
1	1	An open-world action role-playing game developed by miHoYo.	Action, RPG	f	2025-01-09 13:50:24	2025-01-09 13:50:24
2	2	Multiplayer online battle arena game developed by Riot Games.	MOBA	f	2025-01-09 13:50:24	2025-01-09 13:50:24
3	3	Battle royale game developed by Epic Games.	Battle Royale	f	2025-01-09 13:50:24	2025-01-09 13:50:24
4	4	Multiplayer first-person shooter game developed by Respawn Entertainment.	FPS	f	2025-01-09 13:50:24	2025-01-09 13:50:24
5	5	Sandbox video game developed by Mojang Studios.	Sandbox	f	2025-01-09 13:50:24	2025-01-09 13:50:24
6	6	Battle royale game developed by Infinity Ward.	Battle Royale	f	2025-01-09 13:50:24	2025-01-09 13:50:24
7	7	Tactical shooter game developed by Riot Games.	Tactical Shooter	f	2025-01-09 13:50:24	2025-01-09 13:50:24
8	8	Open-world role-playing game developed by CD Projekt.	RPG, Action	f	2025-01-09 13:50:24	2025-01-09 13:50:24
9	9	Football simulation video game developed by EA Sports.	Sports	f	2025-01-09 13:50:24	2025-01-09 13:50:24
10	10	Action role-playing game developed by CD Projekt Red.	RPG	f	2025-01-09 13:50:24	2025-01-09 13:50:24
\.


--
-- TOC entry 3411 (class 0 OID 16478)
-- Dependencies: 223
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.player (id, nick_name, password, is_deleted, created_at, updated_at) FROM stdin;
1	starlight	secret	f	2025-01-09 13:50:24	2025-01-09 13:50:24
2	blizzard	secret	f	2025-01-09 13:50:24	2025-01-09 13:50:24
3	phantom	secret	f	2025-01-09 13:50:24	2025-01-09 13:50:24
4	viper	secret	f	2025-01-09 13:50:24	2025-01-09 13:50:24
5	neon	secret	f	2025-01-09 13:50:24	2025-01-09 13:50:24
6	maverick	secret	f	2025-01-09 13:50:24	2025-01-09 13:50:24
7	zenith	secret	f	2025-01-09 13:50:24	2025-01-09 13:50:24
8	tornado	secret	f	2025-01-09 13:50:24	2025-01-09 13:50:24
9	raven	secret	f	2025-01-09 13:50:24	2025-01-09 13:50:24
10	spectrum	secret	f	2025-01-09 13:50:24	2025-01-09 13:50:24
\.


--
-- TOC entry 3412 (class 0 OID 16482)
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
-- TOC entry 3425 (class 0 OID 0)
-- Dependencies: 218
-- Name: code_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.code_id', 10, true);


--
-- TOC entry 3426 (class 0 OID 0)
-- Dependencies: 221
-- Name: game_detail_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.game_detail_id', 10, true);


--
-- TOC entry 3427 (class 0 OID 0)
-- Dependencies: 222
-- Name: game_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.game_id_seq', 10, true);


--
-- TOC entry 3428 (class 0 OID 0)
-- Dependencies: 225
-- Name: player_game_id; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.player_game_id', 10, true);


--
-- TOC entry 3429 (class 0 OID 0)
-- Dependencies: 226
-- Name: player_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.player_id_seq', 10, true);


--
-- TOC entry 3240 (class 2606 OID 16493)
-- Name: code code_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.code
    ADD CONSTRAINT code_pkey PRIMARY KEY (id);


--
-- TOC entry 3246 (class 2606 OID 16495)
-- Name: game_detail game_detail_game_id_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_detail
    ADD CONSTRAINT game_detail_game_id_key UNIQUE (game_id);


--
-- TOC entry 3248 (class 2606 OID 16497)
-- Name: game_detail game_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_detail
    ADD CONSTRAINT game_detail_pkey PRIMARY KEY (id);


--
-- TOC entry 3242 (class 2606 OID 16499)
-- Name: game game_name_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_name_key UNIQUE (name);


--
-- TOC entry 3244 (class 2606 OID 16501)
-- Name: game game_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game
    ADD CONSTRAINT game_pkey PRIMARY KEY (id);


--
-- TOC entry 3254 (class 2606 OID 16503)
-- Name: player_game player_game_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player_game
    ADD CONSTRAINT player_game_pkey PRIMARY KEY (id);


--
-- TOC entry 3250 (class 2606 OID 16505)
-- Name: player player_nick_name_key; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_nick_name_key UNIQUE (nick_name);


--
-- TOC entry 3252 (class 2606 OID 16507)
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (id);


--
-- TOC entry 3255 (class 2606 OID 16508)
-- Name: code code_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.code
    ADD CONSTRAINT code_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE SET NULL;


--
-- TOC entry 3256 (class 2606 OID 16513)
-- Name: code code_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.code
    ADD CONSTRAINT code_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(id) ON DELETE SET NULL;


--
-- TOC entry 3257 (class 2606 OID 16518)
-- Name: game_detail game_detail_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.game_detail
    ADD CONSTRAINT game_detail_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE SET NULL;


--
-- TOC entry 3258 (class 2606 OID 16523)
-- Name: player_game player_game_game_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player_game
    ADD CONSTRAINT player_game_game_id_fkey FOREIGN KEY (game_id) REFERENCES public.game(id) ON DELETE SET NULL;


--
-- TOC entry 3259 (class 2606 OID 16528)
-- Name: player_game player_game_player_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.player_game
    ADD CONSTRAINT player_game_player_id_fkey FOREIGN KEY (player_id) REFERENCES public.player(id) ON DELETE SET NULL;


-- Completed on 2025-01-09 17:13:57 UTC

--
-- PostgreSQL database dump complete
--

