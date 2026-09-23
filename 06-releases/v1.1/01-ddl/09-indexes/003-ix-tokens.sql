--liquibase formatted sql

--changeset esteban:v1.1-ddl-ix-003-tokens
--comment: Índices de FK para tokens (revocar todas las sesiones, invalidar enlaces previos)
CREATE INDEX IX_rtoken_user    ON security.refresh_tokens      (user_id);
CREATE INDEX IX_emailver_user  ON security.email_verifications (user_id);
CREATE INDEX IX_pwdreset_user  ON security.password_resets     (user_id);
--rollback DROP INDEX IX_pwdreset_user ON security.password_resets;
--rollback DROP INDEX IX_emailver_user ON security.email_verifications;
--rollback DROP INDEX IX_rtoken_user   ON security.refresh_tokens;
