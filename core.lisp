;;;; plotly.lisp

(in-package #:plotly-cl)

(defun generate-plot (plot-code width height)
  (let ((dim (format nil "width:~Apx;height:~Apx;" width height)))
    (who:with-html-output-to-string (_)
      (:html
       (:head
        (:script :src "https://cdn.plot.ly/plotly-latest.min.js"))
       (:body
        (:div :id "plot" :style dim)
        (:script (who:str plot-code)))))))

(defun open-plot (plot-code width height)
  "Write output to the file and open browser"
  (uiop/stream:with-temporary-file (:pathname pn :stream stream :direction :output :keep t :type "html")
    (write-string (generate-plot plot-code width height) stream)
    (sb-ext:run-program (or (uiop:getenv "BROWSER") "xdg-open") (list (namestring pn)) :wait nil :search t)))

(defun pl-plot (traces &key layout (width 800) (height 600))
  "Plot the data (list of traces)"
  (let* ((json-traces (format nil "[~{~a~^,~}]" (mapcar #'json:encode-json-alist-to-string traces)))
         (json-layout (json:encode-json-alist-to-string layout))
         (plot-code (ps:ps
                      (let ((div ((ps:@ document get-element-by-id) "plot")))
                        (*plotly.plot div ((ps:@ *json* parse) (ps:lisp json-traces))
                                      ((ps:@ *json* parse) (ps:lisp json-layout)))))))
    (open-plot plot-code width height)))
