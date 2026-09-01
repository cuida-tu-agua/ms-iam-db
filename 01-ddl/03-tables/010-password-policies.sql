--liquibase formatted sql

--changeset esteban:ddl-table-010-politicas-contrasenas
--comment: System password policies
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
--rollback DROP TABLE security.Password_Policies;
