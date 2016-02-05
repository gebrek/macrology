;;;; macros.lisp
;;;; in reference to on-lisp 85

(defmacro nil! (var)
  `(setq ,var nil))
;;; the above and below are equivalent. backquote is a convenience
;;; function to describe a commonly used pattern.
;; (defmacro nil! (var)
;;   (list 'setq var nil))

;;; numeric-if: a three way function that returns if function was
;;; ZERO, POSITIVE, or NEGATIVE
;;; consider the following two implementations

;;; with backquote
(defmacro nif (expr pos zero neg)
  `(case (truncate (signum ,expr))
     (1 ,pos)
     (0 ,zero)
     (-1 ,neg)))

(defmacro nif (expr pos zero neg)
  (list 'case
	(list 'truncate (list 'signum expr))
	(list 1 pos)
	(list 0 zero)
	(list -1 neg)))

;;; , is a simple syntactic substitution
;;; try saying that five times fast
;;; pronounced: "comma"
(let ((b '(1 2 3)))
  `(a ,b c))
;; (A (1 2 3) C)

;;; ,@ splices a list in place
(let ((b '(1 2 3)))
  `(a ,@b c))
;;; (A 1 2 3 C)
;;; we could go over a non-reader macro example of what code it
;;; generates but that's not too important

;; (member x choices :test #'eq)

(defmacro memq (obj lst)
  `(member ,obj ,lst :test #'eq))

(defmacro while (test &body body)
  `(do ()
       ((not ,test))
     ,@body))
