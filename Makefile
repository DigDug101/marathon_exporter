VERSION  := $$(git describe --tags --always)
TARGET   := ads-marathon-exporter
TEST     ?= ./...

default: test build

test:
	go test -v -run=$(RUN) $(TEST)

build: clean
	go build -v -o bin/$(TARGET)

release: clean
	CGO_ENABLED=0 GOARCH=amd64 GOOS=linux go build \
		-a -tags netgo \
		-ldflags "-X main.Version=$(VERSION)" \
		-o bin/$(TARGET) .
	docker build -t quay.io/reddit/$(TARGET):$(VERSION) .

publish: release
	docker push quay.io/reddit/$(TARGET):$(VERSION)
	docker tag quay.io/reddit/$(TARGET):$(VERSION) quay.io/reddit/$(TARGET):latest
	docker push quay.io/reddit/$(TARGET):latest

clean:
	rm -rf bin/
