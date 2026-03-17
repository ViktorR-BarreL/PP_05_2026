--
-- PostgreSQL database dump
--

\restrict 1SQMygsOeSUmeGmPWyYdB4szKybYjvwuxC1EDXyvZs5lIAiJeemVRhL8QewoTRb

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-03-17 15:31:15

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
-- TOC entry 5161 (class 0 OID 0)
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
-- TOC entry 5162 (class 0 OID 0)
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
-- TOC entry 5163 (class 0 OID 0)
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
-- TOC entry 5164 (class 0 OID 0)
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
-- TOC entry 5165 (class 0 OID 0)
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
-- TOC entry 5166 (class 0 OID 0)
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
-- TOC entry 5167 (class 0 OID 0)
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
-- TOC entry 5168 (class 0 OID 0)
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
-- TOC entry 5169 (class 0 OID 0)
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
-- TOC entry 5170 (class 0 OID 0)
-- Dependencies: 239
-- Name: productions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.productions_id_seq OWNED BY public.productions.id;


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
-- TOC entry 5171 (class 0 OID 0)
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
-- TOC entry 5172 (class 0 OID 0)
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
-- TOC entry 5173 (class 0 OID 0)
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
-- TOC entry 5174 (class 0 OID 0)
-- Dependencies: 221
-- Name: tipy_nomenklatury_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipy_nomenklatury_id_seq OWNED BY public.tipy_nomenklatury.id;


--
-- TOC entry 4933 (class 2604 OID 16760)
-- Name: ceny id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ceny ALTER COLUMN id SET DEFAULT nextval('public.ceny_id_seq'::regclass);


--
-- TOC entry 4944 (class 2604 OID 16939)
-- Name: cost_calculation_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculation_items ALTER COLUMN id SET DEFAULT nextval('public.cost_calculation_items_id_seq'::regclass);


--
-- TOC entry 4942 (class 2604 OID 16913)
-- Name: cost_calculations id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculations ALTER COLUMN id SET DEFAULT nextval('public.cost_calculations_id_seq'::regclass);


--
-- TOC entry 4937 (class 2604 OID 16813)
-- Name: customer_orders id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_orders ALTER COLUMN id SET DEFAULT nextval('public.customer_orders_id_seq'::regclass);


--
-- TOC entry 4931 (class 2604 OID 16702)
-- Name: edinicy_izmereniya id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edinicy_izmereniya ALTER COLUMN id SET DEFAULT nextval('public.edinicy_izmereniya_id_seq'::regclass);


--
-- TOC entry 4932 (class 2604 OID 16737)
-- Name: nomenklatura id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura ALTER COLUMN id SET DEFAULT nextval('public.nomenklatura_id_seq'::regclass);


--
-- TOC entry 4938 (class 2604 OID 16831)
-- Name: order_items id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items ALTER COLUMN id SET DEFAULT nextval('public.order_items_id_seq'::regclass);


--
-- TOC entry 4941 (class 2604 OID 16892)
-- Name: prod_materials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_materials ALTER COLUMN id SET DEFAULT nextval('public.prod_materials_id_seq'::regclass);


--
-- TOC entry 4940 (class 2604 OID 16871)
-- Name: prod_products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_products ALTER COLUMN id SET DEFAULT nextval('public.prod_products_id_seq'::regclass);


--
-- TOC entry 4939 (class 2604 OID 16853)
-- Name: productions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productions ALTER COLUMN id SET DEFAULT nextval('public.productions_id_seq'::regclass);


--
-- TOC entry 4936 (class 2604 OID 16792)
-- Name: spec_materials id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_materials ALTER COLUMN id SET DEFAULT nextval('public.spec_materials_id_seq'::regclass);


--
-- TOC entry 4934 (class 2604 OID 16776)
-- Name: specifikacii id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specifikacii ALTER COLUMN id SET DEFAULT nextval('public.specifikacii_id_seq'::regclass);


--
-- TOC entry 4929 (class 2604 OID 16678)
-- Name: tipy_kontragentov id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_kontragentov ALTER COLUMN id SET DEFAULT nextval('public.tipy_kontragentov_id_seq'::regclass);


--
-- TOC entry 4930 (class 2604 OID 16690)
-- Name: tipy_nomenklatury id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_nomenklatury ALTER COLUMN id SET DEFAULT nextval('public.tipy_nomenklatury_id_seq'::regclass);


--
-- TOC entry 4964 (class 2606 OID 16766)
-- Name: ceny ceny_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ceny
    ADD CONSTRAINT ceny_pkey PRIMARY KEY (id);


--
-- TOC entry 4988 (class 2606 OID 16947)
-- Name: cost_calculation_items cost_calculation_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculation_items
    ADD CONSTRAINT cost_calculation_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4984 (class 2606 OID 16924)
-- Name: cost_calculations cost_calculations_nomer_dokumenta_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculations
    ADD CONSTRAINT cost_calculations_nomer_dokumenta_key UNIQUE (nomer_dokumenta);


