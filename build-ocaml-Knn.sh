cd ocamlbuild && ocamldep *.ml *.mli > .depend && make ocaml-knn
cd .. && cp ocamlbuild/ocaml-knn ocaml-knn