FROM sentry:9.0-onbuild

COPY config.yml /etc/sentry/

COPY entrypoint.sh /custom_entrypoint.sh
RUN chmod a+x /custom_entrypoint.sh

# ENTRYPOINT source /custom_entrypoint.sh
CMD [".", "/custom_entrypoint.sh", "sentry", "run", "web"]
