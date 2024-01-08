TARGET = ok
REPO = assemblyline/ok
.PHONY: build clean release

all: $(TARGET)

$(TARGET): export GOOS=linux
$(TARGET): export GOARCH=amd64
$(TARGET): export CGO_ENABLED=0
$(TARGET): $(TARGET).go
	go build $(TARGET).go

build:
	docker build --target=prod -t $(REPO) .

release: build
	docker push $(REPO)

clean:
	$(RM) $(TARGET)
