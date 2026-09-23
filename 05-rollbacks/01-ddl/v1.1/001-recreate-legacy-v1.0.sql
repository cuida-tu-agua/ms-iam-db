-- 05-rollbacks/01-ddl/v1.1/001-recreate-legacy-v1.0.sql
-- Rollback of v1.1-ddl-drop-001-legacy-v1.0: rebuilds the v1.0-baseline structure + seeds.
-- Generated from the v1.0 changesets (01-ddl, 02-dml). Used by 'liquibase rollback v1.0-baseline'.

-- from 01-ddl/03-tables/001-users.sql
CREATE TABLE security.Users (
    UserID              INT IDENTITY(1,1) NOT NULL,
    UserName            NVARCHAR(255)     NOT NULL,
    Email               NVARCHAR(255)     NOT NULL,
    password_hash       NVARCHAR(255)     NOT NULL,
    UserState           BIT               NOT NULL CONSTRAINT DF_Users_State        DEFAULT (1),
    AuthenticationType  NVARCHAR(50)      NOT NULL CONSTRAINT DF_Users_AuthType      DEFAULT (N'LOCAL'),
    CreationDate        DATETIME2         NOT NULL CONSTRAINT DF_Users_CreationDate DEFAULT (SYSUTCDATETIME()),
    LastAccess          DATETIME2         NULL,
    CONSTRAINT PK_Users        PRIMARY KEY (UserID),
    CONSTRAINT UQ_Users_Name UNIQUE (UserName),
    CONSTRAINT UQ_Users_Email  UNIQUE (Email)
);


-- from 01-ddl/03-tables/002-roles.sql
CREATE TABLE security.Roles (
    RoleID          INT IDENTITY(1,1) NOT NULL,
    RoleName        NVARCHAR(50)      NOT NULL,
    RoleDescription NVARCHAR(255)     NULL,
    CONSTRAINT PK_Roles        PRIMARY KEY (RoleID),
    CONSTRAINT UQ_Roles_Name UNIQUE (RoleName)
);


-- from 01-ddl/03-tables/003-permissions.sql
CREATE TABLE security.Permissions (
    PermissionID        INT IDENTITY(1,1) NOT NULL,
    PermissionName      NVARCHAR(100)     NOT NULL,
    PerDescription      NVARCHAR(255)     NULL,
    CONSTRAINT PK_Permissions        PRIMARY KEY (PermissionID),
    CONSTRAINT UQ_Permissions_Name UNIQUE (PermissionName)
);


-- from 01-ddl/03-tables/004-user-role.sql
CREATE TABLE security.User_Role (
    UserID          INT       NOT NULL,
    RoleID          INT       NOT NULL,
    AssignationDate DATETIME2 NOT NULL CONSTRAINT DF_UserRole_Date DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_User_Role PRIMARY KEY (UserID, RoleID)
);


-- from 01-ddl/03-tables/005-role-permission.sql
CREATE TABLE security.Role_Permission (
    RoleID          INT NOT NULL,
    PermissionID    INT NOT NULL,
    CONSTRAINT PK_Role_Permission PRIMARY KEY (RoleID, PermissionID)
);


-- from 01-ddl/03-tables/006-user-session.sql
CREATE TABLE security.User_Session (
    SessionID           BIGINT IDENTITY(1,1) NOT NULL,
    UserID              INT                  NOT NULL,
    TokenJTI            NVARCHAR(255)        NOT NULL,
    StartDate           DATETIME2            NOT NULL CONSTRAINT DF_Session_Start  DEFAULT (SYSUTCDATETIME()),
    ExpirationDate      DATETIME2            NOT NULL,
    Revoked             BIT                  NOT NULL CONSTRAINT DF_Sesion_Revoked DEFAULT (0),
    IpOrigin            NVARCHAR(45)         NULL,
    UserAgent           NVARCHAR(512)        NULL,
    CONSTRAINT PK_User_Session  PRIMARY KEY (SessionID),
    CONSTRAINT UQ_Sesion_TokenJTI UNIQUE (TokenJTI)
);


-- from 01-ddl/03-tables/007-audit.sql
CREATE TABLE security.Audit (
    AuditID         BIGINT IDENTITY(1,1) NOT NULL,
    UserID          INT                  NULL,
    AuditAction     NVARCHAR(100)        NOT NULL,
    Entity          NVARCHAR(100)        NULL,
    Detail          NVARCHAR(MAX)        NULL,
    IpOrigin        NVARCHAR(45)         NULL,
    AuditDate       DATETIME2            NOT NULL CONSTRAINT DF_Audit_Date DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_Audit PRIMARY KEY (AuditID)
);


-- from 01-ddl/03-tables/008-log-errors.sql
CREATE TABLE security.Log_Errors (
    LogErrorID          BIGINT IDENTITY(1,1) NOT NULL,
    LogErrorLevel       NVARCHAR(20)         NOT NULL,
    LogErrorMessage     NVARCHAR(1024)       NOT NULL,
    StackTrace          NVARCHAR(MAX)        NULL,
    Origin              NVARCHAR(255)        NULL,
    LogErrorDate        DATETIME2            NOT NULL CONSTRAINT DF_LogErrors_Date DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_Log_Errors PRIMARY KEY (LogErrorID)
);


