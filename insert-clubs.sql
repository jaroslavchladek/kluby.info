--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

-- Started on 2024-12-08 11:07:55 CET

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 216 (class 1259 OID 34114)
-- Name: clubs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.clubs (
    id bigint NOT NULL,
    content character varying(500000),
    created_on timestamp(6) without time zone,
    photo_url character varying(255),
    title character varying(255),
    updated_on timestamp(6) without time zone,
    created_by bigint NOT NULL,
    location_map_link character varying(5000)
);


ALTER TABLE public.clubs OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 34113)
-- Name: clubs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.clubs ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.clubs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 34122)
-- Name: event; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event (
    id bigint NOT NULL,
    created_on timestamp(6) without time zone,
    end_time timestamp(6) without time zone,
    name character varying(255),
    photo_url character varying(255),
    start_time timestamp(6) without time zone,
    type character varying(255),
    updated_on timestamp(6) without time zone,
    club_id bigint NOT NULL,
    location_map_link character varying(5000)
);


ALTER TABLE public.event OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 34121)
-- Name: event_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.event ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.event_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 220 (class 1259 OID 34130)
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id bigint NOT NULL,
    name character varying(255)
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 34129)
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.roles ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 221 (class 1259 OID 34135)
-- Name: user_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.user_roles OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 34139)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    email character varying(255),
    password character varying(255),
    username character varying(255)
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 34138)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.users ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 224 (class 1259 OID 34167)
-- Name: users_roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users_roles (
    user_id bigint NOT NULL,
    role_id bigint NOT NULL
);


ALTER TABLE public.users_roles OWNER TO postgres;

