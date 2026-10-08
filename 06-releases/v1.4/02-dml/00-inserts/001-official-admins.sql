--liquibase formatted sql

--changeset diego:v1.4-dml-001-official-admins runAlways:true
--comment: HU-059..HU-062 official platform administrators. Idempotent and runAlways: an account that registers AFTER this release gets the ADMIN role in the next "liquibase update". Accounts are never created here (no passwords in migrations); to add an administrator, add the e-mail to this list in a new release
INSERT INTO security.user_roles (user_id, role_id, assigned_at)
SELECT u.id, r.id, SYSUTCDATETIME()
FROM security.users u
CROSS JOIN security.roles r
WHERE r.code = N'ADMIN'
  AND LOWER(u.email) IN (N'daalvarado2007@gmail.com', N'juanome43@gmail.com')
  AND u.deleted_at IS NULL
  AND NOT EXISTS (SELECT 1 FROM security.user_roles ur WHERE ur.user_id = u.id AND ur.role_id = r.id);
--rollback DELETE ur FROM security.user_roles ur JOIN security.users u ON u.id = ur.user_id JOIN security.roles r ON r.id = ur.role_id WHERE r.code = N'ADMIN' AND LOWER(u.email) IN (N'daalvarado2007@gmail.com', N'juanome43@gmail.com');
