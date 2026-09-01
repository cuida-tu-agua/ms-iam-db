--liquibase formatted sql

--changeset esteban:ddl-table-001-users
--comment: Security system users
CREATE TABLE security.Users (
    UserID              INT IDENTITY(1,1) NOT NULL,
    UserName            NVARCHAR(255)     NOT NULL,
    Email               NVARCHAR(255)     NOT NULL,
    password_hash       NVARCHAR(255)     NOT NULL,
    UserState           BIT               NOT NULL CONSTRAINT DF_Users_State        DEFAULT (1),
    AuthenticationType  NVARCHAR(50)      NOT NULL CONSTRAINT DF_Users_AuthType      DEFAULT (N'LOCAL'),
    CreationDate        DATETIME2         NOT NULL CONSTRAINT DF_Users_CreationDate DEFAULT (SYSUTCDATETIME()),
    LastAccess          DATETIME2         NULL,
    CONSTRAINT PK_Users        PRIMARY KEY (UserID),
    CONSTRAINT UQ_Users_Name UNIQUE (UserName),
    CONSTRAINT UQ_Users_Email  UNIQUE (Email)
);
--rollback DROP TABLE security.Users;
