--liquibase formatted sql

--changeset esteban:v1.1-ddl-table-006-login-attempts
--comment: HU-003 cada intento de login (éxito o fallo). user_id NULL cuando el correo no existe
CREATE TABLE security.login_attempts (
    id             BIGINT        IDENTITY(1,1) NOT NULL,
    user_id        BIGINT        NULL,
    email          NVARCHAR(320) NOT NULL,
    ip_address     NVARCHAR(45)  NOT NULL,
    success        BIT           NOT NULL,
    failure_reason NVARCHAR(50)  NULL,
    attempted_at   DATETIME2     NOT NULL CONSTRAINT DF_login_attempted_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_login_attempts PRIMARY KEY (id),
    CONSTRAINT CK_login_reason   CHECK (success = 1 OR failure_reason IS NOT NULL)
);
--rollback DROP TABLE security.login_attempts;
