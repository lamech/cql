# This is a bmake (http://www.crufty.net/help/sjg/bmake.htm) makefile
# that uses dash (https://www.in-ulm.de/~mascheck/various/ash/) 
# for compatibility with a-shell.

SHELL:=dash
CQL_WASM:=cql.wasm
WASM:=wasmtime --dir=.
TESTOUTPUT:=testoutput
EXAMPLES!=find . -name "*.cql"

$(CQL_WASM):
	@$(MAKE) -C src/ cql
	@mv src/cql.wasm $(CQL_WASM)

clean-test:
	@rm -rf $(TESTOUTPUT)

clean: clean-test
	@rm -f $(CQL_WASM)
	@$(MAKE) -C src/ clean-cql

.for e in ${EXAMPLES:O}

${e:R:T}: $(TESTOUTPUT)
	@echo $(WASM) $(CQL_WASM) -i sample.pgn -o $(TESTOUTPUT)/$(@)-out.pgn $e

.endfor

test: $(TESTOUTPUT)
.for e in ${EXAMPLES:O}
	@$(MAKE) ${e:R:T}
.endfor

$(TESTOUTPUT):
	mkdir -p $(@)
