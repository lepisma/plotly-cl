;;;; package.lisp

(defpackage #:plotly-cl-server
  (:use #:cl))

(defpackage #:plotly-cl
  (:use #:cl)
  (:export #:pl-plot
           #:line
           #:scatter))