--
-- TOC entry 4986 (class 2606 OID 16922)
-- Name: cost_calculations cost_calculations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculations
    ADD CONSTRAINT cost_calculations_pkey PRIMARY KEY (id);


--
-- TOC entry 4970 (class 2606 OID 16821)
-- Name: customer_orders customer_orders_nomer_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_orders
    ADD CONSTRAINT customer_orders_nomer_key UNIQUE (nomer);


--
-- TOC entry 4972 (class 2606 OID 16819)
-- Name: customer_orders customer_orders_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_orders
    ADD CONSTRAINT customer_orders_pkey PRIMARY KEY (id);


--
-- TOC entry 4954 (class 2606 OID 16710)
-- Name: edinicy_izmereniya edinicy_izmereniya_kod_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edinicy_izmereniya
    ADD CONSTRAINT edinicy_izmereniya_kod_key UNIQUE (kod);


--
-- TOC entry 4956 (class 2606 OID 16708)
-- Name: edinicy_izmereniya edinicy_izmereniya_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.edinicy_izmereniya
    ADD CONSTRAINT edinicy_izmereniya_pkey PRIMARY KEY (id);


--
-- TOC entry 4958 (class 2606 OID 16719)
-- Name: kontragenty kontragenty_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontragenty
    ADD CONSTRAINT kontragenty_pkey PRIMARY KEY (id);


--
-- TOC entry 4960 (class 2606 OID 16745)
-- Name: nomenklatura nomenklatura_kod_nomenklatury_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura
    ADD CONSTRAINT nomenklatura_kod_nomenklatury_key UNIQUE (kod_nomenklatury);


--
-- TOC entry 4962 (class 2606 OID 16743)
-- Name: nomenklatura nomenklatura_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura
    ADD CONSTRAINT nomenklatura_pkey PRIMARY KEY (id);


--
-- TOC entry 4974 (class 2606 OID 16838)
-- Name: order_items order_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4982 (class 2606 OID 16898)
-- Name: prod_materials prod_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_materials
    ADD CONSTRAINT prod_materials_pkey PRIMARY KEY (id);


--
-- TOC entry 4980 (class 2606 OID 16877)
-- Name: prod_products prod_products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_products
    ADD CONSTRAINT prod_products_pkey PRIMARY KEY (id);


--
-- TOC entry 4976 (class 2606 OID 16861)
-- Name: productions productions_nomer_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productions
    ADD CONSTRAINT productions_nomer_key UNIQUE (nomer);


--
-- TOC entry 4978 (class 2606 OID 16859)
-- Name: productions productions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productions
    ADD CONSTRAINT productions_pkey PRIMARY KEY (id);


--
-- TOC entry 4968 (class 2606 OID 16798)
-- Name: spec_materials spec_materials_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_materials
    ADD CONSTRAINT spec_materials_pkey PRIMARY KEY (id);


--
-- TOC entry 4966 (class 2606 OID 16782)
-- Name: specifikacii specifikacii_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specifikacii
    ADD CONSTRAINT specifikacii_pkey PRIMARY KEY (id);


--
-- TOC entry 4946 (class 2606 OID 16685)
-- Name: tipy_kontragentov tipy_kontragentov_kod_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_kontragentov
    ADD CONSTRAINT tipy_kontragentov_kod_key UNIQUE (kod);


--
-- TOC entry 4948 (class 2606 OID 16683)
-- Name: tipy_kontragentov tipy_kontragentov_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_kontragentov
    ADD CONSTRAINT tipy_kontragentov_pkey PRIMARY KEY (id);


--
-- TOC entry 4950 (class 2606 OID 16697)
-- Name: tipy_nomenklatury tipy_nomenklatury_kod_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_nomenklatury
    ADD CONSTRAINT tipy_nomenklatury_kod_key UNIQUE (kod);


--
-- TOC entry 4952 (class 2606 OID 16695)
-- Name: tipy_nomenklatury tipy_nomenklatury_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipy_nomenklatury
    ADD CONSTRAINT tipy_nomenklatury_pkey PRIMARY KEY (id);


