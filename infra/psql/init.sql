CREATE DATABASE dms;

ALTER DATABASE dms OWNER TO postgres;

\connect dms

CREATE TABLE public.document_meta
(
    id            character varying(255) NOT NULL,
    author        character varying(255),
    category      character varying(255),
    created_at    timestamp(6) with time zone,
    fts           tsvector,
    original_name character varying(255)
);


ALTER TABLE public.document_meta
    OWNER TO postgres;

CREATE TABLE public.ocr_text
(
    id   text NOT NULL,
    text text,
    tags text[]
);


ALTER TABLE public.ocr_text
    OWNER TO postgres;

ALTER TABLE ONLY public.document_meta
    ADD CONSTRAINT document_meta_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.ocr_text
    ADD CONSTRAINT ocr_text_pkey PRIMARY KEY (id);

CREATE INDEX idx_docmeta_fts ON public.document_meta USING btree (fts);

CREATE EXTENSION IF NOT EXISTS vector;

SELECT 'init.sql is executed'
