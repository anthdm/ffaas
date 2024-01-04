.PHONY: proto

build:
	@go build -o bin/api cmd/api/main.go 
	@go build -o bin/wasmserver cmd/wasmserver/main.go 
	@go build -o bin/hailstorm cmd/cli/main.go 

wasmserver: build
	@./bin/wasmserver

api: build
	@./bin/api --seed

test:
	@go test ./pkg/* -v

proto:
	protoc --go_out=. --go_opt=paths=source_relative --proto_path=. proto/types.proto

clean:
	@rm -rf bin/api
	@rm -rf bin/wasmserver
	@rm -rf bin/hailstorm

goex:
	GOOS=wasip1 GOARCH=wasm go build -o examples/go/app.wasm examples/go/main.go 