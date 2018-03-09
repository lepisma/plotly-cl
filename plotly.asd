;;;; plotly.lisp.asd

(asdf:defsystem #:plotly
  :description "Lisp to plotly.js"
  :author "Abhinav Tushar <lepisma@fastmail.com>"
  :license "GPLv3"
  :depends-on (#:parenscript
               #:cl-who
               #:serapeum
               #:inferior-shell)
  :serial t
  :components ((:file "package")
               (:file "plotly.lisp")))
