--
-- PostgreSQL database dump
--


-- Dumped from database version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.13 (Ubuntu 16.13-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    category_id integer NOT NULL,
    name character varying(100) NOT NULL,
    parent_category_id integer,
    description text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.categories_category_id_seq OWNER TO postgres;

--
-- Name: categories_category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_category_id_seq OWNED BY public.categories.category_id;


--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    employee_id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    role character varying(100) NOT NULL,
    phone character varying(50) NOT NULL,
    email character varying(255),
    manager_id integer,
    hire_date date NOT NULL,
    is_active boolean DEFAULT true
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.employees_employee_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.employees_employee_id_seq OWNER TO postgres;

--
-- Name: employees_employee_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.employees_employee_id_seq OWNED BY public.employees.employee_id;


--
-- Name: medicines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.medicines (
    medicine_id integer NOT NULL,
    name character varying(255) NOT NULL,
    generic_name character varying(255),
    category_id integer,
    manufacturer character varying(255),
    description text,
    requires_prescription boolean DEFAULT false,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.medicines OWNER TO postgres;

--
-- Name: medicines_medicine_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.medicines_medicine_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.medicines_medicine_id_seq OWNER TO postgres;

--
-- Name: medicines_medicine_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.medicines_medicine_id_seq OWNED BY public.medicines.medicine_id;


--
-- Name: patients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.patients (
    patient_id integer NOT NULL,
    full_name character varying(255) NOT NULL,
    date_of_birth date NOT NULL,
    phone character varying(50) NOT NULL,
    email character varying(255),
    address text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_dob CHECK ((date_of_birth <= CURRENT_DATE))
);


ALTER TABLE public.patients OWNER TO postgres;

--
-- Name: patients_patient_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.patients_patient_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.patients_patient_id_seq OWNER TO postgres;

--
-- Name: patients_patient_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.patients_patient_id_seq OWNED BY public.patients.patient_id;


--
-- Name: prescription_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescription_items (
    prescription_id integer NOT NULL,
    medicine_id integer NOT NULL,
    dosage character varying(255),
    quantity integer NOT NULL,
    CONSTRAINT chk_presc_item_qty CHECK ((quantity > 0))
);


ALTER TABLE public.prescription_items OWNER TO postgres;

--
-- Name: prescriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescriptions (
    prescription_id integer NOT NULL,
    patient_id integer NOT NULL,
    employee_id integer NOT NULL,
    issued_date date DEFAULT CURRENT_DATE NOT NULL,
    expiry_date date NOT NULL,
    status character varying(50) DEFAULT 'Active'::character varying,
    notes text,
    CONSTRAINT chk_presc_expiry CHECK ((expiry_date >= issued_date))
);


ALTER TABLE public.prescriptions OWNER TO postgres;

--
-- Name: prescriptions_prescription_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescriptions_prescription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prescriptions_prescription_id_seq OWNER TO postgres;

--
-- Name: prescriptions_prescription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescriptions_prescription_id_seq OWNED BY public.prescriptions.prescription_id;


--
-- Name: sale_items; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sale_items (
    sale_item_id integer NOT NULL,
    sale_id integer NOT NULL,
    batch_id integer NOT NULL,
    quantity integer NOT NULL,
    price_at_sale numeric(12,2) NOT NULL,
    CONSTRAINT chk_sale_price CHECK ((price_at_sale >= (0)::numeric)),
    CONSTRAINT chk_sale_qty CHECK ((quantity > 0))
);


ALTER TABLE public.sale_items OWNER TO postgres;

--
-- Name: sale_items_sale_item_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sale_items_sale_item_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sale_items_sale_item_id_seq OWNER TO postgres;

--
-- Name: sale_items_sale_item_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sale_items_sale_item_id_seq OWNED BY public.sale_items.sale_item_id;


--
-- Name: sales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sales (
    sale_id integer NOT NULL,
    patient_id integer,
    employee_id integer NOT NULL,
    sale_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    total_amount numeric(12,2) DEFAULT 0,
    payment_method character varying(50)
);


ALTER TABLE public.sales OWNER TO postgres;

--
-- Name: sales_sale_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sales_sale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sales_sale_id_seq OWNER TO postgres;

--
-- Name: sales_sale_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sales_sale_id_seq OWNED BY public.sales.sale_id;


--
-- Name: stock_batches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stock_batches (
    batch_id integer NOT NULL,
    medicine_id integer NOT NULL,
    supplier_id integer NOT NULL,
    batch_number character varying(100) NOT NULL,
    quantity integer DEFAULT 0 NOT NULL,
    unit_price numeric(12,2) NOT NULL,
    expiry_date date NOT NULL,
    received_date date DEFAULT CURRENT_DATE NOT NULL,
    CONSTRAINT chk_expiry CHECK ((expiry_date > received_date)),
    CONSTRAINT chk_quantity CHECK ((quantity >= 0)),
    CONSTRAINT chk_unit_price CHECK ((unit_price >= (0)::numeric))
);


ALTER TABLE public.stock_batches OWNER TO postgres;

--
-- Name: stock_batches_batch_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.stock_batches_batch_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.stock_batches_batch_id_seq OWNER TO postgres;

--
-- Name: stock_batches_batch_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.stock_batches_batch_id_seq OWNED BY public.stock_batches.batch_id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliers (
    supplier_id integer NOT NULL,
    name character varying(255) NOT NULL,
    contact_person character varying(255),
    phone character varying(50) NOT NULL,
    email character varying(255),
    address text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.suppliers OWNER TO postgres;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliers_supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliers_supplier_id_seq OWNER TO postgres;

--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliers_supplier_id_seq OWNED BY public.suppliers.supplier_id;


--
-- Name: view_active_prescriptions; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_active_prescriptions AS
 SELECT p.prescription_id,
    pat.full_name AS patient_name,
    emp.full_name AS issued_by,
    p.issued_date,
    p.expiry_date
   FROM ((public.prescriptions p
     JOIN public.patients pat ON ((p.patient_id = pat.patient_id)))
     JOIN public.employees emp ON ((p.employee_id = emp.employee_id)))
  WHERE (((p.status)::text = 'Active'::text) AND (p.expiry_date >= CURRENT_DATE));


ALTER VIEW public.view_active_prescriptions OWNER TO postgres;

--
-- Name: view_expiring_soon; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_expiring_soon AS
 SELECT sb.batch_id,
    m.name AS medicine_name,
    sb.batch_number,
    sb.expiry_date,
    sb.quantity,
    s.name AS supplier_name
   FROM ((public.stock_batches sb
     JOIN public.medicines m ON ((sb.medicine_id = m.medicine_id)))
     JOIN public.suppliers s ON ((sb.supplier_id = s.supplier_id)))
  WHERE ((sb.expiry_date >= CURRENT_DATE) AND (sb.expiry_date <= (CURRENT_DATE + '90 days'::interval)))
  ORDER BY sb.expiry_date;


ALTER VIEW public.view_expiring_soon OWNER TO postgres;

--
-- Name: view_low_stock; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_low_stock AS
 SELECT m.medicine_id,
    m.name,
    sum(sb.quantity) AS total_quantity
   FROM (public.medicines m
     LEFT JOIN public.stock_batches sb ON ((m.medicine_id = sb.medicine_id)))
  GROUP BY m.medicine_id, m.name
 HAVING ((sum(sb.quantity) < 50) OR (sum(sb.quantity) IS NULL))
  ORDER BY (sum(sb.quantity));


ALTER VIEW public.view_low_stock OWNER TO postgres;

--
-- Name: view_monthly_sales; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.view_monthly_sales AS
 SELECT date_trunc('month'::text, sale_date) AS month,
    count(sale_id) AS total_transactions,
    sum(total_amount) AS total_revenue
   FROM public.sales
  GROUP BY (date_trunc('month'::text, sale_date))
  ORDER BY (date_trunc('month'::text, sale_date)) DESC;


ALTER VIEW public.view_monthly_sales OWNER TO postgres;

--
-- Name: categories category_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN category_id SET DEFAULT nextval('public.categories_category_id_seq'::regclass);


--
-- Name: employees employee_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees ALTER COLUMN employee_id SET DEFAULT nextval('public.employees_employee_id_seq'::regclass);


--
-- Name: medicines medicine_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines ALTER COLUMN medicine_id SET DEFAULT nextval('public.medicines_medicine_id_seq'::regclass);


--
-- Name: patients patient_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients ALTER COLUMN patient_id SET DEFAULT nextval('public.patients_patient_id_seq'::regclass);


--
-- Name: prescriptions prescription_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions ALTER COLUMN prescription_id SET DEFAULT nextval('public.prescriptions_prescription_id_seq'::regclass);


--
-- Name: sale_items sale_item_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items ALTER COLUMN sale_item_id SET DEFAULT nextval('public.sale_items_sale_item_id_seq'::regclass);


--
-- Name: sales sale_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales ALTER COLUMN sale_id SET DEFAULT nextval('public.sales_sale_id_seq'::regclass);


--
-- Name: stock_batches batch_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_batches ALTER COLUMN batch_id SET DEFAULT nextval('public.stock_batches_batch_id_seq'::regclass);


--
-- Name: suppliers supplier_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers ALTER COLUMN supplier_id SET DEFAULT nextval('public.suppliers_supplier_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (category_id, name, parent_category_id, description) FROM stdin;
1	Antibiotics	\N	\N
2	Painkillers	\N	\N
3	Cardiovascular	\N	\N
4	Respiratory	\N	\N
5	Vitamins	\N	\N
6	Dermatology	\N	\N
7	Beta-lactams	1	\N
8	NSAIDs	2	\N
9	Statins	3	\N
10	Antihistamines	4	\N
\.


--
-- Data for Name: employees; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.employees (employee_id, full_name, role, phone, email, manager_id, hire_date, is_active) FROM stdin;
1	Aigerim Sultanova	Admin	+996 700 680 180	aigerim.sultanova10@outlook.com	\N	2017-12-10	t
2	Nurlan Bekov	Pharmacist	+996 500 994 477	nurlan.bekov17@yandex.ru	1	2023-09-29	t
3	Aizada Toktomusheva	Pharmacist	+996 700 868 227	aizada.toktomusheva63@mail.ru	2	2023-12-28	t
4	Bakyt Asanov	Manager	+996 555 677 400	bakyt.asanov82@gmail.com	3	2021-07-08	t
5	Cholpon Mamatova	Technician	+996 700 107 296	cholpon.mamatova76@mail.ru	2	2016-01-14	t
6	Sergey Ivanov	Admin	+996 770 112 931	sergey.ivanov61@gmail.com	2	2022-08-15	t
7	Elena Petrova	Manager	+996 770 499 502	elena.petrova2@yandex.ru	4	2021-10-15	t
8	Dmitry Volkov	Admin	+996 555 829 796	dmitry.volkov23@mail.ru	7	2020-03-28	t
9	Aziza Karimova	Manager	+996 555 432 112	aziza.karimova14@gmail.com	2	2017-07-27	t
10	Talgat Nurpeisov	Pharmacist	+996 700 920 918	talgat.nurpeisov59@yandex.ru	9	2015-01-01	t
11	Adilet Usenov	Admin	+996 220 262 470	adilet.usenov40@outlook.com	7	2017-09-18	t
12	Meerim Alieva	Technician	+996 500 348 432	meerim.alieva48@outlook.com	8	2015-09-19	t
13	Ulan Sadykov	Manager	+996 555 725 674	ulan.sadykov81@gmail.com	6	2020-08-30	t
14	Jyldyz Omonova	Technician	+996 500 399 643	jyldyz.omonova18@outlook.com	12	2016-07-25	t
15	Kanykei Isakova	Admin	+996 500 956 382	kanykei.isakova59@mail.ru	6	2018-07-01	t
16	Ermek Kurmanaliev	Admin	+996 220 504 628	ermek.kurmanaliev73@mail.ru	9	2021-02-28	t
17	Bermet Joldosheva	Admin	+996 555 524 756	bermet.joldosheva55@yandex.ru	15	2023-06-08	t
18	Tilek Maratov	Technician	+996 555 973 849	tilek.maratov8@mail.ru	15	2018-02-02	t
19	Dinara Kasymova	Pharmacist	+996 500 168 433	dinara.kasymova51@yandex.ru	8	2023-04-29	t
20	Ruslan Alykulov	Pharmacist	+996 700 359 123	ruslan.alykulov69@gmail.com	12	2020-05-02	t
21	Aisuluu Tursunova	Technician	+996 555 332 275	aisuluu.tursunova18@gmail.com	19	2020-03-02	t
22	Maksat Omurov	Pharmacist	+996 220 547 678	maksat.omurov36@yandex.ru	20	2023-10-12	t
23	Gulnara Satybaldieva	Manager	+996 500 290 181	gulnara.satybaldieva59@outlook.com	16	2021-02-28	t
24	Almaz Bolotov	Manager	+996 500 205 696	almaz.bolotov2@outlook.com	19	2017-06-19	t
25	Saltanat Kerimova	Technician	+996 700 589 421	saltanat.kerimova78@yandex.ru	12	2018-11-20	t
26	Kanat Sydykov	Admin	+996 220 936 692	kanat.sydykov75@yandex.ru	18	2018-11-21	t
27	Nazira Moldalieva	Technician	+996 500 425 678	nazira.moldalieva81@mail.ru	24	2019-07-10	t
28	Azamat Abdyrakhmanov	Manager	+996 770 907 435	azamat.abdyrakhmanov90@yandex.ru	15	2015-11-01	t
29	Elvira Saparova	Admin	+996 770 340 246	elvira.saparova28@yandex.ru	20	2020-04-03	t
30	Kubat Osmonov	Admin	+996 555 828 152	kubat.osmonov70@mail.ru	16	2017-12-31	t
31	Aisuluu Kenjebaeva	Technician	+996 770 773 814	aisuluu.kenjebaeva57@yandex.ru	4	2021-06-24	t
32	Erkin Turdukulov	Technician	+996 700 799 435	erkin.turdukulov76@yandex.ru	9	2022-01-18	t
33	Zamir Begaliev	Manager	+996 555 296 973	zamir.begaliev48@outlook.com	5	2020-07-15	t
34	Kunduz Sharapova	Manager	+996 220 404 369	kunduz.sharapova55@mail.ru	7	2016-07-31	t
35	Asel Akmatova	Admin	+996 500 718 673	asel.akmatova28@outlook.com	27	2017-04-05	t
36	Talant Djumaev	Technician	+996 700 999 181	talant.djumaev11@gmail.com	7	2015-10-04	t
37	Syrga Borubaeva	Pharmacist	+996 700 494 835	syrga.borubaeva59@mail.ru	36	2022-03-23	t
38	Urmat Kalykov	Admin	+996 555 920 791	urmat.kalykov8@outlook.com	12	2015-08-04	t
39	Chinara Ishenbaeva	Admin	+996 555 160 574	chinara.ishenbaeva15@outlook.com	12	2017-07-29	t
40	Medetbek Alybaev	Pharmacist	+996 770 184 220	medetbek.alybaev73@gmail.com	28	2015-12-18	t
41	Nurbek Turganbaev	Manager	+996 555 448 624	nurbek.turganbaev4@gmail.com	20	2020-01-08	t
42	Aigul Esenalieva	Technician	+996 220 947 618	aigul.esenalieva38@yandex.ru	9	2017-07-24	t
43	Beksultan Imanaliev	Admin	+996 555 868 370	beksultan.imanaliev5@mail.ru	30	2022-02-11	t
44	Malika Rustamova	Admin	+996 555 759 541	malika.rustamova82@gmail.com	22	2021-10-23	t
45	Igor Sidorov	Admin	+996 555 173 236	igor.sidorov23@outlook.com	37	2015-10-15	t
46	Tatyana Kuznetsova	Pharmacist	+996 700 907 445	tatyana.kuznetsova43@yandex.ru	21	2016-04-10	t
47	Andrey Popov	Manager	+996 220 683 595	andrey.popov5@yandex.ru	10	2022-10-10	t
48	Marina Vasilyeva	Pharmacist	+996 555 361 100	marina.vasilyeva70@outlook.com	13	2020-12-31	t
49	Victor Kozlov	Pharmacist	+996 700 690 203	victor.kozlov30@gmail.com	30	2023-08-14	t
50	Olga Morozova	Pharmacist	+996 555 385 322	olga.morozova59@yandex.ru	32	2020-03-14	t
\.


--
-- Data for Name: medicines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.medicines (medicine_id, name, generic_name, category_id, manufacturer, description, requires_prescription, created_at) FROM stdin;
1	Atorvastatin 988mg	Atorvastatin	5	PharmaCorp 2	\N	f	2026-05-18 08:36:40.500392
2	Metformin 583mg	Metformin	9	PharmaCorp 7	\N	t	2026-05-18 08:36:40.501683
3	Atorvastatin 249mg	Atorvastatin	1	PharmaCorp 1	\N	t	2026-05-18 08:36:40.502336
4	Paracetamol 629mg	Paracetamol	9	PharmaCorp 7	\N	t	2026-05-18 08:36:40.503122
5	Amoxicillin 929mg	Amoxicillin	9	PharmaCorp 1	\N	t	2026-05-18 08:36:40.504034
6	Amoxicillin 853mg	Amoxicillin	1	PharmaCorp 10	\N	t	2026-05-18 08:36:40.504877
7	Ibuprofen 609mg	Ibuprofen	2	PharmaCorp 7	\N	f	2026-05-18 08:36:40.505641
8	Atorvastatin 170mg	Atorvastatin	8	PharmaCorp 1	\N	f	2026-05-18 08:36:40.506382
9	Omeprazole 792mg	Omeprazole	2	PharmaCorp 10	\N	f	2026-05-18 08:36:40.507085
10	Azithromycin 921mg	Azithromycin	8	PharmaCorp 6	\N	f	2026-05-18 08:36:40.507679
11	Azithromycin 733mg	Azithromycin	1	PharmaCorp 4	\N	t	2026-05-18 08:36:40.508325
12	Omeprazole 677mg	Omeprazole	8	PharmaCorp 10	\N	f	2026-05-18 08:36:40.509159
13	Aspirin 788mg	Aspirin	9	PharmaCorp 8	\N	t	2026-05-18 08:36:40.509755
14	Aspirin 228mg	Aspirin	4	PharmaCorp 3	\N	t	2026-05-18 08:36:40.51056
15	Amoxicillin 175mg	Amoxicillin	3	PharmaCorp 2	\N	t	2026-05-18 08:36:40.511147
16	Paracetamol 687mg	Paracetamol	6	PharmaCorp 1	\N	f	2026-05-18 08:36:40.511753
17	Atorvastatin 646mg	Atorvastatin	1	PharmaCorp 3	\N	t	2026-05-18 08:36:40.514617
18	Azithromycin 917mg	Azithromycin	1	PharmaCorp 9	\N	t	2026-05-18 08:36:40.515377
19	Metformin 531mg	Metformin	2	PharmaCorp 7	\N	f	2026-05-18 08:36:40.516158
20	Ceftriaxone 775mg	Ceftriaxone	5	PharmaCorp 2	\N	f	2026-05-18 08:36:40.516852
21	Ibuprofen 760mg	Ibuprofen	3	PharmaCorp 10	\N	t	2026-05-18 08:36:40.517678
22	Loratadine 693mg	Loratadine	7	PharmaCorp 1	\N	t	2026-05-18 08:36:40.518589
23	Amoxicillin 959mg	Amoxicillin	5	PharmaCorp 8	\N	f	2026-05-18 08:36:40.519495
24	Azithromycin 284mg	Azithromycin	1	PharmaCorp 10	\N	t	2026-05-18 08:36:40.520384
25	Ceftriaxone 115mg	Ceftriaxone	6	PharmaCorp 4	\N	f	2026-05-18 08:36:40.521148
26	Azithromycin 657mg	Azithromycin	1	PharmaCorp 6	\N	t	2026-05-18 08:36:40.522049
27	Omeprazole 511mg	Omeprazole	10	PharmaCorp 3	\N	t	2026-05-18 08:36:40.522957
28	Metformin 591mg	Metformin	7	PharmaCorp 7	\N	t	2026-05-18 08:36:40.523958
29	Paracetamol 575mg	Paracetamol	7	PharmaCorp 10	\N	t	2026-05-18 08:36:40.524777
30	Ceftriaxone 280mg	Ceftriaxone	10	PharmaCorp 3	\N	t	2026-05-18 08:36:40.525695
31	Ibuprofen 605mg	Ibuprofen	3	PharmaCorp 7	\N	t	2026-05-18 08:36:40.526584
32	Paracetamol 148mg	Paracetamol	4	PharmaCorp 4	\N	t	2026-05-18 08:36:40.52742
33	Loratadine 304mg	Loratadine	10	PharmaCorp 4	\N	t	2026-05-18 08:36:40.52816
34	Amoxicillin 943mg	Amoxicillin	9	PharmaCorp 8	\N	t	2026-05-18 08:36:40.529481
35	Ceftriaxone 999mg	Ceftriaxone	1	PharmaCorp 9	\N	t	2026-05-18 08:36:40.530366
36	Aspirin 569mg	Aspirin	1	PharmaCorp 3	\N	t	2026-05-18 08:36:40.531229
37	Metformin 569mg	Metformin	7	PharmaCorp 3	\N	t	2026-05-18 08:36:40.531989
38	Ceftriaxone 859mg	Ceftriaxone	6	PharmaCorp 8	\N	f	2026-05-18 08:36:40.532722
39	Amoxicillin 567mg	Amoxicillin	10	PharmaCorp 10	\N	t	2026-05-18 08:36:40.533636
40	Omeprazole 470mg	Omeprazole	8	PharmaCorp 2	\N	f	2026-05-18 08:36:40.534624
41	Azithromycin 657mg	Azithromycin	3	PharmaCorp 1	\N	t	2026-05-18 08:36:40.535392
42	Omeprazole 382mg	Omeprazole	10	PharmaCorp 7	\N	t	2026-05-18 08:36:40.536071
43	Azithromycin 104mg	Azithromycin	1	PharmaCorp 1	\N	t	2026-05-18 08:36:40.536625
44	Amoxicillin 468mg	Amoxicillin	4	PharmaCorp 7	\N	t	2026-05-18 08:36:40.537259
45	Metformin 123mg	Metformin	5	PharmaCorp 1	\N	f	2026-05-18 08:36:40.537845
46	Atorvastatin 848mg	Atorvastatin	4	PharmaCorp 4	\N	t	2026-05-18 08:36:40.538526
47	Loratadine 680mg	Loratadine	9	PharmaCorp 5	\N	t	2026-05-18 08:36:40.539126
48	Atorvastatin 649mg	Atorvastatin	6	PharmaCorp 10	\N	f	2026-05-18 08:36:40.539657
49	Ibuprofen 923mg	Ibuprofen	2	PharmaCorp 4	\N	f	2026-05-18 08:36:40.540223
50	Aspirin 465mg	Aspirin	7	PharmaCorp 4	\N	t	2026-05-18 08:36:40.540966
51	Omeprazole 412mg	Omeprazole	2	PharmaCorp 6	\N	f	2026-05-18 08:36:40.541553
52	Metformin 186mg	Metformin	1	PharmaCorp 3	\N	t	2026-05-18 08:36:40.542179
53	Metformin 301mg	Metformin	3	PharmaCorp 9	\N	t	2026-05-18 08:36:40.54284
54	Azithromycin 697mg	Azithromycin	9	PharmaCorp 2	\N	t	2026-05-18 08:36:40.543417
55	Ceftriaxone 983mg	Ceftriaxone	2	PharmaCorp 9	\N	f	2026-05-18 08:36:40.543996
56	Atorvastatin 988mg	Atorvastatin	8	PharmaCorp 3	\N	f	2026-05-18 08:36:40.544534
57	Aspirin 532mg	Aspirin	2	PharmaCorp 8	\N	f	2026-05-18 08:36:40.545117
58	Paracetamol 412mg	Paracetamol	2	PharmaCorp 3	\N	f	2026-05-18 08:36:40.54563
59	Atorvastatin 435mg	Atorvastatin	6	PharmaCorp 9	\N	f	2026-05-18 08:36:40.54622
60	Amoxicillin 253mg	Amoxicillin	1	PharmaCorp 5	\N	t	2026-05-18 08:36:40.547076
61	Amoxicillin 756mg	Amoxicillin	3	PharmaCorp 4	\N	t	2026-05-18 08:36:40.547798
62	Paracetamol 863mg	Paracetamol	4	PharmaCorp 3	\N	t	2026-05-18 08:36:40.54848
63	Loratadine 782mg	Loratadine	9	PharmaCorp 6	\N	t	2026-05-18 08:36:40.549098
64	Metformin 231mg	Metformin	1	PharmaCorp 3	\N	t	2026-05-18 08:36:40.549611
65	Metformin 108mg	Metformin	5	PharmaCorp 10	\N	f	2026-05-18 08:36:40.550189
66	Aspirin 100mg	Aspirin	3	PharmaCorp 8	\N	t	2026-05-18 08:36:40.55079
67	Atorvastatin 380mg	Atorvastatin	3	PharmaCorp 6	\N	t	2026-05-18 08:36:40.551395
68	Paracetamol 576mg	Paracetamol	8	PharmaCorp 5	\N	f	2026-05-18 08:36:40.553046
69	Aspirin 257mg	Aspirin	2	PharmaCorp 3	\N	f	2026-05-18 08:36:40.553771
70	Loratadine 388mg	Loratadine	2	PharmaCorp 6	\N	f	2026-05-18 08:36:40.554595
71	Metformin 809mg	Metformin	5	PharmaCorp 10	\N	f	2026-05-18 08:36:40.555355
72	Ceftriaxone 366mg	Ceftriaxone	4	PharmaCorp 5	\N	t	2026-05-18 08:36:40.555997
73	Ibuprofen 724mg	Ibuprofen	9	PharmaCorp 1	\N	t	2026-05-18 08:36:40.556838
74	Loratadine 640mg	Loratadine	3	PharmaCorp 6	\N	t	2026-05-18 08:36:40.557765
75	Metformin 956mg	Metformin	4	PharmaCorp 2	\N	t	2026-05-18 08:36:40.558577
76	Omeprazole 555mg	Omeprazole	7	PharmaCorp 4	\N	t	2026-05-18 08:36:40.559446
77	Ibuprofen 614mg	Ibuprofen	8	PharmaCorp 9	\N	f	2026-05-18 08:36:40.560247
78	Atorvastatin 426mg	Atorvastatin	7	PharmaCorp 4	\N	t	2026-05-18 08:36:40.561032
79	Metformin 995mg	Metformin	7	PharmaCorp 2	\N	t	2026-05-18 08:36:40.561693
80	Aspirin 104mg	Aspirin	3	PharmaCorp 9	\N	t	2026-05-18 08:36:40.562384
81	Aspirin 498mg	Aspirin	5	PharmaCorp 9	\N	f	2026-05-18 08:36:40.563023
82	Aspirin 360mg	Aspirin	1	PharmaCorp 9	\N	t	2026-05-18 08:36:40.56362
83	Ibuprofen 895mg	Ibuprofen	5	PharmaCorp 6	\N	f	2026-05-18 08:36:40.564351
84	Paracetamol 880mg	Paracetamol	7	PharmaCorp 2	\N	t	2026-05-18 08:36:40.565003
85	Azithromycin 134mg	Azithromycin	5	PharmaCorp 7	\N	f	2026-05-18 08:36:40.565804
86	Aspirin 612mg	Aspirin	9	PharmaCorp 1	\N	t	2026-05-18 08:36:40.566566
87	Azithromycin 515mg	Azithromycin	8	PharmaCorp 8	\N	f	2026-05-18 08:36:40.567277
88	Paracetamol 767mg	Paracetamol	2	PharmaCorp 9	\N	f	2026-05-18 08:36:40.567934
89	Metformin 429mg	Metformin	10	PharmaCorp 9	\N	t	2026-05-18 08:36:40.568577
90	Amoxicillin 252mg	Amoxicillin	9	PharmaCorp 7	\N	t	2026-05-18 08:36:40.569364
91	Ceftriaxone 544mg	Ceftriaxone	4	PharmaCorp 1	\N	t	2026-05-18 08:36:40.570672
92	Metformin 801mg	Metformin	2	PharmaCorp 9	\N	f	2026-05-18 08:36:40.571439
93	Ibuprofen 926mg	Ibuprofen	10	PharmaCorp 1	\N	t	2026-05-18 08:36:40.572287
94	Metformin 158mg	Metformin	6	PharmaCorp 2	\N	f	2026-05-18 08:36:40.573006
95	Azithromycin 251mg	Azithromycin	3	PharmaCorp 6	\N	t	2026-05-18 08:36:40.573791
96	Ibuprofen 353mg	Ibuprofen	10	PharmaCorp 4	\N	t	2026-05-18 08:36:40.574638
97	Aspirin 811mg	Aspirin	10	PharmaCorp 9	\N	t	2026-05-18 08:36:40.575301
98	Azithromycin 946mg	Azithromycin	7	PharmaCorp 5	\N	t	2026-05-18 08:36:40.576241
99	Omeprazole 173mg	Omeprazole	6	PharmaCorp 5	\N	f	2026-05-18 08:36:40.576876
100	Ceftriaxone 418mg	Ceftriaxone	5	PharmaCorp 9	\N	f	2026-05-18 08:36:40.577739
\.


--
-- Data for Name: patients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.patients (patient_id, full_name, date_of_birth, phone, email, address, created_at) FROM stdin;
1	Talant Djumaev	2000-05-15	+996 500 145 759	talant.djumaev25@outlook.com	Karakol, Chui Avenue 66, kv. 40	2026-05-18 08:36:40.609697
2	Aisuluu Kenjebaeva	2001-04-27	+996 500 511 623	aisuluu.kenjebaeva59@outlook.com	Jalal-Abad, Toktogul Street 83, kv. 16	2026-05-18 08:36:40.610786
3	Bakyt Asanov	1969-02-17	+996 220 617 975	bakyt.asanov66@gmail.com	Jalal-Abad, Chui Avenue 133, kv. 23	2026-05-18 08:36:40.611279
4	Aisuluu Tursunova	1964-05-12	+996 555 657 278	aisuluu.tursunova52@yandex.ru	Batken, Ibraimova Street 50, kv. 37	2026-05-18 08:36:40.611724
5	Jyldyz Omonova	2004-02-27	+996 500 565 802	jyldyz.omonova44@outlook.com	Naryn, Moskovskaya Street 102, kv. 56	2026-05-18 08:36:40.612321
6	Aisuluu Tursunova	1983-06-03	+996 770 108 903	aisuluu.tursunova4@mail.ru	Batken, Chui Avenue 145, kv. 43	2026-05-18 08:36:40.612801
7	Chinara Ishenbaeva	1995-12-23	+996 770 805 168	chinara.ishenbaeva8@gmail.com	Batken, Ibraimova Street 67, kv. 42	2026-05-18 08:36:40.613293
8	Zamir Begaliev	1993-02-03	+996 500 210 726	zamir.begaliev78@mail.ru	Bishkek, Chui Avenue 48, kv. 14	2026-05-18 08:36:40.613725
9	Zamir Begaliev	2002-02-13	+996 555 403 868	zamir.begaliev37@mail.ru	Jalal-Abad, Moskovskaya Street 52, kv. 1	2026-05-18 08:36:40.615921
10	Kubat Osmonov	1985-07-09	+996 770 193 463	kubat.osmonov1@gmail.com	Jalal-Abad, Lenin Street 21, kv. 50	2026-05-18 08:36:40.616614
11	Tatyana Kuznetsova	1995-11-30	+996 770 572 393	tatyana.kuznetsova56@yandex.ru	Jalal-Abad, Chui Avenue 145, kv. 15	2026-05-18 08:36:40.617136
12	Urmat Kalykov	1965-08-06	+996 500 170 779	urmat.kalykov42@outlook.com	Jalal-Abad, Lenin Street 77, kv. 20	2026-05-18 08:36:40.617563
13	Asel Akmatova	1976-08-31	+996 220 855 678	asel.akmatova38@mail.ru	Osh, Moskovskaya Street 28, kv. 37	2026-05-18 08:36:40.618039
14	Aigul Esenalieva	1983-09-27	+996 220 563 725	aigul.esenalieva64@yandex.ru	Karakol, Chui Avenue 51, kv. 25	2026-05-18 08:36:40.618584
15	Ulan Sadykov	1969-08-27	+996 220 885 364	ulan.sadykov13@gmail.com	Osh, Moskovskaya Street 41, kv. 51	2026-05-18 08:36:40.61916
16	Kubat Osmonov	1983-06-05	+996 220 168 927	kubat.osmonov9@outlook.com	Naryn, Manas Avenue 77, kv. 16	2026-05-18 08:36:40.619735
17	Kanat Sydykov	1955-02-23	+996 700 967 483	kanat.sydykov5@mail.ru	Osh, Erkindik Boulevard 78, kv. 5	2026-05-18 08:36:40.620569
18	Cholpon Mamatova	1957-09-07	+996 555 505 383	cholpon.mamatova44@yandex.ru	Talas, Chui Avenue 19, kv. 17	2026-05-18 08:36:40.621263
19	Saltanat Kerimova	1964-12-14	+996 700 299 654	saltanat.kerimova94@yandex.ru	Karakol, Erkindik Boulevard 117, kv. 1	2026-05-18 08:36:40.622002
20	Gulnara Satybaldieva	1966-04-02	+996 700 497 714	gulnara.satybaldieva61@gmail.com	Talas, Lenin Street 111, kv. 12	2026-05-18 08:36:40.622682
21	Victor Kozlov	1996-12-27	+996 555 945 548	victor.kozlov54@gmail.com	Naryn, Erkindik Boulevard 12, kv. 15	2026-05-18 08:36:40.623272
22	Maksat Omurov	1977-12-29	+996 500 750 722	maksat.omurov13@yandex.ru	Naryn, Toktogul Street 34, kv. 42	2026-05-18 08:36:40.6238
23	Malika Rustamova	1970-06-16	+996 700 138 710	malika.rustamova77@gmail.com	Jalal-Abad, Chui Avenue 103, kv. 21	2026-05-18 08:36:40.624376
24	Erkin Turdukulov	2004-06-06	+996 700 998 112	erkin.turdukulov86@yandex.ru	Naryn, Ibraimova Street 99, kv. 31	2026-05-18 08:36:40.62491
25	Talant Djumaev	1975-08-21	+996 500 987 567	talant.djumaev23@gmail.com	Talas, Manas Avenue 82, kv. 12	2026-05-18 08:36:40.6261
26	Erkin Turdukulov	1951-11-16	+996 700 864 547	erkin.turdukulov85@yandex.ru	Bishkek, Moskovskaya Street 41, kv. 58	2026-05-18 08:36:40.626731
27	Dmitry Volkov	1962-11-05	+996 770 383 132	dmitry.volkov29@yandex.ru	Bishkek, Ibraimova Street 38, kv. 44	2026-05-18 08:36:40.62742
28	Azamat Abdyrakhmanov	1970-11-10	+996 220 481 756	azamat.abdyrakhmanov98@mail.ru	Talas, Chui Avenue 35, kv. 20	2026-05-18 08:36:40.628082
29	Aizada Toktomusheva	1998-11-15	+996 220 187 694	aizada.toktomusheva51@gmail.com	Bishkek, Lenin Street 123, kv. 39	2026-05-18 08:36:40.62884
30	Kunduz Sharapova	1982-07-28	+996 700 275 964	kunduz.sharapova30@yandex.ru	Talas, Erkindik Boulevard 107, kv. 57	2026-05-18 08:36:40.629618
31	Kunduz Sharapova	1995-08-11	+996 555 765 844	kunduz.sharapova83@mail.ru	Talas, Toktogul Street 10, kv. 57	2026-05-18 08:36:40.630454
32	Aizada Toktomusheva	1967-03-11	+996 500 612 754	aizada.toktomusheva9@outlook.com	Naryn, Ibraimova Street 4, kv. 16	2026-05-18 08:36:40.631255
33	Kanat Sydykov	1993-08-01	+996 700 872 300	kanat.sydykov60@yandex.ru	Batken, Erkindik Boulevard 105, kv. 28	2026-05-18 08:36:40.63201
34	Aizada Toktomusheva	1974-05-30	+996 500 748 632	aizada.toktomusheva41@mail.ru	Naryn, Ibraimova Street 13, kv. 11	2026-05-18 08:36:40.6327
35	Ruslan Alykulov	1982-07-17	+996 770 575 588	ruslan.alykulov34@outlook.com	Karakol, Toktogul Street 119, kv. 37	2026-05-18 08:36:40.633476
36	Aigul Esenalieva	1978-08-26	+996 700 982 665	aigul.esenalieva31@yandex.ru	Osh, Erkindik Boulevard 31, kv. 36	2026-05-18 08:36:40.634371
37	Aisuluu Kenjebaeva	1978-11-03	+996 700 399 659	aisuluu.kenjebaeva27@mail.ru	Osh, Toktogul Street 23, kv. 27	2026-05-18 08:36:40.635165
38	Nurlan Bekov	1961-09-12	+996 770 776 271	nurlan.bekov19@outlook.com	Naryn, Lenin Street 75, kv. 27	2026-05-18 08:36:40.635857
39	Chinara Ishenbaeva	2003-08-23	+996 500 673 669	chinara.ishenbaeva14@yandex.ru	Karakol, Moskovskaya Street 79, kv. 39	2026-05-18 08:36:40.636713
40	Zamir Begaliev	1999-07-01	+996 770 352 387	zamir.begaliev50@gmail.com	Batken, Moskovskaya Street 149, kv. 34	2026-05-18 08:36:40.637378
41	Dinara Kasymova	1968-08-09	+996 500 916 671	dinara.kasymova79@yandex.ru	Naryn, Lenin Street 21, kv. 53	2026-05-18 08:36:40.638017
42	Bermet Joldosheva	1959-05-23	+996 220 265 114	bermet.joldosheva32@outlook.com	Talas, Erkindik Boulevard 64, kv. 59	2026-05-18 08:36:40.6388
43	Aigerim Sultanova	1957-11-12	+996 555 707 531	aigerim.sultanova72@outlook.com	Talas, Toktogul Street 51, kv. 4	2026-05-18 08:36:40.639724
44	Aisuluu Kenjebaeva	1982-05-26	+996 700 595 556	aisuluu.kenjebaeva58@gmail.com	Karakol, Manas Avenue 51, kv. 42	2026-05-18 08:36:40.640487
45	Olga Morozova	1996-08-23	+996 770 103 368	olga.morozova55@outlook.com	Bishkek, Toktogul Street 24, kv. 28	2026-05-18 08:36:40.641344
46	Andrey Popov	1970-05-02	+996 770 522 503	andrey.popov66@yandex.ru	Karakol, Lenin Street 150, kv. 21	2026-05-18 08:36:40.642019
47	Aziza Karimova	1992-01-11	+996 770 367 201	aziza.karimova68@mail.ru	Osh, Chui Avenue 6, kv. 13	2026-05-18 08:36:40.642737
48	Nurbek Turganbaev	1986-08-21	+996 770 526 204	nurbek.turganbaev27@outlook.com	Talas, Toktogul Street 22, kv. 32	2026-05-18 08:36:40.64341
49	Kanat Sydykov	1990-04-03	+996 770 903 261	kanat.sydykov2@gmail.com	Batken, Ibraimova Street 3, kv. 19	2026-05-18 08:36:40.644242
50	Dinara Kasymova	1995-07-30	+996 555 760 523	dinara.kasymova45@mail.ru	Bishkek, Toktogul Street 142, kv. 3	2026-05-18 08:36:40.645
51	Asel Akmatova	1959-12-16	+996 770 860 331	asel.akmatova10@mail.ru	Bishkek, Chui Avenue 147, kv. 28	2026-05-18 08:36:40.645611
52	Urmat Kalykov	1968-02-03	+996 500 923 626	urmat.kalykov94@outlook.com	Jalal-Abad, Lenin Street 14, kv. 14	2026-05-18 08:36:40.646495
53	Chinara Ishenbaeva	1985-11-05	+996 700 320 530	chinara.ishenbaeva34@outlook.com	Osh, Lenin Street 129, kv. 38	2026-05-18 08:36:40.647396
54	Nurbek Turganbaev	1998-06-09	+996 220 198 440	nurbek.turganbaev83@yandex.ru	Karakol, Erkindik Boulevard 59, kv. 6	2026-05-18 08:36:40.64836
55	Azamat Abdyrakhmanov	1987-05-02	+996 500 729 616	azamat.abdyrakhmanov39@yandex.ru	Bishkek, Chui Avenue 143, kv. 32	2026-05-18 08:36:40.649051
56	Chinara Ishenbaeva	2004-07-03	+996 555 819 277	chinara.ishenbaeva68@outlook.com	Bishkek, Lenin Street 118, kv. 22	2026-05-18 08:36:40.649644
57	Bermet Joldosheva	1971-11-25	+996 700 255 158	bermet.joldosheva55@yandex.ru	Bishkek, Toktogul Street 149, kv. 6	2026-05-18 08:36:40.650574
58	Erkin Turdukulov	1971-12-06	+996 770 115 560	erkin.turdukulov14@yandex.ru	Batken, Erkindik Boulevard 74, kv. 18	2026-05-18 08:36:40.651155
59	Bermet Joldosheva	1967-10-20	+996 770 515 945	bermet.joldosheva49@mail.ru	Jalal-Abad, Toktogul Street 20, kv. 55	2026-05-18 08:36:40.651648
60	Jyldyz Omonova	1970-04-27	+996 700 359 751	jyldyz.omonova87@yandex.ru	Karakol, Erkindik Boulevard 121, kv. 1	2026-05-18 08:36:40.652205
61	Ermek Kurmanaliev	2002-03-06	+996 770 493 695	ermek.kurmanaliev96@outlook.com	Osh, Lenin Street 107, kv. 23	2026-05-18 08:36:40.65267
62	Beksultan Imanaliev	1973-07-14	+996 770 290 131	beksultan.imanaliev45@gmail.com	Naryn, Manas Avenue 61, kv. 33	2026-05-18 08:36:40.653291
63	Adilet Usenov	1971-10-06	+996 500 421 738	adilet.usenov86@gmail.com	Naryn, Erkindik Boulevard 121, kv. 39	2026-05-18 08:36:40.653851
64	Jyldyz Omonova	1967-11-04	+996 770 715 803	jyldyz.omonova20@yandex.ru	Bishkek, Lenin Street 114, kv. 12	2026-05-18 08:36:40.654481
65	Bakyt Asanov	1955-10-13	+996 770 971 695	bakyt.asanov89@outlook.com	Karakol, Manas Avenue 42, kv. 60	2026-05-18 08:36:40.655074
66	Almaz Bolotov	1986-07-21	+996 770 665 406	almaz.bolotov2@yandex.ru	Talas, Toktogul Street 60, kv. 57	2026-05-18 08:36:40.655588
67	Bermet Joldosheva	1979-12-23	+996 770 736 614	bermet.joldosheva74@gmail.com	Batken, Moskovskaya Street 70, kv. 35	2026-05-18 08:36:40.656338
68	Maksat Omurov	1973-07-20	+996 700 890 313	maksat.omurov98@outlook.com	Batken, Ibraimova Street 35, kv. 23	2026-05-18 08:36:40.657211
69	Saltanat Kerimova	1988-10-21	+996 770 425 576	saltanat.kerimova40@mail.ru	Naryn, Manas Avenue 14, kv. 55	2026-05-18 08:36:40.658041
70	Tilek Maratov	1970-06-14	+996 700 539 434	tilek.maratov42@gmail.com	Batken, Chui Avenue 97, kv. 4	2026-05-18 08:36:40.658566
71	Ulan Sadykov	1961-10-16	+996 555 493 822	ulan.sadykov42@outlook.com	Osh, Chui Avenue 70, kv. 22	2026-05-18 08:36:40.659234
72	Ulan Sadykov	1967-04-29	+996 500 717 729	ulan.sadykov18@yandex.ru	Talas, Lenin Street 60, kv. 35	2026-05-18 08:36:40.659787
73	Tilek Maratov	1996-02-24	+996 555 481 981	tilek.maratov94@outlook.com	Karakol, Ibraimova Street 44, kv. 16	2026-05-18 08:36:40.660488
74	Chinara Ishenbaeva	1960-04-16	+996 500 385 931	chinara.ishenbaeva39@outlook.com	Jalal-Abad, Moskovskaya Street 67, kv. 29	2026-05-18 08:36:40.66116
75	Talant Djumaev	1989-07-01	+996 770 577 708	talant.djumaev6@mail.ru	Naryn, Ibraimova Street 36, kv. 59	2026-05-18 08:36:40.66169
76	Adilet Usenov	1971-09-07	+996 770 652 779	adilet.usenov12@gmail.com	Osh, Manas Avenue 9, kv. 9	2026-05-18 08:36:40.662359
77	Urmat Kalykov	1960-07-10	+996 555 536 487	urmat.kalykov82@mail.ru	Osh, Lenin Street 120, kv. 9	2026-05-18 08:36:40.662847
78	Maksat Omurov	2003-05-12	+996 220 582 455	maksat.omurov34@yandex.ru	Bishkek, Ibraimova Street 150, kv. 6	2026-05-18 08:36:40.663356
79	Ermek Kurmanaliev	1951-02-20	+996 220 220 552	ermek.kurmanaliev26@yandex.ru	Osh, Ibraimova Street 100, kv. 13	2026-05-18 08:36:40.663784
80	Maksat Omurov	1999-07-25	+996 700 747 769	maksat.omurov71@yandex.ru	Talas, Ibraimova Street 10, kv. 54	2026-05-18 08:36:40.664272
81	Kunduz Sharapova	2004-10-27	+996 700 606 767	kunduz.sharapova11@gmail.com	Osh, Ibraimova Street 116, kv. 34	2026-05-18 08:36:40.664733
82	Maksat Omurov	1981-06-26	+996 500 281 600	maksat.omurov17@outlook.com	Jalal-Abad, Chui Avenue 105, kv. 21	2026-05-18 08:36:40.665661
83	Talgat Nurpeisov	1966-08-10	+996 500 107 436	talgat.nurpeisov59@yandex.ru	Karakol, Lenin Street 108, kv. 46	2026-05-18 08:36:40.666487
84	Marina Vasilyeva	1977-10-26	+996 700 630 773	marina.vasilyeva31@gmail.com	Batken, Manas Avenue 86, kv. 2	2026-05-18 08:36:40.667317
85	Adilet Usenov	2001-12-19	+996 700 139 294	adilet.usenov74@outlook.com	Naryn, Toktogul Street 145, kv. 10	2026-05-18 08:36:40.667917
86	Ermek Kurmanaliev	1967-10-08	+996 500 424 126	ermek.kurmanaliev61@mail.ru	Jalal-Abad, Ibraimova Street 130, kv. 35	2026-05-18 08:36:40.668509
87	Aisuluu Tursunova	1980-07-22	+996 555 371 557	aisuluu.tursunova25@yandex.ru	Naryn, Erkindik Boulevard 46, kv. 56	2026-05-18 08:36:40.669109
88	Zamir Begaliev	2005-07-19	+996 700 274 587	zamir.begaliev61@outlook.com	Bishkek, Lenin Street 125, kv. 38	2026-05-18 08:36:40.669618
89	Aigerim Sultanova	1988-11-16	+996 555 397 634	aigerim.sultanova35@outlook.com	Talas, Manas Avenue 23, kv. 13	2026-05-18 08:36:40.670224
90	Nazira Moldalieva	1992-06-04	+996 500 839 913	nazira.moldalieva35@yandex.ru	Talas, Toktogul Street 10, kv. 1	2026-05-18 08:36:40.670845
91	Tatyana Kuznetsova	1951-12-31	+996 555 941 542	tatyana.kuznetsova30@gmail.com	Batken, Lenin Street 93, kv. 7	2026-05-18 08:36:40.671448
92	Olga Morozova	1994-12-15	+996 700 678 263	olga.morozova28@mail.ru	Naryn, Erkindik Boulevard 145, kv. 6	2026-05-18 08:36:40.672097
93	Asel Akmatova	1971-12-19	+996 555 100 992	asel.akmatova36@gmail.com	Osh, Ibraimova Street 37, kv. 23	2026-05-18 08:36:40.672648
94	Talant Djumaev	1951-04-17	+996 220 714 549	talant.djumaev31@gmail.com	Batken, Moskovskaya Street 83, kv. 21	2026-05-18 08:36:40.673226
95	Ermek Kurmanaliev	1972-11-11	+996 700 832 915	ermek.kurmanaliev29@outlook.com	Bishkek, Manas Avenue 53, kv. 9	2026-05-18 08:36:40.673789
96	Ulan Sadykov	1971-11-29	+996 700 521 145	ulan.sadykov91@outlook.com	Jalal-Abad, Moskovskaya Street 121, kv. 7	2026-05-18 08:36:40.674379
97	Olga Morozova	1971-06-24	+996 700 910 241	olga.morozova86@gmail.com	Naryn, Toktogul Street 105, kv. 42	2026-05-18 08:36:40.675008
98	Gulnara Satybaldieva	1959-02-11	+996 555 628 305	gulnara.satybaldieva57@outlook.com	Jalal-Abad, Erkindik Boulevard 28, kv. 30	2026-05-18 08:36:40.675696
99	Aisuluu Kenjebaeva	1995-10-23	+996 500 912 455	aisuluu.kenjebaeva92@gmail.com	Batken, Toktogul Street 32, kv. 51	2026-05-18 08:36:40.676235
100	Ulan Sadykov	1983-05-15	+996 220 344 828	ulan.sadykov76@outlook.com	Jalal-Abad, Manas Avenue 43, kv. 40	2026-05-18 08:36:40.676726
\.


--
-- Data for Name: prescription_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescription_items (prescription_id, medicine_id, dosage, quantity) FROM stdin;
145	63	3 times a day	4
111	95	2 times a day	2
89	85	2 times a day	4
18	48	1 times a day	5
103	69	3 times a day	5
65	48	3 times a day	4
41	91	2 times a day	4
146	38	1 times a day	5
4	23	3 times a day	2
109	96	3 times a day	1
120	80	2 times a day	1
122	49	1 times a day	1
27	69	2 times a day	2
14	87	3 times a day	5
121	47	1 times a day	5
98	39	2 times a day	4
81	54	2 times a day	2
112	49	1 times a day	5
142	4	3 times a day	4
59	5	3 times a day	2
57	13	2 times a day	1
58	3	2 times a day	2
92	51	2 times a day	3
64	100	3 times a day	4
140	68	3 times a day	2
149	39	1 times a day	1
65	33	3 times a day	4
125	35	1 times a day	5
91	44	2 times a day	1
55	76	2 times a day	2
30	73	3 times a day	2
33	29	3 times a day	5
34	81	3 times a day	1
49	87	3 times a day	5
110	63	1 times a day	5
74	31	2 times a day	5
150	10	3 times a day	4
95	36	1 times a day	1
54	50	2 times a day	2
147	57	2 times a day	2
146	33	1 times a day	2
16	56	3 times a day	5
104	12	3 times a day	4
120	66	2 times a day	2
72	7	2 times a day	4
54	7	2 times a day	3
33	44	2 times a day	5
139	82	2 times a day	5
132	46	1 times a day	1
12	25	1 times a day	2
97	38	3 times a day	5
13	97	2 times a day	3
27	64	2 times a day	1
5	17	3 times a day	4
150	13	2 times a day	2
24	88	3 times a day	3
89	70	3 times a day	4
113	27	3 times a day	4
6	29	1 times a day	4
132	5	3 times a day	4
76	47	3 times a day	3
76	78	2 times a day	1
68	86	1 times a day	1
39	52	1 times a day	1
7	20	3 times a day	4
24	10	2 times a day	4
147	7	2 times a day	3
12	39	3 times a day	5
112	23	1 times a day	1
45	96	1 times a day	2
66	2	3 times a day	4
48	81	1 times a day	4
108	11	1 times a day	3
119	19	3 times a day	4
103	49	3 times a day	3
109	3	1 times a day	1
98	32	2 times a day	1
145	76	1 times a day	4
114	29	3 times a day	1
100	46	1 times a day	4
8	70	3 times a day	1
15	94	2 times a day	2
30	83	2 times a day	1
131	99	3 times a day	1
23	24	3 times a day	3
33	16	3 times a day	1
103	57	3 times a day	2
146	49	3 times a day	3
116	84	2 times a day	1
112	85	1 times a day	3
36	78	3 times a day	1
30	35	1 times a day	3
25	51	3 times a day	1
66	78	1 times a day	1
75	39	2 times a day	5
4	71	2 times a day	3
53	6	2 times a day	1
147	39	2 times a day	3
24	24	2 times a day	1
18	35	3 times a day	4
46	46	1 times a day	1
106	96	3 times a day	2
24	95	2 times a day	3
98	52	1 times a day	1
145	89	1 times a day	5
71	69	3 times a day	5
31	2	1 times a day	1
44	15	3 times a day	5
39	21	2 times a day	5
49	46	1 times a day	4
107	9	1 times a day	1
17	54	3 times a day	4
32	38	1 times a day	5
14	55	1 times a day	3
35	61	1 times a day	4
26	25	2 times a day	3
42	8	1 times a day	4
39	24	1 times a day	3
20	72	2 times a day	1
73	70	1 times a day	1
86	90	3 times a day	4
36	34	2 times a day	3
20	96	2 times a day	1
59	95	3 times a day	2
117	7	3 times a day	5
44	59	1 times a day	2
11	7	2 times a day	1
46	73	3 times a day	4
148	73	1 times a day	1
149	50	1 times a day	3
136	17	2 times a day	1
25	21	3 times a day	4
93	98	2 times a day	2
21	44	2 times a day	5
84	87	2 times a day	5
73	35	2 times a day	4
41	86	2 times a day	4
56	36	3 times a day	5
3	69	2 times a day	1
2	32	1 times a day	5
138	88	2 times a day	4
134	96	3 times a day	1
111	73	2 times a day	4
82	12	3 times a day	3
44	9	1 times a day	3
73	13	2 times a day	2
5	77	1 times a day	5
112	71	1 times a day	3
9	40	2 times a day	1
77	91	1 times a day	1
81	28	1 times a day	4
41	53	1 times a day	4
48	40	2 times a day	1
132	23	2 times a day	4
34	65	1 times a day	1
110	26	3 times a day	5
38	27	1 times a day	2
19	11	1 times a day	2
124	75	3 times a day	3
106	9	2 times a day	5
61	31	3 times a day	5
35	14	1 times a day	1
114	68	2 times a day	2
116	73	1 times a day	4
124	23	1 times a day	1
50	30	1 times a day	3
32	77	3 times a day	3
2	68	2 times a day	4
78	7	3 times a day	1
105	17	3 times a day	5
83	97	2 times a day	3
72	23	2 times a day	2
44	26	3 times a day	1
50	86	2 times a day	1
118	52	1 times a day	4
126	77	1 times a day	3
104	82	2 times a day	1
147	56	2 times a day	1
19	94	3 times a day	4
8	99	2 times a day	1
17	46	3 times a day	3
51	15	1 times a day	4
74	47	1 times a day	2
106	26	3 times a day	2
121	27	2 times a day	2
17	43	2 times a day	2
34	77	2 times a day	3
137	64	2 times a day	1
135	22	1 times a day	2
11	78	2 times a day	4
48	83	1 times a day	5
28	2	2 times a day	5
149	19	2 times a day	4
43	37	2 times a day	5
21	31	2 times a day	3
108	91	1 times a day	5
134	37	2 times a day	5
108	24	3 times a day	2
49	83	3 times a day	3
87	94	1 times a day	3
118	90	2 times a day	1
20	16	3 times a day	4
15	74	2 times a day	4
147	72	3 times a day	1
46	54	3 times a day	1
120	81	1 times a day	3
1	17	2 times a day	2
138	19	3 times a day	2
71	20	3 times a day	3
142	16	3 times a day	1
65	98	3 times a day	1
71	44	3 times a day	5
77	16	3 times a day	1
40	65	2 times a day	3
60	10	1 times a day	1
64	68	3 times a day	4
79	92	2 times a day	5
17	16	1 times a day	3
10	11	3 times a day	1
29	93	2 times a day	1
22	89	2 times a day	1
39	81	3 times a day	3
68	64	1 times a day	4
48	58	3 times a day	2
22	8	3 times a day	3
91	9	3 times a day	1
47	49	2 times a day	1
58	89	1 times a day	3
52	77	1 times a day	2
95	90	1 times a day	4
37	31	1 times a day	4
65	9	1 times a day	5
130	84	1 times a day	3
57	100	1 times a day	5
111	76	2 times a day	1
12	72	2 times a day	2
146	30	1 times a day	1
48	87	1 times a day	5
81	92	1 times a day	5
92	94	2 times a day	1
14	97	3 times a day	4
121	35	3 times a day	3
8	7	1 times a day	1
77	27	1 times a day	2
121	96	1 times a day	4
48	95	1 times a day	2
130	73	2 times a day	3
58	28	3 times a day	4
81	83	3 times a day	4
38	7	3 times a day	1
37	77	2 times a day	1
33	19	2 times a day	2
24	61	1 times a day	3
145	4	3 times a day	3
26	15	1 times a day	3
21	28	1 times a day	3
100	58	2 times a day	3
52	97	1 times a day	2
37	51	3 times a day	1
115	81	1 times a day	1
133	62	1 times a day	3
17	58	2 times a day	3
59	69	3 times a day	2
25	8	2 times a day	4
145	1	3 times a day	1
141	23	2 times a day	5
104	47	1 times a day	4
149	79	3 times a day	2
69	37	3 times a day	2
100	8	1 times a day	4
122	44	3 times a day	4
124	51	1 times a day	4
112	86	1 times a day	3
110	61	1 times a day	4
58	51	2 times a day	3
134	38	2 times a day	3
101	16	2 times a day	5
62	3	3 times a day	5
10	59	1 times a day	2
120	34	2 times a day	5
139	85	2 times a day	5
73	50	3 times a day	2
83	63	3 times a day	2
35	45	1 times a day	2
141	22	1 times a day	4
112	22	2 times a day	2
12	56	1 times a day	5
6	37	3 times a day	1
50	49	2 times a day	4
150	96	3 times a day	4
108	41	2 times a day	4
59	68	3 times a day	2
57	62	1 times a day	4
57	24	2 times a day	5
142	59	1 times a day	5
135	79	3 times a day	3
115	96	2 times a day	3
\.


--
-- Data for Name: prescriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescriptions (prescription_id, patient_id, employee_id, issued_date, expiry_date, status, notes) FROM stdin;
1	62	8	2024-09-07	2024-10-26	Active	\N
2	30	17	2024-10-24	2025-03-03	Active	\N
3	14	14	2024-03-30	2024-09-10	Active	\N
4	16	44	2024-12-19	2025-05-18	Active	\N
5	18	32	2024-11-21	2025-03-15	Active	\N
6	73	12	2023-06-14	2023-07-24	Active	\N
7	5	37	2024-12-17	2025-05-04	Active	\N
8	80	44	2024-09-25	2024-10-28	Active	\N
9	12	43	2024-10-06	2024-12-20	Active	\N
10	6	16	2023-08-12	2023-11-04	Active	\N
11	70	12	2023-07-25	2023-09-28	Active	\N
12	30	23	2024-06-06	2024-09-04	Active	\N
13	11	16	2023-01-01	2023-03-12	Active	\N
14	14	3	2023-10-23	2023-12-14	Active	\N
15	95	34	2023-07-13	2023-11-11	Active	\N
16	73	47	2024-03-13	2024-05-20	Active	\N
17	94	17	2024-04-22	2024-10-02	Active	\N
18	71	20	2024-09-21	2024-11-15	Active	\N
19	47	16	2024-08-15	2024-12-17	Active	\N
20	41	29	2023-01-12	2023-04-10	Active	\N
21	66	32	2023-10-13	2023-12-09	Active	\N
22	52	32	2023-06-20	2023-09-28	Active	\N
23	23	12	2024-01-25	2024-05-29	Active	\N
24	55	35	2023-06-22	2023-08-04	Active	\N
25	63	7	2023-06-12	2023-11-08	Active	\N
26	13	47	2024-04-17	2024-08-17	Active	\N
27	98	25	2023-06-18	2023-08-07	Active	\N
28	46	43	2023-11-09	2024-01-11	Active	\N
29	100	8	2023-12-04	2024-05-30	Active	\N
30	28	7	2024-06-21	2024-09-14	Active	\N
31	20	26	2023-09-02	2024-01-19	Active	\N
32	19	21	2024-10-25	2025-03-30	Active	\N
33	78	27	2023-06-22	2023-09-07	Active	\N
34	70	37	2024-04-15	2024-07-29	Active	\N
35	93	7	2024-07-23	2024-11-24	Active	\N
36	81	13	2023-12-16	2024-04-27	Active	\N
37	2	29	2024-09-02	2025-01-24	Active	\N
38	13	49	2023-12-27	2024-04-17	Active	\N
39	50	43	2024-02-16	2024-05-28	Active	\N
40	77	8	2024-12-15	2025-02-27	Active	\N
41	70	37	2024-03-08	2024-08-26	Active	\N
42	100	22	2024-03-28	2024-05-30	Active	\N
43	46	42	2024-10-10	2024-12-12	Active	\N
44	52	3	2024-04-30	2024-08-24	Active	\N
45	58	23	2024-09-25	2024-12-23	Active	\N
46	32	9	2023-06-02	2023-11-04	Active	\N
47	70	13	2023-05-03	2023-09-17	Active	\N
48	72	45	2023-07-22	2023-10-23	Active	\N
49	59	7	2024-08-14	2024-10-20	Active	\N
50	85	48	2024-09-27	2024-12-24	Active	\N
51	70	47	2023-10-22	2024-03-07	Active	\N
52	95	4	2024-12-12	2025-02-07	Active	\N
53	60	41	2024-12-28	2025-06-16	Active	\N
54	98	5	2023-09-17	2024-01-06	Active	\N
55	12	45	2023-07-16	2023-11-20	Active	\N
56	72	46	2023-07-26	2023-11-26	Active	\N
57	63	38	2023-05-19	2023-08-12	Active	\N
58	57	11	2024-02-03	2024-03-17	Active	\N
59	74	26	2023-04-25	2023-09-15	Active	\N
60	33	46	2024-06-17	2024-10-28	Active	\N
61	79	25	2024-10-17	2024-12-23	Active	\N
62	94	44	2024-10-30	2025-04-04	Active	\N
63	62	38	2024-06-11	2024-08-02	Active	\N
64	69	27	2023-05-09	2023-07-24	Active	\N
65	36	46	2024-11-04	2025-01-21	Active	\N
66	69	19	2024-03-15	2024-06-25	Active	\N
67	22	10	2024-06-06	2024-10-20	Active	\N
68	89	9	2024-03-02	2024-06-27	Active	\N
69	62	33	2023-12-26	2024-02-21	Active	\N
70	10	4	2024-12-11	2025-01-15	Active	\N
71	69	38	2023-06-25	2023-11-01	Active	\N
72	99	21	2023-09-27	2023-11-19	Active	\N
73	31	36	2023-06-15	2023-11-17	Active	\N
74	39	38	2023-08-30	2023-11-16	Active	\N
75	42	6	2023-11-09	2024-01-31	Active	\N
76	3	6	2023-09-10	2023-11-15	Active	\N
77	50	11	2023-09-11	2023-10-15	Active	\N
78	41	20	2024-07-22	2024-12-13	Active	\N
79	96	22	2024-10-22	2024-12-15	Active	\N
80	86	9	2023-03-18	2023-09-08	Active	\N
81	63	35	2023-01-31	2023-07-21	Active	\N
82	87	42	2023-01-29	2023-06-11	Active	\N
83	28	44	2023-11-15	2024-05-11	Active	\N
84	39	50	2023-09-06	2024-01-08	Active	\N
85	11	41	2023-08-29	2023-12-28	Active	\N
86	45	45	2024-06-16	2024-10-21	Active	\N
87	82	24	2024-01-05	2024-06-03	Active	\N
88	70	20	2024-04-06	2024-08-05	Active	\N
89	72	13	2023-04-19	2023-05-29	Active	\N
90	76	45	2024-03-24	2024-06-07	Active	\N
91	20	33	2023-06-11	2023-12-04	Active	\N
92	21	23	2023-07-15	2023-10-27	Active	\N
93	37	29	2024-03-31	2024-07-05	Active	\N
94	22	1	2023-07-14	2023-10-07	Active	\N
95	83	6	2023-04-01	2023-07-12	Active	\N
96	84	9	2024-11-03	2025-01-28	Active	\N
97	56	45	2024-01-06	2024-05-17	Active	\N
98	26	43	2023-10-05	2024-02-03	Active	\N
99	2	32	2023-02-14	2023-05-23	Active	\N
100	20	19	2024-04-23	2024-07-22	Active	\N
101	25	7	2024-04-06	2024-08-30	Active	\N
102	26	21	2023-07-28	2023-10-03	Active	\N
103	91	13	2023-12-29	2024-06-06	Active	\N
104	49	28	2023-02-28	2023-07-11	Active	\N
105	54	46	2023-11-15	2024-02-15	Active	\N
106	100	21	2023-12-03	2024-03-16	Active	\N
107	74	3	2024-06-18	2024-09-01	Active	\N
108	51	44	2024-06-29	2024-10-20	Active	\N
109	75	37	2024-04-14	2024-07-31	Active	\N
110	77	3	2024-04-21	2024-07-21	Active	\N
111	43	12	2024-12-18	2025-05-26	Active	\N
112	82	12	2023-01-06	2023-06-11	Active	\N
113	17	8	2024-01-06	2024-06-11	Active	\N
114	40	33	2023-07-06	2023-09-15	Active	\N
115	22	29	2023-12-21	2024-06-09	Active	\N
116	52	6	2024-05-26	2024-10-27	Active	\N
117	11	14	2024-05-30	2024-08-03	Active	\N
118	15	46	2023-04-10	2023-05-16	Active	\N
119	33	33	2024-07-07	2024-08-19	Active	\N
120	57	40	2024-11-16	2025-04-24	Active	\N
121	88	39	2023-03-24	2023-07-27	Active	\N
122	78	32	2023-12-13	2024-02-21	Active	\N
123	17	23	2024-05-12	2024-10-16	Active	\N
124	72	1	2023-05-17	2023-06-29	Active	\N
125	81	3	2024-09-29	2024-12-18	Active	\N
126	99	42	2024-12-18	2025-05-29	Active	\N
127	88	29	2023-11-05	2024-04-06	Active	\N
128	87	35	2023-12-15	2024-06-06	Active	\N
129	50	47	2023-06-29	2023-11-19	Active	\N
130	68	23	2023-12-28	2024-03-05	Active	\N
131	70	21	2024-04-01	2024-06-21	Active	\N
132	30	13	2023-04-16	2023-08-09	Active	\N
133	37	33	2024-05-15	2024-07-03	Active	\N
134	85	8	2023-03-10	2023-08-21	Active	\N
135	59	2	2023-03-27	2023-05-08	Active	\N
136	27	44	2024-02-04	2024-05-25	Active	\N
137	85	27	2024-09-11	2025-03-07	Active	\N
138	42	31	2024-12-14	2025-05-27	Active	\N
139	58	48	2024-10-11	2025-01-30	Active	\N
140	17	48	2023-11-12	2023-12-13	Active	\N
141	67	16	2024-10-13	2024-12-20	Active	\N
142	6	46	2024-06-09	2024-09-02	Active	\N
143	14	5	2023-10-25	2024-03-28	Active	\N
144	3	44	2024-10-20	2025-02-24	Active	\N
145	4	29	2024-06-16	2024-12-10	Active	\N
146	56	23	2024-01-16	2024-05-07	Active	\N
147	31	37	2023-12-08	2024-04-25	Active	\N
148	34	1	2024-10-24	2024-12-18	Active	\N
149	13	7	2024-05-23	2024-08-09	Active	\N
150	42	40	2023-01-01	2023-05-10	Active	\N
\.


--
-- Data for Name: sale_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sale_items (sale_item_id, sale_id, batch_id, quantity, price_at_sale) FROM stdin;
1	179	132	3	1088.48
2	162	40	2	252.92
3	43	167	3	803.46
4	86	78	2	1117.46
5	46	9	2	570.73
6	55	58	2	733.71
7	25	63	3	977.26
8	190	112	2	1357.66
9	2	127	3	343.45
10	63	108	1	803.79
11	114	35	3	484.77
12	209	95	1	101.92
13	201	191	3	435.24
14	98	113	2	497.88
15	73	165	2	745.95
16	209	83	1	1196.97
17	160	100	1	509.18
18	22	138	3	1229.45
19	140	50	2	1098.21
20	158	1	2	926.10
21	83	196	2	243.67
22	123	84	3	506.34
23	88	67	1	918.45
24	144	135	2	552.99
25	178	63	3	1179.33
26	173	67	3	372.85
27	188	147	2	1198.03
28	45	75	2	1032.42
29	165	200	1	262.23
30	160	34	1	408.45
31	79	154	1	1339.71
32	89	150	1	1202.59
33	125	20	2	1464.84
34	82	7	1	978.62
35	80	197	1	213.15
36	172	50	2	635.25
37	149	125	1	1127.39
38	78	122	2	1392.40
39	241	12	2	1404.82
40	58	143	1	279.48
41	204	172	2	806.57
42	151	68	2	533.43
43	198	168	2	764.13
44	170	28	3	932.48
45	233	113	1	1282.25
46	194	11	1	451.53
47	67	123	2	967.37
48	78	72	1	264.38
49	112	55	1	1023.31
50	97	174	3	1433.48
51	132	78	2	133.59
52	57	106	2	639.72
53	168	7	1	447.58
54	138	141	1	211.27
55	58	149	3	247.04
56	44	196	2	1114.46
57	66	191	1	660.38
58	172	196	3	237.37
59	17	133	2	931.20
60	42	124	2	897.93
61	13	177	2	859.08
62	52	4	3	650.00
63	219	143	3	1174.78
64	96	36	2	1005.98
65	186	109	1	1437.06
66	210	175	3	1420.77
67	148	193	3	613.05
68	206	171	1	1137.06
69	131	159	1	210.58
70	69	7	2	986.85
71	95	194	2	1421.66
72	30	67	1	811.03
73	136	38	1	423.85
74	87	70	3	1298.96
75	69	194	2	1188.19
76	58	141	2	1343.82
77	31	80	3	1352.21
78	183	74	1	491.32
79	166	162	1	793.18
80	181	132	3	1414.97
81	9	182	3	1348.28
82	75	76	3	1296.14
83	37	48	3	835.00
84	168	189	3	1197.76
85	11	109	3	817.27
86	134	151	2	1163.72
87	117	31	2	681.96
88	82	192	1	759.66
89	158	142	2	378.45
90	128	103	2	281.93
91	209	37	3	1400.50
92	7	15	3	681.35
93	66	1	3	727.60
94	75	23	1	1056.27
95	133	129	2	919.02
96	249	104	2	798.95
97	224	95	1	284.98
98	38	40	1	1220.95
99	18	145	2	923.24
100	28	55	3	1242.30
101	141	167	1	138.05
102	135	62	2	513.36
103	55	151	2	1431.66
104	134	144	2	594.07
105	151	69	2	179.13
106	28	19	2	164.03
107	137	117	3	392.20
108	25	193	2	845.16
109	193	198	2	301.03
110	149	3	1	1494.92
111	212	46	3	557.77
112	161	172	2	794.93
113	13	96	3	1385.79
114	95	76	3	465.49
115	174	74	3	1490.44
116	80	179	2	369.16
117	94	29	1	1348.52
118	39	116	2	1231.24
119	126	130	3	1306.71
120	26	14	2	817.80
121	211	176	2	493.47
122	230	170	2	172.62
123	151	8	1	1120.13
124	179	73	1	531.65
125	78	184	2	377.17
126	153	66	1	682.09
127	72	183	1	898.44
128	129	17	2	775.81
129	3	174	3	1157.18
130	185	141	1	703.55
131	241	157	3	737.81
132	212	77	1	1203.66
133	186	22	2	1079.92
134	42	41	1	599.15
135	180	69	1	186.51
136	195	56	3	427.25
137	150	112	2	1263.36
138	232	130	2	834.28
139	74	141	2	1435.94
140	105	85	3	156.34
141	140	27	1	627.73
142	106	23	2	368.44
143	170	85	2	411.65
144	150	181	3	264.28
145	135	181	3	1431.35
146	158	63	1	784.93
147	214	30	2	1011.55
148	18	57	1	1495.61
149	240	65	2	1325.10
150	130	36	2	718.59
151	67	41	3	668.12
152	244	84	2	826.17
153	115	47	3	271.61
154	41	125	1	896.00
155	105	72	2	873.07
156	10	92	2	609.75
157	186	108	1	581.76
158	191	127	2	173.49
159	171	191	3	283.25
160	247	4	2	208.23
161	208	151	3	221.51
162	123	35	1	799.45
163	73	84	2	1333.09
164	117	1	3	671.32
165	131	45	3	357.74
166	214	60	1	337.56
167	105	199	2	210.56
168	3	126	3	198.89
169	21	10	2	658.78
170	197	71	1	993.92
171	71	5	3	1005.39
172	103	173	1	1348.69
173	91	46	3	1041.13
174	120	37	2	269.70
175	168	18	3	1018.16
176	52	200	1	602.14
177	184	34	1	740.82
178	50	96	1	715.91
179	236	47	3	575.55
180	203	18	3	1411.34
181	217	145	2	1123.39
182	35	85	2	253.43
183	218	196	1	759.42
184	50	140	1	685.13
185	216	166	1	479.79
186	46	174	2	560.88
187	166	28	2	1398.41
188	24	94	2	1394.92
189	103	60	3	110.36
190	207	107	1	1091.60
191	130	76	3	247.47
192	73	38	2	865.14
193	87	21	1	886.27
194	51	135	2	536.27
195	83	25	2	1142.61
196	126	36	2	1099.28
197	223	29	1	1415.13
198	175	116	2	687.42
199	186	183	3	1342.02
200	173	143	1	1240.60
201	246	183	1	706.76
202	35	31	2	148.04
203	110	25	2	1098.29
204	129	45	1	553.52
205	218	50	2	604.85
206	199	153	3	307.02
207	191	135	2	584.19
208	201	5	3	688.68
209	135	121	2	671.61
210	145	32	1	1380.08
211	43	200	2	962.76
212	95	153	2	1492.46
213	150	189	3	816.15
214	26	129	3	836.26
215	26	70	2	291.82
216	250	70	1	250.46
217	211	68	2	1028.06
218	236	72	2	562.15
219	136	126	2	439.07
220	101	63	2	1198.75
221	175	105	3	531.35
222	232	168	2	582.66
223	123	44	1	136.70
224	235	165	2	260.40
225	39	114	2	1437.95
226	227	37	2	1105.36
227	168	173	2	1152.07
228	83	152	2	997.94
229	43	172	2	993.23
230	238	172	1	357.73
231	223	184	2	1091.87
232	72	173	1	188.73
233	112	91	3	1250.78
234	70	31	1	807.17
235	168	169	3	790.00
236	41	103	3	856.93
237	77	3	1	420.47
238	247	11	2	776.56
239	11	194	1	150.51
240	59	95	3	864.42
241	114	168	2	706.18
242	45	146	3	123.93
243	51	162	3	1244.27
244	66	72	1	368.28
245	241	149	3	590.22
246	211	22	1	160.04
247	158	110	3	888.57
248	248	124	2	724.08
249	9	160	3	632.12
250	93	1	3	1420.49
251	167	139	1	116.33
252	195	154	3	1117.31
253	16	187	1	1390.29
254	88	47	2	231.32
255	176	6	3	223.34
256	107	52	3	1266.93
257	173	73	1	772.74
258	170	135	3	302.50
259	98	122	1	568.71
260	159	4	2	1271.68
261	142	2	2	961.34
262	214	43	3	273.72
263	151	21	2	475.45
264	193	19	1	207.49
265	70	41	1	1033.13
266	39	49	2	822.76
267	245	176	3	491.48
268	236	74	2	118.54
269	54	5	3	322.74
270	206	18	3	715.68
271	49	191	3	325.11
272	202	87	1	103.89
273	134	114	2	1024.77
274	211	198	2	666.85
275	30	133	3	658.27
276	220	144	1	176.79
277	207	57	3	413.92
278	149	157	2	1213.31
279	167	68	2	1091.38
280	199	170	2	312.84
281	93	48	2	1290.21
282	19	149	3	526.21
283	115	49	3	137.45
284	20	52	3	1215.30
285	209	2	1	217.71
286	203	11	2	574.22
287	185	51	2	1176.87
288	205	193	2	134.69
289	219	96	2	796.81
290	8	191	1	831.28
291	1	22	3	684.88
292	3	84	2	132.37
293	205	114	3	222.23
294	221	106	3	871.84
295	122	90	3	339.13
296	30	8	1	764.86
297	189	121	2	455.79
298	76	120	2	1244.06
299	3	109	1	428.66
300	30	39	2	475.33
301	32	18	3	449.05
302	4	51	1	753.28
303	27	51	3	1423.18
304	158	109	2	963.79
305	135	28	1	1048.65
306	220	11	3	903.18
307	152	52	2	337.74
308	136	117	3	792.16
309	224	34	2	1476.16
310	88	134	1	1384.24
311	139	153	2	717.62
312	165	135	1	1327.42
313	178	37	3	379.74
314	149	111	1	1317.64
315	35	89	1	1107.38
316	60	116	1	1073.59
317	249	197	3	1131.77
318	61	124	2	914.31
319	43	74	3	1231.96
320	216	185	2	874.96
321	245	20	1	1061.44
322	150	76	2	614.09
323	173	54	3	1358.71
324	178	109	1	953.32
325	159	124	3	1128.46
326	155	69	2	276.09
327	194	39	3	1215.74
328	148	10	2	812.41
329	89	174	3	456.21
330	90	93	1	865.73
331	78	173	2	1301.38
332	223	10	3	1132.50
333	210	45	2	1391.04
334	81	61	1	327.45
335	34	185	2	816.23
336	244	79	1	1444.09
337	169	186	3	528.91
338	226	30	2	119.69
339	179	60	2	575.75
340	214	61	2	1044.31
341	114	129	2	290.54
342	173	25	1	907.96
343	15	147	1	587.04
344	151	58	3	1262.51
345	107	85	2	181.58
346	81	3	3	1364.30
347	167	140	3	178.52
348	199	163	2	1464.88
349	235	144	3	770.29
350	53	183	2	1244.12
351	157	140	2	1167.47
352	88	65	2	697.42
353	155	70	3	1105.35
354	67	82	1	1392.94
355	6	194	3	649.14
356	206	166	1	963.06
357	119	174	2	1435.11
358	106	71	2	914.02
359	190	123	3	1175.86
360	102	120	1	1397.70
361	212	166	1	957.27
362	2	131	2	619.43
363	32	180	2	385.11
364	77	98	1	1134.04
365	105	166	1	1419.10
366	56	6	1	574.45
367	164	167	3	302.75
368	166	153	2	512.54
369	118	125	2	1358.38
370	135	159	2	1242.85
371	71	7	1	1039.60
372	208	16	1	833.85
373	2	184	2	812.60
374	205	115	1	670.51
375	51	41	2	1137.85
376	24	191	3	519.16
377	105	81	3	510.81
378	1	124	1	1362.96
379	220	113	3	1108.56
380	143	4	3	564.48
381	223	32	3	185.18
382	99	10	3	1295.44
383	52	105	3	1049.00
384	24	9	1	1058.76
385	73	32	3	657.91
386	11	152	2	150.06
387	52	76	3	133.29
388	81	175	2	273.36
389	27	62	1	363.37
390	240	137	1	988.37
391	115	118	1	560.50
392	100	9	2	552.03
393	183	143	3	1471.83
394	6	72	2	1382.60
395	168	49	3	268.17
396	200	173	2	142.18
397	235	17	1	885.72
398	135	58	1	228.84
399	204	181	1	886.96
400	225	34	3	448.56
401	153	184	2	1300.15
402	147	134	1	708.53
403	231	113	2	812.43
404	100	21	1	1463.50
405	208	20	3	1306.01
406	31	166	3	510.25
407	112	140	2	821.79
408	242	170	2	564.46
409	234	118	1	1028.78
410	109	187	3	1253.55
411	110	75	1	259.99
412	2	94	3	361.30
413	227	65	1	1488.55
414	222	56	2	1438.10
415	240	78	2	152.92
416	154	163	2	1448.67
417	177	24	3	368.20
418	132	22	1	413.96
419	250	45	1	529.20
420	60	56	2	273.60
421	69	137	3	193.80
422	220	198	2	109.62
423	44	19	1	861.51
424	101	200	3	834.43
425	109	65	1	1481.85
426	53	33	3	448.79
427	167	130	2	1274.39
428	216	166	1	765.36
429	69	55	2	564.40
430	212	176	2	493.17
431	237	198	3	850.39
432	149	50	3	320.67
433	167	199	2	983.25
434	97	104	3	465.85
435	55	160	2	878.21
436	163	61	3	516.50
437	29	15	2	1234.48
438	57	174	3	1296.24
439	35	88	3	256.05
440	113	98	3	515.21
441	217	151	1	996.38
442	193	87	3	169.00
443	160	174	3	1408.34
444	96	142	3	601.25
445	166	196	3	350.86
446	160	54	3	1134.62
447	106	52	1	732.72
448	100	149	3	208.32
449	48	54	2	488.84
450	120	46	2	910.49
451	249	172	3	1404.64
452	3	161	2	988.09
453	148	5	2	1380.63
454	43	77	1	1311.74
455	105	12	1	1315.66
456	83	116	3	603.53
457	17	146	1	1120.93
458	22	25	1	1299.45
459	36	70	1	672.63
460	43	25	2	343.75
461	191	120	2	525.54
462	37	106	1	748.73
463	84	35	3	685.05
464	179	43	1	611.61
465	184	126	1	700.19
466	235	147	1	1439.25
467	148	34	1	948.01
468	110	52	2	257.38
469	235	92	3	614.85
470	187	124	2	584.33
471	6	105	1	677.70
472	205	149	2	1437.91
473	195	45	1	665.77
474	53	170	1	159.99
475	142	9	1	1190.61
476	166	93	1	837.30
477	24	1	3	1418.85
478	12	67	2	1030.62
479	229	137	3	812.82
480	84	179	1	1268.42
481	141	138	3	868.33
482	91	108	1	1497.48
483	185	84	1	356.46
484	195	2	3	1157.52
485	5	6	1	1139.77
486	14	10	3	882.55
487	183	145	1	1106.30
488	218	106	3	1315.73
489	125	195	1	114.87
490	121	105	3	259.16
491	154	70	2	1450.02
492	132	21	3	1392.36
493	206	191	1	1396.37
494	248	26	3	797.62
495	95	129	2	338.22
496	23	37	1	423.12
497	239	150	2	537.29
498	127	69	3	1156.70
499	143	197	2	926.92
500	81	193	1	366.04
501	98	168	2	241.07
502	203	130	1	445.10
503	169	136	3	651.03
504	212	52	3	602.77
505	189	86	3	775.24
506	90	53	3	479.03
507	31	150	2	1394.66
508	180	123	3	411.98
509	26	129	1	1396.24
510	164	80	3	511.97
511	208	53	2	587.80
512	191	121	3	696.34
513	234	24	2	1438.95
514	214	104	3	1330.12
515	29	66	2	815.44
516	50	79	3	652.48
517	177	99	2	1332.94
518	194	111	3	1381.28
519	28	38	1	1498.33
520	25	191	1	270.53
521	11	137	2	738.31
522	100	112	2	1354.58
523	56	19	3	1135.55
524	64	67	3	496.06
525	81	86	1	742.67
526	80	200	2	1298.33
527	231	2	3	699.38
528	248	123	2	942.42
529	174	47	1	1038.24
530	143	100	3	333.41
531	45	69	1	368.89
532	78	92	3	1272.71
533	146	43	1	854.68
534	204	197	3	376.35
535	241	115	3	1497.82
536	62	49	3	1046.41
537	227	175	2	1107.05
538	201	143	2	1269.81
539	196	23	3	468.62
540	129	84	3	1355.06
541	91	172	1	330.86
542	204	108	3	416.04
543	174	130	2	135.14
544	245	121	3	1146.57
545	16	66	3	987.14
546	141	101	2	1195.95
547	26	101	2	1226.31
548	13	102	3	972.80
549	207	184	2	1461.04
550	84	13	1	837.79
551	1	189	2	1048.45
552	234	187	3	1200.91
553	114	60	1	899.07
554	143	90	3	1362.26
555	237	38	1	839.43
556	184	183	1	1366.75
557	116	186	2	596.51
558	151	91	1	1098.65
559	157	131	2	796.21
560	20	61	1	229.51
561	94	153	1	636.79
562	205	88	2	1049.69
563	229	122	3	1056.46
564	126	92	1	744.85
565	137	32	2	825.65
566	70	108	2	1481.34
567	171	197	1	557.72
568	158	102	3	1099.98
569	152	14	2	367.98
570	38	73	2	1000.44
571	40	144	3	229.29
572	165	176	1	1247.00
573	129	38	3	114.08
574	103	162	1	138.92
575	245	21	2	546.05
576	222	120	2	616.85
577	51	17	1	759.36
578	149	19	1	549.89
579	58	164	3	292.57
580	16	84	1	1068.12
581	181	142	2	1179.98
582	160	152	3	899.13
583	242	35	3	641.38
584	8	113	3	705.30
585	141	79	3	437.88
586	45	148	3	451.44
587	92	165	1	1411.51
588	146	177	3	1258.93
589	214	184	3	1112.32
590	247	53	3	1059.90
591	197	63	3	231.97
592	205	146	3	1173.01
593	14	143	1	1338.74
594	174	34	1	1207.78
595	87	189	1	1153.06
596	81	60	1	388.39
597	138	74	3	1083.88
598	175	63	2	747.99
599	27	146	2	806.15
600	230	158	1	1045.31
601	251	1	2	250.00
\.


--
-- Data for Name: sales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sales (sale_id, patient_id, employee_id, sale_date, total_amount, payment_method) FROM stdin;
33	\N	8	2024-07-23 15:44:00	0.00	Cash
47	\N	26	2024-05-06 16:16:00	0.00	Card
65	82	24	2024-06-05 08:54:00	0.00	Card
68	23	13	2024-12-21 18:20:00	0.00	Cash
85	\N	5	2024-10-12 09:54:00	0.00	Cash
104	\N	23	2024-07-26 12:58:00	0.00	Cash
108	\N	4	2024-08-23 19:18:00	0.00	Cash
111	\N	49	2024-04-24 18:27:00	0.00	M-Bank
124	\N	9	2024-05-27 12:28:00	0.00	Cash
86	\N	21	2024-09-16 15:06:00	2234.93	Card
55	\N	35	2024-03-12 09:37:00	6087.16	M-Bank
25	\N	45	2024-03-02 13:45:00	4892.65	M-Bank
2	23	11	2024-06-24 16:53:00	4978.30	Card
63	54	13	2024-03-12 10:36:00	803.79	M-Bank
114	\N	39	2024-01-26 15:02:00	4346.84	Card
73	33	20	2024-02-23 11:00:00	7862.07	Cash
22	76	29	2024-06-03 11:56:00	4987.80	M-Bank
140	92	11	2024-09-05 10:41:00	2824.14	Card
83	\N	11	2024-12-25 10:27:00	6579.03	Cash
123	39	43	2024-11-22 09:16:00	2455.16	Cash
88	\N	31	2024-09-12 19:41:00	4160.17	Card
79	30	49	2024-01-24 14:12:00	1339.71	M-Bank
89	\N	49	2024-06-18 10:55:00	2571.23	Cash
125	\N	44	2024-08-24 14:47:00	3044.54	Cash
82	57	12	2024-12-21 12:35:00	1738.28	Card
80	91	42	2024-06-07 14:25:00	3548.13	Card
78	\N	49	2024-07-16 19:59:00	10224.42	M-Bank
58	\N	32	2024-04-19 08:21:00	4585.96	Cash
112	\N	23	2024-04-16 18:41:00	6419.23	Cash
97	66	3	2024-05-25 09:44:00	5697.99	Cash
132	\N	7	2024-10-03 13:44:00	4858.20	M-Bank
57	\N	16	2024-08-18 10:23:00	5168.14	M-Bank
138	\N	48	2024-06-10 11:15:00	3462.90	Cash
44	74	34	2024-05-11 20:28:00	3090.43	M-Bank
66	\N	6	2024-06-25 10:00:00	3211.47	M-Bank
17	\N	18	2024-04-01 15:42:00	2983.32	M-Bank
13	\N	27	2024-12-02 15:44:00	8793.91	Cash
52	79	3	2024-03-27 13:38:00	6099.02	M-Bank
96	\N	34	2024-10-11 17:25:00	3815.71	M-Bank
131	55	26	2024-04-06 17:13:00	1283.81	Card
69	\N	12	2024-03-10 18:09:00	6060.29	Cash
95	\N	3	2024-05-04 11:43:00	7901.15	M-Bank
30	58	15	2024-08-08 08:18:00	4501.37	Card
87	\N	20	2024-06-20 19:03:00	5936.21	Card
31	68	19	2024-04-11 12:05:00	8376.69	Cash
9	\N	26	2024-01-26 16:55:00	5941.20	Card
75	\N	26	2024-10-12 15:57:00	4944.69	M-Bank
11	\N	16	2024-11-13 19:39:00	4379.03	M-Bank
134	9	42	2024-10-09 14:13:00	5565.10	Cash
117	\N	1	2024-05-23 14:11:00	3377.88	Card
128	\N	30	2024-09-27 15:06:00	563.86	Card
7	100	49	2024-09-19 10:24:00	2044.06	Cash
133	62	32	2024-07-25 17:26:00	1838.05	Card
18	\N	32	2024-05-17 09:58:00	3342.09	Cash
28	\N	37	2024-11-05 08:47:00	5553.29	M-Bank
135	74	18	2024-07-26 12:27:00	10427.20	M-Bank
137	\N	34	2024-06-15 16:07:00	2827.90	Cash
94	\N	4	2024-01-26 10:28:00	1985.31	Cash
39	56	11	2024-04-23 12:42:00	6983.90	M-Bank
26	55	21	2024-04-09 08:09:00	8576.89	M-Bank
72	\N	34	2024-06-03 17:54:00	1087.17	Card
129	18	21	2024-04-06 19:04:00	6512.57	Cash
3	\N	46	2024-04-20 10:22:00	6737.80	Cash
74	47	3	2024-04-04 09:11:00	2871.88	Cash
105	\N	43	2024-08-15 08:48:00	6903.48	Card
130	\N	13	2024-07-02 12:06:00	2179.59	M-Bank
115	79	11	2024-09-27 08:22:00	1787.69	Cash
41	\N	18	2024-11-06 14:16:00	3466.80	Card
10	\N	39	2024-03-27 18:15:00	1219.50	Cash
21	\N	37	2024-07-17 14:10:00	1317.55	Cash
103	\N	46	2024-06-19 20:43:00	1818.70	Cash
91	65	21	2024-05-21 14:55:00	4951.74	Card
120	\N	4	2024-12-16 08:13:00	2360.37	Card
50	\N	4	2024-02-23 14:50:00	3358.47	Cash
35	\N	12	2024-09-14 20:07:00	2678.45	Card
51	100	42	2024-03-26 20:17:00	7840.41	Card
110	83	29	2024-07-27 09:47:00	2971.33	M-Bank
101	31	14	2024-12-14 17:53:00	4900.79	M-Bank
70	\N	34	2024-04-16 09:04:00	4802.97	Card
77	50	35	2024-03-18 13:34:00	1554.51	Card
59	\N	16	2024-02-17 11:32:00	2593.26	M-Bank
93	42	35	2024-12-25 14:31:00	6841.91	M-Bank
16	\N	4	2024-10-27 11:40:00	5419.84	Card
54	\N	19	2024-01-26 20:27:00	968.21	Cash
49	5	19	2024-08-15 12:47:00	975.33	Cash
19	\N	27	2024-10-16 09:00:00	1578.63	M-Bank
20	\N	23	2024-02-14 15:51:00	3875.40	Card
8	80	9	2024-07-23 20:02:00	2947.19	M-Bank
1	4	36	2024-07-04 12:39:00	5514.50	M-Bank
122	\N	26	2024-03-02 20:44:00	1017.38	Cash
32	\N	49	2024-06-05 17:00:00	2117.38	M-Bank
4	36	34	2024-03-14 19:17:00	753.28	M-Bank
27	\N	38	2024-06-20 11:37:00	6245.21	Cash
139	\N	43	2024-08-26 13:33:00	1435.23	Cash
60	\N	24	2024-07-27 11:27:00	1620.80	M-Bank
61	78	1	2024-02-03 10:46:00	1828.61	Card
81	\N	44	2024-12-14 13:33:00	6464.17	M-Bank
34	54	27	2024-12-07 16:08:00	1632.46	Card
15	\N	46	2024-11-03 14:09:00	587.04	Cash
53	\N	31	2024-04-02 13:52:00	3994.58	M-Bank
6	81	23	2024-07-07 13:12:00	5390.32	M-Bank
119	\N	9	2024-02-13 13:53:00	2870.22	Cash
102	\N	17	2024-11-15 10:22:00	1397.70	M-Bank
56	\N	39	2024-03-01 14:58:00	3981.11	Cash
99	63	8	2024-05-28 19:11:00	3886.33	Cash
100	\N	31	2024-10-24 19:36:00	5901.69	Cash
109	66	40	2024-07-10 14:01:00	5242.50	Card
29	\N	5	2024-08-01 13:41:00	4099.84	Cash
113	89	20	2024-12-10 17:21:00	1545.64	Card
36	79	40	2024-10-24 16:47:00	672.63	Cash
84	\N	21	2024-03-17 09:19:00	4161.37	M-Bank
12	89	24	2024-06-14 14:57:00	2061.24	Cash
5	22	48	2024-06-21 08:42:00	1139.77	M-Bank
14	\N	41	2024-11-21 14:22:00	3986.40	Card
121	\N	40	2024-12-05 12:37:00	777.48	Cash
23	\N	4	2024-03-11 14:54:00	423.12	Card
64	53	11	2024-08-12 17:14:00	1488.18	Cash
62	58	16	2024-06-22 10:59:00	3139.22	Card
116	57	44	2024-12-22 17:16:00	1193.02	Cash
92	47	16	2024-06-06 15:07:00	1411.51	M-Bank
156	\N	28	2024-09-25 19:41:00	0.00	Card
182	\N	19	2024-03-18 19:56:00	0.00	Card
192	\N	5	2024-01-27 15:27:00	0.00	Cash
213	\N	17	2024-07-22 09:20:00	0.00	Cash
215	70	5	2024-05-26 15:22:00	0.00	Cash
228	55	42	2024-08-17 15:32:00	0.00	M-Bank
243	\N	14	2024-10-19 16:17:00	0.00	M-Bank
179	\N	41	2024-02-08 14:35:00	5560.21	Card
162	\N	31	2024-02-13 18:06:00	505.85	M-Bank
43	98	8	2024-04-27 20:51:00	12017.47	Card
46	\N	37	2024-06-23 19:29:00	2263.22	Cash
190	\N	13	2024-07-18 12:27:00	6242.90	M-Bank
209	\N	45	2024-12-17 15:20:00	5718.10	Cash
201	97	50	2024-10-22 11:41:00	5911.39	Cash
98	96	17	2024-03-24 15:31:00	2046.62	Card
160	\N	47	2024-02-09 12:22:00	11243.88	Card
158	31	25	2024-07-14 18:10:00	11287.26	Card
144	73	21	2024-09-09 17:59:00	1105.97	Card
178	14	13	2024-11-14 11:47:00	5630.52	Card
173	80	38	2024-12-14 18:33:00	8116.00	M-Bank
188	66	43	2024-07-22 18:21:00	2396.07	Card
45	40	12	2024-07-27 08:29:00	4159.84	M-Bank
165	21	27	2024-11-15 17:53:00	2836.66	M-Bank
172	29	3	2024-01-26 16:50:00	1982.60	M-Bank
149	75	44	2024-04-28 10:34:00	7878.48	Card
241	\N	2	2024-01-18 17:27:00	11287.18	M-Bank
204	\N	20	2024-06-06 11:07:00	4877.28	M-Bank
151	\N	23	2024-06-18 20:24:00	8382.34	Card
198	19	13	2024-10-24 12:30:00	1528.26	M-Bank
170	8	46	2024-01-10 16:25:00	4528.25	Cash
233	68	2	2024-05-20 09:16:00	1282.25	Card
194	\N	40	2024-10-25 12:41:00	8242.59	Cash
67	96	10	2024-01-05 11:26:00	5332.05	M-Bank
168	\N	28	2024-03-18 14:19:00	12573.99	Card
42	41	2	2024-07-13 12:51:00	2395.01	Cash
219	\N	27	2024-11-20 18:46:00	5117.97	Card
186	44	1	2024-02-02 11:46:00	8204.73	Card
210	10	39	2024-04-14 18:02:00	7044.40	M-Bank
148	\N	17	2024-03-22 15:06:00	7173.25	Cash
206	\N	39	2024-11-03 10:27:00	5643.53	Card
136	\N	2	2024-10-12 20:32:00	3678.47	Cash
183	\N	43	2024-11-16 10:06:00	6013.12	Cash
166	\N	39	2024-08-02 16:11:00	6504.94	Cash
181	\N	8	2024-05-08 12:52:00	6604.87	Cash
37	2	23	2024-11-20 11:26:00	3253.73	Card
249	2	44	2024-07-26 20:46:00	9207.13	Cash
224	57	47	2024-07-10 13:32:00	3237.30	Card
38	63	19	2024-03-05 19:18:00	3221.82	Cash
141	\N	34	2024-08-12 09:25:00	6448.57	Cash
193	\N	4	2024-12-09 14:49:00	1316.54	M-Bank
212	74	18	2024-07-05 15:42:00	6628.91	M-Bank
161	20	25	2024-12-08 08:19:00	1589.87	Cash
174	62	19	2024-02-19 10:51:00	6987.62	Cash
126	100	9	2024-06-08 16:38:00	6863.56	Card
211	\N	40	2024-04-28 17:27:00	4536.80	M-Bank
230	67	33	2024-09-28 12:44:00	1390.55	Cash
153	40	32	2024-02-23 13:28:00	3282.39	M-Bank
185	\N	15	2024-07-16 11:52:00	3413.76	Card
180	\N	47	2024-12-25 12:47:00	1422.46	Card
195	19	20	2024-04-09 10:10:00	8772.00	M-Bank
150	\N	3	2024-07-21 17:54:00	6996.19	Card
232	7	43	2024-04-18 19:00:00	2833.89	M-Bank
106	33	20	2024-01-25 19:39:00	3297.65	Card
214	54	25	2024-12-25 16:49:00	12597.76	M-Bank
240	19	3	2024-03-22 18:11:00	3944.40	Card
244	54	9	2024-04-21 13:51:00	3096.44	Card
191	23	7	2024-08-03 20:51:00	4655.48	Cash
171	44	12	2024-09-03 13:06:00	1407.47	Cash
247	81	29	2024-06-21 10:59:00	5149.27	Cash
208	\N	35	2024-12-14 14:28:00	6592.01	Cash
197	\N	26	2024-03-17 11:05:00	1689.82	Cash
71	9	14	2024-10-09 09:37:00	4055.77	Cash
184	\N	44	2024-02-03 08:43:00	2807.76	Cash
236	47	9	2024-02-23 15:39:00	3088.04	Cash
203	\N	9	2024-09-04 13:11:00	5827.55	Card
217	\N	37	2024-09-07 16:12:00	3243.16	Card
218	37	28	2024-10-24 09:04:00	5916.31	M-Bank
216	37	1	2024-05-18 13:18:00	2995.08	Card
24	20	30	2024-06-06 16:29:00	9662.62	M-Bank
207	\N	8	2024-07-27 10:34:00	5255.45	Cash
223	50	29	2024-05-24 14:53:00	7551.90	M-Bank
175	\N	26	2024-04-13 12:11:00	4464.88	M-Bank
246	\N	30	2024-10-23 12:36:00	706.76	Card
199	\N	15	2024-11-10 15:05:00	4476.52	Card
145	\N	38	2024-01-11 17:48:00	1380.08	M-Bank
250	30	22	2024-07-24 14:15:00	779.65	Cash
235	\N	33	2024-06-10 15:00:00	7001.18	M-Bank
227	\N	42	2024-11-21 11:41:00	5913.39	Card
238	\N	24	2024-08-02 15:49:00	357.73	Cash
248	\N	46	2024-02-12 14:39:00	5725.87	M-Bank
167	\N	13	2024-08-03 13:31:00	7349.90	Card
176	\N	29	2024-05-07 13:34:00	670.03	Card
107	42	20	2024-01-12 19:38:00	4163.95	Cash
159	63	11	2024-03-07 18:12:00	5928.76	Cash
142	\N	14	2024-11-02 16:46:00	3113.30	M-Bank
245	\N	14	2024-04-17 13:01:00	7067.69	Cash
202	\N	37	2024-10-23 13:37:00	103.89	Card
220	77	8	2024-01-08 09:34:00	6431.25	Card
205	57	44	2024-09-02 09:18:00	10100.82	Card
221	49	3	2024-06-22 19:34:00	2615.51	M-Bank
189	\N	18	2024-03-25 16:48:00	3237.29	Card
152	19	31	2024-07-14 17:08:00	1411.44	M-Bank
155	\N	16	2024-08-27 08:19:00	3868.22	Card
169	34	5	2024-05-05 12:06:00	3539.82	Card
226	75	14	2024-02-04 15:56:00	239.38	Cash
164	\N	24	2024-12-15 14:16:00	2444.15	Card
143	7	8	2024-10-04 14:41:00	8634.28	M-Bank
200	\N	9	2024-06-01 16:32:00	284.36	Card
225	\N	37	2024-07-04 08:26:00	1345.68	M-Bank
147	\N	31	2024-04-09 14:48:00	708.53	Cash
231	55	24	2024-12-03 17:11:00	3723.00	Card
234	\N	5	2024-10-24 16:33:00	7509.39	Cash
222	\N	24	2024-09-28 12:46:00	4109.89	Card
154	\N	49	2024-11-24 13:37:00	5797.39	Card
177	28	15	2024-02-03 09:53:00	3770.47	Card
163	\N	34	2024-04-10 08:18:00	1549.51	M-Bank
187	\N	37	2024-05-07 08:58:00	1168.65	Card
229	28	36	2024-09-05 15:40:00	5607.85	Card
239	\N	1	2024-08-20 12:21:00	1074.58	Cash
146	26	32	2024-02-14 18:26:00	4631.47	Cash
76	85	13	2024-06-10 15:56:00	2488.12	Card
90	60	6	2024-07-23 16:23:00	2302.80	Card
157	\N	13	2024-04-03 16:47:00	3927.36	M-Bank
118	73	31	2024-03-20 14:24:00	2716.76	M-Bank
242	\N	6	2024-05-15 18:28:00	3053.05	Cash
237	96	9	2024-10-01 17:25:00	3390.59	Cash
48	45	15	2024-03-19 09:49:00	977.68	M-Bank
127	\N	40	2024-05-07 15:43:00	3470.09	Card
196	97	40	2024-09-07 12:44:00	1405.87	Cash
40	95	31	2024-08-24 18:45:00	687.86	Card
251	1	1	2026-05-18 08:38:06.936057	500.00	Cash
\.


--
-- Data for Name: stock_batches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stock_batches (batch_id, medicine_id, supplier_id, batch_number, quantity, unit_price, expiry_date, received_date) FROM stdin;
2	43	34	B-93547	44	1463.75	2025-02-28	2023-04-13
3	53	7	B-37405	512	216.40	2024-10-14	2024-02-16
4	46	22	B-60308	490	184.98	2024-11-29	2023-03-19
5	9	44	B-76933	46	681.45	2024-12-12	2023-09-11
6	73	21	B-32762	151	1076.40	2026-05-05	2024-04-17
7	13	28	B-68012	577	868.17	2026-08-20	2024-10-23
8	55	35	B-87676	293	435.24	2025-05-19	2024-06-06
9	80	19	B-69746	380	1190.57	2027-05-07	2024-12-25
10	66	49	B-60447	388	464.85	2024-07-06	2023-08-03
11	25	45	B-35024	966	1458.67	2026-05-18	2024-02-01
12	93	49	B-52481	311	1427.49	2026-06-03	2024-04-26
13	54	50	B-76985	33	160.70	2025-10-31	2023-09-15
14	86	14	B-72065	10	722.22	2027-06-27	2024-12-29
15	21	29	B-37131	556	1833.51	2024-07-27	2023-02-18
16	89	44	B-93030	648	1344.00	2024-09-11	2023-05-14
17	40	45	B-85869	309	531.73	2024-02-17	2023-07-12
18	28	40	B-82511	649	674.73	2026-12-04	2024-06-26
19	69	40	B-29165	663	1135.11	2025-09-23	2024-06-10
20	14	6	B-81394	95	1896.10	2025-09-21	2024-07-05
21	6	46	B-52263	696	201.53	2026-12-27	2024-05-31
22	76	38	B-10977	15	1106.75	2025-02-28	2023-08-20
23	97	44	B-88040	201	1216.19	2025-12-30	2023-12-01
24	48	35	B-63595	364	1883.53	2026-04-10	2024-11-21
25	28	37	B-44123	84	708.54	2024-12-03	2024-03-15
26	97	28	B-47584	88	637.32	2025-02-07	2024-03-27
27	86	23	B-50946	950	754.46	2025-04-26	2024-06-20
28	77	2	B-42512	69	1005.19	2025-07-19	2024-12-13
29	89	2	B-55681	713	237.30	2025-06-11	2024-02-18
30	62	49	B-18472	524	1326.38	2027-01-26	2024-06-12
31	38	2	B-18690	746	84.23	2024-04-26	2023-08-24
32	33	34	B-21711	169	547.70	2025-12-18	2024-08-25
33	25	3	B-42673	160	1269.38	2024-07-17	2023-10-12
34	57	13	B-48508	223	1526.90	2025-06-20	2023-07-07
35	99	24	B-23161	868	1304.10	2025-12-02	2023-03-09
36	48	22	B-52438	18	652.10	2025-09-02	2024-10-19
37	12	5	B-22728	748	1767.40	2025-07-20	2023-07-30
38	14	31	B-86372	245	1318.37	2025-07-21	2023-12-24
39	94	36	B-36476	465	709.25	2023-10-30	2023-03-10
40	24	35	B-34947	666	322.37	2027-02-02	2024-07-13
41	68	30	B-50458	68	1219.73	2025-05-17	2024-09-14
42	32	46	B-36516	996	396.71	2024-04-18	2023-10-05
43	34	13	B-69775	979	1057.32	2024-06-02	2023-04-15
44	35	17	B-16892	76	1413.86	2026-09-17	2024-08-14
45	54	32	B-94215	924	1443.01	2024-06-06	2023-10-06
46	29	31	B-36759	543	1820.14	2025-01-04	2024-06-03
47	5	10	B-69842	441	1559.02	2024-08-03	2023-01-09
48	50	9	B-59211	764	1900.07	2024-08-31	2023-02-24
49	32	40	B-27712	666	596.65	2027-07-12	2024-10-27
50	89	44	B-69279	830	1685.13	2023-11-21	2023-01-29
51	34	16	B-68250	547	79.57	2025-06-05	2024-02-06
52	57	19	B-81907	217	1936.90	2025-04-18	2023-02-17
53	36	50	B-61460	433	1029.87	2024-07-02	2023-01-01
54	48	33	B-63012	860	1310.39	2026-05-13	2024-07-05
55	56	24	B-14298	266	491.62	2025-03-03	2023-10-10
56	44	5	B-62436	988	1547.33	2026-03-30	2024-06-24
57	11	49	B-51956	236	1405.70	2024-11-12	2023-07-28
58	66	23	B-54900	608	1809.72	2026-02-14	2023-07-10
59	34	10	B-33501	133	1589.02	2025-01-06	2024-07-08
60	35	26	B-97214	812	910.94	2025-07-20	2024-09-28
61	5	1	B-76702	232	1724.72	2026-01-01	2023-07-12
62	7	16	B-92122	970	1806.02	2024-06-05	2023-07-05
63	57	27	B-34620	276	495.74	2025-07-17	2023-10-03
64	23	17	B-17985	931	1474.83	2026-05-16	2024-03-09
65	64	26	B-88928	818	1331.66	2024-03-06	2023-06-15
66	5	18	B-95562	102	857.69	2026-05-16	2024-10-11
67	66	10	B-74489	602	766.42	2024-11-08	2023-09-27
68	31	2	B-28529	777	1775.85	2026-05-28	2024-01-09
69	74	20	B-44761	635	1349.06	2025-12-04	2024-09-20
70	42	4	B-51858	928	1625.78	2023-12-14	2023-02-25
71	99	23	B-20438	863	239.90	2024-08-26	2024-01-01
72	97	7	B-45677	143	841.10	2024-07-09	2023-11-14
73	32	26	B-28861	983	1886.47	2026-07-14	2024-12-27
74	4	4	B-41625	948	593.72	2025-07-24	2024-01-01
75	42	21	B-34650	627	774.52	2025-07-15	2023-05-15
76	86	32	B-12670	682	862.77	2026-11-19	2024-07-12
77	55	29	B-74715	153	923.62	2024-06-14	2023-07-06
78	74	20	B-56304	808	597.70	2025-02-08	2023-08-25
79	8	28	B-93784	453	1032.92	2025-07-26	2023-09-14
80	36	14	B-29477	859	1529.88	2024-05-08	2023-07-02
81	48	20	B-36402	398	1900.61	2027-02-18	2024-08-19
82	33	21	B-32754	177	519.52	2027-01-07	2024-08-04
83	67	21	B-75449	950	957.57	2027-06-23	2024-10-11
84	32	31	B-18279	378	897.67	2025-03-09	2024-01-21
85	48	44	B-77924	327	1386.60	2026-12-23	2024-06-04
86	56	34	B-78781	139	151.73	2025-12-17	2024-08-19
87	85	14	B-49511	834	1452.84	2027-02-03	2024-09-28
88	83	16	B-25961	449	609.33	2026-06-22	2024-08-02
89	6	4	B-54399	626	302.74	2025-01-19	2023-11-06
90	5	14	B-74123	545	198.93	2026-02-06	2024-07-29
91	10	50	B-87798	522	1204.31	2025-03-04	2023-04-29
92	86	17	B-94535	715	438.25	2025-03-22	2024-06-04
93	76	7	B-89794	687	1972.88	2025-08-27	2023-03-22
94	3	2	B-71476	694	892.39	2025-12-23	2023-10-22
95	38	1	B-89625	379	1906.55	2025-09-28	2023-05-24
96	14	25	B-65725	258	207.02	2026-08-15	2024-05-09
97	6	23	B-61652	373	1286.97	2026-02-18	2024-02-07
98	37	50	B-56138	540	1620.57	2025-06-03	2024-10-12
99	94	39	B-21152	900	1416.97	2025-12-08	2023-08-07
100	19	2	B-47425	221	1990.86	2026-11-08	2024-10-21
101	78	11	B-20954	271	1446.47	2026-01-08	2024-07-28
102	29	39	B-45410	785	685.41	2025-09-19	2024-04-22
103	10	42	B-52096	637	348.28	2024-05-04	2023-07-10
104	67	3	B-32074	787	1536.58	2025-06-01	2023-10-28
105	71	15	B-38012	840	898.35	2026-05-07	2024-08-06
106	76	46	B-81009	876	886.56	2024-08-11	2023-11-10
107	35	26	B-74968	28	1881.14	2025-10-20	2023-02-03
108	82	20	B-28032	235	81.85	2024-10-11	2023-06-21
109	58	9	B-59953	902	1334.26	2024-02-16	2023-01-07
110	58	40	B-34788	139	469.60	2024-04-28	2023-04-19
111	48	50	B-20283	604	1262.90	2025-07-04	2024-11-13
112	82	4	B-92950	810	433.04	2026-09-05	2024-09-15
113	16	8	B-81245	515	365.95	2024-08-06	2023-06-16
114	54	23	B-86162	113	1447.46	2027-02-08	2024-05-20
115	31	10	B-49486	881	1882.31	2026-12-20	2024-04-29
116	44	12	B-38409	199	1535.91	2026-04-03	2024-10-14
117	70	9	B-98506	76	98.01	2025-04-07	2024-03-26
118	81	33	B-89738	973	1574.13	2024-04-15	2023-02-05
119	79	15	B-73393	821	719.55	2024-08-05	2023-09-08
120	83	48	B-67251	654	671.52	2026-09-02	2024-03-30
121	57	37	B-32413	751	1750.63	2025-12-26	2023-11-22
122	57	20	B-81103	989	681.03	2026-10-29	2024-03-16
123	51	3	B-65456	121	1766.67	2024-12-30	2023-07-12
124	29	17	B-95472	174	802.16	2026-09-09	2024-11-30
125	90	37	B-66706	494	1900.84	2025-07-15	2024-10-13
126	40	1	B-34349	157	687.89	2025-08-05	2024-07-19
127	99	44	B-69111	161	1584.61	2024-11-13	2023-05-01
128	28	22	B-70158	494	1474.50	2025-04-27	2024-10-24
129	48	20	B-84123	517	548.43	2025-02-14	2023-11-13
130	61	9	B-57167	351	858.72	2025-11-08	2023-03-19
131	68	8	B-43556	736	764.78	2024-01-19	2023-07-03
132	28	50	B-32674	85	951.39	2025-12-28	2024-01-05
133	54	19	B-31659	96	146.69	2026-06-18	2023-09-28
134	85	25	B-51376	412	1040.66	2026-07-21	2024-09-06
135	46	19	B-35951	611	1743.53	2025-03-15	2023-04-03
136	94	33	B-18752	529	1708.26	2026-02-13	2024-04-24
137	77	47	B-66575	74	859.11	2025-03-18	2023-02-08
138	59	23	B-94746	992	1056.49	2025-11-09	2023-06-07
139	96	32	B-70340	883	948.22	2025-02-15	2024-02-18
140	36	25	B-80267	606	997.26	2025-02-19	2024-04-06
141	60	40	B-53477	841	404.10	2024-10-03	2023-09-05
142	1	28	B-19744	524	512.61	2024-08-18	2023-12-04
143	8	46	B-71989	1000	535.85	2024-08-19	2023-08-26
144	66	22	B-62544	160	309.82	2026-11-30	2024-03-26
145	23	10	B-18212	472	1331.29	2026-01-13	2024-02-29
146	60	11	B-81628	313	1032.42	2024-07-26	2023-05-23
147	81	5	B-94700	531	1913.88	2026-11-17	2024-03-16
148	2	35	B-94088	577	1217.44	2024-07-02	2023-03-18
149	81	21	B-96243	794	994.73	2026-08-30	2024-03-19
150	50	29	B-63681	344	938.13	2026-05-29	2024-08-18
151	21	41	B-30099	289	973.48	2024-12-30	2023-12-22
152	77	7	B-96929	610	502.58	2025-06-19	2024-06-12
153	88	44	B-81515	504	1507.12	2026-02-09	2023-06-15
154	79	14	B-99508	997	1818.45	2024-08-13	2023-04-06
155	69	35	B-51808	162	329.37	2026-02-12	2023-08-06
156	40	45	B-80198	749	1468.74	2026-04-29	2024-04-01
157	8	7	B-95315	518	1967.47	2025-09-13	2024-07-13
158	30	33	B-69241	48	1162.76	2027-02-21	2024-09-03
159	25	12	B-34575	252	421.17	2024-07-02	2023-04-15
160	28	28	B-77747	318	1570.51	2025-07-15	2023-12-15
161	10	45	B-21908	791	892.44	2027-04-05	2024-09-08
162	83	24	B-38957	810	141.96	2025-08-08	2023-02-14
163	6	41	B-29791	788	1400.12	2024-12-15	2023-11-30
164	90	49	B-82474	591	1101.71	2027-06-08	2024-10-05
165	8	45	B-34050	687	1354.91	2025-06-26	2023-04-21
166	11	10	B-23998	542	1560.46	2024-10-05	2024-04-04
167	12	19	B-43954	796	662.74	2026-05-11	2023-10-31
168	30	38	B-11980	208	266.85	2025-11-15	2024-07-13
169	48	30	B-92249	811	1716.35	2027-01-29	2024-11-24
170	51	6	B-76626	833	1958.14	2025-11-05	2024-12-07
171	77	19	B-98422	859	693.97	2025-09-21	2024-08-21
172	9	8	B-45865	51	1324.98	2025-08-24	2023-08-13
173	91	15	B-88534	273	1292.60	2024-12-16	2024-02-14
174	76	11	B-77457	30	121.28	2025-06-11	2024-09-04
175	63	40	B-98681	346	1171.07	2023-10-24	2023-03-01
176	46	14	B-11817	31	1868.71	2025-10-07	2023-06-27
177	36	43	B-35976	128	1799.95	2024-07-22	2023-11-17
178	54	29	B-62050	153	1429.58	2026-05-17	2024-05-25
179	51	9	B-16549	159	522.77	2026-08-28	2024-09-14
180	51	32	B-77949	964	243.78	2024-10-17	2023-03-31
181	90	29	B-13731	819	680.83	2024-03-12	2023-05-07
182	64	19	B-27452	327	1003.26	2025-03-18	2024-07-05
183	12	16	B-94814	688	1586.65	2025-08-18	2024-04-09
184	36	41	B-26984	294	1419.54	2026-05-05	2024-09-21
185	57	6	B-91998	918	940.17	2026-12-10	2024-06-07
186	92	17	B-84230	490	925.23	2026-08-08	2024-11-01
187	79	33	B-87494	354	609.99	2026-10-05	2024-10-13
188	86	42	B-78677	346	70.58	2024-11-25	2023-11-06
189	94	11	B-31291	937	988.34	2026-05-15	2023-09-14
190	99	45	B-55006	201	1323.46	2027-04-08	2024-10-08
191	52	15	B-31492	248	872.18	2025-07-30	2024-10-17
192	80	23	B-19219	739	1301.99	2025-08-18	2024-04-11
193	32	49	B-37702	706	482.39	2024-05-06	2023-06-01
194	80	46	B-37487	397	134.22	2026-04-16	2024-02-12
195	69	25	B-95212	619	1336.62	2025-10-30	2023-10-11
196	4	44	B-39961	169	1199.56	2025-06-05	2024-04-30
197	82	20	B-27309	120	69.05	2025-11-15	2024-06-10
198	94	35	B-85813	420	1353.49	2027-02-27	2024-12-04
199	57	43	B-34904	677	1953.00	2026-06-30	2024-10-23
200	33	15	B-97693	862	305.86	2025-12-10	2024-03-03
1	97	35	B-79688	374	924.23	2026-01-11	2023-07-29
\.


--
-- Data for Name: suppliers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.suppliers (supplier_id, name, contact_person, phone, email, address, created_at) FROM stdin;
1	Neman-Pharm 1	Dmitry Volkov	+996 500 951 168	aisuluu.kenjebaeva61@outlook.com	Jalal-Abad, Manas Avenue 56, kv. 53	2026-05-18 08:36:40.471762
2	Amanat Pharm 2	Nurlan Bekov	+996 770 406 238	andrey.popov52@mail.ru	Osh, Manas Avenue 36, kv. 36	2026-05-18 08:36:40.472832
3	Pharmacom 3	Aziza Karimova	+996 220 203 796	aziza.karimova99@outlook.com	Karakol, Chui Avenue 31, kv. 17	2026-05-18 08:36:40.473424
4	Kyrgyz Pharm 4	Urmat Kalykov	+996 700 802 352	dmitry.volkov77@gmail.com	Naryn, Ibraimova Street 40, kv. 35	2026-05-18 08:36:40.473968
5	Pharmacom 5	Tilek Maratov	+996 220 477 949	beksultan.imanaliev10@yandex.ru	Jalal-Abad, Erkindik Boulevard 69, kv. 55	2026-05-18 08:36:40.474488
6	Amanat Pharm 6	Talgat Nurpeisov	+996 770 854 800	cholpon.mamatova37@yandex.ru	Jalal-Abad, Lenin Street 104, kv. 25	2026-05-18 08:36:40.47497
7	Kyrgyz Pharm 7	Igor Sidorov	+996 770 639 895	aisuluu.tursunova25@yandex.ru	Jalal-Abad, Ibraimova Street 80, kv. 43	2026-05-18 08:36:40.475403
8	Neman-Pharm 8	Dmitry Volkov	+996 220 106 938	nurlan.bekov54@outlook.com	Bishkek, Toktogul Street 35, kv. 38	2026-05-18 08:36:40.475813
9	Kyrgyz Pharm 9	Erkin Turdukulov	+996 500 903 377	azamat.abdyrakhmanov59@gmail.com	Bishkek, Lenin Street 102, kv. 36	2026-05-18 08:36:40.47626
10	Pharmacom 10	Cholpon Mamatova	+996 500 562 649	kubat.osmonov71@yandex.ru	Batken, Moskovskaya Street 22, kv. 53	2026-05-18 08:36:40.476679
11	Neman-Pharm 11	Adilet Usenov	+996 770 739 913	bermet.joldosheva18@gmail.com	Talas, Chui Avenue 58, kv. 33	2026-05-18 08:36:40.477161
12	Amanat Pharm 12	Bakyt Asanov	+996 220 877 729	medetbek.alybaev5@outlook.com	Bishkek, Moskovskaya Street 48, kv. 48	2026-05-18 08:36:40.477665
13	Pharmacom 13	Nurbek Turganbaev	+996 700 654 351	talant.djumaev5@mail.ru	Naryn, Moskovskaya Street 10, kv. 55	2026-05-18 08:36:40.47839
14	Pharmacom 14	Aigerim Sultanova	+996 770 560 254	ermek.kurmanaliev12@yandex.ru	Naryn, Erkindik Boulevard 148, kv. 13	2026-05-18 08:36:40.479007
15	Kyrgyz Pharm 15	Talgat Nurpeisov	+996 770 224 883	medetbek.alybaev22@gmail.com	Naryn, Moskovskaya Street 7, kv. 30	2026-05-18 08:36:40.479506
16	Amanat Pharm 16	Sergey Ivanov	+996 220 420 383	victor.kozlov17@outlook.com	Karakol, Lenin Street 122, kv. 8	2026-05-18 08:36:40.480062
17	Kyrgyz Pharm 17	Jyldyz Omonova	+996 220 701 373	bermet.joldosheva62@gmail.com	Bishkek, Lenin Street 127, kv. 21	2026-05-18 08:36:40.480525
18	Pharmacom 18	Ulan Sadykov	+996 770 301 784	aigul.esenalieva17@outlook.com	Naryn, Manas Avenue 123, kv. 46	2026-05-18 08:36:40.481099
19	Amanat Pharm 19	Medetbek Alybaev	+996 500 334 995	elena.petrova2@outlook.com	Batken, Manas Avenue 24, kv. 31	2026-05-18 08:36:40.481551
20	Pharmacom 20	Erkin Turdukulov	+996 220 447 236	kunduz.sharapova41@gmail.com	Batken, Manas Avenue 7, kv. 32	2026-05-18 08:36:40.482413
21	Kyrgyz Pharm 21	Kanat Sydykov	+996 700 626 797	cholpon.mamatova68@mail.ru	Batken, Ibraimova Street 134, kv. 4	2026-05-18 08:36:40.48303
22	Pharmacom 22	Almaz Bolotov	+996 500 111 164	beksultan.imanaliev60@mail.ru	Bishkek, Chui Avenue 53, kv. 48	2026-05-18 08:36:40.483588
23	Amanat Pharm 23	Igor Sidorov	+996 700 334 950	adilet.usenov77@gmail.com	Karakol, Moskovskaya Street 113, kv. 5	2026-05-18 08:36:40.484196
24	Kyrgyz Pharm 24	Tilek Maratov	+996 700 814 115	dmitry.volkov24@outlook.com	Jalal-Abad, Erkindik Boulevard 12, kv. 30	2026-05-18 08:36:40.484721
25	Neman-Pharm 25	Aziza Karimova	+996 220 322 209	medetbek.alybaev77@outlook.com	Osh, Manas Avenue 111, kv. 11	2026-05-18 08:36:40.485318
26	Pharmacom 26	Andrey Popov	+996 500 237 600	nurlan.bekov48@outlook.com	Osh, Toktogul Street 100, kv. 24	2026-05-18 08:36:40.485849
27	Pharmacom 27	Kanykei Isakova	+996 770 508 744	nurlan.bekov81@mail.ru	Karakol, Manas Avenue 47, kv. 41	2026-05-18 08:36:40.486376
28	Kyrgyz Pharm 28	Almaz Bolotov	+996 220 274 763	adilet.usenov33@gmail.com	Talas, Manas Avenue 69, kv. 53	2026-05-18 08:36:40.486977
29	Neman-Pharm 29	Tatyana Kuznetsova	+996 220 380 155	igor.sidorov14@gmail.com	Bishkek, Chui Avenue 61, kv. 4	2026-05-18 08:36:40.487662
30	Europharm 30	Medetbek Alybaev	+996 220 891 360	nurbek.turganbaev22@yandex.ru	Batken, Moskovskaya Street 45, kv. 46	2026-05-18 08:36:40.488297
31	Amanat Pharm 31	Nurbek Turganbaev	+996 500 166 638	ulan.sadykov53@gmail.com	Osh, Toktogul Street 43, kv. 55	2026-05-18 08:36:40.488758
32	Amanat Pharm 32	Talgat Nurpeisov	+996 500 584 515	cholpon.mamatova34@outlook.com	Osh, Lenin Street 107, kv. 59	2026-05-18 08:36:40.489289
33	Amanat Pharm 33	Beksultan Imanaliev	+996 220 671 893	elvira.saparova97@mail.ru	Jalal-Abad, Chui Avenue 104, kv. 1	2026-05-18 08:36:40.489818
34	Europharm 34	Asel Akmatova	+996 770 704 662	victor.kozlov38@outlook.com	Jalal-Abad, Ibraimova Street 138, kv. 38	2026-05-18 08:36:40.490509
35	Kyrgyz Pharm 35	Aigerim Sultanova	+996 500 216 764	tilek.maratov83@yandex.ru	Karakol, Chui Avenue 109, kv. 31	2026-05-18 08:36:40.491161
36	Kyrgyz Pharm 36	Bermet Joldosheva	+996 500 890 545	ermek.kurmanaliev21@mail.ru	Talas, Toktogul Street 42, kv. 2	2026-05-18 08:36:40.491735
37	Pharmacom 37	Elvira Saparova	+996 555 766 199	kanykei.isakova55@outlook.com	Jalal-Abad, Toktogul Street 99, kv. 49	2026-05-18 08:36:40.492302
38	Kyrgyz Pharm 38	Maksat Omurov	+996 770 614 932	nazira.moldalieva34@gmail.com	Osh, Moskovskaya Street 95, kv. 24	2026-05-18 08:36:40.493017
39	Kyrgyz Pharm 39	Elvira Saparova	+996 770 423 162	bakyt.asanov42@outlook.com	Jalal-Abad, Chui Avenue 128, kv. 50	2026-05-18 08:36:40.493525
40	Kyrgyz Pharm 40	Talgat Nurpeisov	+996 500 464 372	urmat.kalykov7@gmail.com	Naryn, Lenin Street 81, kv. 23	2026-05-18 08:36:40.493993
41	Europharm 41	Dinara Kasymova	+996 220 817 967	adilet.usenov78@outlook.com	Naryn, Lenin Street 101, kv. 20	2026-05-18 08:36:40.494451
42	Neman-Pharm 42	Saltanat Kerimova	+996 700 744 667	asel.akmatova43@mail.ru	Karakol, Ibraimova Street 92, kv. 38	2026-05-18 08:36:40.495188
43	Pharmacom 43	Tatyana Kuznetsova	+996 555 924 791	cholpon.mamatova25@mail.ru	Bishkek, Chui Avenue 18, kv. 36	2026-05-18 08:36:40.495713
44	Pharmacom 44	Gulnara Satybaldieva	+996 770 749 838	talgat.nurpeisov95@outlook.com	Talas, Ibraimova Street 41, kv. 8	2026-05-18 08:36:40.496222
45	Pharmacom 45	Azamat Abdyrakhmanov	+996 700 816 308	dinara.kasymova24@gmail.com	Batken, Toktogul Street 89, kv. 1	2026-05-18 08:36:40.496762
46	Amanat Pharm 46	Adilet Usenov	+996 500 479 965	ermek.kurmanaliev91@mail.ru	Jalal-Abad, Erkindik Boulevard 12, kv. 14	2026-05-18 08:36:40.497319
47	Neman-Pharm 47	Almaz Bolotov	+996 500 658 800	azamat.abdyrakhmanov5@yandex.ru	Osh, Toktogul Street 7, kv. 40	2026-05-18 08:36:40.49779
48	Pharmacom 48	Kunduz Sharapova	+996 700 546 340	erkin.turdukulov43@yandex.ru	Bishkek, Moskovskaya Street 136, kv. 58	2026-05-18 08:36:40.498427
49	Neman-Pharm 49	Urmat Kalykov	+996 770 688 775	chinara.ishenbaeva99@gmail.com	Talas, Chui Avenue 58, kv. 34	2026-05-18 08:36:40.499194
50	Europharm 50	Aisuluu Kenjebaeva	+996 555 586 330	erkin.turdukulov50@gmail.com	Bishkek, Moskovskaya Street 140, kv. 5	2026-05-18 08:36:40.499746
\.


--
-- Name: categories_category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_category_id_seq', 10, true);


--
-- Name: employees_employee_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.employees_employee_id_seq', 50, true);


--
-- Name: medicines_medicine_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.medicines_medicine_id_seq', 100, true);


--
-- Name: patients_patient_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.patients_patient_id_seq', 100, true);


--
-- Name: prescriptions_prescription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescriptions_prescription_id_seq', 150, true);


--
-- Name: sale_items_sale_item_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sale_items_sale_item_id_seq', 601, true);


--
-- Name: sales_sale_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sales_sale_id_seq', 252, true);


--
-- Name: stock_batches_batch_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.stock_batches_batch_id_seq', 200, true);


--
-- Name: suppliers_supplier_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.suppliers_supplier_id_seq', 50, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (category_id);


--
-- Name: employees employees_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_email_key UNIQUE (email);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (employee_id);


--
-- Name: medicines medicines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines
    ADD CONSTRAINT medicines_pkey PRIMARY KEY (medicine_id);


--
-- Name: patients patients_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.patients
    ADD CONSTRAINT patients_pkey PRIMARY KEY (patient_id);


--
-- Name: prescription_items prescription_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_items
    ADD CONSTRAINT prescription_items_pkey PRIMARY KEY (prescription_id, medicine_id);


--
-- Name: prescriptions prescriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (prescription_id);


--
-- Name: sale_items sale_items_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT sale_items_pkey PRIMARY KEY (sale_item_id);


--
-- Name: sales sales_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (sale_id);


--
-- Name: stock_batches stock_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT stock_batches_pkey PRIMARY KEY (batch_id);


--
-- Name: suppliers suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (supplier_id);


--
-- Name: idx_medicines_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_medicines_name ON public.medicines USING btree (name);


--
-- Name: idx_prescriptions_patient; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_prescriptions_patient ON public.prescriptions USING btree (patient_id);


--
-- Name: idx_sales_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_sales_date ON public.sales USING btree (sale_date);


--
-- Name: idx_stock_expiry; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_stock_expiry ON public.stock_batches USING btree (expiry_date);


--
-- Name: idx_stock_medicine; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_stock_medicine ON public.stock_batches USING btree (medicine_id);


--
-- Name: categories categories_parent_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_parent_category_id_fkey FOREIGN KEY (parent_category_id) REFERENCES public.categories(category_id);


--
-- Name: employees employees_manager_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_manager_id_fkey FOREIGN KEY (manager_id) REFERENCES public.employees(employee_id);


--
-- Name: medicines medicines_category_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.medicines
    ADD CONSTRAINT medicines_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(category_id);


--
-- Name: prescription_items prescription_items_medicine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_items
    ADD CONSTRAINT prescription_items_medicine_id_fkey FOREIGN KEY (medicine_id) REFERENCES public.medicines(medicine_id);


--
-- Name: prescription_items prescription_items_prescription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescription_items
    ADD CONSTRAINT prescription_items_prescription_id_fkey FOREIGN KEY (prescription_id) REFERENCES public.prescriptions(prescription_id);


--
-- Name: prescriptions prescriptions_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: prescriptions prescriptions_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- Name: sale_items sale_items_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT sale_items_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.stock_batches(batch_id);


--
-- Name: sale_items sale_items_sale_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale_items
    ADD CONSTRAINT sale_items_sale_id_fkey FOREIGN KEY (sale_id) REFERENCES public.sales(sale_id);


--
-- Name: sales sales_employee_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_employee_id_fkey FOREIGN KEY (employee_id) REFERENCES public.employees(employee_id);


--
-- Name: sales sales_patient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_patient_id_fkey FOREIGN KEY (patient_id) REFERENCES public.patients(patient_id);


--
-- Name: stock_batches stock_batches_medicine_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT stock_batches_medicine_id_fkey FOREIGN KEY (medicine_id) REFERENCES public.medicines(medicine_id);


--
-- Name: stock_batches stock_batches_supplier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stock_batches
    ADD CONSTRAINT stock_batches_supplier_id_fkey FOREIGN KEY (supplier_id) REFERENCES public.suppliers(supplier_id);


--
-- Name: TABLE categories; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.categories TO pharmacy_admin;
GRANT SELECT ON TABLE public.categories TO pharmacist;
GRANT SELECT,INSERT,UPDATE ON TABLE public.categories TO inventory_manager;


--
-- Name: SEQUENCE categories_category_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.categories_category_id_seq TO pharmacy_admin;
GRANT SELECT,USAGE ON SEQUENCE public.categories_category_id_seq TO pharmacist;
GRANT SELECT,USAGE ON SEQUENCE public.categories_category_id_seq TO inventory_manager;


--
-- Name: TABLE employees; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.employees TO pharmacy_admin;


--
-- Name: SEQUENCE employees_employee_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.employees_employee_id_seq TO pharmacy_admin;
GRANT SELECT,USAGE ON SEQUENCE public.employees_employee_id_seq TO pharmacist;
GRANT SELECT,USAGE ON SEQUENCE public.employees_employee_id_seq TO inventory_manager;


--
-- Name: TABLE medicines; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.medicines TO pharmacy_admin;
GRANT SELECT ON TABLE public.medicines TO pharmacist;
GRANT SELECT,INSERT,UPDATE ON TABLE public.medicines TO inventory_manager;


--
-- Name: SEQUENCE medicines_medicine_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.medicines_medicine_id_seq TO pharmacy_admin;
GRANT SELECT,USAGE ON SEQUENCE public.medicines_medicine_id_seq TO pharmacist;
GRANT SELECT,USAGE ON SEQUENCE public.medicines_medicine_id_seq TO inventory_manager;


--
-- Name: TABLE patients; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.patients TO pharmacy_admin;
GRANT SELECT,INSERT,UPDATE ON TABLE public.patients TO pharmacist;


--
-- Name: SEQUENCE patients_patient_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.patients_patient_id_seq TO pharmacy_admin;
GRANT SELECT,USAGE ON SEQUENCE public.patients_patient_id_seq TO pharmacist;
GRANT SELECT,USAGE ON SEQUENCE public.patients_patient_id_seq TO inventory_manager;


--
-- Name: TABLE prescription_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.prescription_items TO pharmacy_admin;
GRANT SELECT,INSERT,UPDATE ON TABLE public.prescription_items TO pharmacist;


--
-- Name: TABLE prescriptions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.prescriptions TO pharmacy_admin;
GRANT SELECT,INSERT,UPDATE ON TABLE public.prescriptions TO pharmacist;


--
-- Name: SEQUENCE prescriptions_prescription_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.prescriptions_prescription_id_seq TO pharmacy_admin;
GRANT SELECT,USAGE ON SEQUENCE public.prescriptions_prescription_id_seq TO pharmacist;
GRANT SELECT,USAGE ON SEQUENCE public.prescriptions_prescription_id_seq TO inventory_manager;


--
-- Name: TABLE sale_items; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sale_items TO pharmacy_admin;
GRANT SELECT,INSERT,UPDATE ON TABLE public.sale_items TO pharmacist;
GRANT SELECT ON TABLE public.sale_items TO inventory_manager;


--
-- Name: SEQUENCE sale_items_sale_item_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.sale_items_sale_item_id_seq TO pharmacy_admin;
GRANT SELECT,USAGE ON SEQUENCE public.sale_items_sale_item_id_seq TO pharmacist;
GRANT SELECT,USAGE ON SEQUENCE public.sale_items_sale_item_id_seq TO inventory_manager;


--
-- Name: TABLE sales; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sales TO pharmacy_admin;
GRANT SELECT,INSERT,UPDATE ON TABLE public.sales TO pharmacist;
GRANT SELECT ON TABLE public.sales TO inventory_manager;


--
-- Name: SEQUENCE sales_sale_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.sales_sale_id_seq TO pharmacy_admin;
GRANT SELECT,USAGE ON SEQUENCE public.sales_sale_id_seq TO pharmacist;
GRANT SELECT,USAGE ON SEQUENCE public.sales_sale_id_seq TO inventory_manager;


--
-- Name: TABLE stock_batches; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.stock_batches TO pharmacy_admin;
GRANT SELECT ON TABLE public.stock_batches TO pharmacist;
GRANT SELECT,INSERT,UPDATE ON TABLE public.stock_batches TO inventory_manager;


--
-- Name: SEQUENCE stock_batches_batch_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.stock_batches_batch_id_seq TO pharmacy_admin;
GRANT SELECT,USAGE ON SEQUENCE public.stock_batches_batch_id_seq TO pharmacist;
GRANT SELECT,USAGE ON SEQUENCE public.stock_batches_batch_id_seq TO inventory_manager;


--
-- Name: TABLE suppliers; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.suppliers TO pharmacy_admin;
GRANT SELECT,INSERT,UPDATE ON TABLE public.suppliers TO inventory_manager;


--
-- Name: SEQUENCE suppliers_supplier_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.suppliers_supplier_id_seq TO pharmacy_admin;
GRANT SELECT,USAGE ON SEQUENCE public.suppliers_supplier_id_seq TO pharmacist;
GRANT SELECT,USAGE ON SEQUENCE public.suppliers_supplier_id_seq TO inventory_manager;


--
-- Name: TABLE view_active_prescriptions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.view_active_prescriptions TO pharmacy_admin;


--
-- Name: TABLE view_expiring_soon; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.view_expiring_soon TO pharmacy_admin;


--
-- Name: TABLE view_low_stock; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.view_low_stock TO pharmacy_admin;


--
-- Name: TABLE view_monthly_sales; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.view_monthly_sales TO pharmacy_admin;


--
-- PostgreSQL database dump complete
--
