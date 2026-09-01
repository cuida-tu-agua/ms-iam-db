--liquibase formatted sql

--changeset juanmanuel:dml-001-seed-roles context:seed
--comment: Initial system roles
INSERT INTO security.Roles (RoleName, RoleDescription) VALUES (N'ADMIN',    N'Full control administrator');
INSERT INTO security.Roles (RoleName, RoleDescription) VALUES (N'AUDITOR',  N'Security auditor (read + audit)');
INSERT INTO security.Roles (RoleName, RoleDescription) VALUES (N'OPERATOR', N'Operator with limited user management');
INSERT INTO security.Roles (RoleName, RoleDescription) VALUES (N'READER',   N'Read only');
--rollback DELETE FROM security.Roles WHERE RoleName IN (N'ADMIN',N'AUDITOR',N'OPERATOR',N'READER');