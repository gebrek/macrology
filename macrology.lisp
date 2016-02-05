;;;; macrology.lisp

(in-package #:macrology)

(defun our-remove-if (fn list)
  (if (null list)
      nil
      (if (funcall fn (car list))
	  (cons (car list)
		(our-remove-if fn (cdr list))))))
