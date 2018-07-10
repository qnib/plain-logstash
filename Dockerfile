FROM qnib/alplain-openjre8-glibc

ARG LOGSTASH_VER=6.3.1
ARG LOGSTASH_URL=https://artifacts.elastic.co/downloads/logstash
RUN mkdir -p /opt/logstash \
 && wget -qO - ${LOGSTASH_URL}/logstash-oss-${LOGSTASH_VER}.tar.gz |tar xfz - -C /opt/logstash --strip-components=1
RUN /opt/logstash/bin/logstash-plugin install \
       logstash-input-tcp \
       logstash-input-udp \
       logstash-input-syslog \
       logstash-filter-grok \
       logstash-filter-mutate \
       logstash-output-elasticsearch \
 && apk --no-cache add curl nmap
COPY opt/qnib/logstash/etc/logstash.conf /opt/qnib/logstash/etc/
COPY opt/qnib/entry/20-logstash.sh /opt/qnib/entry/
ENV ENTRYPOINTS_DIR=/opt/qnib/entry
RUN echo "tail -f /var/log/supervisor/logstash.log" >> /root/.bash_history
CMD ["/opt/logstash/bin/logstash", "-f", "/etc/logstash/conf.d/"]
