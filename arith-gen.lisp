(defparameter *exp*
  '((lambda (x)
      ((lambda (y)
	 (+ x y)) 1)) 2))

(defparameter *eqv-exp*
  '(labels ((f1 (x1)
	     (f2 x1 1))
	    (f2 (x1 y1)
	     (+ x1 y1)))
    (f1 2)))

(defparameter *basic-exp*
  '((lambda (x)
      (* x 2))
    5))

(defparameter *lam*
  '(lambda (x)
    (+ x 1)))

(defun lisp->java (exp)
  (cond ((eql (car exp) 'lambda)
	 (format nil
		 "static int ~a(~{int ~a~^, ~}) {
~a
}"
		 (gensym)
		 (cadr exp)
		 (lisp->java (caddr exp))))
	((eql (car exp) '+)
	 (format nil
		 "~{~a ~^+ ~};"
		 (cdr exp)))))


;; CL-USER> (lisp->java *lam*)
;; "static int G864(int X) {
;; X + 1;
;; }"
;; CL-USER> (lisp->java '(lambda (x y) (+ x y)))
;; "static int G865(int X, int Y) {
;; X + Y;
;; }"
;; CL-USER> (lisp->java '(lambda (x) (+ x)))
;; "static int G866(int X) {
;; X;
;; }"
;; CL-USER> (lisp->java '(lambda (x y z) (+ x y z)))
;; "static int G867(int X, int Y, int Z) {
;; X + Y + Z 
;; }"
;; CL-USER> 
