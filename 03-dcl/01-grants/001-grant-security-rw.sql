--liquibase formatted sql

--changeset esteban:dcl-grant-001-security-rw runInTransaction:false
--comment: Minimum read/write permissions for the app role on the security schema
GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::security TO security_rw;
--rollback REVOKE SELECT, INSERT, UPDATE, DELETE ON SCHEMA::security FROM security_rw;