--liquibase formatted sql

--changeset juanmanuel:ddl-fk-002-role-permission
--comment: FK from Role_Permission to Roles and Permissions
ALTER TABLE security.Role_Permission
    ADD CONSTRAINT FK_RolePermission_Role
    FOREIGN KEY (RoleID) REFERENCES security.Roles (RoleID) ON DELETE CASCADE;
ALTER TABLE security.Role_Permission
    ADD CONSTRAINT FK_RolePermission_Permission
    FOREIGN KEY (PermissionID) REFERENCES security.Permissions (PermissionID) ON DELETE CASCADE;
--rollback ALTER TABLE security.Role_Permission DROP CONSTRAINT FK_RolePermission_Permission;
--rollback ALTER TABLE security.Role_Permission DROP CONSTRAINT FK_RolePermission_Role;