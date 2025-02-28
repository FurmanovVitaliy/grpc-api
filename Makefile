LOCAL_BIN := $(CURDIR)/bin
INSTALL_PROTOS_GEN_VALIDATE_VERSION := v1.2.1

PROTO_DIR := proto
GEN_DIR := gen/go

install-deps:
	if [ ! -d "$(LOCAL_BIN)" ]; then \
		mkdir -p $(LOCAL_BIN); \
	fi
	GOBIN=$(LOCAL_BIN) go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.1
	GOBIN=$(LOCAL_BIN) go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2
	GOBIN=$(LOCAL_BIN) go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@v2.15.2
	GOBIN=$(LOCAL_BIN) go install github.com/envoyproxy/protoc-gen-validate@$(INSTALL_PROTOS_GEN_VALIDATE_VERSION)

get-deps:
	if [ ! -d "$(LOCAL_BIN)" ]; then \
		mkdir -p $(LOCAL_BIN); \
	fi
	GOBIN=$(LOCAL_BIN) go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	GOBIN=$(LOCAL_BIN) go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	GOBIN=$(LOCAL_BIN) go install github.com/grpc-ecosystem/grpc-gateway/v2/protoc-gen-grpc-gateway@latest
	GOBIN=$(LOCAL_BIN) go install github.com/envoyproxy/protoc-gen-validate@$(INSTALL_PROTOS_GEN_VALIDATE_VERSION)

generate:
	@find $(PROTO_DIR) -type d | while read dir; do \
		if ls $$dir/*.proto >/dev/null 2>&1; then \
			OUT_DIR="$(GEN_DIR)/$$(basename $$dir)"; \
			mkdir -p $$OUT_DIR; \
			protoc --proto_path=$(PROTO_DIR) --proto_path=vendor.protogen \
				--go_out=$$OUT_DIR --go_opt=paths=source_relative \
				--plugin=protoc-gen-go=$(LOCAL_BIN)/protoc-gen-go \
				--go-grpc_out=$$OUT_DIR --go-grpc_opt=paths=source_relative \
				--plugin=protoc-gen-go-grpc=$(LOCAL_BIN)/protoc-gen-go-grpc \
				--grpc-gateway_out=$$OUT_DIR --grpc-gateway_opt=paths=source_relative \
				--plugin=protoc-gen-grpc-gateway=$(LOCAL_BIN)/protoc-gen-grpc-gateway \
				--validate_out=lang=go,paths=source_relative:$$OUT_DIR \
				--plugin=protoc-gen-validate=$(LOCAL_BIN)/protoc-gen-validate \
				$$dir/*.proto; \
		fi \
	done

vendor-proto:
	if [ ! -d vendor.protogen/google ]; then \
		git clone https://github.com/googleapis/googleapis vendor.protogen/googleapis &&\
		mkdir -p vendor.protogen/google &&\
		mv vendor.protogen/googleapis/google/api vendor.protogen/google &&\
		rm -rf vendor.protogen/googleapis; \
	fi
	if [ ! -f vendor.protogen/validate/validate.proto ]; then \
		mkdir -p vendor.protogen/validate &&\
		curl -L https://raw.githubusercontent.com/bufbuild/protoc-gen-validate/main/validate/validate.proto -o vendor.protogen/validate/validate.proto; \
	fi
