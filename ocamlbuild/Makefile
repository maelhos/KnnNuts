.PHONY: all

all: depend ocaml-knn

ocaml-knn: mnist.cmx prioQueue.cmx knn.cmx main.cmx
	ocamlopt -o $@ $^

clean:
	rm -f *.cmi *.cmo *.cmx *.o print_mnist ocaml-knn

%.cmx: %.ml
	ocamlopt -c -o $@ $<

%.cmi: %.mli
	ocamlopt -c -o $@ $<

depend:
	ocamldep *.ml *.mli > .depend
include .depend