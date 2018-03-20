;;;; User end wrappers around main plotly function

(in-package #:plotly-cl)

(defun pl-line (x y &key layout)
  "Single line plot"
  (let ((trace `((:x . ,x) (:y . ,y))))
    (pl-plot (list trace) :layout layout)))

(defun pl-scatter (x y &key layout)
  "Single scatter plot"
  (let ((trace `((:x . ,x) (:y . ,y) (:mode . "markers") (:type . "scatter"))))
    (pl-plot (list trace) :layout layout)))

(defun pl-fn (fn &key (low 0) (high 1) (points 1000) layout)
  "Plot the function in the given range"
  (let* ((x (loop for i from 1 to points
                  collect (+ low (* i (/ (- high low) points)))))
         (y (mapcar fn x)))
    (pl-line x y :layout layout)))
