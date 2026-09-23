--liquibase formatted sql

--changeset esteban:v1.1-ddl-fk-002-fk-user-credentials
--comment: user_credentials -> users
ALTER TABLE security.user_credentials
    ADD CONSTRAINT FK_cred_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE security.user_credentials DROP CONSTRAINT FK_cred_user;
