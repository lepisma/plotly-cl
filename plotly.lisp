;;;; plotly.lisp

(in-package #:plotly)

(defconstant *cache-dir* #p"~/.cache/plotly.lisp/"
             "Directory for keeping temporary files")

(defun generate-plot (plot-code &optional (width 600) (height 400))
  (with-html-output-to-string (_)
    (:html
     (:head
      (:script :src "https://cdn.plot.ly/plotly-latest.min.js"))
     (:body
      (:div :id "plot" :style (str (format nil "width:~Apx;height:~Apx;" width height)))
      (:script (str plot-code))))))

(defun write-plot (plot-code)
  "Write output to the file"
  (ensure-directories-exist *cache-dir*)
  (let ((output-file (serapeum:path-join *cache-dir* "index.html")))
    (with-open-file (fp output-file
                        :direction :output
                        :if-exists :supersede
                        :if-does-not-exist :create)
        (write-string (generate-plot plot-code) fp))))

(defun start-server ()
  "Start web server and open index.html in browser")

(defun plot (x y)
  "Plot simple vectors"
  (let ((plot-code (ps:ps
                     (let ((div ((@ document get-element-by-id) "plot")))
                       (*plotly.plot div (list (ps:create x (ps:lisp x)
                                                          y (ps:lisp y))))))))
    (write-plot plot-code)))
