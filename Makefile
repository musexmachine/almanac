.PHONY: help bootstrap fmt lint test build validate doctor clean

help:
	@echo "Targets: bootstrap fmt lint test build validate doctor clean"

bootstrap:
	go mod tidy
	@echo "bootstrap complete"

fmt:
	gofmt -w ./cmd || true

lint:
	@echo "lint not wired yet"

test:
	go test ./...

build:
	go build -o bin/almanac ./cmd/almanac
	go build -o bin/almanacd ./cmd/almanacd

validate:
	@echo "validate path not wired yet; use PLAN.md and TASKS.md as execution source"

doctor:
	@echo "doctor path not wired yet"

clean:
	rm -rf bin
