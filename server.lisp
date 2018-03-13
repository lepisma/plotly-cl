;;;; Server handling component for plotly

(in-package #:plotly-server)

(defconstant *cmd* "live-server"
  "Command for launching the server")

(defconstant *port* 8800
  "Port to fire server at")

(defvar *process* NIL
  "Server process")

(defun running? ()
  "Check whether the server is running"
  (if *process* (sb-ext:process-alive-p *process*)))

(defun start ()
  "Start server"
  (unless (running?)
    (setf *process*
          (sb-ext:run-program *cmd* (list (format NIL "--port=~A" *port*))
                              :search t
                              :directory plotly::*cache-dir*
                              :wait NIL))))

(defun stop ()
  "Stop server"
  (if *process* (sb-ext:process-kill *process* 15 :pid)))
