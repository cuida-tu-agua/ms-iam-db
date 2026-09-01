--liquibase formatted sql

--changeset diego:ddl-fk-004-audit-user
--comment: FK from Audit to Users (SET NULL: the record is preserved even if the User is deleted)
ALTER TABLE security.Audit
    ADD CONSTRAINT FK_Audit_User
    FOREIGN KEY (UserID) REFERENCES security.Users (UserID) ON DELETE SET NULL;
--rollback ALTER TABLE security.Audit DROP CONSTRAINT FK_Audit_User;
