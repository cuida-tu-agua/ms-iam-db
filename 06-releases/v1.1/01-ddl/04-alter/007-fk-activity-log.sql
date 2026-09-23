--liquibase formatted sql

--changeset esteban:v1.1-ddl-fk-007-fk-activity-log
--comment: activity_log -> users
ALTER TABLE security.activity_log
    ADD CONSTRAINT FK_actlog_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
--rollback ALTER TABLE security.activity_log DROP CONSTRAINT FK_actlog_user;
