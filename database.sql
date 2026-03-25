--
-- PostgreSQL database dump
--

\restrict QQyOEgcIC8TafcMSz3eIQAyIPbJ5krUYWKbhf8cfzHjHDBT4lZZHdTdibirqJaY

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-03-24 20:42:31

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
-- TOC entry 230 (class 1259 OID 16757)
-- Name: ceny; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ceny (
    id integer NOT NULL,
    nomenklatura_id integer NOT NULL,
    cena numeric(10,2) NOT NULL,
    data_ustanovki date NOT NULL
);


ALTER TABLE public.ceny OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16756)
-- Name: ceny_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.ceny_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.ceny_id_seq OWNER TO postgres;

--
-- TOC entry 5218 (class 0 OID 0)
-- Dependencies: 229
-- Name: ceny_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.ceny_id_seq OWNED BY public.ceny.id;


--
-- TOC entry 248 (class 1259 OID 16936)
-- Name: cost_calculation_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cost_calculation_items (
    id integer NOT NULL,
    raschet_id integer NOT NULL,
    nomenklatura_id integer NOT NULL,
    kolichestvo numeric(10,3) NOT NULL,
    cena numeric(10,2) NOT NULL,
    stoimost numeric(10,2) NOT NULL
);


ALTER TABLE public.cost_calculation_items OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16935)
-- Name: cost_calculation_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cost_calculation_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cost_calculation_items_id_seq OWNER TO postgres;

--
-- TOC entry 5219 (class 0 OID 0)
-- Dependencies: 247
-- Name: cost_calculation_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cost_calculation_items_id_seq OWNED BY public.cost_calculation_items.id;


--
-- TOC entry 246 (class 1259 OID 16910)
-- Name: cost_calculations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cost_calculations (
    id integer NOT NULL,
    nomer_dokumenta character varying(50) NOT NULL,
    data_dokumenta date DEFAULT now() NOT NULL,
    produkt_id integer NOT NULL,
    specifikaciya_id integer NOT NULL,
    itogovaya_stoimost numeric(10,2) NOT NULL
);


ALTER TABLE public.cost_calculations OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16909)
-- Name: cost_calculations_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cost_calculations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cost_calculations_id_seq OWNER TO postgres;

--
-- TOC entry 5220 (class 0 OID 0)
-- Dependencies: 245
-- Name: cost_calculations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cost_calculations_id_seq OWNED BY public.cost_calculations.id;


--
-- TOC entry 236 (class 1259 OID 16810)
-- Name: customer_orders; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.customer_orders (
    id integer NOT NULL,
    nomer character varying(50) NOT NULL,
    data date NOT NULL,
    zakazchik_id character varying(9) NOT NULL
);


ALTER TABLE public.customer_orders OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16809)
-- Name: customer_orders_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.customer_orders_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.customer_orders_id_seq OWNER TO postgres;

--
-- TOC entry 5221 (class 0 OID 0)
-- Dependencies: 235
-- Name: customer_orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.customer_orders_id_seq OWNED BY public.customer_orders.id;


--
-- TOC entry 224 (class 1259 OID 16699)
-- Name: edinicy_izmereniya; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.edinicy_izmereniya (
    id integer NOT NULL,
    kod character varying(10) NOT NULL,
    naimenovanie character varying(20) NOT NULL,
    kratkoe character varying(10) NOT NULL
);


ALTER TABLE public.edinicy_izmereniya OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16698)
-- Name: edinicy_izmereniya_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.edinicy_izmereniya_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.edinicy_izmereniya_id_seq OWNER TO postgres;

--
-- TOC entry 5222 (class 0 OID 0)
-- Dependencies: 223
-- Name: edinicy_izmereniya_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.edinicy_izmereniya_id_seq OWNED BY public.edinicy_izmereniya.id;


--
-- TOC entry 226 (class 1259 OID 16720)
-- Name: kontragent_tipy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kontragent_tipy (
    kontragent_id character varying(9),
    tip_kontragenta_id integer
);


