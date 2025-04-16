FROM ahmettoguz/postgresql-client

WORKDIR /app

COPY ./sql/init.sql .
# COPY ./sql/init2.sql .

CMD /bin/sh -c "\
  #   echo '🚀🚀🚀' && \
  #   echo '🚀 Running the init2.sql script' && \
  #   echo '🚀🚀🚀' && \

  #   /usr/bin/psql -U \"$USERNAME\" -d \"$DATABASE\" -h \"$HOST\" -f /app/init2.sql && \

  #   echo '⚓⚓⚓' && \
  #   echo '⚓ Execution of init2.sql is complete' && \
  #   echo -e '⚓⚓⚓\n' && \

  echo '🚀🚀🚀' && \
  echo '🚀 Running the init.sql script' && \
  echo '🚀🚀🚀' && \

  /usr/bin/psql -U \"$USERNAME\" -d \"$DATABASE\" -h \"$HOST\" -f /app/init.sql && \

  echo '⚓⚓⚓' && \
  echo '⚓ Execution of init.sql is complete' && \
  echo '⚓⚓⚓'"
