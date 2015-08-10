--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: cohort; Tablespace: 
--

CREATE TABLE orders (
    id integer NOT NULL,
    user_id integer,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone,
    order_num integer
);


ALTER TABLE orders OWNER TO cohort;

--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: cohort
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE orders_id_seq OWNER TO cohort;

--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cohort
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: cohort; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    created_at timestamp(6) without time zone,
    updated_at timestamp(6) without time zone
);


ALTER TABLE users OWNER TO cohort;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: cohort
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO cohort;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cohort
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cohort
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: cohort
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: cohort
--

COPY orders (id, user_id, created_at, updated_at, order_num) FROM stdin;
\.


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cohort
--

SELECT pg_catalog.setval('orders_id_seq', 2, false);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: cohort
--

COPY users (id, created_at, updated_at) FROM stdin;
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cohort
--

SELECT pg_catalog.setval('users_id_seq', 2, false);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: cohort; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: cohort; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: public; Type: ACL; Schema: -; Owner: cohort
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM cohort;
GRANT ALL ON SCHEMA public TO cohort;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

