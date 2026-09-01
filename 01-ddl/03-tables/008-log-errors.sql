--liquibase formatted sql

--changeset diego:ddl-table-008-log-errors
--comment: Application technical error log
CREATE TABLE security.Log_Errors (
    LogErrorID          BIGINT IDENTITY(1,1) NOT NULL,
    LogErrorLevel       NVARCHAR(20)         NOT NULL,
    LogErrorMessage     NVARCHAR(1024)       NOT NULL,
    StackTrace          NVARCHAR(MAX)        NULL,
    Origin              NVARCHAR(255)        NULL,
    LogErrorDate        DATETIME2            NOT NULL CONSTRAINT DF_LogErrors_Date DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_Log_Errors PRIMARY KEY (LogErrorID)
);
--rollback DROP TABLE security.Log_Errors;
