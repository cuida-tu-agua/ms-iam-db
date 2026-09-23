--liquibase formatted sql

--changeset esteban:v1.1-ddl-ix-005-user-roles
--comment: Buscar usuarios por rol (HU-059 listar admins)
CREATE INDEX IX_uroles_role ON security.user_roles (role_id);
--rollback DROP INDEX IX_uroles_role ON security.user_roles;
