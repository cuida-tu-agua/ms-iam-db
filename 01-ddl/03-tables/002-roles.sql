--liquibase formatted sql

--changeset esteban:ddl-table-002-roles
--comment: System roles (ADMIN, AUDITOR, OPERATOR, READER...)
CREATE TABLE security.Roles (
    RoleID          INT IDENTITY(1,1) NOT NULL,
    RoleName        NVARCHAR(50)      NOT NULL,
    RoleDescription NVARCHAR(255)     NULL,
    CONSTRAINT PK_Roles        PRIMARY KEY (RoleID),
    CONSTRAINT UQ_Roles_Name UNIQUE (RoleName)
);
--rollback DROP TABLE security.Roles;
