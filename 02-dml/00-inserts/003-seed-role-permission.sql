--liquibase formatted sql

--changeset juanmanuel:dml-003-seed-role-permission context:seed
--comment: Initial role-permission matrix (resolved by name, IDs are IDENTITY)

-- ADMIN: all permissions
INSERT INTO security.Role_Permission (RoleID, PermissionID)
SELECT r.RoleID, p.PermissionID
FROM security.Roles r CROSS JOIN security.Permissions p
WHERE r.RoleName = N'ADMIN';

-- AUDITOR: all read + audit
INSERT INTO security.Role_Permission (RoleID, PermissionID)
SELECT r.RoleID, p.PermissionID
FROM security.Roles r JOIN security.Permissions p
  ON p.PermissionName IN (N'USER_READ',N'ROLE_READ',N'PERMISSION_READ',N'AUDIT_READ',N'SESSION_READ',N'SECURITY_POLICY_READ')
WHERE r.RoleName = N'AUDITOR';

-- OPERATOR: user read/create/update + read of roles/permissions/sessions
INSERT INTO security.Role_Permission (RoleID, PermissionID)
SELECT r.RoleID, p.PermissionID
FROM security.Roles r JOIN security.Permissions p
  ON p.PermissionName IN (N'USER_READ',N'USER_CREATE',N'USER_UPDATE',N'ROLE_READ',N'PERMISSION_READ',N'SESSION_READ')
WHERE r.RoleName = N'OPERATOR';

-- READER: basic read only
INSERT INTO security.Role_Permission (RoleID, PermissionID)
SELECT r.RoleID, p.PermissionID
FROM security.Roles r JOIN security.Permissions p
  ON p.PermissionName IN (N'USER_READ',N'ROLE_READ',N'PERMISSION_READ')
WHERE r.RoleName = N'READER';
--rollback DELETE FROM security.Role_Permission;