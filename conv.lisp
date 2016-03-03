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
  (let ((sq (make-array '(2 2)))
	(counter 0))
    (loop for i from 0 upto 1 do
	 (loop for j from 0 upto 1 do
	      (setf (aref sq i j)
		    (incf counter))))
    sq))

(defmacro array-loop (array (&rest binds) ))
