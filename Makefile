CC ?= cc
CFLAGS ?= -O2 -fPIC
PREFIX ?= /usr/local
VFILES := $(shell find compiler vlib -name '*.v')

all: force-download-vc v

force-download-vc:
	rm -f v.c.out

v.c.out:
	curl -o v.c -LsSf https://raw.githubusercontent.com/vlang/vc/master/v.c
	${CC} -std=gnu11 -w -o v.c.out v.c -lm
	rm v.c

v: v.c.out ${VFILES}
	./v.c.out -o v compiler
	@echo "V has been successfully built"

symlink: v
	ln -sf `pwd`/v ${PREFIX}/bin/v

clean:
	rm -f v.c v.c.out v
