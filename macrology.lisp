;;;; macrology.lisp

(in-package #:macrology)

(defun our-remove-if (fn lst)
  (if (null lst)
      nil
      (if (funcall fn (car lst))
	  (our-remove-if fn (cdr lst))
	  (cons (car lst)
		(our-remove-if fn (cdr lst))))))