ALTER TABLE public.kontragent_tipy OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16711)
-- Name: kontragenty; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kontragenty (
    id character varying(9) NOT NULL,
    naimenovanie character varying(255) NOT NULL,
    inn character varying(12),
    adres character varying(255),
    telefon character varying(15)
);


ALTER TABLE public.kontragenty OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16734)
-- Name: nomenklatura; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nomenklatura (
    id integer NOT NULL,
    kod_nomenklatury character varying(20),
    naimenovanie character varying(255) NOT NULL,
    tip_id integer NOT NULL,
    edinica_id integer NOT NULL
);


ALTER TABLE public.nomenklatura OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16733)
-- Name: nomenklatura_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.nomenklatura_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.nomenklatura_id_seq OWNER TO postgres;

--
-- TOC entry 5223 (class 0 OID 0)
-- Dependencies: 227
-- Name: nomenklatura_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.nomenklatura_id_seq OWNED BY public.nomenklatura.id;


--
-- TOC entry 238 (class 1259 OID 16828)
-- Name: order_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.order_items (
    id integer NOT NULL,
    zakaz_id integer NOT NULL,
    produkt_id integer NOT NULL,
    kolichestvo numeric(10,3) NOT NULL,
    cena numeric(10,2) NOT NULL,
    naimenovanie_na_moment character varying(255)
);


ALTER TABLE public.order_items OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16827)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.order_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_items_id_seq OWNER TO postgres;

--
-- TOC entry 5224 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.order_items_id_seq OWNED BY public.order_items.id;


--
-- TOC entry 244 (class 1259 OID 16889)
-- Name: prod_materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prod_materials (
    id integer NOT NULL,
    proizvodstvo_id integer NOT NULL,
    material_id integer NOT NULL,
    kolichestvo numeric(10,3) NOT NULL
);


ALTER TABLE public.prod_materials OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16888)
-- Name: prod_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prod_materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prod_materials_id_seq OWNER TO postgres;

--
-- TOC entry 5225 (class 0 OID 0)
-- Dependencies: 243
-- Name: prod_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prod_materials_id_seq OWNED BY public.prod_materials.id;


--
-- TOC entry 242 (class 1259 OID 16868)
-- Name: prod_products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prod_products (
    id integer NOT NULL,
    proizvodstvo_id integer NOT NULL,
    produkt_id integer NOT NULL,
    kolichestvo numeric(10,3) NOT NULL
);


ALTER TABLE public.prod_products OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16867)
-- Name: prod_products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prod_products_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prod_products_id_seq OWNER TO postgres;

--
-- TOC entry 5226 (class 0 OID 0)
-- Dependencies: 241
-- Name: prod_products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prod_products_id_seq OWNED BY public.prod_products.id;


--
-- TOC entry 240 (class 1259 OID 16850)
-- Name: productions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productions (
    id integer NOT NULL,
    nomer character varying(50) NOT NULL,
    data date NOT NULL,
    specifikaciya_id integer NOT NULL
);


ALTER TABLE public.productions OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16849)
-- Name: productions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.productions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.productions_id_seq OWNER TO postgres;

--
-- TOC entry 5227 (class 0 OID 0)
-- Dependencies: 239
-- Name: productions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productions_id_seq OWNED BY public.productions.id;


--
-- TOC entry 250 (class 1259 OID 16959)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character varying(20) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16958)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.roles_id_seq OWNER TO postgres;

--
-- TOC entry 5228 (class 0 OID 0)
-- Dependencies: 249
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- TOC entry 234 (class 1259 OID 16789)
-- Name: spec_materials; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.spec_materials (
    id integer NOT NULL,
    specifikaciya_id integer NOT NULL,
    material_id integer NOT NULL,
    kolichestvo numeric(10,3) NOT NULL
);


ALTER TABLE public.spec_materials OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16788)
-- Name: spec_materials_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.spec_materials_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.spec_materials_id_seq OWNER TO postgres;

--
-- TOC entry 5229 (class 0 OID 0)
-- Dependencies: 233
-- Name: spec_materials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.spec_materials_id_seq OWNED BY public.spec_materials.id;


