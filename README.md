# plain-logstash (6.3.2)
Plain image running logstash-oss

## Fire it up

Start the ELK stack (all components use the same version) using `docker-app`.

```
$ docker-app deploy -s dev.yml
Creating network elk_default
Creating config elk_logstash_config
Creating service elk_logstash
Creating service elk_elasticsearch
Creating service elk_kibana
```

Once all components are started (`docker service ls`), send an message to create and populate an index.

```
$ curl -XPOST localhost:8080 -d test2
```
