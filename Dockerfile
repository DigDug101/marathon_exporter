FROM golang:1.9
MAINTAINER Reddit "https://github.com/reddit"

ADD bin/ads-marathon-exporter /marathon_exporter
ENTRYPOINT ["/marathon_exporter"]
