--liquibase formatted sql

--changeset esteban:v1.3-ddl-table-001-action-codes
--comment: HU-020 6-digit code (5 min, single use, 5 tries) that confirms a sensitive action such as closing the valve. token_hash is NOT unique: only 10^6 codes exist, the same code can come back for the same user
CREATE TABLE security.action_codes (
    id              BIGINT           IDENTITY(1,1) NOT NULL,
    user_id         UNIQUEIDENTIFIER NOT NULL,
    action          NVARCHAR(30)     NOT NULL,
    token_hash      NVARCHAR(256)    NOT NULL,
    expires_at      DATETIME2        NOT NULL,
    used_at         DATETIME2        NULL,
    failed_attempts INT              NOT NULL CONSTRAINT DF_actcode_failed     DEFAULT (0),
    created_at      DATETIME2        NOT NULL CONSTRAINT DF_actcode_created_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_action_codes   PRIMARY KEY (id),
    CONSTRAINT CK_actcode_action CHECK (action IN (N'VALVE_CLOSE')),
    CONSTRAINT CK_actcode_failed CHECK (failed_attempts >= 0)
);
--rollback DROP TABLE security.action_codes;
