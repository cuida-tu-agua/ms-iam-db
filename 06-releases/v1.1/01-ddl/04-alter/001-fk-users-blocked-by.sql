--liquibase formatted sql

--changeset esteban:v1.1-ddl-fk-001-fk-users-blocked-by
--comment: users.blocked_by -> users (admin que bloqueó, HU-060)
ALTER TABLE security.users
    ADD CONSTRAINT FK_users_blocked_by
    FOREIGN KEY (blocked_by) REFERENCES security.users (id);
--rollback ALTER TABLE security.users DROP CONSTRAINT FK_users_blocked_by;
