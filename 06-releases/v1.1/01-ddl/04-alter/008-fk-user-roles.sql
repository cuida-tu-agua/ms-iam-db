--liquibase formatted sql

--changeset esteban:v1.1-ddl-fk-008-fk-user-roles
--comment: user_roles -> users, roles, users (assigned_by)
ALTER TABLE security.user_roles
    ADD CONSTRAINT FK_uroles_user
    FOREIGN KEY (user_id) REFERENCES security.users (id);
ALTER TABLE security.user_roles
    ADD CONSTRAINT FK_uroles_role
    FOREIGN KEY (role_id) REFERENCES security.roles (id);
ALTER TABLE security.user_roles
    ADD CONSTRAINT FK_uroles_assigned_by
    FOREIGN KEY (assigned_by) REFERENCES security.users (id);
--rollback ALTER TABLE security.user_roles DROP CONSTRAINT FK_uroles_assigned_by;
--rollback ALTER TABLE security.user_roles DROP CONSTRAINT FK_uroles_role;
--rollback ALTER TABLE security.user_roles DROP CONSTRAINT FK_uroles_user;
