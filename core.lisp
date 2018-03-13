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

(defun make-trace (trace-alist)
  "Create str for a single trace"
  (json:encode-json-alist-to-string trace-alist))

(defun join-traces (&rest traces)
  "Join traces in a single list"
  (format nil "[~{~a~^,~}]" traces))

(defun make-layout (layout-alist)
  "Make layout str"
  (json:encode-json-alist-to-string layout-alist))

(defun pl-plot (data &optional layout)
  "Plot the data (list of traces)"
  (let ((plot-code (ps:ps
                     (let ((div ((ps:@ document get-element-by-id) "plot")))
                       (*plotly.plot div ((ps:@ *json* parse) (ps:lisp data))
                                     ((ps:@ *json* parse) (ps:lisp layout)))))))
    (write-plot plot-code)
    (plotly-cl-server::start)))