--
-- TOC entry 232 (class 1259 OID 16773)
-- Name: specifikacii; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specifikacii (
    id integer NOT NULL,
    naimenovanie character varying(255) NOT NULL,
    produkt_id integer NOT NULL,
    bazovoe_kolichestvo numeric(10,3) DEFAULT 1
);


ALTER TABLE public.specifikacii OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16772)
-- Name: specifikacii_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.specifikacii_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.specifikacii_id_seq OWNER TO postgres;

--
-- TOC entry 5230 (class 0 OID 0)
-- Dependencies: 231
-- Name: specifikacii_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.specifikacii_id_seq OWNED BY public.specifikacii.id;


--
-- TOC entry 220 (class 1259 OID 16675)
-- Name: tipy_kontragentov; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipy_kontragentov (
    id integer NOT NULL,
    kod character varying(20) NOT NULL,
    naimenovanie character varying(50) NOT NULL
);


ALTER TABLE public.tipy_kontragentov OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16674)
-- Name: tipy_kontragentov_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipy_kontragentov_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipy_kontragentov_id_seq OWNER TO postgres;

--
-- TOC entry 5231 (class 0 OID 0)
-- Dependencies: 219
-- Name: tipy_kontragentov_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipy_kontragentov_id_seq OWNED BY public.tipy_kontragentov.id;


--
-- TOC entry 222 (class 1259 OID 16687)
-- Name: tipy_nomenklatury; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipy_nomenklatury (
    id integer NOT NULL,
    kod character varying(20) NOT NULL,
    naimenovanie character varying(50) NOT NULL
);


ALTER TABLE public.tipy_nomenklatury OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16686)
-- Name: tipy_nomenklatury_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipy_nomenklatury_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipy_nomenklatury_id_seq OWNER TO postgres;

--
-- TOC entry 5232 (class 0 OID 0)
-- Dependencies: 221
-- Name: tipy_nomenklatury_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipy_nomenklatury_id_seq OWNED BY public.tipy_nomenklatury.id;


--
-- TOC entry 252 (class 1259 OID 16970)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    login character varying(50) NOT NULL,
    password character varying(50) NOT NULL,
    role_id integer,
    is_blocked boolean DEFAULT false,
    attempts integer DEFAULT 0
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 251 (class 1259 OID 16969)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5233 (class 0 OID 0)
-- Dependencies: 251
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4943 (class 2604 OID 16760)
-- Name: ceny id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ceny ALTER COLUMN id SET DEFAULT nextval('public.ceny_id_seq'::regclass);


--
-- TOC entry 4954 (class 2604 OID 16939)
-- Name: cost_calculation_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculation_items ALTER COLUMN id SET DEFAULT nextval('public.cost_calculation_items_id_seq'::regclass);


--
-- TOC entry 4952 (class 2604 OID 16913)
-- Name: cost_calculations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculations ALTER COLUMN id SET DEFAULT nextval('public.cost_calculations_id_seq'::regclass);


--
-- TOC entry 4947 (class 2604 OID 16813)
-- Name: customer_orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_orders ALTER COLUMN id SET DEFAULT nextval('public.customer_orders_id_seq'::regclass);


--
-- TOC entry 4941 (class 2604 OID 16702)
-- Name: edinicy_izmereniya id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edinicy_izmereniya ALTER COLUMN id SET DEFAULT nextval('public.edinicy_izmereniya_id_seq'::regclass);


--
-- TOC entry 4942 (class 2604 OID 16737)
-- Name: nomenklatura id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura ALTER COLUMN id SET DEFAULT nextval('public.nomenklatura_id_seq'::regclass);


--
-- TOC entry 4948 (class 2604 OID 16831)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 4951 (class 2604 OID 16892)
-- Name: prod_materials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_materials ALTER COLUMN id SET DEFAULT nextval('public.prod_materials_id_seq'::regclass);


--
-- TOC entry 4950 (class 2604 OID 16871)
-- Name: prod_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_products ALTER COLUMN id SET DEFAULT nextval('public.prod_products_id_seq'::regclass);


