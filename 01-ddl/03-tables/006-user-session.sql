--liquibase formatted sql

--changeset diego:ddl-table-006-user-session
--comment: Administrative session log (control/revocation/audit)
CREATE TABLE security.User_Session (
    SessionID           BIGINT IDENTITY(1,1) NOT NULL,
    UserID              INT                  NOT NULL,
    TokenJTI            NVARCHAR(255)        NOT NULL,
    StartDate           DATETIME2            NOT NULL CONSTRAINT DF_Session_Start  DEFAULT (SYSUTCDATETIME()),
    ExpirationDate      DATETIME2            NOT NULL,
    Revoked             BIT                  NOT NULL CONSTRAINT DF_Sesion_Revoked DEFAULT (0),
    IpOrigin            NVARCHAR(45)         NULL,
    UserAgent           NVARCHAR(512)        NULL,
    CONSTRAINT PK_User_Session  PRIMARY KEY (SessionID),
    CONSTRAINT UQ_Sesion_TokenJTI UNIQUE (TokenJTI)
);
--rollback DROP TABLE security.User_Session;
