--liquibase formatted sql

--changeset diego:ddl-fk-003-user-session
--comment: FK from User_Session to Users
ALTER TABLE security.User_Session
    ADD CONSTRAINT FK_User_Session
    FOREIGN KEY (UserID) REFERENCES security.Users (UserID) ON DELETE CASCADE;
--rollback ALTER TABLE security.User_Session DROP CONSTRAINT FK_User_Session;
