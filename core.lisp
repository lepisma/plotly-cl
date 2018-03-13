;;;; plotly.lisp

(in-package #:plotly-cl)

(defvar *cache-dir* #p"~/.cache/plotly.lisp/"
        "Directory for keeping temporary files")

(defun generate-plot (plot-code &optional (width 800) (height 600))
  (let ((dim (format nil "width:~Apx;height:~Apx;" width height)))
    (who:with-html-output-to-string (_)
      (:html
       (:head
        (:script :src "https://cdn.plot.ly/plotly-latest.min.js"))
       (:body
        (:div :id "plot" :style dim)
        (:script (who:str plot-code)))))))

(defun write-plot (plot-code)
  "Write output to the file"
  (ensure-directories-exist *cache-dir*)
  (let ((output-file (serapeum:path-join *cache-dir* "index.html")))
    (with-open-file (fp output-file
                        :direction :output
                        :if-exists :supersede
                        :if-does-not-exist :create)
      (write-string (generate-plot plot-code) fp))))

(defun pl-plot (traces &key layout)
  "Plot the data (list of traces)"
  (let* ((json-traces (format nil "[~{~a~^,~}]" (mapcar #'json:encode-json-alist-to-string traces)))
         (json-layout (json:encode-json-alist-to-string layout))
         (plot-code (ps:ps
                      (let ((div ((ps:@ document get-element-by-id) "plot")))
                        (*plotly.plot div ((ps:@ *json* parse) (ps:lisp json-traces))
                                      ((ps:@ *json* parse) (ps:lisp json-layout)))))))
    (write-plot plot-code)
    (plotly-cl-server::start)))
