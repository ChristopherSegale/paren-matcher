(asdf:defsystem "paren-matcher"
  :author "Christopher Segale"
  :license "MIT"
  :depends-on (:let-over-lambda
	       :cffi)
  :components ((:file "package")
	       (:file "util")
	       (:file "paren-matcher"))
  :build-operation "program-op"
  :build-pathname "paren-matcher"
  :entry-point "paren-matcher:main")