--
-- TOC entry 4949 (class 2604 OID 16853)
-- Name: productions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productions ALTER COLUMN id SET DEFAULT nextval('public.productions_id_seq'::regclass);


--
-- TOC entry 4955 (class 2604 OID 16962)
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- TOC entry 4946 (class 2604 OID 16792)
-- Name: spec_materials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_materials ALTER COLUMN id SET DEFAULT nextval('public.spec_materials_id_seq'::regclass);


--
-- TOC entry 4944 (class 2604 OID 16776)
-- Name: specifikacii id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specifikacii ALTER COLUMN id SET DEFAULT nextval('public.specifikacii_id_seq'::regclass);


--
-- TOC entry 4939 (class 2604 OID 16678)
-- Name: tipy_kontragentov id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_kontragentov ALTER COLUMN id SET DEFAULT nextval('public.tipy_kontragentov_id_seq'::regclass);


--
-- TOC entry 4940 (class 2604 OID 16690)
-- Name: tipy_nomenklatury id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_nomenklatury ALTER COLUMN id SET DEFAULT nextval('public.tipy_nomenklatury_id_seq'::regclass);


--
-- TOC entry 4956 (class 2604 OID 16973)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 5190 (class 0 OID 16757)
-- Dependencies: 230
-- Data for Name: ceny; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ceny (id, nomenklatura_id, cena, data_ustanovki) FROM stdin;
1	1	10.00	2025-01-01
2	2	40.00	2025-01-01
3	3	89.00	2025-01-01
4	4	80.00	2025-01-01
5	5	82.00	2025-01-01
6	6	79.00	2025-01-01
\.


--
-- TOC entry 5208 (class 0 OID 16936)
-- Dependencies: 248
-- Data for Name: cost_calculation_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cost_calculation_items (id, raschet_id, nomenklatura_id, kolichestvo, cena, stoimost) FROM stdin;
1	1	1	0.070	10.00	0.70
2	1	2	0.900	40.00	36.00
\.


--
-- TOC entry 5206 (class 0 OID 16910)
-- Dependencies: 246
-- Data for Name: cost_calculations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cost_calculations (id, nomer_dokumenta, data_dokumenta, produkt_id, specifikaciya_id, itogovaya_stoimost) FROM stdin;
1	РС-001	2025-06-09	3	1	36.70
\.


--
-- TOC entry 5196 (class 0 OID 16810)
-- Dependencies: 236
-- Data for Name: customer_orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.customer_orders (id, nomer, data, zakazchik_id) FROM stdin;
1	2	2025-06-06	000000010
\.


--
-- TOC entry 5184 (class 0 OID 16699)
-- Dependencies: 224
-- Data for Name: edinicy_izmereniya; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.edinicy_izmereniya (id, kod, naimenovanie, kratkoe) FROM stdin;
1	kg	Килограмм	кг
2	pcs	Штука	шт
\.


--
-- TOC entry 5186 (class 0 OID 16720)
-- Dependencies: 226
-- Data for Name: kontragent_tipy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kontragent_tipy (kontragent_id, tip_kontragenta_id) FROM stdin;
000000001	2
000000001	1
000000002	2
000000008	2
000000003	1
000000009	2
000000009	1
000000010	1
\.


--
-- TOC entry 5185 (class 0 OID 16711)
-- Dependencies: 225
-- Data for Name: kontragenty; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kontragenty (id, naimenovanie, inn, adres, telefon) FROM stdin;
000000001	ООО "Поставка"		г.Пятигорск	+79198634592
000000002	ООО "Кинотеатр Квант"	26320045123	г. Железноводск, ул. Мира, 123	+79884581555
000000008	ООО "Новый JDTO"	26320045111	г. Железноводсу	+79884581555
000000003	ООО "Ромашка"	4140784214	г. Омск, ул. Строителей, 294	+79882584546
000000009	ООО "Ипподром"	5874045632	г. Уфа, ул. Набережная,  37	+79627486389
000000010	ООО "Ассоль"	2629011278	г. Калуга, ул. Пушкина, 94	+79184572398
\.


