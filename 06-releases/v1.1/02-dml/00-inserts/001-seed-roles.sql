--liquibase formatted sql

--changeset esteban:v1.1-dml-001-seed-roles context:seed
--comment: Roles de plataforma (PB decisión 1). Dueño/Colaborador viven en places.place_members; Invitado no tiene cuenta
INSERT INTO security.roles (code, description) VALUES
 (N'USER',  N'Usuario base: registrado, puede crear lugares o ser invitado a uno'),
 (N'ADMIN', N'Administrador de plataforma: usuarios, dispositivos, métricas y consejos (E14)');
--rollback DELETE FROM security.roles WHERE code IN (N'USER', N'ADMIN');