--
-- TOC entry 3624 (class 0 OID 34114)
-- Dependencies: 216
-- Data for Name: clubs; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.clubs VALUES (17, 'Shibuya CLUB QUATTRO is a well-regarded live music venue located on the top floor of the Book Off store in Shibuya, Tokyo. Known for its intimate setting and excellent acoustics, it attracts a wide range of both international and Japanese artists, spanning diverse music genres. It is especially popular among fans who enjoy close-up performances from their favorite bands.

The venue''s main floor features a standing area that creates a dynamic and immersive concert experience, though it does have a few view-obstructing pillars. Despite this, it remains a favorite for music enthusiasts due to its high-quality performances and vibrant atmosphere.

Situated at 32-13-4 Udagawacho in Shibuya, it''s easily accessible from Shibuya Station via multiple train lines. Recent acts performing at the club include international bands like Rhapsody of Fire and local Japanese groups such as Wienners​
TIME OUT WORLDWIDE
​
SETLIST.FM
.', NULL, 'https://limpress.com/wp-content/uploads/2018/04/20180420-DSC_6221-1.jpg', 'Shibuya CLUB QUATTRO', '2024-11-26 21:03:33.049266', 1, 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3241.6454720887546!2d139.6949713768007!3d35.66110547259382!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x60188ca90b39b971%3A0x731249a28e21e3a7!2sShibuya%20CLUB%20QUATTRO!5e0!3m2!1sen!2scz!4v1732651065706!5m2!1sen!2scz');
INSERT INTO public.clubs VALUES (18, 'BAIA Tokyo is a sophisticated nightclub located in Shibuya, known for its luxurious and artistic ambiance. Designed by New York architect Roy Nacham, the venue is distinguished by its use of high-end marble, offering a refined alternative to the typical underground club aesthetic. BAIA is a hotspot for upscale parties and adult social gatherings, creating a stylish and elegant space for its guests.

The club caters to a chic crowd and offers discounted entry prices, such as ¥1,500 for men and ¥500 for women, each including one drink. VIP tables are also available for a more exclusive experience.

For more details about events and bookings, you can visit platforms like Wanderlog or BAIA''s official pages.', NULL, 'https://baiatokyo.com/wp-content/themes/baia-tokyo-5/assets/images/venu-second.jpg', 'BAIA Tokyo', '2024-11-26 22:18:35.497721', 1, 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3241.623781095299!2d139.69649987680074!3d35.6616397725936!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x60188d2ffa183811%3A0x51a7cadafb5b9c3a!2sBAIA!5e0!3m2!1sen!2scz!4v1732655866664!5m2!1sen!2scz');
INSERT INTO public.clubs VALUES (19, 'CÉ LA VI Tokyo is a luxurious rooftop venue located in the iconic Tokyu Plaza Shibuya. It offers a multi-faceted experience with stunning views of Tokyo, spread across three main spaces: the Restaurant & Sky Bar, the Bao by CÉ LA VI casual dining area, and the Club Lounge. The restaurant serves contemporary Asian cuisine, while the Bao restaurant focuses on fusion dishes like bao buns and burgers​
CLUBBABLE
​
CÉ LA VI
.

The Club Lounge, where the nightlife action happens, boasts an impressive sound and light system, with rotating beam lights and lasers to enhance the experience. It''s known for hosting top-tier DJs who play a mix of house, techno, and hip-hop. The ambiance at CE LA VI is cosmopolitan, attracting both locals and international visitors​
CLUBBABLE
.

In terms of atmosphere, the venue strikes a balance between refined elegance and relaxed luxury, with a smart-casual dress code in place​
CÉ LA VI
.', NULL, 'https://globalproduce-event.com/wp-content/uploads/2022/07/main15-1.jpg', 'CÉ LA VI TOKYO', '2024-12-01 23:14:35.697474', 7, 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3241.7948006145302!2d139.69755137680048!3d35.657426972595005!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x60188b502d673a83%3A0xb5db861a876a9348!2sC%C3%89%20LA%20VI%20TOKYO!5e0!3m2!1sen!2scz!4v1732715511718!5m2!1sen!2scz');


--
-- TOC entry 3626 (class 0 OID 34122)
-- Dependencies: 218
-- Data for Name: event; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.event VALUES (4, NULL, NULL, 'Hello, this is Admin', 'https://d2vexfq4a24j3u.cloudfront.net/wp-content/uploads/355416_3_1607424506.jpg', NULL, 'This is a party. Wow.', '2024-12-01 23:14:53.56679', 18, 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3025.0763333130812!2d-73.90474132302916!3d40.69431647139629!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c25c25366f077b%3A0x3d04555d34846937!2sH0L0!5e0!3m2!1sen!2scz!4v1732654337253!5m2!1sen!2scz');
INSERT INTO public.event VALUES (1, NULL, NULL, 'holo', 'https://cdn.sanity.io/images/rizm0do5/production/cae2acb561e5c23008a216ca8cb039ccec9f56b9-2500x1667.jpg?rect=26,0,2474,1667&w=690&h=465&q=80&fit=clip&auto=format', NULL, 'this is an event', '2024-11-28 15:34:26.593202', 17, 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3025.0763333130812!2d-73.90474132302916!3d40.69431647139629!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x89c25c25366f077b%3A0x3d04555d34846937!2sH0L0!5e0!3m2!1sen!2scz!4v1732804082731!5m2!1sen!2scz');
INSERT INTO public.event VALUES (2, NULL, NULL, 'holomana', 'https://res.cloudinary.com/shotgun/image/upload/v1653148607/production/artworks/h0l0_interior_nhaurd.jpg', NULL, 'holomana', '2024-11-28 20:31:46.913135', 17, '');
INSERT INTO public.event VALUES (3, NULL, '0022-11-28 13:30:00', 'hello3', 'https://hellotheclub.com/wp-content/uploads/2023/11/bnnr-bb2.jpg', NULL, 'this is coola', '2024-11-28 20:38:41.994875', 17, 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3241.6454720887546!2d139.6949713768007!3d35.66110547259382!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x60188ca90b39b971%3A0x731249a28e21e3a7!2sShibuya%20CLUB%20QUATTRO!5e0!3m2!1sen!2scz!4v1732655497154!5m2!1sen!2scz');
INSERT INTO public.event VALUES (6, '2024-11-29 06:15:45.971574', '2024-11-30 06:16:00', 'Wednesday BAIA (Tech House)', 'https://imgproxy.ra.co/_/quality:66/w:1442/rt:fill/aHR0cHM6Ly9pbWFnZXMucmEuY28vMTQ3YzAxNjA3ZjVkYjUxNGYwZDVhMDUwMWU1NThkMzI0OTY0NWUxYy5qcGc=', '2024-11-29 06:15:00', 'Tech House Event', '2024-11-29 06:15:45.972717', 18, 'https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d6483.247543726428!2d139.699075!3d35.66164!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x60188d2ffa183811%3A0x51a7cadafb5b9c3a!2sBAIA!5e0!3m2!1sen!2sus!4v1732857306934!5m2!1sen!2sus');
INSERT INTO public.event VALUES (7, '2024-11-29 06:38:05.305955', '2024-11-30 06:35:00', 'oono yuuki band × neco眠る', 'https://www.club-quattro.com/image/clubquattro/shop/shibuya/w528/241212_oonoyuukiband.jpg', '2024-11-29 06:35:00', 'Concert', '2024-11-29 06:38:05.306071', 17, 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3241.6454720887546!2d139.6949713768007!3d35.66110547259382!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x60188ca90b39b971%3A0x731249a28e21e3a7!2sShibuya%20CLUB%20QUATTRO!5e0!3m2!1sen!2scz!4v1732858676791!5m2!1sen!2scz');


--
-- TOC entry 3628 (class 0 OID 34130)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.roles VALUES (1, 'USER');
INSERT INTO public.roles VALUES (2, 'USER');
INSERT INTO public.roles VALUES (3, 'USER');
INSERT INTO public.roles VALUES (4, 'USER');
INSERT INTO public.roles VALUES (5, 'USER');
INSERT INTO public.roles VALUES (6, 'USER');
INSERT INTO public.roles VALUES (7, 'ADMIN');
INSERT INTO public.roles VALUES (8, 'USER');
INSERT INTO public.roles VALUES (9, 'ADMIN');
INSERT INTO public.roles VALUES (10, 'USER');


--
-- TOC entry 3629 (class 0 OID 34135)
-- Dependencies: 221
-- Data for Name: user_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.user_roles VALUES (2, 1);
INSERT INTO public.user_roles VALUES (3, 2);
INSERT INTO public.user_roles VALUES (4, 3);
INSERT INTO public.user_roles VALUES (5, 4);
INSERT INTO public.user_roles VALUES (6, 5);
INSERT INTO public.user_roles VALUES (7, 6);
INSERT INTO public.user_roles VALUES (7, 7);
INSERT INTO public.user_roles VALUES (8, 8);
INSERT INTO public.user_roles VALUES (8, 9);
INSERT INTO public.user_roles VALUES (9, 10);


--
-- TOC entry 3631 (class 0 OID 34139)
-- Dependencies: 223
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'hello@hello.com', '$2a$10$I33gJNfvLLexk6Ux19WMg.MDufwqP2oBdD8qIQCQUaR6KZb.pirt.', 'hello');
INSERT INTO public.users VALUES (2, 'sup@sup.com', '$2a$10$nwYc0eknmAMbITbVzSaqEe4e/8dKbfxo.Xmfc7CVyQzwrWZjJELju', 'sup');
INSERT INTO public.users VALUES (3, 'supi@supi.com', '$2a$10$WegM2XcmQKr/dmkPaFgmAe7Wl0za.ts7SFm0zSFcEvs8UT2iwwkdG', 'supi');
INSERT INTO public.users VALUES (4, 'man@man.com', '$2a$10$hBXa155e58SG6YnCNm/E4.7xja3OSUflDi.eRRxhrpW9dErgjzv5.', 'man');
INSERT INTO public.users VALUES (5, 'suppa@suppa.com', '$2a$10$hmb4dFiZJVgGTso.4YjFMObbMkh91pn83AaSCJTVjGpoXazCKGvDq', 'suppa');
INSERT INTO public.users VALUES (6, 'hellom@hellom.com', '$2a$10$VFl04C7npabw7YTiGENXwueCQ/uIsGRfEXNotgWdCW8GOlzmN8qE6', 'hellom');
INSERT INTO public.users VALUES (7, 'admin@admin.com', '$2a$10$3aoo2VkZaRZOkHeawrcngejLY2JO2UD/w95rBjkD/CPOOYtNSUNtC', 'admin');
INSERT INTO public.users VALUES (8, 'admin2@admin2.com', '$2a$10$Ragas/dp9qJZxGn0UeN1L.85jlq0nIsTn6bKB.4kua3PEVplTDXF2', 'admin2');
INSERT INTO public.users VALUES (9, 'sudoku@sudoku.com', '$2a$10$uLEg9hRTuRk1EE9DlisPluPNkCat/S9NOtsF5h7aQZXHtHiSTfYPm', 'sudoku');


--
-- TOC entry 3632 (class 0 OID 34167)
-- Dependencies: 224
-- Data for Name: users_roles; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 3638 (class 0 OID 0)
-- Dependencies: 215
-- Name: clubs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.clubs_id_seq', 19, true);


--
-- TOC entry 3639 (class 0 OID 0)
-- Dependencies: 217
-- Name: event_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.event_id_seq', 7, true);


--
-- TOC entry 3640 (class 0 OID 0)
-- Dependencies: 219
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 10, true);


--
-- TOC entry 3641 (class 0 OID 0)
-- Dependencies: 222
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 9, true);


--
-- TOC entry 3467 (class 2606 OID 34120)
-- Name: clubs clubs_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_pkey PRIMARY KEY (id);


--
-- TOC entry 3469 (class 2606 OID 34128)
-- Name: event event_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT event_pkey PRIMARY KEY (id);


--
-- TOC entry 3471 (class 2606 OID 34134)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 3473 (class 2606 OID 34145)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 3474 (class 2606 OID 34146)
-- Name: clubs fk1e0ic3ghh6e36j1c3mh1o07f3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT fk1e0ic3ghh6e36j1c3mh1o07f3 FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- TOC entry 3478 (class 2606 OID 34175)
-- Name: users_roles fk2o0jvgh89lemvvo17cbqvdxaa; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT fk2o0jvgh89lemvvo17cbqvdxaa FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3475 (class 2606 OID 34151)
-- Name: event fk8meg6nvkeiw3li6ufg06xww2d; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event
    ADD CONSTRAINT fk8meg6nvkeiw3li6ufg06xww2d FOREIGN KEY (club_id) REFERENCES public.clubs(id);


--
-- TOC entry 3476 (class 2606 OID 34156)
-- Name: user_roles fkh8ciramu9cc9q3qcqiv4ue8a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkh8ciramu9cc9q3qcqiv4ue8a6 FOREIGN KEY (role_id) REFERENCES public.roles(id);


--
-- TOC entry 3477 (class 2606 OID 34161)
-- Name: user_roles fkhfh9dx7w3ubf1co1vdev94g3f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_roles
    ADD CONSTRAINT fkhfh9dx7w3ubf1co1vdev94g3f FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- TOC entry 3479 (class 2606 OID 34170)
-- Name: users_roles fkj6m8fwv7oqv74fcehir1a9ffy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users_roles
    ADD CONSTRAINT fkj6m8fwv7oqv74fcehir1a9ffy FOREIGN KEY (role_id) REFERENCES public.roles(id);


-- Completed on 2024-12-08 11:07:55 CET

--
-- PostgreSQL database dump complete
--

