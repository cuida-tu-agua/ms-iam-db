--liquibase formatted sql

--changeset esteban:v1.1-ddl-fk-006-fk-login-attempts
--comment: login_attempts -> users (nullable: correo inexistente)
ALTER TABLE security.login_attempts
    ADD CONSTRAINT FK_login_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE security.login_attempts DROP CONSTRAINT FK_login_user;
