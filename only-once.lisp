;;;; from peter siebel's `practical-common-lisp'
;;; `only-once' cannot be used standalone, it must be in another macro

;;; it evaluates each form passed _only once_ and in the given order

;;; bind each result to the local variable inside `body'

;;; use the created binding instead of the parameter in the
;;; surrounding macro

(defmacro once-only ((&rest names) &body body)
  (let ((gensyms (loop repeat (length names) collect (gensym))))
    ;; `gensyms' is a list of #:Gxxx same length as `names'
    `(let (,@(loop for g in gensyms collect `(,g (gensym))))
       ;; in this let scope each #:G in `gensyms' is given another #:G value
       ;; eg. #:G904 => #:G112
       `(let (,,@(loop for g in gensyms
		       for n in names
		       collect ``(,,g ,,n)))
	  ;; i may be lost here
	  ,(let (,@(loop for n in names for g in gensyms
		      collect `(,n ,g)))
		,@body)))))

(defun primep (number)
  (when (> number 1)
    (loop for fac from 2 to (isqrt number)
       never (zerop (mod number fac)))))

(defun next-prime (number)
  (loop for n from number when (primep n)
       return n))

(defmacro do-primes ((var start end) &body body)
  (once-only (start end)
    `(do ((,var (next-prime ,start)
		(next-prime (1+ ,var))))
	 ((> ,var ,end))
       ,@body)))
