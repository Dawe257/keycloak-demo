CREATE TABLE IF NOT EXISTS public.organizations
(
    organization_id text COLLATE pg_catalog."default" NOT NULL,
    name text COLLATE pg_catalog."default",
    contact_name text COLLATE pg_catalog."default",
    contact_email text COLLATE pg_catalog."default",
    contact_phone text COLLATE pg_catalog."default",
    CONSTRAINT organizations_pkey PRIMARY KEY (organization_id)
)

TABLESPACE pg_default;

ALTER TABLE public.organizations
    OWNER to postgres;


CREATE TABLE IF NOT EXISTS public.licenses
(
    license_id text COLLATE pg_catalog."default" NOT NULL,
    organization_id text COLLATE pg_catalog."default" NOT NULL,
    description text COLLATE pg_catalog."default",
    product_name text COLLATE pg_catalog."default" NOT NULL,
    license_type text COLLATE pg_catalog."default" NOT NULL,
    comment text COLLATE pg_catalog."default",
    CONSTRAINT licenses_pkey PRIMARY KEY (license_id),
    CONSTRAINT licenses_organization_id_fkey FOREIGN KEY (organization_id)
        REFERENCES public.organizations (organization_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
        NOT VALID
)
    TABLESPACE pg_default;

ALTER TABLE public.licenses
    OWNER to postgres;

CREATE TABLE IF NOT EXISTS acl_sid
(
    id        SERIAL PRIMARY KEY,
    principal int          NOT NULL,
    sid       varchar(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS acl_class
(
    id    SERIAL PRIMARY KEY,
    class varchar(255) NOT NULL,
    class_id_type varchar(100)
);

CREATE TABLE IF NOT EXISTS acl_object_identity
(
    id                 SERIAL PRIMARY KEY,
    object_id_class    bigint NOT NULL,
    object_id_identity varchar NOT NULL,
    parent_object      bigint DEFAULT NULL,
    owner_sid          bigint DEFAULT NULL,
    entries_inheriting int    NOT NULL
);
ALTER TABLE acl_object_identity
    ADD FOREIGN KEY (parent_object) REFERENCES acl_object_identity (id);
ALTER TABLE acl_object_identity
    ADD FOREIGN KEY (object_id_class) REFERENCES acl_class (id);
ALTER TABLE acl_object_identity
    ADD FOREIGN KEY (owner_sid) REFERENCES acl_sid (id);

CREATE TABLE IF NOT EXISTS acl_entry
(
    id                  SERIAL PRIMARY KEY,
    acl_object_identity bigint NOT NULL,
    ace_order           int    NOT NULL,
    sid                 bigint NOT NULL,
    mask                int    NOT NULL,
    granting            int    NOT NULL,
    audit_success       int    NOT NULL,
    audit_failure       int    NOT NULL
);
ALTER TABLE acl_entry
    ADD FOREIGN KEY (acl_object_identity) REFERENCES acl_object_identity (id);
ALTER TABLE acl_entry
    ADD FOREIGN KEY (sid) REFERENCES acl_sid (id);