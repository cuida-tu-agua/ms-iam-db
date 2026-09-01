--liquibase formatted sql

--changeset esteban:ddl-table-009-security-config
--comment: Security configuration parameters (key-value)
CREATE TABLE security.Security_Config (
    ConfigID                INT IDENTITY(1,1) NOT NULL,
    Clue                    NVARCHAR(100)     NOT NULL,
    ConfigValue             NVARCHAR(512)     NOT NULL,
    ConfigDescription       NVARCHAR(255)     NULL,
    UpdatedDate DATETIME2         NOT NULL CONSTRAINT DF_Config_Date DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_Security_Config PRIMARY KEY (ConfigID),
    CONSTRAINT UQ_Config_Clue     UNIQUE (Clue)
);
--rollback DROP TABLE security.Security_Config;
