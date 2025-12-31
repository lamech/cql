# This is a bmake (http://www.crufty.net/help/sjg/bmake.htm) makefile
# that uses dash (https://www.in-ulm.de/~mascheck/various/ash/) 
# for compatibility with a-shell.

BUILD_NO=1
SHELL:=dash
CQL_WASM:=cql.wasm
WASM:=wasmtime --dir=.
TESTOUTPUT:=testoutput
EXAMPLES!=cd exalpha && find . -name "*.cql"

$(CQL_WASM):
	@make -C src/ cql # Assume GNU make, since that's what the cql distribution uses.
	@mv src/cql.wasm $(CQL_WASM)

clean-test:
	@rm -rf $(TESTOUTPUT)

clean: clean-test
	@rm -f $(CQL_WASM)
	@make -C src/ clean-cql # Assume GNU make, since that's what the cql distribution uses.

# Dynamically create test targets based on files in the exalpha directory,
# e.g. `bmake turton` will run the turton.cql file against the sample.pgn database.
.for e in ${EXAMPLES:O}

${e:R:T}: $(TESTOUTPUT)
	$(WASM) $(CQL_WASM) -i sample.pgn -o $(TESTOUTPUT)/$(@)-out.pgn exalpha/$(@).cql

.endfor

test: $(TESTOUTPUT)
.for e in ${EXAMPLES:O}
	$(WASM) $(CQL_WASM) -i sample.pgn -o $(TESTOUTPUT)/${e:R:T}-out.pgn exalpha/${e:R:T}.cql
.endfor

$(TESTOUTPUT):
	mkdir -p $(@)

release:
	tar cfz cql-wasm-$(BUILD_NO).tgz cql.wasm LICENSE
