--liquibase formatted sql

--changeset esteban:v1.1-ddl-table-003-email-verifications
--comment: HU-002 token de verificación de correo (expira a las 24 h, se guarda solo el hash)
CREATE TABLE security.email_verifications (
    id          BIGINT        IDENTITY(1,1) NOT NULL,
    user_id     UNIQUEIDENTIFIER NOT NULL,
    token_hash  NVARCHAR(256) NOT NULL,
    expires_at  DATETIME2     NOT NULL,
    verified_at DATETIME2     NULL,
    created_at  DATETIME2     NOT NULL CONSTRAINT DF_emailver_created_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_email_verifications PRIMARY KEY (id),
    CONSTRAINT UQ_emailver_token      UNIQUE (token_hash)
);
--rollback DROP TABLE security.email_verifications;
