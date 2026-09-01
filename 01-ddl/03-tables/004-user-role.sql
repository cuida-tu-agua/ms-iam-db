--liquibase formatted sql

--changeset juanmanuel:ddl-table-004-user-role
--comment: User <-> Role bridge table (many-to-many)
CREATE TABLE security.User_Role (
    UserID          INT       NOT NULL,
    RoleID          INT       NOT NULL,
    AssignationDate DATETIME2 NOT NULL CONSTRAINT DF_UserRole_Date DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_User_Role PRIMARY KEY (UserID, RoleID)
);
--rollback DROP TABLE security.User_Role;
