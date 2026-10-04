--liquibase formatted sql

--changeset esteban:v1.2-ddl-ix-002-refresh-active
--comment: HU-006/HU-005 "close all sessions" updates the ACTIVE refresh tokens of one user
CREATE INDEX IX_rtoken_user_active ON security.refresh_tokens (user_id) WHERE revoked_at IS NULL;
--rollback DROP INDEX IX_rtoken_user_active ON security.refresh_tokens;
