--liquibase formatted sql

--changeset diego:ddl-ix-001-user-session
--comment: Support indexes for session queries
CREATE INDEX IX_User_Session_UserID         ON security.User_Session (UserID);
CREATE INDEX IX_User_Session_Expiration     ON security.User_Session (ExpirationDate);
--rollback DROP INDEX IX_User_Session_Expiration ON security.User_Session;
--rollback DROP INDEX IX_User_Session_UserID  ON security.User_Session;
