(defparameter *cube*
  (let ((cube (make-array '(3 3 3)))
	(counter 0))
    (loop for i from 0 upto 2 do
	 (loop for j from 0 upto 2 do
	      (loop for k from 0 upto 2 do
		   (setf (aref cube i j k)
			 (incf counter)))))
    cube))

(defparameter *square*
  (let* ((dim 3)
	 (sq (make-array (list dim dim)))
	 (counter 0))
    (loop for i from 0 upto (1- dim) do
	 (loop for j from 0 upto (1- dim) do
	      (setf (aref sq i j)
		    (incf counter))))
    sq))

(defun array-slicing (pattern array)
  "`pattern' provides a shape for a subarray"
  (if (/= (length pattern)
  	  (length (array-dimensions array)))
      (error "Pattern and array dimensions mismatch."))
  (let* ((dims (array-dimensions array))
	 (rank (length (array-dimensions array)))
	 (index (loop for i in pattern collect 0))
	 (limits (loop for i from 0 below rank collect
		      (1+ (- (nth i dims)
			     (nth i pattern)))))
	 (gensyms (loop for i in pattern collect (gensym)))) 
    (print (list :pattern pattern :array array :dims dims
		 :rank rank :index index :limits limits))
    (let ((bloc (print "something")))
      ())))

;; (defmacro arr-slice (arr-dims body)
;;   (let ((bloc body))
;;     (loop for i from 0 below (length arr-dims) do
;; 	 (setf bloc `(loop for ,(gensym) from 0 below ,(nth i arr-dims) do
;; 			  ,bloc)))
;;     bloc))

(defun array-loop (var-list array b)
  (let* ((rank (length (array-dimensions array)))
	 (gensyms (loop for i in (array-dimensions array) collect
		       (gensym)))
	 (bloc `(let ,(loop :for var :in var-list :for sym :in gensyms
			 :collect (list var sym)) 
		  ,b)))
    (if (/= (length var-list) rank)
	(error "Variable and array rank mismatch"))
    (loop :for i :from 0 :below rank :do
       (setf bloc `(loop :for ,(nth i gensyms) :from 0
		      :below ,(nth i (array-dimensions array))
		      :do ,bloc)))
    bloc))

;; (defun array-loop (array)
;;   (let ((rank (array-dimensions array))
;; 	(bloc nil)
;; 	(gensyms (loop :for i :in (array-dimensions array) :collect (gensym))))
;;     (loop :for i :from 0 :below rank :do
;;        (setf bloc `(loop :for ,(nth i gensyms) :from 0
;; 		      :below ,(nth i (array-dimensions array))
;; 		      :do ,bloc)))
;;     bloc))


(defmacro tst (array)
  `(list ,(array-dimensions array)))
