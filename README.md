# WORK STILL IN PROGRESS

# fluentd-timescaledb

This image contains the open source data collector `Fluentd` together with the timescaledb output
plugin `fluent-plugin-timescaledb`.

In order to concatenate multiline logs separated in multiple events, this image also includes the
`fluent-plugin-concat`.

### Versions overview

| plugin | version |
| fluent-plugin-timescaledb | 1.0.1 |
| fluent-plugin-concat | TODO |

# Startup

# Check for logs in TimescaleDB

```
psql -U postgres

\c logging

\dt

SELECT * FROM log_records ORDER BY time DESC LIMIT 100;
```

# References

https://www.fluentd.org/guides/recipes/docker-logging

https://github.com/1500cloud/fluent-plugin-timescaledb

# Contribution

I welcome any kind of contribution. Fork it and/or contact me. I appreciate any kind of help.
