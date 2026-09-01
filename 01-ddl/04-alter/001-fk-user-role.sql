--liquibase formatted sql

--changeset juanmanuel:ddl-fk-001-user-role
--comment: FK from User_Role to Users and Roles
ALTER TABLE security.User_Role
    ADD CONSTRAINT FK_UserRole_User
    FOREIGN KEY (UserID) REFERENCES security.Users (UserID) ON DELETE CASCADE;
ALTER TABLE security.User_Role
    ADD CONSTRAINT FK_UserRole_Role
    FOREIGN KEY (RoleID) REFERENCES security.Roles (RoleID) ON DELETE CASCADE;
--rollback ALTER TABLE security.User_Role DROP CONSTRAINT FK_UserRole_Role;
--rollback ALTER TABLE security.User_Role DROP CONSTRAINT FK_UserRole_User;