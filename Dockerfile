FROM alpine:3.15
RUN apk update
RUN apk add openjdk17-jre
RUN apk add python3
RUN apk add bash
RUN apk add curl
RUN mkdir /app
WORKDIR /app
COPY ./* ./
CMD bash init.bash