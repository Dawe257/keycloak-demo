INSERT INTO public.organizations
VALUES ('e6a625cc-718b-48c2-ac76-1dfdff9a531e', 'Ostock', 'Illary Huaylupo', 'illaryhs@gmail.com', '888888888');
INSERT INTO public.organizations
VALUES ('d898a142-de44-466c-8c88-9ceb2c2429d3', 'OptimaGrowth', 'Admin', 'illaryhs@gmail.com', '888888888');
INSERT INTO public.organizations
VALUES ('e839ee96-28de-4f67-bb79-870ca89743a0', 'Ostock', 'Illary Huaylupo', 'illaryhs@gmail.com', '888888888');
INSERT INTO public.licenses
VALUES ('f2a9c9d4-d2c0-44fa-97fe-724d77173c62', 'd898a142-de44-466c-8c88-9ceb2c2429d3', 'Software Product', 'Ostock',
        'complete', 'I AM DEV');
INSERT INTO public.licenses
VALUES ('279709ff-e6d5-4a54-8b55-a5c37542025b', 'e839ee96-28de-4f67-bb79-870ca89743a0', 'Software Product', 'Ostock',
        'complete', 'I AM DEV');

INSERT INTO acl_sid (id, principal, sid)
VALUES (1, 1, 'ivan');

INSERT INTO acl_class (id, class)
VALUES (1, 'com.optimagrowth.organization.model.Organization');

INSERT INTO acl_object_identity (id, object_id_class, object_id_identity, parent_object, owner_sid, entries_inheriting)
VALUES (1, 1, 'd898a142-de44-466c-8c88-9ceb2c2429d3', NULL, 1, 0);

INSERT INTO acl_entry (id, acl_object_identity, ace_order, sid, mask, granting, audit_success, audit_failure)
VALUES (1, 1, 1, 1, 1, 1, 1, 1);