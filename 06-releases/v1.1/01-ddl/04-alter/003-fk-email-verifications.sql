--liquibase formatted sql

--changeset esteban:v1.1-ddl-fk-003-fk-email-verifications
--comment: email_verifications -> users
ALTER TABLE security.email_verifications
    ADD CONSTRAINT FK_emailver_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE security.email_verifications DROP CONSTRAINT FK_emailver_user;
