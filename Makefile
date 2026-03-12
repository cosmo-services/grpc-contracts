.PHONY: proto-gen proto-clean install-deps

PROTO_DIR = api
GEN_DIR = gen

install-deps:
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
	go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
	@echo "protoc plugins installed"

proto-gen:
	@echo "Generating Go code from .proto files..."
	@mkdir -p $(GEN_DIR)
	@mkdir -p $(GEN_DIR)/$(PROTO_DIR)
	protoc -I=$(PROTO_DIR) \
		--go_out=$(GEN_DIR)/$(PROTO_DIR) --go_opt=paths=source_relative \
		--go-grpc_out=$(GEN_DIR)/$(PROTO_DIR) --go-grpc_opt=paths=source_relative \
		$(shell find $(PROTO_DIR) -name "*.proto")
	@echo "Done!"

proto-clean:
	@echo "Cleaning generated files..."
	rm -rf $(GEN_DIR)
	@echo "Done!"