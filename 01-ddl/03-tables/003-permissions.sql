--liquibase formatted sql

--changeset esteban:ddl-table-003-permissions
--comment: Granular permissions (USER_READ, ROLE_CREATE, ...)
CREATE TABLE security.Permissions (
    PermissionID        INT IDENTITY(1,1) NOT NULL,
    PermissionName      NVARCHAR(100)     NOT NULL,
    PerDescription      NVARCHAR(255)     NULL,
    CONSTRAINT PK_Permissions        PRIMARY KEY (PermissionID),
    CONSTRAINT UQ_Permissions_Name UNIQUE (PermissionName)
);
--rollback DROP TABLE security.Permissions;
