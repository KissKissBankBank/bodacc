--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

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
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);



--
--

CREATE TABLE bilans (
    id bigint NOT NULL,
    nojo character varying,
    type_annonce character varying,
    numero_annonce character varying,
    numero_departement character varying,
    tribunal character varying,
    siren character varying,
    code_rcs character varying,
    nom_greffe_immat character varying,
    denomination character varying,
    sigle character varying,
    forme_juridique character varying,
    numero_voie character varying,
    type_voie character varying,
    nom_voie character varying,
    compl_geographique character varying,
    code_postal character varying,
    ville character varying,
    date_cloture character varying,
    type_depot character varying,
    descriptif character varying,
    nom_publication_ap character varying,
    numero_parution_ap character varying,
    date_parution_ap timestamp without time zone,
    numero_annonce_ap character varying,
    file character varying,
    type_bodacc character varying,
    parution_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL
);



--
--

CREATE SEQUENCE bilans_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
--

ALTER SEQUENCE bilans_id_seq OWNED BY bilans.id;


--
--

CREATE TABLE immatriculations (
    id bigint NOT NULL,
    nojo character varying,
    type_annonce character varying,
    numero_annonce character varying,
    numero_departement character varying,
    tribunal character varying,
    siren character varying,
    code_rcs character varying,
    nom_greffe_immat character varying,
    denomination character varying,
    administration character varying,
    montant_capital character varying,
    devise character varying,
    forme_juridique character varying,
    numero_voie character varying,
    type_voie character varying,
    nom_voie character varying,
    code_postal character varying,
    ville character varying,
    origine_fonds character varying,
    qualite_etablissement character varying,
    activite character varying,
    date_immatriculation timestamp without time zone,
    date_commencement_activite timestamp without time zone,
    descriptif character varying,
    date_effet timestamp without time zone,
    journal character varying,
    opposition character varying,
    declaration_creance character varying,
    categorie character varying,
    immatriculation character varying,
    nom_publication_ap character varying,
    numero_parution_ap character varying,
    date_parution_ap timestamp without time zone,
    numero_annonce_ap character varying,
    file character varying,
    type_bodacc character varying,
    parution_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL
);



--
--

CREATE SEQUENCE immatriculations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
--

ALTER SEQUENCE immatriculations_id_seq OWNED BY immatriculations.id;


--
--

CREATE TABLE modifications (
    id bigint NOT NULL,
    nojo character varying,
    type_annonce character varying,
    numero_annonce character varying,
    numero_departement character varying,
    tribunal character varying,
    siren character varying,
    code_rcs character varying,
    nom_greffe_immat character varying,
    denomination character varying,
    sigle character varying,
    forme_juridique character varying,
    date_commencement_activite timestamp without time zone,
    date_effet timestamp without time zone,
    descriptif character varying,
    denomination_pepm character varying,
    siren_pepm character varying,
    nature_pepp character varying,
    nom_pepp character varying,
    prenom_pepp character varying,
    nom_usage_pepp character varying,
    siren_pepp character varying,
    nom_publication_ap character varying,
    numero_parution_ap character varying,
    date_parution_ap timestamp without time zone,
    numero_annonce_ap character varying,
    file character varying,
    type_bodacc character varying,
    parution_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL
);



--
--

CREATE SEQUENCE modifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
--

ALTER SEQUENCE modifications_id_seq OWNED BY modifications.id;


--
--

CREATE TABLE pcls (
    id bigint NOT NULL,
    nojo character varying,
    type_annonce character varying,
    numero_annonce character varying,
    numero_departement character varying,
    tribunal character varying,
    identifiant_client character varying,
    siren character varying,
    code_rcs character varying,
    nom_greffe_immat character varying,
    denomination character varying,
    sigle character varying,
    forme_juridique character varying,
    numero_voie character varying,
    type_voie character varying,
    nom_voie character varying,
    compl_geographique character varying,
    code_postal character varying,
    ville character varying,
    famille character varying,
    nature character varying,
    date_jugement timestamp without time zone,
    compl_jugement character varying,
    nom_publication_ap character varying,
    numero_parution_ap character varying,
    date_parution_ap timestamp without time zone,
    numero_annonce_ap character varying,
    file character varying,
    type_bodacc character varying,
    parution_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL
);



--
--

CREATE SEQUENCE pcls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
--

ALTER SEQUENCE pcls_id_seq OWNED BY pcls.id;


--
--

CREATE TABLE radiations (
    id bigint NOT NULL,
    nojo character varying,
    type_annonce character varying,
    numero_annonce character varying,
    numero_departement character varying,
    tribunal character varying,
    siren character varying,
    code_rcs character varying,
    nom_greffe_immat character varying,
    denomination character varying,
    sigle character varying,
    forme_juridique character varying,
    numero_voie character varying,
    type_voie character varying,
    nom_voie character varying,
    code_postal character varying,
    ville character varying,
    radiation_pm character varying,
    date_cessation_activite_pp timestamp without time zone,
    commentaire character varying,
    nom_publication_ap character varying,
    numero_parution_ap character varying,
    date_parution_ap timestamp without time zone,
    numero_annonce_ap character varying,
    file character varying,
    type_bodacc character varying,
    parution_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    created_at timestamp without time zone NOT NULL
);



--
--

CREATE SEQUENCE radiations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;



--
--

ALTER SEQUENCE radiations_id_seq OWNED BY radiations.id;


--
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);



--
--

ALTER TABLE ONLY bilans ALTER COLUMN id SET DEFAULT nextval('bilans_id_seq'::regclass);


--
--

ALTER TABLE ONLY immatriculations ALTER COLUMN id SET DEFAULT nextval('immatriculations_id_seq'::regclass);


