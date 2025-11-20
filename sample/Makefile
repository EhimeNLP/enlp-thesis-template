SRC_DIR = ../src
DST_DIR = .
TEX = sample.tex

LATEXMK = latexmk

.PHONY: build cp compile reset clean

build: cp compile

cp:
	for f in $(SRC_DIR)/*; do \
		cp $$f $(DST_DIR)/; \
	done

compile:
	$(LATEXMK) $(TEX)

reset:
	for f in $(SRC_DIR)/*; do \
		rm -f $(DST_DIR)/`basename $$f`; \
	done

clean:
	$(LATEXMK) -c
