# Default is x86_64
.PHONY: default
default: c-knn

c_source_files := $(shell find src -name *.c)
c_object_files := $(patsubst src/%.c, build/%.o, $(c_source_files))

C_INCLUDE_PATH := include

OUT_NAME := c-knn

OPTN := -g # -Ofast -march=znver3
$(c_object_files): build/%.o : src/%.c
	@mkdir -p $(dir $@) && \
	gcc $(OPTN) -c -Wall -I $(C_INCLUDE_PATH) $(patsubst build/%.o, src/%.c, $@) -o $@ -lm

.PHONY: c-knn
c-knn: $(c_object_files)
	@echo "[C Files] :"
	@echo $(c_source_files)
	@echo "[C OBJ Files] :"
	@echo $(c_object_files)
	@gcc $(OPTN) -Wall -o $(OUT_NAME) $(c_object_files) -lm

CLEAN:
	@rm -rfv build/
	@mkdir build
	@echo "CLEAN"