--
-- CLOSE CONNECTIONS
--
DO $$
BEGIN
    PERFORM pg_terminate_backend(pg_stat_activity.pid)
    FROM pg_stat_activity
    WHERE pg_stat_activity.datname = 'auth' AND pid <> pg_backend_pid();
END;
$$;
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

DROP DATABASE IF EXISTS auth;
CREATE DATABASE auth WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.utf8';


ALTER DATABASE auth OWNER TO admin;

\connect auth

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

CREATE TABLE public.t_permission (
    id bigint NOT NULL,
    permisson_name character varying(255) NOT NULL
);


ALTER TABLE public.t_permission OWNER TO admin;

CREATE SEQUENCE public.t_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_permission_id_seq OWNER TO admin;

ALTER SEQUENCE public.t_permission_id_seq OWNED BY public.t_permission.id;


CREATE TABLE public.t_role (
    id bigint NOT NULL,
    role_name character varying(255) NOT NULL
);


ALTER TABLE public.t_role OWNER TO admin;

CREATE SEQUENCE public.t_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_role_id_seq OWNER TO admin;

ALTER SEQUENCE public.t_role_id_seq OWNED BY public.t_role.id;


CREATE TABLE public.t_role_permission (
    id bigint NOT NULL,
    role_id bigint NOT NULL,
    permission_id bigint NOT NULL
);


ALTER TABLE public.t_role_permission OWNER TO admin;

CREATE SEQUENCE public.t_role_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_role_permission_id_seq OWNER TO admin;

ALTER SEQUENCE public.t_role_permission_id_seq OWNED BY public.t_role_permission.id;


CREATE SEQUENCE public.t_role_permission_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_role_permission_permission_id_seq OWNER TO admin;

ALTER SEQUENCE public.t_role_permission_permission_id_seq OWNED BY public.t_role_permission.permission_id;


CREATE SEQUENCE public.t_role_permission_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_role_permission_role_id_seq OWNER TO admin;

ALTER SEQUENCE public.t_role_permission_role_id_seq OWNED BY public.t_role_permission.role_id;


CREATE TABLE public.t_user (
    id bigint NOT NULL,
    email character varying(255) NOT NULL,
    username character varying(255) NOT NULL,
    password character varying
);


ALTER TABLE public.t_user OWNER TO admin;

CREATE SEQUENCE public.t_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_user_id_seq OWNER TO admin;

ALTER SEQUENCE public.t_user_id_seq OWNED BY public.t_user.id;


CREATE TABLE public.t_user_role (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.t_user_role OWNER TO admin;

CREATE SEQUENCE public.t_user_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_user_role_id_seq OWNER TO admin;

ALTER SEQUENCE public.t_user_role_id_seq OWNED BY public.t_user_role.id;


CREATE SEQUENCE public.t_user_role_role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_user_role_role_id_seq OWNER TO admin;

ALTER SEQUENCE public.t_user_role_role_id_seq OWNED BY public.t_user_role.role_id;


CREATE SEQUENCE public.t_user_role_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.t_user_role_user_id_seq OWNER TO admin;

ALTER SEQUENCE public.t_user_role_user_id_seq OWNED BY public.t_user_role.user_id;


ALTER TABLE ONLY public.t_permission ALTER COLUMN id SET DEFAULT nextval('public.t_permission_id_seq'::regclass);


ALTER TABLE ONLY public.t_role ALTER COLUMN id SET DEFAULT nextval('public.t_role_id_seq'::regclass);


ALTER TABLE ONLY public.t_role_permission ALTER COLUMN id SET DEFAULT nextval('public.t_role_permission_id_seq'::regclass);


ALTER TABLE ONLY public.t_role_permission ALTER COLUMN role_id SET DEFAULT nextval('public.t_role_permission_role_id_seq'::regclass);


ALTER TABLE ONLY public.t_role_permission ALTER COLUMN permission_id SET DEFAULT nextval('public.t_role_permission_permission_id_seq'::regclass);


ALTER TABLE ONLY public.t_user ALTER COLUMN id SET DEFAULT nextval('public.t_user_id_seq'::regclass);


ALTER TABLE ONLY public.t_user_role ALTER COLUMN id SET DEFAULT nextval('public.t_user_role_id_seq'::regclass);


ALTER TABLE ONLY public.t_user_role ALTER COLUMN user_id SET DEFAULT nextval('public.t_user_role_user_id_seq'::regclass);


ALTER TABLE ONLY public.t_user_role ALTER COLUMN role_id SET DEFAULT nextval('public.t_user_role_role_id_seq'::regclass);


COPY public.t_permission (id, permisson_name) FROM stdin;
1	create_appointment
2	read_appointment
3	delete_appointment
4	create_report
5	read_report
6	delete_report
\.


COPY public.t_role (id, role_name) FROM stdin;
1	admin
2	doctor
3	nurse
4	patient
\.


COPY public.t_role_permission (id, role_id, permission_id) FROM stdin;
1	2	2
2	2	4
3	2	5
4	3	2
5	3	5
6	4	1
7	4	2
\.


COPY public.t_user (id, email, username, password) FROM stdin;
1	admin@admin.admin	admin	hashed_password
2	ahmet@ahmet.ahmet	ahmet	hashed_password
3	tuna@tuna.tuna	tuna	hashed_password
4	ali@ali.ali	ali	hashed_password
\.


COPY public.t_user_role (id, user_id, role_id) FROM stdin;
1	1	1
2	2	2
3	3	3
4	4	4
\.


SELECT pg_catalog.setval('public.t_permission_id_seq', 6, true);


SELECT pg_catalog.setval('public.t_role_id_seq', 4, true);


SELECT pg_catalog.setval('public.t_role_permission_id_seq', 7, true);


SELECT pg_catalog.setval('public.t_role_permission_permission_id_seq', 1, false);


SELECT pg_catalog.setval('public.t_role_permission_role_id_seq', 1, false);


SELECT pg_catalog.setval('public.t_user_id_seq', 5, false);


SELECT pg_catalog.setval('public.t_user_role_id_seq', 4, true);


SELECT pg_catalog.setval('public.t_user_role_role_id_seq', 1, false);


SELECT pg_catalog.setval('public.t_user_role_user_id_seq', 1, false);


ALTER TABLE ONLY public.t_permission
    ADD CONSTRAINT t_permission_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.t_role_permission
    ADD CONSTRAINT t_role_permission_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.t_role
    ADD CONSTRAINT t_role_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.t_user
    ADD CONSTRAINT t_user_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.t_user_role
    ADD CONSTRAINT t_user_role_pkey PRIMARY KEY (id);


ALTER TABLE ONLY public.t_role_permission
    ADD CONSTRAINT t_role_permission_permission_id_fkey FOREIGN KEY (permission_id) REFERENCES public.t_permission(id) NOT VALID;


ALTER TABLE ONLY public.t_role_permission
    ADD CONSTRAINT t_role_permission_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.t_role(id) NOT VALID;


ALTER TABLE ONLY public.t_user_role
    ADD CONSTRAINT t_user_role_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.t_role(id) NOT VALID;


ALTER TABLE ONLY public.t_user_role
    ADD CONSTRAINT t_user_role_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.t_user(id) NOT VALID;


