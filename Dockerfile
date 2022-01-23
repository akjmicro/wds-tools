FROM alpine

COPY . /

RUN apk add sqlite

CMD sh -l
