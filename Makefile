.PHONY: help install book runall clean serve build publish

help:
	@echo "Please use 'make <target>' where <target> is one of:"
	@echo "  install     to install the necessary dependencies for jupyter-book to build"
	@echo "  book        to convert the `content/` folder into Jekyll markdown in `_build/`"
	@echo "  runall      to run all notebooks in-place, capturing outputs with the notebook"
	@echo "  clean       to clean out site build files"
	@echo "  serve       to serve the repository locally with Jekyll"
	@echo "  build       to build the site HTML locally with Jekyll and store in _site/"
	@echo "  publish     to build, commit to master, and push to GitHub"

install:
	gem install bundler
	bundle install

book:
	jupyter-book build ./

runall:
	jupyter-book run ./content

clean:
	python scripts/clean.py

serve:
	bundle exec guard

build:
	bundle exec jekyll build
	touch _site/.nojekyll

publish:
	git checkout -b master
	jupyter-book toc . && jupyter-book build .
	git add .
	git commit -m 'Result of `jupyter-book toc . && jupyter-book build .`'
	git push --force --set-upstream origin master
	git checkout develop
	git branch -d master
