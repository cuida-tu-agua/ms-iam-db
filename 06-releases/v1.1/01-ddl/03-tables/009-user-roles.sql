--liquibase formatted sql

--changeset esteban:v1.1-ddl-table-009-user-roles
--comment: Usuario <-> rol de plataforma. assigned_by = admin que lo asignó (NULL = sistema, p. ej. registro)
CREATE TABLE security.user_roles (
    user_id     UNIQUEIDENTIFIER NOT NULL,
    role_id     BIGINT           NOT NULL,
    assigned_at DATETIME2        NOT NULL CONSTRAINT DF_uroles_assigned_at DEFAULT (SYSUTCDATETIME()),
    assigned_by UNIQUEIDENTIFIER NULL,
    CONSTRAINT PK_user_roles PRIMARY KEY (user_id, role_id)
);
--rollback DROP TABLE security.user_roles;
