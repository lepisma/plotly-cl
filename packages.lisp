;;;; package.lisp

(defpackage #:plotly-server
  (:use #:cl))

(defpackage #:plotly
  (:use #:cl)
  (:export #:make-trace
           #:join-traces
           #:make-layout
           #:pl-plot
           #:line
           #:scatter))