--
-- TOC entry 5188 (class 0 OID 16734)
-- Dependencies: 228
-- Data for Name: nomenklatura; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.nomenklatura (id, kod_nomenklatury, naimenovanie, tip_id, edinica_id) FROM stdin;
1	MAT-001	Закваска сметанная	2	1
2	MAT-002	Молоко нормализованное	2	1
3	PROD-001	Сметана классическая 15% 540г.	1	2
4	PROD-002	Кефир 2,5% 900г.	1	2
5	PROD-003	Кефир 3,2% 900г.	1	2
6	PROD-004	Молоко 2,5% 900г.	1	2
\.


--
-- TOC entry 5198 (class 0 OID 16828)
-- Dependencies: 238
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.order_items (id, zakaz_id, produkt_id, kolichestvo, cena, naimenovanie_na_moment) FROM stdin;
1	1	4	12.000	80.00	Кефир 2,5% 900г.
2	1	5	9.000	82.00	Кефир 3,2% 900г.
3	1	6	10.000	79.00	Молоко 2,5% 900г.
\.


--
-- TOC entry 5204 (class 0 OID 16889)
-- Dependencies: 244
-- Data for Name: prod_materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prod_materials (id, proizvodstvo_id, material_id, kolichestvo) FROM stdin;
1	1	2	0.900
2	1	1	0.070
\.


--
-- TOC entry 5202 (class 0 OID 16868)
-- Dependencies: 242
-- Data for Name: prod_products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prod_products (id, proizvodstvo_id, produkt_id, kolichestvo) FROM stdin;
1	1	3	1.000
\.


--
-- TOC entry 5200 (class 0 OID 16850)
-- Dependencies: 240
-- Data for Name: productions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.productions (id, nomer, data, specifikaciya_id) FROM stdin;
1	1	2025-06-09	1
\.


--
-- TOC entry 5210 (class 0 OID 16959)
-- Dependencies: 250
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	admin
2	user
\.


--
-- TOC entry 5194 (class 0 OID 16789)
-- Dependencies: 234
-- Data for Name: spec_materials; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.spec_materials (id, specifikaciya_id, material_id, kolichestvo) FROM stdin;
1	1	2	0.900
2	1	1	0.070
3	2	2	0.900
4	2	1	0.070
5	3	2	0.900
6	3	1	0.070
7	4	2	0.900
8	4	1	0.070
\.


--
-- TOC entry 5192 (class 0 OID 16773)
-- Dependencies: 232
-- Data for Name: specifikacii; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specifikacii (id, naimenovanie, produkt_id, bazovoe_kolichestvo) FROM stdin;
1	Основная Сметана 15%	3	1.000
2	Спецификация Кефир 2.5%	4	1.000
3	Спецификация Кефир 3.2%	5	1.000
4	Спецификация Молоко 2.5%	6	1.000
\.


--
-- TOC entry 5180 (class 0 OID 16675)
-- Dependencies: 220
-- Data for Name: tipy_kontragentov; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipy_kontragentov (id, kod, naimenovanie) FROM stdin;
1	buyer	Покупатель
2	seller	Продавец
\.


--
-- TOC entry 5182 (class 0 OID 16687)
-- Dependencies: 222
-- Data for Name: tipy_nomenklatury; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipy_nomenklatury (id, kod, naimenovanie) FROM stdin;
1	product	Готовая продукция
2	material	Материал
\.


--
-- TOC entry 5212 (class 0 OID 16970)
-- Dependencies: 252
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, login, password, role_id, is_blocked, attempts) FROM stdin;
1	admin	123	1	f	0
2	user1	3456	2	f	0
\.


--
-- TOC entry 5234 (class 0 OID 0)
-- Dependencies: 229
-- Name: ceny_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.ceny_id_seq', 6, true);


--
-- TOC entry 5235 (class 0 OID 0)
-- Dependencies: 247
-- Name: cost_calculation_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cost_calculation_items_id_seq', 2, true);


--
-- TOC entry 5236 (class 0 OID 0)
-- Dependencies: 245
-- Name: cost_calculations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cost_calculations_id_seq', 1, true);


