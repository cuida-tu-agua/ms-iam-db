--liquibase formatted sql

--changeset diego:ddl-ix-002-audit
--comment: Support indices for audit queries
CREATE INDEX IX_Audit_UserID ON security.Audit (UserID);
CREATE INDEX IX_Audit_Date     ON security.Audit (AuditDate);
--rollback DROP INDEX IX_Audit_Date     ON security.Audit;
--rollback DROP INDEX IX_Audit_UserID ON security.Audit;
