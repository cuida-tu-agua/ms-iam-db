--liquibase formatted sql

--changeset esteban:dcl-role-001-security-rw runInTransaction:false
--comment: DB role for app read/write + security_app membership
IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name='security_rw' AND type='R')
    CREATE ROLE security_rw;
ALTER ROLE security_rw ADD MEMBER security_app;
--rollback ALTER ROLE security_rw DROP MEMBER security_app;
--rollback DROP ROLE security_rw;