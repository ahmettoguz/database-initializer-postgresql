--
-- PostgreSQL database dump
--

-- Dumped from database version 17.2 (Debian 17.2-1.pgdg120+1)
-- Dumped by pg_dump version 17.2

-- Started on 2024-12-19 09:45:53 UTC

DO $$ 
BEGIN
    PERFORM pg_terminate_backend(pg_stat_activity.pid)
    FROM pg_stat_activity
    WHERE pg_stat_activity.datname = 'bank' AND pid <> pg_backend_pid();
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

DROP DATABASE IF EXISTS bank;
--
-- TOC entry 3402 (class 1262 OID 16747)
-- Name: bank; Type: DATABASE; Schema: -; Owner: admin
--

CREATE DATABASE bank WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE bank OWNER TO admin;

\connect bank

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
-- TOC entry 217 (class 1259 OID 16748)
-- Name: account; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.account (
    id integer NOT NULL,
    balance numeric(15,2) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    provision numeric(15,2) DEFAULT 0 NOT NULL
);


ALTER TABLE public.account OWNER TO admin;

--
-- TOC entry 218 (class 1259 OID 16754)
-- Name: account_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.account_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.account_id_seq OWNER TO admin;

--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 218
-- Name: account_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.account_id_seq OWNED BY public.account.id;


--
-- TOC entry 219 (class 1259 OID 16755)
-- Name: auditlog; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.auditlog (
    id integer NOT NULL,
    action character varying(255) NOT NULL,
    performed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.auditlog OWNER TO admin;

--
-- TOC entry 220 (class 1259 OID 16759)
-- Name: auditlog_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.auditlog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.auditlog_id_seq OWNER TO admin;

--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 220
-- Name: auditlog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.auditlog_id_seq OWNED BY public.auditlog.id;


--
-- TOC entry 221 (class 1259 OID 16760)
-- Name: card; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.card (
    id integer NOT NULL,
    account_id integer NOT NULL,
    number character varying(16) NOT NULL,
    expiration_date date NOT NULL,
    cvv character(3) NOT NULL
);


ALTER TABLE public.card OWNER TO admin;

--
-- TOC entry 222 (class 1259 OID 16763)
-- Name: card_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.card_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.card_id_seq OWNER TO admin;

--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 222
-- Name: card_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.card_id_seq OWNED BY public.card.id;


--
-- TOC entry 223 (class 1259 OID 16764)
-- Name: transaction; Type: TABLE; Schema: public; Owner: admin
--

CREATE TABLE public.transaction (
    id integer NOT NULL,
    sender_account_id integer NOT NULL,
    receiver_account_id integer NOT NULL,
    sender_card_id integer NOT NULL,
    amount numeric(15,2) NOT NULL,
    transaction_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    description character varying(255)
);


ALTER TABLE public.transaction OWNER TO admin;

--
-- TOC entry 224 (class 1259 OID 16768)
-- Name: transaction_id_seq; Type: SEQUENCE; Schema: public; Owner: admin
--

CREATE SEQUENCE public.transaction_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transaction_id_seq OWNER TO admin;

--
-- TOC entry 3406 (class 0 OID 0)
-- Dependencies: 224
-- Name: transaction_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: admin
--

ALTER SEQUENCE public.transaction_id_seq OWNED BY public.transaction.id;


--
-- TOC entry 3225 (class 2604 OID 16769)
-- Name: account id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.account ALTER COLUMN id SET DEFAULT nextval('public.account_id_seq'::regclass);


--
-- TOC entry 3229 (class 2604 OID 16770)
-- Name: auditlog id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auditlog ALTER COLUMN id SET DEFAULT nextval('public.auditlog_id_seq'::regclass);


--
-- TOC entry 3231 (class 2604 OID 16771)
-- Name: card id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.card ALTER COLUMN id SET DEFAULT nextval('public.card_id_seq'::regclass);


--
-- TOC entry 3232 (class 2604 OID 16772)
-- Name: transaction id; Type: DEFAULT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.transaction ALTER COLUMN id SET DEFAULT nextval('public.transaction_id_seq'::regclass);


--
-- TOC entry 3389 (class 0 OID 16748)
-- Dependencies: 217
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.account (id, balance, created_at, updated_at, provision) FROM stdin;
1	1000000000.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705	0.00
2	100000.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705	0.00
3	4380.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705	0.00
4	98120.50	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705	0.00
5	25000.25	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705	0.00
6	34560.50	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705	0.00
7	56230.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705	0.00
8	49000.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705	0.00
9	83010.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705	0.00
10	72650.00	2024-12-18 18:44:29.679705	2024-12-18 18:44:29.679705	0.00
\.


--
-- TOC entry 3391 (class 0 OID 16755)
-- Dependencies: 219
-- Data for Name: auditlog; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.auditlog (id, action, performed_at) FROM stdin;
\.


--
-- TOC entry 3393 (class 0 OID 16760)
-- Dependencies: 221
-- Data for Name: card; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.card (id, account_id, number, expiration_date, cvv) FROM stdin;
1	1	4242424242424242	2029-12-25	123
2	2	4000056655665556	2029-04-25	678
3	2	5555555555554444	2028-05-24	456
4	3	2223003122003222	2027-02-27	890
5	3	5200828282828210	2026-11-26	789
6	4	5105105105105100	2029-01-25	321
7	5	378282246310005	2026-07-26	654
8	6	371449635398431	2027-08-27	987
9	7	6011111111111117	2028-09-24	213
10	8	6011000990139424	2029-10-25	432
11	9	6011981111111113	2028-03-28	567
12	10	3056930009020004	2029-06-29	876
\.


--
-- TOC entry 3395 (class 0 OID 16764)
-- Dependencies: 223
-- Data for Name: transaction; Type: TABLE DATA; Schema: public; Owner: admin
--

COPY public.transaction (id, sender_account_id, receiver_account_id, sender_card_id, amount, transaction_date, description) FROM stdin;
\.


--
-- TOC entry 3407 (class 0 OID 0)
-- Dependencies: 218
-- Name: account_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.account_id_seq', 11, false);


--
-- TOC entry 3408 (class 0 OID 0)
-- Dependencies: 220
-- Name: auditlog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.auditlog_id_seq', 1, false);


--
-- TOC entry 3409 (class 0 OID 0)
-- Dependencies: 222
-- Name: card_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.card_id_seq', 13, false);


--
-- TOC entry 3410 (class 0 OID 0)
-- Dependencies: 224
-- Name: transaction_id_seq; Type: SEQUENCE SET; Schema: public; Owner: admin
--

SELECT pg_catalog.setval('public.transaction_id_seq', 1, false);


--
-- TOC entry 3235 (class 2606 OID 16774)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (id);


--
-- TOC entry 3237 (class 2606 OID 16776)
-- Name: auditlog auditlog_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.auditlog
    ADD CONSTRAINT auditlog_pkey PRIMARY KEY (id);


--
-- TOC entry 3239 (class 2606 OID 16778)
-- Name: card card_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.card
    ADD CONSTRAINT card_pkey PRIMARY KEY (id);


--
-- TOC entry 3243 (class 2606 OID 16780)
-- Name: transaction transaction_pkey; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.transaction
    ADD CONSTRAINT transaction_pkey PRIMARY KEY (id);


--
-- TOC entry 3241 (class 2606 OID 16782)
-- Name: card unique_card_number; Type: CONSTRAINT; Schema: public; Owner: admin
--

ALTER TABLE ONLY public.card
    ADD CONSTRAINT unique_card_number UNIQUE (number);


-- Completed on 2024-12-19 09:45:54 UTC

--
-- PostgreSQL database dump complete
--

