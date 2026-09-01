--liquibase formatted sql

--changeset juanmanuel:ddl-table-005-role-permission
--comment: Role <-> Permission bridge table (many-to-many)
CREATE TABLE security.Role_Permission (
    RoleID          INT NOT NULL,
    PermissionID    INT NOT NULL,
    CONSTRAINT PK_Role_Permission PRIMARY KEY (RoleID, PermissionID)
);
--rollback DROP TABLE security.Role_Permission;
