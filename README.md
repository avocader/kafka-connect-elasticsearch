# Kafka Connect Elasticsearch Connector
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fconfluentinc%2Fkafka-connect-elasticsearch.svg?type=shield)](https://app.fossa.io/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fconfluentinc%2Fkafka-connect-elasticsearch?ref=badge_shield)


kafka-connect-elasticsearch is a [Kafka Connector](http://kafka.apache.org/documentation.html#connect)
for copying data between Kafka and Elasticsearch.

# Development

To build a development version you'll need a recent version of Kafka as well as a set of upstream Confluent projects, which you'll have to build from their appropriate snapshot branch. See the [FAQ](https://github.com/confluentinc/kafka-connect-elasticsearch/wiki/FAQ) for guidance on this process.

You can build kafka-connect-elasticsearch with Maven using the standard lifecycle phases.

# Running integration tests on Mac

There is a known networking issue with Docker on Mac(host machine can't access container by its IP), so you have to route Docker containers to your loopback interface:
```
sudo ifconfig lo0 alias 172.17.0.1/24
sudo ifconfig lo0 alias 172.17.0.2/24
sudo ifconfig lo0 alias 172.17.0.3/24
```

# Contribute

- Source Code: https://github.com/confluentinc/kafka-connect-elasticsearch
- Issue Tracker: https://github.com/confluentinc/kafka-connect-elasticsearch/issues


# License

This project is licensed under the [Confluent Community License](LICENSE).


[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fconfluentinc%2Fkafka-connect-elasticsearch.svg?type=large)](https://app.fossa.io/projects/git%2Bhttps%3A%2F%2Fgithub.com%2Fconfluentinc%2Fkafka-connect-elasticsearch?ref=badge_large)
