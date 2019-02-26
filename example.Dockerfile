FROM ubuntu:latest
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN set -x \ 
        && apt-get update \ 
        && apt-get install -y gosu sudo \ 
        && rm -rf /var/lib/apt/lists/* \ 
        && gosu nobody true \ 
        && chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
