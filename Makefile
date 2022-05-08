cname = rndsrc.dev

all: build publish

build:
	jupyter-book build .

publish:
	ghp-import -npofc $(cname) _build/html
