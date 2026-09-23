--liquibase formatted sql

--changeset esteban:v1.1-ddl-ix-004-audit
--comment: HU-003 conteo de intentos fallidos recientes; historial de actividad por usuario
CREATE INDEX IX_login_user_time  ON security.login_attempts (user_id, attempted_at);
CREATE INDEX IX_actlog_user_time ON security.activity_log   (user_id, created_at);
--rollback DROP INDEX IX_actlog_user_time ON security.activity_log;
--rollback DROP INDEX IX_login_user_time  ON security.login_attempts;