--
--

ALTER TABLE ONLY modifications ALTER COLUMN id SET DEFAULT nextval('modifications_id_seq'::regclass);


--
--

ALTER TABLE ONLY pcls ALTER COLUMN id SET DEFAULT nextval('pcls_id_seq'::regclass);


--
--

ALTER TABLE ONLY radiations ALTER COLUMN id SET DEFAULT nextval('radiations_id_seq'::regclass);


--
--

COPY ar_internal_metadata (key, value, created_at, updated_at) FROM stdin;
environment	development	2017-12-19 15:13:10.813312	2017-12-19 15:13:10.813312
\.


--
--

COPY bilans (id, nojo, type_annonce, numero_annonce, numero_departement, tribunal, siren, code_rcs, nom_greffe_immat, denomination, sigle, forme_juridique, numero_voie, type_voie, nom_voie, compl_geographique, code_postal, ville, date_cloture, type_depot, descriptif, nom_publication_ap, numero_parution_ap, date_parution_ap, numero_annonce_ap, file, type_bodacc, parution_at, updated_at, created_at) FROM stdin;
\.


--
--

COPY immatriculations (id, nojo, type_annonce, numero_annonce, numero_departement, tribunal, siren, code_rcs, nom_greffe_immat, denomination, administration, montant_capital, devise, forme_juridique, numero_voie, type_voie, nom_voie, code_postal, ville, origine_fonds, qualite_etablissement, activite, date_immatriculation, date_commencement_activite, descriptif, date_effet, journal, opposition, declaration_creance, categorie, immatriculation, nom_publication_ap, numero_parution_ap, date_parution_ap, numero_annonce_ap, file, type_bodacc, parution_at, updated_at, created_at) FROM stdin;
\.


--
--

COPY modifications (id, nojo, type_annonce, numero_annonce, numero_departement, tribunal, siren, code_rcs, nom_greffe_immat, denomination, sigle, forme_juridique, date_commencement_activite, date_effet, descriptif, denomination_pepm, siren_pepm, nature_pepp, nom_pepp, prenom_pepp, nom_usage_pepp, siren_pepp, nom_publication_ap, numero_parution_ap, date_parution_ap, numero_annonce_ap, file, type_bodacc, parution_at, updated_at, created_at) FROM stdin;
\.


--
--

COPY pcls (id, nojo, type_annonce, numero_annonce, numero_departement, tribunal, identifiant_client, siren, code_rcs, nom_greffe_immat, denomination, sigle, forme_juridique, numero_voie, type_voie, nom_voie, compl_geographique, code_postal, ville, famille, nature, date_jugement, compl_jugement, nom_publication_ap, numero_parution_ap, date_parution_ap, numero_annonce_ap, file, type_bodacc, parution_at, updated_at, created_at) FROM stdin;
\.


--
--

COPY radiations (id, nojo, type_annonce, numero_annonce, numero_departement, tribunal, siren, code_rcs, nom_greffe_immat, denomination, sigle, forme_juridique, numero_voie, type_voie, nom_voie, code_postal, ville, radiation_pm, date_cessation_activite_pp, commentaire, nom_publication_ap, numero_parution_ap, date_parution_ap, numero_annonce_ap, file, type_bodacc, parution_at, updated_at, created_at) FROM stdin;
\.


--
--

COPY schema_migrations (version) FROM stdin;
20171207091438
20171207102203
20171207104153
20171207111501
20171207114120
20180103101449
\.


--
--

SELECT pg_catalog.setval('bilans_id_seq', 6609547, true);


--
--

SELECT pg_catalog.setval('immatriculations_id_seq', 170139, true);


--
--

SELECT pg_catalog.setval('modifications_id_seq', 1, false);


--
--

SELECT pg_catalog.setval('pcls_id_seq', 207550, true);


--
--

SELECT pg_catalog.setval('radiations_id_seq', 1, false);


--
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
--

ALTER TABLE ONLY bilans
    ADD CONSTRAINT bilans_pkey PRIMARY KEY (id);


--
--

ALTER TABLE ONLY immatriculations
    ADD CONSTRAINT immatriculations_pkey PRIMARY KEY (id);


--
--

ALTER TABLE ONLY modifications
    ADD CONSTRAINT modifications_pkey PRIMARY KEY (id);


--
--

ALTER TABLE ONLY pcls
    ADD CONSTRAINT pcls_pkey PRIMARY KEY (id);


--
--

ALTER TABLE ONLY radiations
    ADD CONSTRAINT radiations_pkey PRIMARY KEY (id);


--
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
--

CREATE INDEX index_bilans_on_numero_annonce ON bilans USING btree (numero_annonce);


--
--

CREATE INDEX index_bilans_on_siren ON bilans USING btree (siren);


--
--

CREATE INDEX index_immatriculations_on_numero_annonce ON immatriculations USING btree (numero_annonce);


--
--

CREATE INDEX index_immatriculations_on_siren ON immatriculations USING btree (siren);


--
--

CREATE INDEX index_modifications_on_numero_annonce ON modifications USING btree (numero_annonce);


--
--

CREATE INDEX index_modifications_on_siren ON modifications USING btree (siren);


--
--

CREATE INDEX index_pcls_on_numero_annonce ON pcls USING btree (numero_annonce);


--
--

CREATE INDEX index_pcls_on_siren ON pcls USING btree (siren);


--
--

CREATE INDEX index_radiations_on_numero_annonce ON radiations USING btree (numero_annonce);


--
--

CREATE INDEX index_radiations_on_siren ON radiations USING btree (siren);


--
-- PostgreSQL database dump complete
--