-- from 01-ddl/03-tables/009-security-config.sql
CREATE TABLE security.Security_Config (
    ConfigID                INT IDENTITY(1,1) NOT NULL,
    Clue                    NVARCHAR(100)     NOT NULL,
    ConfigValue             NVARCHAR(512)     NOT NULL,
    ConfigDescription       NVARCHAR(255)     NULL,
    UpdatedDate DATETIME2         NOT NULL CONSTRAINT DF_Config_Date DEFAULT (SYSUTCDATETIME()),
    CONSTRAINT PK_Security_Config PRIMARY KEY (ConfigID),
    CONSTRAINT UQ_Config_Clue     UNIQUE (Clue)
);


-- from 01-ddl/03-tables/010-password-policies.sql
CREATE TABLE security.Password_Policies (
    PolicieID        INT IDENTITY(1,1) NOT NULL,
    MinimumLength    INT               NOT NULL CONSTRAINT DF_Pol_Length   DEFAULT (8),
    RequiresUpercase BIT               NOT NULL CONSTRAINT DF_Pol_Upper      DEFAULT (1),
    RequiresLowercase BIT               NOT NULL CONSTRAINT DF_Pol_Lower      DEFAULT (1),
    RequireNumber    BIT               NOT NULL CONSTRAINT DF_Pol_Number     DEFAULT (1),
    RequireSpecial  BIT               NOT NULL CONSTRAINT DF_Pol_Special   DEFAULT (1),
    ExpirationDays    INT               NOT NULL CONSTRAINT DF_Pol_ExpDays    DEFAULT (90),
    MaxAttempts   INT               NOT NULL CONSTRAINT DF_Pol_Attempts   DEFAULT (5),
    PolActive            BIT               NOT NULL CONSTRAINT DF_Pol_Active     DEFAULT (1),
    CONSTRAINT PK_Password_Policies PRIMARY KEY (PolicieID)
);


-- from 01-ddl/04-alter/001-fk-user-role.sql
ALTER TABLE security.User_Role
    ADD CONSTRAINT FK_UserRole_User
    FOREIGN KEY (UserID) REFERENCES security.Users (UserID) ON DELETE CASCADE;
ALTER TABLE security.User_Role
    ADD CONSTRAINT FK_UserRole_Role
    FOREIGN KEY (RoleID) REFERENCES security.Roles (RoleID) ON DELETE CASCADE;


-- from 01-ddl/04-alter/002-role-permission.sql
ALTER TABLE security.Role_Permission
    ADD CONSTRAINT FK_RolePermission_Role
    FOREIGN KEY (RoleID) REFERENCES security.Roles (RoleID) ON DELETE CASCADE;
ALTER TABLE security.Role_Permission
    ADD CONSTRAINT FK_RolePermission_Permission
    FOREIGN KEY (PermissionID) REFERENCES security.Permissions (PermissionID) ON DELETE CASCADE;


-- from 01-ddl/04-alter/003-fk-user-session.sql
ALTER TABLE security.User_Session
    ADD CONSTRAINT FK_User_Session
    FOREIGN KEY (UserID) REFERENCES security.Users (UserID) ON DELETE CASCADE;


-- from 01-ddl/04-alter/004-fk-audit-user.sql
ALTER TABLE security.Audit
    ADD CONSTRAINT FK_Audit_User
    FOREIGN KEY (UserID) REFERENCES security.Users (UserID) ON DELETE SET NULL;


-- from 01-ddl/09-indexes/001-ix-user-session.sql
CREATE INDEX IX_User_Session_UserID         ON security.User_Session (UserID);
CREATE INDEX IX_User_Session_Expiration     ON security.User_Session (ExpirationDate);


-- from 01-ddl/09-indexes/002-ix-audit.sql
CREATE INDEX IX_Audit_UserID ON security.Audit (UserID);
CREATE INDEX IX_Audit_Date     ON security.Audit (AuditDate);


-- from 01-ddl/09-indexes/003-ix-log-errors.sql
CREATE INDEX IX_Log_Errors_Date ON security.Log_Errors (LogErrorDate);


-- from 02-dml/00-inserts/001-seed-roles.sql
INSERT INTO security.Roles (RoleName, RoleDescription) VALUES (N'ADMIN',    N'Full control administrator');
INSERT INTO security.Roles (RoleName, RoleDescription) VALUES (N'AUDITOR',  N'Security auditor (read + audit)');
INSERT INTO security.Roles (RoleName, RoleDescription) VALUES (N'OPERATOR', N'Operator with limited user management');
INSERT INTO security.Roles (RoleName, RoleDescription) VALUES (N'READER',   N'Read only');


-- from 02-dml/00-inserts/002-seed-permissions.sql
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


-- from 02-dml/00-inserts/003-seed-role-permission.sql
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


-- from 02-dml/00-inserts/004-seed-password-policy.sql
INSERT INTO security.Password_Policies
    (MinimumLength, RequiresUpercase, RequiresLowercase, RequireNumber, RequireSpecial, ExpirationDays, MaxAttempts, PolActive)
VALUES
    (8, 1, 1, 1, 1, 90, 5, 1);