--
-- TOC entry 5237 (class 0 OID 0)
-- Dependencies: 235
-- Name: customer_orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.customer_orders_id_seq', 1, true);


--
-- TOC entry 5238 (class 0 OID 0)
-- Dependencies: 223
-- Name: edinicy_izmereniya_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.edinicy_izmereniya_id_seq', 2, true);


--
-- TOC entry 5239 (class 0 OID 0)
-- Dependencies: 227
-- Name: nomenklatura_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.nomenklatura_id_seq', 6, true);


--
-- TOC entry 5240 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.order_items_id_seq', 3, true);


--
-- TOC entry 5241 (class 0 OID 0)
-- Dependencies: 243
-- Name: prod_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prod_materials_id_seq', 2, true);


--
-- TOC entry 5242 (class 0 OID 0)
-- Dependencies: 241
-- Name: prod_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prod_products_id_seq', 1, true);


--
-- TOC entry 5243 (class 0 OID 0)
-- Dependencies: 239
-- Name: productions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.productions_id_seq', 1, true);


--
-- TOC entry 5244 (class 0 OID 0)
-- Dependencies: 249
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 2, true);


--
-- TOC entry 5245 (class 0 OID 0)
-- Dependencies: 233
-- Name: spec_materials_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.spec_materials_id_seq', 8, true);


--
-- TOC entry 5246 (class 0 OID 0)
-- Dependencies: 231
-- Name: specifikacii_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.specifikacii_id_seq', 4, true);


--
-- TOC entry 5247 (class 0 OID 0)
-- Dependencies: 219
-- Name: tipy_kontragentov_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipy_kontragentov_id_seq', 2, true);


--
-- TOC entry 5248 (class 0 OID 0)
-- Dependencies: 221
-- Name: tipy_nomenklatury_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipy_nomenklatury_id_seq', 2, true);


--
-- TOC entry 5249 (class 0 OID 0)
-- Dependencies: 251
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- TOC entry 4978 (class 2606 OID 16766)
-- Name: ceny ceny_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ceny
    ADD CONSTRAINT ceny_pkey PRIMARY KEY (id);


--
-- TOC entry 5002 (class 2606 OID 16947)
-- Name: cost_calculation_items cost_calculation_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculation_items
    ADD CONSTRAINT cost_calculation_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4998 (class 2606 OID 16924)
-- Name: cost_calculations cost_calculations_nomer_dokumenta_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculations
    ADD CONSTRAINT cost_calculations_nomer_dokumenta_key UNIQUE (nomer_dokumenta);


--
-- TOC entry 5000 (class 2606 OID 16922)
-- Name: cost_calculations cost_calculations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculations
    ADD CONSTRAINT cost_calculations_pkey PRIMARY KEY (id);


--
-- TOC entry 4984 (class 2606 OID 16821)
-- Name: customer_orders customer_orders_nomer_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_orders
    ADD CONSTRAINT customer_orders_nomer_key UNIQUE (nomer);


--
-- TOC entry 4986 (class 2606 OID 16819)
-- Name: customer_orders customer_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_orders
    ADD CONSTRAINT customer_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4968 (class 2606 OID 16710)
-- Name: edinicy_izmereniya edinicy_izmereniya_kod_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edinicy_izmereniya
    ADD CONSTRAINT edinicy_izmereniya_kod_key UNIQUE (kod);


--
-- TOC entry 4970 (class 2606 OID 16708)
-- Name: edinicy_izmereniya edinicy_izmereniya_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edinicy_izmereniya
    ADD CONSTRAINT edinicy_izmereniya_pkey PRIMARY KEY (id);


--
-- TOC entry 4972 (class 2606 OID 16719)
-- Name: kontragenty kontragenty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontragenty
    ADD CONSTRAINT kontragenty_pkey PRIMARY KEY (id);


--
-- TOC entry 4974 (class 2606 OID 16745)
-- Name: nomenklatura nomenklatura_kod_nomenklatury_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura
    ADD CONSTRAINT nomenklatura_kod_nomenklatury_key UNIQUE (kod_nomenklatury);


