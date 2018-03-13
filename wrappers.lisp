;;;; User end wrappers around main plotly function

(in-package #:plotly-cl)

(defun scatter (x y)
  "Simple scatter plot"
  (let ((trace (make-trace `((:x . ,x) (:y . ,y) (:mode . "markers") (:type . "scatter")))))
    (pl-plot (join-traces trace))))

(defun line (x y)
  "Simple line plot"
  (let ((trace (make-trace `((:x . ,x) (:y . ,y)))))
    (pl-plot (join-traces trace))))
