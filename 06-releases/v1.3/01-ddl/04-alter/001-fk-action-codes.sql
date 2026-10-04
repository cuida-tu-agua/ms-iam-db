--liquibase formatted sql

--changeset esteban:v1.3-ddl-fk-001-fk-action-codes
--comment: action_codes -> users
ALTER TABLE security.action_codes
    ADD CONSTRAINT FK_actcode_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE security.action_codes DROP CONSTRAINT FK_actcode_user;
