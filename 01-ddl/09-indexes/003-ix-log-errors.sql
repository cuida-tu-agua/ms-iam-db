--liquibase formatted sql

--changeset diego:ddl-ix-003-log-errors
--comment: Support index for error log queries by date
CREATE INDEX IX_Log_Errors_Date ON security.Log_Errors (LogErrorDate);
--rollback DROP INDEX IX_Log_Errors_Date ON security.Log_Errors;
