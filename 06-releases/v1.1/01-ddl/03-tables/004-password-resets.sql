--liquibase formatted sql

--changeset esteban:v1.1-ddl-table-004-password-resets
--comment: HU-005 reset de contraseña de un solo uso (15 min). + channel: se solicita por correo o teléfono
CREATE TABLE security.password_resets (
    id          BIGINT        IDENTITY(1,1) NOT NULL,
    user_id     UNIQUEIDENTIFIER NOT NULL,
    token_hash  NVARCHAR(256) NOT NULL,
    channel     NVARCHAR(10)  NOT NULL CONSTRAINT DF_pwdreset_channel    DEFAULT (N'EMAIL'),
    expires_at  DATETIME2     NOT NULL,
    used_at     DATETIME2     NULL,
    created_at  DATETIME2     NOT NULL CONSTRAINT DF_pwdreset_created_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_password_resets PRIMARY KEY (id),
    CONSTRAINT UQ_pwdreset_token  UNIQUE (token_hash),
    CONSTRAINT CK_pwdreset_channel CHECK (channel IN (N'EMAIL', N'PHONE'))
);
--rollback DROP TABLE security.password_resets;
