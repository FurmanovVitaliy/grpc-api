# Переменные
PROTOC = protoc
PROTO_FILES = proto/sso/sso.proto
GO_OUT_DIR = ./gen/go/
GO_OPTIONS = --go_out=$(GO_OUT_DIR) --go_opt=paths=source_relative --go-grpc_out=$(GO_OUT_DIR) --go-grpc_opt=paths=source_relative

# Цель по умолчанию
all: generate

# Генерация Go-кода из протобуффов
generate:
	$(PROTOC) -I proto $(PROTO_FILES) $(GO_OPTIONS)

# Очистка сгенерированного кода
clean:
	rm -rf $(GO_OUT_DIR)*
