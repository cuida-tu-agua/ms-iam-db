--liquibase formatted sql

--changeset diego:v1.5-ddl-alter-001-action-codes-phone-verify
--comment: HU-028 the 6-digit code also verifies a phone. It travels by the mode the user picked (SMS or WhatsApp) and remembers the number and the mode it was sent to: the user's verified phone does not change until the code is confirmed
ALTER TABLE security.action_codes DROP CONSTRAINT CK_actcode_action;
ALTER TABLE security.action_codes
    ADD CONSTRAINT CK_actcode_action CHECK (action IN (N'VALVE_CLOSE', N'PHONE_VERIFY'));
ALTER TABLE security.action_codes ADD target_phone NVARCHAR(20) NULL;
ALTER TABLE security.action_codes ADD channel NVARCHAR(10) NULL;
--rollback ALTER TABLE security.action_codes DROP COLUMN channel;
--rollback ALTER TABLE security.action_codes DROP COLUMN target_phone;
--rollback ALTER TABLE security.action_codes DROP CONSTRAINT CK_actcode_action;
--rollback ALTER TABLE security.action_codes ADD CONSTRAINT CK_actcode_action CHECK (action IN (N'VALVE_CLOSE'));

--changeset diego:v1.5-ddl-alter-002-action-codes-phone-checks
--comment: A phone code always carries its number (E.164, +57 Colombia / +593 Ecuador) and its mode; a valve code carries neither. IS NOT NULL is explicit: NULL LIKE '+%' is UNKNOWN and a CHECK lets UNKNOWN through
ALTER TABLE security.action_codes
    ADD CONSTRAINT CK_actcode_channel CHECK (channel IS NULL OR channel IN (N'SMS', N'WHATSAPP'));
ALTER TABLE security.action_codes
    ADD CONSTRAINT CK_actcode_phone_target CHECK (
        (action = N'PHONE_VERIFY' AND target_phone IS NOT NULL AND target_phone LIKE N'+%' AND channel IS NOT NULL)
        OR (action <> N'PHONE_VERIFY' AND target_phone IS NULL AND channel IS NULL));
--rollback ALTER TABLE security.action_codes DROP CONSTRAINT CK_actcode_phone_target;
--rollback ALTER TABLE security.action_codes DROP CONSTRAINT CK_actcode_channel;
