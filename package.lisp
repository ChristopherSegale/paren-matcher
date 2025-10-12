(defpackage :paren-matcher
  (:use :cl)
  (:import-from :let-over-lambda :defmacro! :dlambda)
  (:export :main))

(in-package :paren-matcher)

(declaim (inline list-to-string
		 list-repeat
		 paren-fixer))
