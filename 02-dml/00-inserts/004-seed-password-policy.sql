--liquibase formatted sql

--changeset esteban:dml-004-seed-password-policy context:seed
--comment: Default password policy
INSERT INTO security.Password_Policies
    (MinimumLength, RequiresUpercase, RequiresLowercase, RequireNumber, RequireSpecial, ExpirationDays, MaxAttempts, PolActive)
VALUES
    (8, 1, 1, 1, 1, 90, 5, 1);
--rollback DELETE FROM security.Password_Policies;