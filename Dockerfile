FROM alpine
RUN apk add ssh-cert-authority --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing; apk add openssh-client
WORKDIR /ssh-ca
COPY ["entrypoint.sh","daemon_config.json","signer_config.json","/ssh-ca/"]
RUN chmod +x entrypoint.sh
ENV ADDRESS=0.0.0.0
ENV PORT=8080
ENV KEY_BITS=4096
ENV KEY_PATH=/keys/key.pem
ENTRYPOINT ["./entrypoint.sh"]
CMD ["--config-file", "daemon_config.json.edited"]
