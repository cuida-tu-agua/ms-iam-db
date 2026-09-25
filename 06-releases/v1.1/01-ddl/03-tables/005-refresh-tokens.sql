--liquibase formatted sql

--changeset esteban:v1.1-ddl-table-005-refresh-tokens
--comment: HU-003/005/006/008/060 refresh token 7 días, revocable (revoked_at). Solo se guarda el hash SHA-256
CREATE TABLE security.refresh_tokens (
    id          BIGINT        IDENTITY(1,1) NOT NULL,
    user_id     UNIQUEIDENTIFIER NOT NULL,
    token_hash  NVARCHAR(256) NOT NULL,
    device_info NVARCHAR(500) NULL,
    expires_at  DATETIME2     NOT NULL,
    revoked_at  DATETIME2     NULL,
    created_at  DATETIME2     NOT NULL CONSTRAINT DF_rtoken_created_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_refresh_tokens PRIMARY KEY (id),
    CONSTRAINT UQ_rtoken_hash    UNIQUE (token_hash)
);
--rollback DROP TABLE security.refresh_tokens;
