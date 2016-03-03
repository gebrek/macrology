(defparameter *cube*
  (let ((cube (make-array '(3 3 3)))
	(two-powers 1/2))
    (loop for i from 0 upto 2 do
	 (loop for j from 0 upto 2 do
	      (loop for k from 0 upto 2 do
		   (setf (aref cube i j k)
			 (setf two-powers (* two-powers 2))))))
    cube))
