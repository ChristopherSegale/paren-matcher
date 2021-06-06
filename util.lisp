(in-package :paren-matcher)

(cffi:defcfun ("getchar" gchar) :int)

(defun get-char ()
  (let ((ch (gchar)))
    (if (> ch 0)
	(code-char ch)
	nil)))

(defun stream-select (stream)
  (if (eq stream :stdin)
      #'get-char
      (lambda ()
	(read-char stream nil))))

(defmacro! states (&rest states)
  `(let (g!state g!pstate)
     (macrolet ((state (s)
		  `(setf ,',g!state #',s))
		(save-state (s)
		  `(progn
		     (setf ,',g!pstate ,',g!state)
		     (setf ,',g!state #',s)))
		(revert-state ()
		  `(progn
		     (setf ,',g!state ,',g!pstate)
		     (setf ,',g!pstate nil))))
       (labels ,states
	 (setf ,g!state #',(caar states))
	 (lambda (&rest args)
	   (apply ,g!state args))))))

(defmacro! char-case (o!char &rest clauses)
  `(cond
     ,@(mapcar (lambda (c)
		 (if (eq (car c) t)
		     `(t ,@(cdr c))
		     `((char= ,g!char ,(car c)) ,@(cdr c))))
	       clauses)))

(defun list-repeat (val n)
  (do ((l nil (cons val l))
       (c 0 (1+ c)))
      ((>= c n) l)))