--
-- TOC entry 4993 (class 2606 OID 16767)
-- Name: ceny ceny_nomenklatura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ceny
    ADD CONSTRAINT ceny_nomenklatura_id_fkey FOREIGN KEY (nomenklatura_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5007 (class 2606 OID 16953)
-- Name: cost_calculation_items cost_calculation_items_nomenklatura_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculation_items
    ADD CONSTRAINT cost_calculation_items_nomenklatura_id_fkey FOREIGN KEY (nomenklatura_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5008 (class 2606 OID 16948)
-- Name: cost_calculation_items cost_calculation_items_raschet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculation_items
    ADD CONSTRAINT cost_calculation_items_raschet_id_fkey FOREIGN KEY (raschet_id) REFERENCES public.cost_calculations(id);


--
-- TOC entry 5005 (class 2606 OID 16925)
-- Name: cost_calculations cost_calculations_produkt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculations
    ADD CONSTRAINT cost_calculations_produkt_id_fkey FOREIGN KEY (produkt_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5006 (class 2606 OID 16930)
-- Name: cost_calculations cost_calculations_specifikaciya_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cost_calculations
    ADD CONSTRAINT cost_calculations_specifikaciya_id_fkey FOREIGN KEY (specifikaciya_id) REFERENCES public.specifikacii(id);


--
-- TOC entry 4997 (class 2606 OID 16822)
-- Name: customer_orders customer_orders_zakazchik_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.customer_orders
    ADD CONSTRAINT customer_orders_zakazchik_id_fkey FOREIGN KEY (zakazchik_id) REFERENCES public.kontragenty(id);


--
-- TOC entry 4989 (class 2606 OID 16723)
-- Name: kontragent_tipy kontragent_tipy_kontragent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontragent_tipy
    ADD CONSTRAINT kontragent_tipy_kontragent_id_fkey FOREIGN KEY (kontragent_id) REFERENCES public.kontragenty(id);


--
-- TOC entry 4990 (class 2606 OID 16728)
-- Name: kontragent_tipy kontragent_tipy_tip_kontragenta_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kontragent_tipy
    ADD CONSTRAINT kontragent_tipy_tip_kontragenta_id_fkey FOREIGN KEY (tip_kontragenta_id) REFERENCES public.tipy_kontragentov(id);


--
-- TOC entry 4991 (class 2606 OID 16751)
-- Name: nomenklatura nomenklatura_edinica_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura
    ADD CONSTRAINT nomenklatura_edinica_id_fkey FOREIGN KEY (edinica_id) REFERENCES public.edinicy_izmereniya(id);


--
-- TOC entry 4992 (class 2606 OID 16746)
-- Name: nomenklatura nomenklatura_tip_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nomenklatura
    ADD CONSTRAINT nomenklatura_tip_id_fkey FOREIGN KEY (tip_id) REFERENCES public.tipy_nomenklatury(id);


--
-- TOC entry 4998 (class 2606 OID 16844)
-- Name: order_items order_items_produkt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_produkt_id_fkey FOREIGN KEY (produkt_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 4999 (class 2606 OID 16839)
-- Name: order_items order_items_zakaz_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.order_items
    ADD CONSTRAINT order_items_zakaz_id_fkey FOREIGN KEY (zakaz_id) REFERENCES public.customer_orders(id);


--
-- TOC entry 5003 (class 2606 OID 16904)
-- Name: prod_materials prod_materials_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_materials
    ADD CONSTRAINT prod_materials_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5004 (class 2606 OID 16899)
-- Name: prod_materials prod_materials_proizvodstvo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_materials
    ADD CONSTRAINT prod_materials_proizvodstvo_id_fkey FOREIGN KEY (proizvodstvo_id) REFERENCES public.productions(id);


--
-- TOC entry 5001 (class 2606 OID 16883)
-- Name: prod_products prod_products_produkt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_products
    ADD CONSTRAINT prod_products_produkt_id_fkey FOREIGN KEY (produkt_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 5002 (class 2606 OID 16878)
-- Name: prod_products prod_products_proizvodstvo_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prod_products
    ADD CONSTRAINT prod_products_proizvodstvo_id_fkey FOREIGN KEY (proizvodstvo_id) REFERENCES public.productions(id);


--
-- TOC entry 5000 (class 2606 OID 16862)
-- Name: productions productions_specifikaciya_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productions
    ADD CONSTRAINT productions_specifikaciya_id_fkey FOREIGN KEY (specifikaciya_id) REFERENCES public.specifikacii(id);


--
-- TOC entry 4995 (class 2606 OID 16804)
-- Name: spec_materials spec_materials_material_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_materials
    ADD CONSTRAINT spec_materials_material_id_fkey FOREIGN KEY (material_id) REFERENCES public.nomenklatura(id);


--
-- TOC entry 4996 (class 2606 OID 16799)
-- Name: spec_materials spec_materials_specifikaciya_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.spec_materials
    ADD CONSTRAINT spec_materials_specifikaciya_id_fkey FOREIGN KEY (specifikaciya_id) REFERENCES public.specifikacii(id);


--
-- TOC entry 4994 (class 2606 OID 16783)
-- Name: specifikacii specifikacii_produkt_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specifikacii
    ADD CONSTRAINT specifikacii_produkt_id_fkey FOREIGN KEY (produkt_id) REFERENCES public.nomenklatura(id);


-- Completed on 2026-03-17 15:31:16

--
-- PostgreSQL database dump complete
--

\unrestrict 1SQMygsOeSUmeGmPWyYdB4szKybYjvwuxC1EDXyvZs5lIAiJeemVRhL8QewoTRb

