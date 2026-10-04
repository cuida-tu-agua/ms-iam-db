--liquibase formatted sql

--changeset esteban:v1.2-ddl-alter-001-code-failed-attempts
--comment: HU-002/HU-005 the 6-digit codes allow at most 5 wrong tries; the counter lives next to each code
ALTER TABLE security.email_verifications
    ADD failed_attempts INT NOT NULL CONSTRAINT DF_emailver_failed DEFAULT (0);
ALTER TABLE security.email_verifications
    ADD CONSTRAINT CK_emailver_failed CHECK (failed_attempts >= 0);
ALTER TABLE security.password_resets
    ADD failed_attempts INT NOT NULL CONSTRAINT DF_pwdreset_failed DEFAULT (0);
ALTER TABLE security.password_resets
    ADD CONSTRAINT CK_pwdreset_failed CHECK (failed_attempts >= 0);
--rollback ALTER TABLE security.password_resets DROP CONSTRAINT CK_pwdreset_failed;
--rollback ALTER TABLE security.password_resets DROP CONSTRAINT DF_pwdreset_failed;
--rollback ALTER TABLE security.password_resets DROP COLUMN failed_attempts;
--rollback ALTER TABLE security.email_verifications DROP CONSTRAINT CK_emailver_failed;
--rollback ALTER TABLE security.email_verifications DROP CONSTRAINT DF_emailver_failed;
--rollback ALTER TABLE security.email_verifications DROP COLUMN failed_attempts;
