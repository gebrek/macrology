(ql:quickload :cffi)
(defpackage :cffi-user
  (:use :common-lisp :cffi))
(in-package :cffi-user)
(define-foreign-library libcurl
  (:unix (:or "libcurl.so.3" "libcurl.so" "libcurl.so.4"))
  (t (:default libcurl)))
(use-foreign-library libcurl)

(defctype curl-code :int)

;;; CURL code is the universal error code. 
(defcfun "curl_global_init" curl-code
  (flags :long))

(defcfun "curl_easy_init" :pointer)

(defcfun "curl_easy_cleanup" :void)

(defmacro define-curl-options (name type-offsets &rest enum-args)
  "As with `CFFI:DEFCENUM', except each of `ENUM-ARGS' is as follows:
     (NAME TYPE NUMBER) 
Where the arguments are as they are with the
`CINIT' macro defined in curl.h, except NAME is a keyword.

`TYPE-OFFSETS' is a plist of TYPEs to their integer offsets, as
  defined by the CURLOPTTYPE_LONG et al contrains in curl.h"
  (flet ((enumerated-value (type offset)
	   (+ (getf type-offsets type)
	      offset)))
    `(progn
       (defcenum ,name
	 ,@ (loop for (name type number) in enum-args
		 collect (list name (enumerated-value type number))))
       ',name)))

(define-curl-options curl-option
    (long 0 objectpoint 10000 functionpoint 20000 off-t 30000)
  (:noprogress long 43)
  (:nosignal long 99)
  (:errorbuffer objectpoint 10)
  (:url objectpoint 2))

(defctype easy-handle :pointer)
(defmacro curl-easy-setopt (easy-handle enumerated-name
			    value-type new-value)
  `(foreign-funcall "curl_easy_setopt" easy-handle ,easy-handle
		    curl-option ,enumerated-name
		    ,value-type ,new-value curl-code))
