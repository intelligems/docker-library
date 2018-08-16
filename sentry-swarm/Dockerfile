FROM sentry:9.0-onbuild

COPY config.yml /etc/sentry/
COPY sentry.conf.py /etc/sentry/

COPY entrypoint.sh /custom_entrypoint.sh
RUN chmod a+x /custom_entrypoint.sh

ENTRYPOINT ["/custom_entrypoint.sh"]
CMD ["sentry", "run", "web"]
