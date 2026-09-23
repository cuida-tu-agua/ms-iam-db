--liquibase formatted sql

--changeset esteban:v1.1-ddl-ix-001-users
--comment: HU-005 reset por teléfono necesita resolver un único usuario; HU-059 listado filtra activos
CREATE UNIQUE INDEX UX_users_phone   ON security.users (phone) WHERE phone IS NOT NULL;
CREATE INDEX        IX_users_deleted ON security.users (deleted_at);
--rollback DROP INDEX IX_users_deleted ON security.users;
--rollback DROP INDEX UX_users_phone   ON security.users;
