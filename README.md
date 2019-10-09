# fluentd-timescaledb

This image contains the open source data collector `Fluentd` together with the timescaledb output
plugin `fluent-plugin-timescaledb`.

In order to concatenate multiline logs separated in multiple events, this image also includes the
`fluent-plugin-concat`.

A docker image is available under `mminks/fluentd-timescaledb:latest` if you want to use it in your environment. 

### Versions used

| name | version |
|---------------------------|:-----:|
| fluent-plugin-timescaledb | 1.0.1 |
| fluent-plugin-concat | 2.4.0 |

# Startup

As it is not possible to start all services in one `docker-compose.yml`
with the fluentd logging driver, we need to split up things a bit.

#### 1. TimescaleDB & Fluentd

```
docker-compose -f fluentd-timescaledb.yml up -d
```

This spins up Fluentd with timescaledb output plugin and the TimescaleDB itself.
Check with `docker ps` that everything is running as expected.

#### 2. Demo service 'NGINX Hello World' 

```
docker-compose -f hello-world.yml up -d
```

This starts our demo service that should produce example log messages.
Check with `docker ps` again that everything is running as expected.

If everything is working, it should look like this:

```
CONTAINER ID        IMAGE                                     COMMAND                  CREATED             STATUS              PORTS                                                              NAMES
f52512e60244        nginxdemos/hello:plain-text               "nginx -g 'daemon of…"   18 minutes ago      Up 18 minutes       0.0.0.0:8080->80/tcp                                               fluentd-timescaledb_hello-world_1
9421c9f88bc4        fluentd-timescaledb_fluentd-timescaledb   "tini -- /bin/entryp…"   19 minutes ago      Up 19 minutes       5140/tcp, 127.0.0.1:24224->24224/tcp, 127.0.0.1:24224->24224/udp   fluentd-timescaledb_fluentd-timescaledb_1
fe70ad5e282d        timescale/timescaledb:latest-pg11         "docker-entrypoint.s…"   19 minutes ago      Up 19 minutes       5432/tcp                                                           fluentd-timescaledb_timescaledb_1
```

# Check for logs

#### 1. In fluentd container log

```
docker logs -f fluentd-timescaledb_fluentd-timescaledb_1
```

Every logging event should produce an entry in the Fluentd container:

```
TODO
```

#### 2. In TimescaleDB

```
docker exec -ti fluentd-timescaledb_timescaledb_1 bash

psql -U logging

\c logging

\dt

SELECT * FROM log_records ORDER BY time DESC LIMIT 100;
```

# Improvements

Right now there is a Fluentd parsing error. This needs to be fixed.

# Cleanup

```
docker-compose -f hello-world.yml down
docker-compose -f fluentd-timescaledb.yml down
```

# References

https://www.fluentd.org/guides/recipes/docker-logging

https://github.com/1500cloud/fluent-plugin-timescaledb

# Contribution

I welcome any kind of contribution. Fork it and/or contact me. I appreciate any kind of help.
