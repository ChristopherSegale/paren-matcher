(defpackage :paren-matcher
  (:use :cl)
  (:import-from :let-over-lambda :defmacro! :dlambda :aif)
  (:export :main))

(in-package :paren-matcher)

(declaim (inline stream-select
		 list-to-string
		 list-repeat
		 paren-fixer))
