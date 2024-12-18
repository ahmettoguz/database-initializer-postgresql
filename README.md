# core-database-initializer-alpine-postgresql-client

from pgadmin check repo export plain .sql.
get that sql from postgresql repo.
place it there as init.sql.

to be able to run sql need to close connection. so that add these block to beginning of the sql.

```
DO $$ 
BEGIN
    PERFORM pg_terminate_backend(pg_stat_activity.pid)
    FROM pg_stat_activity
    WHERE pg_stat_activity.datname = 'bank' AND pid <> pg_backend_pid();
END;
$$;
```

to launch container, check core docker config