--liquibase formatted sql

--changeset esteban:v1.1-ddl-table-008-roles
--comment: Roles de PLATAFORMA (USER, ADMIN) para el claim roles del JWT. Dueño/Colaborador son por lugar (places.place_members); Invitado es anónimo
CREATE TABLE security.roles (
    id          BIGINT        IDENTITY(1,1) NOT NULL,
    code        NVARCHAR(30)  NOT NULL,
    description NVARCHAR(255) NULL,
    created_at  DATETIME2     NOT NULL CONSTRAINT DF_roles_created_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_roles      PRIMARY KEY (id),
    CONSTRAINT UQ_roles_code UNIQUE (code)
);
--rollback DROP TABLE security.roles;
