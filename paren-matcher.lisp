(in-package :paren-matcher)

(defun correct-string (char-list pair-count p2)
  (cond
    ((= pair-count 0) (coerce (reverse char-list) 'string))
    ((> pair-count 0) (coerce (reverse (append (list-repeat p2 pair-count) char-list)) 'string))
    (t (coerce (reverse (nthcdr (* pair-count -1) char-list)) 'string))))

(defun pair-count (p1 p2 comment-char escape-char quote-char)
  (let* ((count 0) characters
	 (s (states
	      (default (ch)
	        (char-case ch
	          (comment-char (state comment))
	          (quote-char (state on-quote))
	          (escape-char (save-state escape))
		  (p1 (incf count))
		  (p2 (decf count))))
	      (comment (ch)
	        (if (char= ch #\newline)
		    (state default)))
	      (on-quote (ch)
	        (char-case ch
		  (escape-char (save-state escape))
		  (quote-char (state default))))
	      (escape (ch)
	        (declare (ignore ch))
	        (revert-state)))))
    (dlambda
     (:corrected-string ()
       (correct-string characters count p2))
     (t (ch)
       (funcall s ch)
       (push ch characters)))))

(defun pair-fixer (stream p1 p2 &key comment-char escape-char quote-char)
  (let ((reader (stream-select stream))
	(pc (pair-count p1 p2 comment-char escape-char quote-char)))
    (labels ((inner (ch)
	       (if ch
		   (progn
		     (funcall pc ch)
		     (inner (funcall reader)))
		   (funcall pc :corrected-string))))
      (inner (funcall reader)))))

(defun paren-fixer (stream &key (comment #\;) (escape #\\) (quote-char #\"))
  (pair-fixer stream #\( #\) :comment-char comment :escape-char escape :quote-char quote-char))

(defun main ()
  (princ (paren-fixer :stdin)))

;; Checking how well #'get-char worked
;;(defun main ()
;;  (do ((ch (get-char) (get-char)))
;;      ((null ch))
;;    (write-char ch)))
