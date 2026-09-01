# design-software-iam-db

Repositorio de **base de datos** del dominio de Seguridad e Identidad (IAM) del proyecto
**Sy Water**. Administra el esquema con **Liquibase** y es la **única fuente de verdad**
del esquema: el backend `ms-security` solo se conecta, no crea tablas.

## Estructura (organizada por categoría SQL)

```text
design-software-iam-db/
├── 00_bootstrap.sql                # CREATE DATABASE + usuarios (una vez, como sa)
├── changelog/
│   └── db.changelog-master.yaml    # punto de entrada de Liquibase
│
├── 01_ddl/                         # estructura
│   ├── 01_schemas/ 03_tables/ 04_alter/ 10_indexes/   (con contenido)
│   ├── 00_extensions/ 02_types/ 05_views/ 06_materialized_views/
│   │   07_functions/ 08_procedures/ 09_triggers/       (reservadas)
│   └── changelog.yaml
│
├── 02_dml/                         # datos, por tipo de operación
│   ├── 00_inserts/                 # seeds (roles, permisos, matriz, política)
│   ├── 01_updates/ 02_deletes/ 03_upserts/ 04_patches/  (reservadas)
│   └── changelog.yaml
│
├── 03_dcl/                         # control de acceso
│   ├── 00_roles/                   # CREATE ROLE + membresía
│   ├── 01_grants/                  # GRANT
│   ├── 02_policies/                # políticas (RLS, opcional)
│   └── changelog.yaml
│
├── 04_tcl/                         # control de transacciones
│   ├── 00_transaction_blocks/      # bloques atómicos explícitos (especial)
│   ├── 01_manual_recoveries/       # scripts manuales (NO en el update automático)
│   ├── 02_release_tags/            # tagDatabase → marca versiones (v1.0)
│   └── changelog.yaml
│
├── 05_rollbacks/                   # rollbacks manuales, espejando categorías
│   ├── 01_ddl/ 02_dml/ 03_dcl/ 04_tcl/
│   └── README.md
│
├── liquibase.properties.example
└── compose.yml                     # SQL Server + Liquibase en Docker
```

## Qué se ejecuta en `liquibase update` (y qué no)

El **master** incluye, en orden: `01_ddl` → `02_dml` → `03_dcl` → `04_tcl`.
Dentro de `04_tcl` solo corren `00_transaction_blocks` y `02_release_tags`.

- `04_tcl/01_manual_recoveries/` → **NO** se auto-ejecuta (scripts manuales).
- `05_rollbacks/` → **NO** se incluye en el master (reversión, no aplicación).

## Puesta en marcha

```bash
# 1) Infraestructura (una vez, como sa)
sqlcmd -S localhost -U sa -P "<sa_pwd>" -C -i 00_bootstrap.sql

# 2) Conexión
cp liquibase.properties.example liquibase.properties   # editar credenciales

# 3) Aplicar
liquibase status --verbose
liquibase update-sql        # dry run
liquibase update            # aplica esquema + seeds + grants + tag v1.0-baseline
```

O con Docker: `docker compose up`.

## Orden de carga (dependencias)

```text
schemas → tables → FK (04_alter) → indexes → inserts (seeds) → roles → grants → release tag
```

## Rollback

- **Automático:** `liquibase rollback v1.0-baseline` (usa los `--rollback` inline).
- **Manual/emergencia:** scripts en `05_rollbacks/<categoría>/` con `sqlcmd`.

## Reglas

- **No editar** un changeset ya aplicado (rompe el checksum de `DATABASECHANGELOG`).
- Un cambio nuevo = un changeset nuevo (los `ALTER` van en `01_ddl/04_alter/`).
- **Nunca** subir `liquibase.properties` con credenciales reales.

## Conexión del backend

`ms-security` apunta a esta **misma** `SecurityDB` con el usuario `security_app` y:

```yaml
spring:
  liquibase:
    enabled: false          # el esquema lo administra ESTE repo
  jpa:
    hibernate:
      ddl-auto: none        # (o 'validate' cuando existan entidades JPA)
```
