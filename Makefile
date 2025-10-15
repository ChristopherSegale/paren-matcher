BIN=paren-matcher
LISP=sbcl
BUNDLE=bundle
LIBS=:let-over-lambda
BNFLAGS=--no-sysinit --non-interactive \
        --eval "(ql:quickload '($(LIBS)))" \
        --eval "(ql:bundle-systems '($(LIBS)) :to \"$(BUNDLE)/\")" \
        --eval '(exit)'
BUILDFLAGS=--no-sysinit --no-userinit --non-interactive \
	   --load "$(BUNDLE)/bundle.lisp" \
	   --eval '(asdf:load-system :let-over-lambda)' \
	   --eval '(load "paren-matcher.asd")' \
	   --eval '(asdf:make :paren-matcher)'

all: $(BIN)

$(BIN): $(BUNDLE)
	$(LISP) $(BUILDFLAGS)

$(BUNDLE):
	$(LISP) $(BNFLAGS)

clean_all:
	rm -rf bin/$(BIN) $(BUNDLE)

clean:
	rm -f bin/$(BIN)
