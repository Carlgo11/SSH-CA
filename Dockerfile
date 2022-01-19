FROM alpine
RUN apk add ssh-cert-authority --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing; apk add openssh-client
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENV PORT=8080
ENTRYPOINT /entrypoint.sh
