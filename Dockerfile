FROM rhscl/postgresql-94-rhel7

MAINTAINER Jason Callaway "jason@jasoncallaway.com"

ENV POSTGRESQL_VERSION=9.4 \
    HOME=/var/lib/pgsql \
    PGUSER=postgres

LABEL io.k8s.description="PostgreSQL is an advanced Object-Relational database management system" \
      io.k8s.display-name="PostgreSQL 9.4 PostGIS" \
      io.openshift.expose-services="5432:postgresql" \
      io.openshift.tags="database,postgresql,postgresql94,rh-postgresql94"

# Labels consumed by Red Hat build service
LABEL Name="rhscl/postgresql-94-rhel7-postgis" \
      Version="9.4" \
      Release="0.4" \
      BZComponent="rh-postgresql94-docker" \
      Architecture="x86_64"

EXPOSE 5432

RUN yum install -y https://download.postgresql.org/pub/repos/yum/9.4/redhat/rhel-7-x86_64/pgdg-redhat94-9.4-2.noarch.rpm && \
    yum install -y postgis2_94

ENV BASH_ENV=/var/lib/pgsql/scl_enable \
    ENV=/var/lib/pgsql/scl_enable \
    PROMPT_COMMAND=". /var/lib/pgsql/scl_enable"

VOLUME ["/var/lib/pgsql/data"]

USER 26

ENTRYPOINT ["run-postgresql.sh"]
CMD ["postgres"]
