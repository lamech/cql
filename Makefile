SHELL:=bash
CQL_WASM:=cql.wasm
WASM:=wasmtime
TESTOUTPUT:=testoutput
EXAMPLES:=$(wildcard exalpha/*.cql)
OUTPUT_PGNS:=$(patsubst exalpha/%.cql,$(TESTOUTPUT)/%-out.pgn,$(EXAMPLES))

$(CQL_WASM):
	@make -C src/ cql
	@mv src/cql.wasm $(CQL_WASM)

clean-test:
	@rm -rf $(TESTOUTPUT)

clean: clean-test
	@rm -rf $(CQL_WASM)
	@make -C src/ clean-cql

test: $(OUTPUT_PGNS) 

$(TESTOUTPUT):
	@mkdir -p $(@)

$(TESTOUTPUT)/%-out.pgn: $(TESTOUTPUT) $(CQL_WASM)
	$(WASM) --dir=. $(CQL_WASM) -i sample.pgn -o $(@) exalpha/$(*).cql 

example.%:
	@stat exalpha/$(*).cql # Don't bother executing submake if the cql file does not exist.
	@make -s $(TESTOUTPUT)/$(*)-out.pgn
