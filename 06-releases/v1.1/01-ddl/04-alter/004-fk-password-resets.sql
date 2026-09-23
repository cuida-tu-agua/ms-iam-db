--liquibase formatted sql

--changeset esteban:v1.1-ddl-fk-004-fk-password-resets
--comment: password_resets -> users
ALTER TABLE security.password_resets
    ADD CONSTRAINT FK_pwdreset_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE security.password_resets DROP CONSTRAINT FK_pwdreset_user;
