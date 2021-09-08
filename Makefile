# Makefile for demjson
# This is a simple installation front-end for Unix-like machines.
# See the INSTALL.txt file for specific instructions.

PYTHON=python
PYDOC=pdoc

MODULE=demjson3
VERSION=3.0.4

SOURCES = $(MODULE).py
SETUP = setup.py
READMES = README.txt LICENSE.txt docs/CHANGES.txt docs/INSTALL.txt docs/NEWS.txt
TESTS = test/test_$(MODULE).py
DOCS = docs/$(MODULE).txt docs/jsonlint.txt
DOCS_HTML = docs/$(MODULE).html
SCRIPTS = jsonlint
DISTDIR = dist

DIST_FILE = $(DISTDIR)/$(MODULE)-$(VERSION).tar.gz
ALL_FILES = $(SOURCES) $(SETUP) $(READMES) $(TESTS) $(DOCS) $(SCRIPTS)

all: build test install

ALWAYS:

show:
	@for f in $(ALL_FILES) ; do \
	   echo $$f ; \
	done | sort -u

#MANIFEST.in: $(ALL_FILES) Makefile
#	rm -f $@
#	for f in $(ALL_FILES) ; do \
#	   echo include $$f ; \
#	done | sort -u > $@

dist:   $(DIST_FILE) $(DOCS)
	@ls -l -- $(DIST_FILE)

clean:
	rm *.pyc
	rm -r build

build: $(SOURCES) $(SETUP)
	$(PYTHON) $(SETUP) build

install: $(SOURCES) $(SETUP)
	$(PYTHON) $(SETUP) install

register: $(DISTDIR)/$(MODULE)-$(VERSION).tar.gz $(SETUP)
	$(PYTHON) $(SETUP) register

test: ALWAYS $(SOURCES) $(TESTS)
	(cd test && PYTHONPATH=.. $(PYTHON) test_$(MODULE).py)
	echo done

$(DIST_FILE): MANIFEST.in $(ALL_FILES)
	$(PYTHON) setup.py sdist -d $(DISTDIR)

docs: $(DOCS) ALWAYS
docs_html: $(DOCS_HTML) ALWAYS

docs/jsonlint.txt: jsonlint $(MODULE).py
	PYTHONPATH=. ./jsonlint --help >$@
	echo "" >>$@
	PYTHONPATH=. ./jsonlint --strict --help-behaviors >>$@

docs/$(MODULE).txt:     $(MODULE).py
	python -m pydoc $(MODULE) | sed -e 's|/home/[a-zA-Z0-9_/.-]*/git/demjson/||' >docs/$(MODULE).txt

docs/$(MODULE).html:    $(MODULE).py
	$(PYDOC) --html $(MODULE) -o docs
	mv docs/$(MODULE).html docs/index.html
