;;;; package.lisp

(defpackage #:plotly-cl-server
  (:use #:cl))

(defpackage #:plotly-cl
  (:use #:cl)
  (:export #:make-trace
           #:join-traces
           #:make-layout
           #:pl-plot
           #:line
           #:scatter))