--
-- TOC entry 4976 (class 2606 OID 16743)
-- Name: nomenklatura nomenklatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura
    ADD CONSTRAINT nomenklatura_pkey PRIMARY KEY (id);


--
-- TOC entry 4988 (class 2606 OID 16838)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4996 (class 2606 OID 16898)
-- Name: prod_materials prod_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_materials
    ADD CONSTRAINT prod_materials_pkey PRIMARY KEY (id);


--
-- TOC entry 4994 (class 2606 OID 16877)
-- Name: prod_products prod_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_products
    ADD CONSTRAINT prod_products_pkey PRIMARY KEY (id);


--
-- TOC entry 4990 (class 2606 OID 16861)
-- Name: productions productions_nomer_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productions
    ADD CONSTRAINT productions_nomer_key UNIQUE (nomer);


--
-- TOC entry 4992 (class 2606 OID 16859)
-- Name: productions productions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productions
    ADD CONSTRAINT productions_pkey PRIMARY KEY (id);


--
-- TOC entry 5004 (class 2606 OID 16968)
-- Name: roles roles_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_name_key UNIQUE (name);


--
-- TOC entry 5006 (class 2606 OID 16966)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 4982 (class 2606 OID 16798)
-- Name: spec_materials spec_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_materials
    ADD CONSTRAINT spec_materials_pkey PRIMARY KEY (id);


--
-- TOC entry 4980 (class 2606 OID 16782)
-- Name: specifikacii specifikacii_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specifikacii
    ADD CONSTRAINT specifikacii_pkey PRIMARY KEY (id);


--
-- TOC entry 4960 (class 2606 OID 16685)
-- Name: tipy_kontragentov tipy_kontragentov_kod_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_kontragentov
    ADD CONSTRAINT tipy_kontragentov_kod_key UNIQUE (kod);


--
-- TOC entry 4962 (class 2606 OID 16683)
-- Name: tipy_kontragentov tipy_kontragentov_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_kontragentov
    ADD CONSTRAINT tipy_kontragentov_pkey PRIMARY KEY (id);


--
-- TOC entry 4964 (class 2606 OID 16697)
-- Name: tipy_nomenklatury tipy_nomenklatury_kod_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_nomenklatury
    ADD CONSTRAINT tipy_nomenklatury_kod_key UNIQUE (kod);


--
-- TOC entry 4966 (class 2606 OID 16695)
-- Name: tipy_nomenklatury tipy_nomenklatury_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_nomenklatury
    ADD CONSTRAINT tipy_nomenklatury_pkey PRIMARY KEY (id);


--
-- TOC entry 5008 (class 2606 OID 16982)
-- Name: users users_login_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_login_key UNIQUE (login);


