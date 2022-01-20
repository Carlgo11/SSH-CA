FROM alpine
WORKDIR /ssh-ca
RUN apk add ssh-cert-authority --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing; apk add openssh-client; \
adduser -H -D -u 1000 ssh; chown ssh:ssh /ssh-ca -R; mkdir -p /keys/; chown ssh:ssh /keys;chmod 700 /keys -R
USER ssh
COPY --chown=ssh:ssh ["entrypoint.sh","daemon_config.json","signer_config.json","/ssh-ca/"]
RUN chmod +x entrypoint.sh
ENV ADDRESS=0.0.0.0
ENV PORT=8080
ENV KEY_BITS=4096
ENV KEY_PATH=/keys/key.pem
ENTRYPOINT ["./entrypoint.sh"]
CMD ["--config-file", "daemon_config.json.edited"]
