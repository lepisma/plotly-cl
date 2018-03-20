;;;; plotly.lisp

(in-package #:plotly-cl)

(cl-interpol:enable-interpol-syntax)

(defun generate-plot (plot-code width height)
  (let ((style (cl-css:css `((html :height 100%)
                             (body :height 100%
                                   :display flex
                                   :justify-content center
                                   :align-items center)
                             ("#plot" :width ,#?"${width}px"
                                      :height ,#?"${height}px")))))
    (who:with-html-output-to-string (_)
      (:html
       (:head
        (:script :src "https://cdn.plot.ly/plotly-latest.min.js")
        (:style (who:str style)))
       (:body
        (:div :id "plot")
        (:script (who:str plot-code)))))))

(defun open-plot (plot-code width height)
  "Write output to the file and open browser"
  (uiop/stream:with-temporary-file (:pathname pn :stream stream :direction :output :keep t :type "html")
    (write-string (generate-plot plot-code width height) stream)
    (sb-ext:run-program (or (uiop:getenv "BROWSER") "xdg-open") (list (namestring pn)) :wait nil :search t)))

(defun pl-plot (traces &key layout (width 1000) (height 700))
  "Plot the data (list of traces)"
  (let* ((json-traces (format nil "[~{~a~^,~}]" (mapcar #'json:encode-json-alist-to-string traces)))
         (json-layout (json:encode-json-alist-to-string layout))
         (plot-code (ps:ps
                      (let ((div ((ps:@ document get-element-by-id) "plot")))
                        (*plotly.plot div ((ps:@ *json* parse) (ps:lisp json-traces))
                                      ((ps:@ *json* parse) (ps:lisp json-layout)))))))
    (open-plot plot-code width height)))
