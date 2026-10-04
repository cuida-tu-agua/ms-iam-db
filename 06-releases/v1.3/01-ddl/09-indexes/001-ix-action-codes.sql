--liquibase formatted sql

--changeset esteban:v1.3-ddl-index-001-ix-action-codes
--comment: "the newest usable code of this user for this action" (findActive / lastIssuedAt)
CREATE INDEX IX_actcode_user_action ON security.action_codes (user_id, action, created_at DESC);
--rollback DROP INDEX IX_actcode_user_action ON security.action_codes;
