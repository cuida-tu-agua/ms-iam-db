--liquibase formatted sql

--changeset esteban:v1.1-ddl-ix-002-credentials
--comment: Login con Google busca por google_id (único entre cuentas)
CREATE UNIQUE INDEX UX_cred_google_id ON security.user_credentials (google_id) WHERE google_id IS NOT NULL;
--rollback DROP INDEX UX_cred_google_id ON security.user_credentials;
