--liquibase formatted sql

--changeset esteban:v1.1-ddl-fk-005-fk-refresh-tokens
--comment: refresh_tokens -> users
ALTER TABLE security.refresh_tokens
    ADD CONSTRAINT FK_rtoken_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE security.refresh_tokens DROP CONSTRAINT FK_rtoken_user;
