--liquibase formatted sql

--changeset esteban:v1.1-ddl-table-007-activity-log
--comment: Auditoría general (HU-003, HU-011, HU-060: acción, entidad, metadata JSON, IP)
CREATE TABLE security.activity_log (
    id          BIGINT         IDENTITY(1,1) NOT NULL,
    user_id     UNIQUEIDENTIFIER NOT NULL,
    action      NVARCHAR(50)   NOT NULL,
    entity_type NVARCHAR(50)   NULL,
    entity_id   NVARCHAR(100)  NULL,
    metadata    NVARCHAR(4000) NULL,
    ip_address  NVARCHAR(45)   NULL,
    created_at  DATETIME2      NOT NULL CONSTRAINT DF_actlog_created_at DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_activity_log PRIMARY KEY (id),
    CONSTRAINT CK_actlog_json  CHECK (metadata IS NULL OR ISJSON(metadata) = 1)
);
--rollback DROP TABLE security.activity_log;
