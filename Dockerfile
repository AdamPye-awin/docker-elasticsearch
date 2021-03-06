FROM jakubzapletal/java:openjdk-7-jre

MAINTAINER Jakub Zapletal <zapletal.jakub@gmail.com>

# Install ElasticSearch.
RUN \
  cd /tmp && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.4.1.tar.gz && \
  tar xvzf elasticsearch-1.4.1.tar.gz && \
  rm -f elasticsearch-1.4.1.tar.gz && \
  mv /tmp/elasticsearch-1.4.1 /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD config/elasticsearch.yml /elasticsearch/config/elasticsearch.yml

RUN /elasticsearch/bin/plugin -install royrusso/elasticsearch-HQ

# Define working directory.
WORKDIR /data

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200 9300

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch", "-Des.config=/elasticsearch/config/elasticsearch.yml"]
