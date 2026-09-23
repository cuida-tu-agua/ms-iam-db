--liquibase formatted sql

--changeset esteban:v1.1-ddl-table-001-users
--comment: BC-01 User aggregate root. + deleted_at (HU-008), blocked_at/blocked_by (HU-060). phone NULL: Google sign-up (HU-004) no trae teléfono
CREATE TABLE security.users (
    id                   BIGINT           IDENTITY(1,1) NOT NULL,
    uuid                 UNIQUEIDENTIFIER NOT NULL CONSTRAINT DF_users_uuid           DEFAULT (NEWID()),
    first_name           NVARCHAR(100)    NOT NULL,
    last_name            NVARCHAR(100)    NOT NULL,
    email                NVARCHAR(320)    NOT NULL,
    phone                NVARCHAR(20)     NULL,
    phone_verified       BIT              NOT NULL CONSTRAINT DF_users_phone_verified DEFAULT (0),
    avatar_url           NVARCHAR(500)    NULL,
    email_verified       BIT              NOT NULL CONSTRAINT DF_users_email_verified DEFAULT (0),
    account_locked_until DATETIME2        NULL,
    blocked_at           DATETIME2        NULL,
    blocked_by           BIGINT           NULL,
    deleted_at           DATETIME2        NULL,
    created_at           DATETIME2        NOT NULL CONSTRAINT DF_users_created_at     DEFAULT (SYSUTCDATETIME()),
    updated_at           DATETIME2        NOT NULL CONSTRAINT DF_users_updated_at     DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_users            PRIMARY KEY (id),
    CONSTRAINT UQ_users_uuid       UNIQUE (uuid),
    CONSTRAINT UQ_users_email      UNIQUE (email),
    CONSTRAINT CK_users_first_name CHECK (LEN(first_name) >= 2),
    CONSTRAINT CK_users_last_name  CHECK (LEN(last_name) >= 2),
    CONSTRAINT CK_users_blocked_by CHECK (blocked_by IS NULL OR blocked_at IS NOT NULL)
);
--rollback DROP TABLE security.users;