--
-- TOC entry 5010 (class 2606 OID 16980)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5015 (class 2606 OID 16767)
-- Name: ceny ceny_nomenklatura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ceny
    ADD CONSTRAINT ceny_nomenklatura_id_fkey FOREIGN KEY (nomenklatura_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5029 (class 2606 OID 16953)
-- Name: cost_calculation_items cost_calculation_items_nomenklatura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculation_items
    ADD CONSTRAINT cost_calculation_items_nomenklatura_id_fkey FOREIGN KEY (nomenklatura_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5030 (class 2606 OID 16948)
-- Name: cost_calculation_items cost_calculation_items_raschet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculation_items
    ADD CONSTRAINT cost_calculation_items_raschet_id_fkey FOREIGN KEY (raschet_id) REFERENCES public.cost_calculations(id);


--
-- TOC entry 5027 (class 2606 OID 16925)
-- Name: cost_calculations cost_calculations_produkt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculations
    ADD CONSTRAINT cost_calculations_produkt_id_fkey FOREIGN KEY (produkt_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5028 (class 2606 OID 16930)
-- Name: cost_calculations cost_calculations_specifikaciya_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculations
    ADD CONSTRAINT cost_calculations_specifikaciya_id_fkey FOREIGN KEY (specifikaciya_id) REFERENCES public.specifikacii(id);


--
-- TOC entry 5019 (class 2606 OID 16822)
-- Name: customer_orders customer_orders_zakazchik_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_orders
    ADD CONSTRAINT customer_orders_zakazchik_id_fkey FOREIGN KEY (zakazchik_id) REFERENCES public.kontragenty(id);


--
-- TOC entry 5011 (class 2606 OID 16723)
-- Name: kontragent_tipy kontragent_tipy_kontragent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontragent_tipy
    ADD CONSTRAINT kontragent_tipy_kontragent_id_fkey FOREIGN KEY (kontragent_id) REFERENCES public.kontragenty(id);


--
-- TOC entry 5012 (class 2606 OID 16728)
-- Name: kontragent_tipy kontragent_tipy_tip_kontragenta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontragent_tipy
    ADD CONSTRAINT kontragent_tipy_tip_kontragenta_id_fkey FOREIGN KEY (tip_kontragenta_id) REFERENCES public.tipy_kontragentov(id);


--
-- TOC entry 5013 (class 2606 OID 16751)
-- Name: nomenklatura nomenklatura_edinica_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura
    ADD CONSTRAINT nomenklatura_edinica_id_fkey FOREIGN KEY (edinica_id) REFERENCES public.edinicy_izmereniya(id);


--
-- TOC entry 5014 (class 2606 OID 16746)
-- Name: nomenklatura nomenklatura_tip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura
    ADD CONSTRAINT nomenklatura_tip_id_fkey FOREIGN KEY (tip_id) REFERENCES public.tipy_nomenklatury(id);


--
-- TOC entry 5020 (class 2606 OID 16844)
-- Name: order_items order_items_produkt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_produkt_id_fkey FOREIGN KEY (produkt_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5021 (class 2606 OID 16839)
-- Name: order_items order_items_zakaz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_zakaz_id_fkey FOREIGN KEY (zakaz_id) REFERENCES public.customer_orders(id);


--
-- TOC entry 5025 (class 2606 OID 16904)
-- Name: prod_materials prod_materials_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_materials
    ADD CONSTRAINT prod_materials_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5026 (class 2606 OID 16899)
-- Name: prod_materials prod_materials_proizvodstvo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_materials
    ADD CONSTRAINT prod_materials_proizvodstvo_id_fkey FOREIGN KEY (proizvodstvo_id) REFERENCES public.productions(id);


--
-- TOC entry 5023 (class 2606 OID 16883)
-- Name: prod_products prod_products_produkt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_products
    ADD CONSTRAINT prod_products_produkt_id_fkey FOREIGN KEY (produkt_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5024 (class 2606 OID 16878)
-- Name: prod_products prod_products_proizvodstvo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_products
    ADD CONSTRAINT prod_products_proizvodstvo_id_fkey FOREIGN KEY (proizvodstvo_id) REFERENCES public.productions(id);


--
-- TOC entry 5022 (class 2606 OID 16862)
-- Name: productions productions_specifikaciya_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productions
    ADD CONSTRAINT productions_specifikaciya_id_fkey FOREIGN KEY (specifikaciya_id) REFERENCES public.specifikacii(id);


--
-- TOC entry 5017 (class 2606 OID 16804)
-- Name: spec_materials spec_materials_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_materials
    ADD CONSTRAINT spec_materials_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5018 (class 2606 OID 16799)
-- Name: spec_materials spec_materials_specifikaciya_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_materials
    ADD CONSTRAINT spec_materials_specifikaciya_id_fkey FOREIGN KEY (specifikaciya_id) REFERENCES public.specifikacii(id);


--
-- TOC entry 5016 (class 2606 OID 16783)
-- Name: specifikacii specifikacii_produkt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specifikacii
    ADD CONSTRAINT specifikacii_produkt_id_fkey FOREIGN KEY (produkt_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5031 (class 2606 OID 16983)
-- Name: users users_role_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_role_id_fkey FOREIGN KEY (role_id) REFERENCES public.roles(id);


-- Completed on 2026-03-24 20:42:31

--
-- PostgreSQL database dump complete
--

\unrestrict QQyOEgcIC8TafcMSz3eIQAyIPbJ5krUYWKbhf8cfzHjHDBT4lZZHdTdibirqJaY

