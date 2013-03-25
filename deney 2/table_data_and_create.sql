--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: client_master; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE client_master (
    client_no character varying(6) NOT NULL,
    name character varying(20),
    address1 character varying(30),
    address2 character varying(30),
    city character varying(15),
    pincode numeric(6,0),
    state character varying(15),
    bal_due numeric(10,2)
);


ALTER TABLE public.client_master OWNER TO postgres;

--
-- Name: product_master; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE product_master (
    product_no character varying(6),
    description character varying(15),
    profit_percent numeric(4,2),
    unit_measure character varying(10),
    qty_on_hand numeric(8,0),
    reorder_lvl numeric(8,0),
    sell_price numeric(8,2),
    cost_price numeric(8,2)
);


ALTER TABLE public.product_master OWNER TO postgres;

--
-- Name: sales_order; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sales_order (
    s_order_no character varying(6) NOT NULL,
    s_order_date date,
    client_no character varying(25),
    dely_add character varying(6),
    salesman_no character varying(6),
    dely_type character(1),
    billed_yn character(1),
    dely_date date,
    order_status character varying(10),
    CONSTRAINT sales_order_check CHECK ((dely_date > s_order_date)),
    CONSTRAINT sales_order_dely_type_check CHECK ((dely_type = ANY (ARRAY['P'::bpchar, 'F'::bpchar, 'D'::bpchar]))),
    CONSTRAINT sales_order_order_status_check CHECK (((order_status)::text = ANY ((ARRAY['IP'::character varying, 'F'::character varying, 'B'::character varying, 'C'::character varying])::text[]))),
    CONSTRAINT sales_order_s_order_no_check CHECK (((s_order_no)::text ~~ 'O%'::text))
);


ALTER TABLE public.sales_order OWNER TO postgres;

--
-- Name: sales_order_details; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE sales_order_details (
    s_order_no character varying(6),
    product_no character varying(6),
    qty_order numeric(8,0),
    qty_disp numeric(8,0),
    product_rate numeric(8,2)
);


ALTER TABLE public.sales_order_details OWNER TO postgres;

--
-- Name: salesman_master; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE salesman_master (
    salesman_no character varying(6) NOT NULL,
    sal_name character varying(20) NOT NULL,
    address1 character varying(30) NOT NULL,
    address2 character varying(30),
    city character varying(20),
    pincode character varying(6),
    state character varying(20),
    sal_amt numeric(8,2) NOT NULL,
    tgt_to_get numeric(6,2) NOT NULL,
    ytd_sales numeric(6,2) NOT NULL,
    remarks character varying(60),
    CONSTRAINT salesman_master_sal_amt_check CHECK ((sal_amt <> (0)::numeric)),
    CONSTRAINT salesman_master_salesman_no_check CHECK (((salesman_no)::text ~~ 'S%'::text)),
    CONSTRAINT salesman_master_tgt_to_get_check CHECK ((tgt_to_get <> (0)::numeric))
);


ALTER TABLE public.salesman_master OWNER TO postgres;

--
-- Data for Name: client_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY client_master (client_no, name, address1, address2, city, pincode, state, bal_due) FROM stdin;
0001	Ivan	\N	\N	Bombay	400054	Maharashtra	15000.00
0002	Vandana	\N	\N	Madras	780001	Tamilnadu	0.00
0003	Pramada	\N	\N	Bombay	400057	Maharashtra	5000.00
0004	Basu	\N	\N	Bombay	400056	Maharashtra	0.00
0005	Ravi	\N	\N	Delhi	100001	 	2000.00
0006	Rukmani	\N	\N	Bombay	400050	Maharashtra	0.00
\.


--
-- Data for Name: product_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY product_master (product_no, description, profit_percent, unit_measure, qty_on_hand, reorder_lvl, sell_price, cost_price) FROM stdin;
P00001	1.44 Floppies	5.00	Piece	100	20	525.00	500.00
P03453	Monitors	6.00	Piece	10	3	12000.00	11280.00
P06734	Mouse	5.00	Piece	20	5	1050.00	1000.00
P07865	1.22 Floppies	5.00	Piece	100	20	525.00	500.00
P07868	Keyboards	2.00	Piece	10	3	3150.00	3050.00
P07885	CD Drive	2.50	Piece	10	3	5250.00	5100.00
P07965	540 HDD	4.00	Piece	10	3	8400.00	8000.00
P07975	1.44 Drive	5.00	Piece	10	3	1050.00	1000.00
P08865	1.22 Drive	5.00	Piece	2	3	1050.00	1000.00
\.


--
-- Data for Name: sales_order; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sales_order (s_order_no, s_order_date, client_no, dely_add, salesman_no, dely_type, billed_yn, dely_date, order_status) FROM stdin;
O19001	1996-01-12	0001	\N	S00001	F	n	1996-01-20	IP
O19002	1996-01-25	0002	\N	S00002	P	n	1996-01-27	C
O46865	1996-02-18	0003	\N	S00003	F	y	1996-02-20	F
O19003	1996-04-03	0001	\N	S00001	F	y	1996-04-07	F
O46866	1996-05-20	0004	\N	S00002	P	n	1996-05-22	C
O19008	1996-05-24	0005	\N	S00002	F	n	1996-05-26	IP
\.


--
-- Data for Name: sales_order_details; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY sales_order_details (s_no, product_no, qty_order, qty_disp, product_rate) FROM stdin;
O19001	P00001	4	4	525.00
O19001	P07965	2	1	8400.00
O19001	P07885	2	1	5250.00
O19002	P00001	10	0	525.00
O46865	P07868	3	3	3150.00
O46865	P07885	3	1	5250.00
O46865	P00001	10	10	525.00
O46865	P03453	4	4	1050.00
O19003	P03453	2	2	1050.00
O19003	P06734	1	1	12000.00
O46866	P07965	1	0	8400.00
O46866	P07975	1	0	1050.00
O10008	P00001	10	5	525.00
O10008	P07975	5	3	1050.00
\.


--
-- Data for Name: salesman_master; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY salesman_master (salesman_no, sal_name, address1, address2, city, pincode, state, sal_amt, tgt_to_get, ytd_sales, remarks) FROM stdin;
S00001	Kiran	A/14	Worli	Bombay	400002	MAH	3000.00	100.00	50.00	Good
S00002	Manish	65	Nariman	Bombay	400001	MAH	3000.00	200.00	100.00	Good
S00003	Ravi	P-7	Bandra	Bombay	400032	MAH	3000.00	200.00	100.00	Good
S00004	Ashish	A/5	Juhu	Bombay	400044	MAH	3000.00	200.00	150.00	Good
\.


--
-- Name: client_master_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY client_master
    ADD CONSTRAINT client_master_pkey PRIMARY KEY (client_no);


--
-- Name: sales_order_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY sales_order
    ADD CONSTRAINT sales_order_pkey PRIMARY KEY (s_order_no);


--
-- Name: salesman_master_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY salesman_master
    ADD CONSTRAINT salesman_master_pkey PRIMARY KEY (salesman_no);


--
-- Name: sales_order_client_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_order
    ADD CONSTRAINT sales_order_client_no_fkey FOREIGN KEY (client_no) REFERENCES client_master(client_no);


--
-- Name: sales_order_salesman_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY sales_order
    ADD CONSTRAINT sales_order_salesman_no_fkey FOREIGN KEY (salesman_no) REFERENCES salesman_master(salesman_no);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--
