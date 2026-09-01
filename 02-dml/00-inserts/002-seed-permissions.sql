--liquibase formatted sql

--changeset juanmanuel:dml-002-seed-permissions context:seed
--comment: Granular permission catalog
INSERT INTO security.Permissions (PermissionName, PerDescription) VALUES
 (N'USER_READ',              N'View users'),
 (N'USER_CREATE',            N'Create users'),
 (N'USER_UPDATE',            N'Update users'),
 (N'USER_DELETE',            N'Delete users'),
 (N'ROLE_READ',              N'View roles'),
 (N'ROLE_CREATE',            N'Create roles'),
 (N'ROLE_UPDATE',            N'Update roles'),
 (N'ROLE_DELETE',            N'Delete roles'),
 (N'ROLE_ASSIGN',            N'Assign roles to users'),
 (N'PERMISSION_READ',        N'View permissions'),
 (N'PERMISSION_ASSIGN',      N'Assign permissions to roles'),
 (N'AUDIT_READ',             N'View audit'),
 (N'SESSION_READ',           N'View sessions'),
 (N'SESSION_REVOKE',         N'Revoke sessions'),
 (N'SECURITY_POLICY_READ',   N'View security policies'),
 (N'SECURITY_POLICY_UPDATE', N'Update security policies');
--rollback DELETE FROM security.Permissions;