FROM ubuntu:16.04
COPY --from=gosu/assets /opt/gosu /opt/gosu
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN set -x \
    && /opt/gosu/gosu.install.sh \
    && rm -fr /opt/gosu \
    && apt-get update \
    && apt-get install -y sudo curl ca-certificates \
    && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
