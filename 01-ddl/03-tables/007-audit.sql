--liquibase formatted sql

--changeset diego:ddl-table-007-Audit
--comment: Audit of critical system actions
CREATE TABLE security.Audit (
    AuditID         BIGINT IDENTITY(1,1) NOT NULL,
    UserID          INT                  NULL,
    AuditAction     NVARCHAR(100)        NOT NULL,
    Entity          NVARCHAR(100)        NULL,
    Detail          NVARCHAR(MAX)        NULL,
    IpOrigin        NVARCHAR(45)         NULL,
    AuditDate       DATETIME2            NOT NULL CONSTRAINT DF_Audit_Date DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_Audit PRIMARY KEY (AuditID)
);
--rollback DROP TABLE security.Audit;
