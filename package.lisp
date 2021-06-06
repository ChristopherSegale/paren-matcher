(defpackage :paren-matcher
  (:use :cl)
  (:import-from :let-over-lambda :defmacro! :dlambda :plambda :with-pandoric)
  (:export :main))

(in-package :paren-matcher)

(declaim (inline list-repeat
		 paren-fixer))

(defvar *stdin-called* nil)
