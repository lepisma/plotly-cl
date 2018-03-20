;;;; plotly.lisp.asd

(asdf:defsystem #:plotly-cl
  :description "Lisp to plotly.js"
  :author "Abhinav Tushar <lepisma@fastmail.com>"
  :license "GPLv3"
  :depends-on (#:parenscript
               #:cl-who
               #:cl-json
               #:cl-css
               #:cl-interpol
               #:uiop)
  :serial t
  :components ((:file "packages")
               (:file "core")
               (:file "wrappers")))
