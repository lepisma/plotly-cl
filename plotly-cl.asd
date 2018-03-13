;;;; plotly.lisp.asd

(asdf:defsystem #:plotly-cl
  :description "Lisp to plotly.js"
  :author "Abhinav Tushar <lepisma@fastmail.com>"
  :license "GPLv3"
  :depends-on (#:parenscript
               #:cl-who
               #:serapeum
               #:cl-json)
  :serial t
  :components ((:file "packages")
               (:file "server")
               (:file "core")
               (:file "wrappers")))
