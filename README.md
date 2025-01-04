<h1 id="top" align="center">🚢 v1.0.0 🚢</h1>

<br>

## 🔍 Table of Contents

- [Features](#features)
- [Next Release Features](#next-release-features)
- [System Startup](#system-startup)

<br/>

<h2 id="features">🔥 Features</h2>

+ **Database Initialization:** Automatically sets up the PostgreSQL database schema and loads seed data during container startup.
+ **Lightweight Alpine Base:** Built using an Alpine Linux base for minimal image size and faster startup.
+ **Felxibility:** Easily modify the default schema and data by updating SQL scripts in the project.
+ **Docker Containerization:** The application is containerized for consistent deployment and scaling.

<br/>

<h2 id="next-release-features">🚧 Next Release Features</h2>

- Not planning further features.

<br/>

<h2 id="system-startup">🚀 System Startup</h2> 

* Create a new directory named `core`.
* Clone the `core-docker-config` and `core-database-initializer-alpine-postgresql-client` repositories into the `core` directory.
```
git clone https://github.com/ahmettoguz/core-docker-config
git clone https://github.com/ahmettoguz/core-database-initializer-alpine-postgresql-client
```
- Create `.env` file based on the `.env.example` file and configure it appropriately.
- Export the SQL script using the pgAdmin interface. Check [`core-pgadmin`](https://github.com/ahmettoguz/core-pgadmin) repository.
- Replace the `init.sql` file with your custom SQL script to initialize the database schema and seed data.
- Include following code block to terminate all connections from database to be able to remove and re-initialize it.

```
DO $$ 
BEGIN
    PERFORM pg_terminate_backend(pg_stat_activity.pid)
    FROM pg_stat_activity
    WHERE pg_stat_activity.datname = '<DATABASE_NAME>' AND pid <> pg_backend_pid();
END;
$$;
```

- Refer to the documentation provided in the [`core-docker-config`](https://github.com/ahmettoguz/core-docker-config) project for the system startup commands.

<br/>

### [🔝](#top)
