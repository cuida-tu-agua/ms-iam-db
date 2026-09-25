--liquibase formatted sql

--changeset esteban:v1.1-ddl-table-002-user-credentials
--comment: Una credencial por tipo y usuario (LOCAL / GOOGLE). HU-004: ambos métodos vinculados a la misma cuenta
CREATE TABLE security.user_credentials (
    id              BIGINT        IDENTITY(1,1) NOT NULL,
    user_id         UNIQUEIDENTIFIER NOT NULL,
    credential_type NVARCHAR(10)  NOT NULL,
    password_hash   NVARCHAR(256) NULL,
    google_id       NVARCHAR(256) NULL,
    created_at      DATETIME2     NOT NULL CONSTRAINT DF_cred_created_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_user_credentials PRIMARY KEY (id),
    CONSTRAINT UQ_cred_user_type   UNIQUE (user_id, credential_type),
    CONSTRAINT CK_cred_type        CHECK (credential_type IN (N'LOCAL', N'GOOGLE')),
    CONSTRAINT CK_cred_secret      CHECK (
        (credential_type = N'LOCAL'  AND password_hash IS NOT NULL AND google_id IS NULL) OR
        (credential_type = N'GOOGLE' AND google_id     IS NOT NULL AND password_hash IS NULL)
    )
);
--rollback DROP TABLE security.user_credentials;
