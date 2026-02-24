FROM alpine:3.20

RUN adduser -D -h /home/worker worker \
    && mkdir -p /app /data/shared \
    && chown -R worker:worker /app /data/shared

COPY writer.sh /app/writer.sh
RUN chmod +x /app/writer.sh

USER worker
ENTRYPOINT ["/app/writer.sh"]
