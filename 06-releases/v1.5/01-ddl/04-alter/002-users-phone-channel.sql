--liquibase formatted sql

--changeset diego:v1.5-ddl-alter-003-users-phone-channel
--comment: HU-028 the mode the phone was verified with (SMS or WHATSAPP). Critical alerts are sent by that same mode, so a number that does not work for it can never be chosen. A verified phone always has its mode; changing the number clears both
ALTER TABLE security.users ADD phone_channel NVARCHAR(10) NULL;
--rollback ALTER TABLE security.users DROP COLUMN phone_channel;

--changeset diego:v1.5-ddl-alter-004-users-phone-channel-checks
--comment: Only SMS or WHATSAPP, and phone_verified = 1 requires a phone and its mode
ALTER TABLE security.users
    ADD CONSTRAINT CK_users_phone_channel CHECK (phone_channel IS NULL OR phone_channel IN (N'SMS', N'WHATSAPP'));
ALTER TABLE security.users
    ADD CONSTRAINT CK_users_phone_verified CHECK (phone_verified = 0 OR (phone IS NOT NULL AND phone_channel IS NOT NULL));
--rollback ALTER TABLE security.users DROP CONSTRAINT CK_users_phone_verified;
--rollback ALTER TABLE security.users DROP CONSTRAINT CK_users_phone_channel;
