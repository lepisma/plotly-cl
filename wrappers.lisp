;;;; User end wrappers around main plotly function

(in-package #:plotly)

(defun scatter (x y)
  "Simple scatter plot"
  (let ((trace (make-trace `((:x . ,x) (:y . ,y) (:mode . "markers") (:type . "scatter")))))
    (-plot (join-traces (list trace)))))

(defun line (x y)
  "Simple line plot"
  (let ((trace (make-trace `((:x . ,x) (:y . ,y)))))
    (-plot (join-traces (list trace)))))
