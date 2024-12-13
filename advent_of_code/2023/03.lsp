(load "utils.lsp")

(defun parse-schematic (filename)
  (with-open-file (stream filename)
    (mapcar (lambda (line) (coerce line 'list)) ; coerce "obrigar ou levas facada"
            (loop for line = (read-line stream nil)
                  while line collect line))))


(defun is-symbol? (ch)
  (member ch '(#\* #\# #\$ #\+ #\- #\@ #\= #\% #\\ #\/ #\&) :test 'char=))

(defun adjacent-coordinates-has-symbol (x y max-x max-y)
  (let ((deltas '((-1 -1) (-1 0) (-1 1) (0 -1) (0 1) (1 -1) (1 0) (1 1)))
        (result nil)) 
    (dolist (coord deltas result) 
      (let* ((nx (+ x (first coord))) 
             (ny (+ y (second coord))))
        (format t "Coord: ~A~%" coord)
        (format t "Nx: ~A Ny: ~A~%" nx ny)
        
        (if (and (>= nx 0) (< nx max-x) (>= ny 0) (< ny max-y)
                 (is-symbol? (elt (elt *schematic* nx) ny))) 
            (setf result t))) 
        (format t "Result: ~A~%" result)
    result))
)

(defun sum-part-numbers ()
  (format t "====Schematic===~%~A~%" *schematic*)
  (let* ((max-x (length *schematic*))
         (max-y (length (first *schematic*))) ; take first list
         (total-sum 0)
         (found-adjacent nil) 
         (whole-number '()))
    (format t "Max-X: ~A~%" max-x)
    (format t "Max-Y: ~A~%" max-y)
    (dotimes (x max-x)
      (dotimes (y max-y)
        (let ((ch (elt (elt *schematic* x) y))) ; elt (element access)
             
          (format t "---Ch: ~A X:~A Y:~A----~%" ch x y)
          (if (and (digit-char-p ch))
              (progn
                (push ch whole-number)
                (format t "Whole-Number: ~A~%" whole-number)
                (when (adjacent-coordinates-has-symbol x y max-x max-y)
                      (format t "Found symbol in adjacent coordinates~%")
                      (setf found-adjacent T) 
                )
              )
              (progn
                (when found-adjacent
                      (setf reversed-list (reverse whole-number))
                      (setf str (coerce reversed-list 'string))
                      (setf result (parse-integer str))
                      (push result *adjacent-list*)
                      (setf total-sum (+ total-sum result))
                )
                (setf found-adjacent nil)
                (setf whole-number '())
              )
          )
        )))
    total-sum))

; Global variables
(defvar *schematic* (parse-schematic "03_input.txt"))
(defparameter *adjacent-list* '())

(let ((result (sum-part-numbers)))
  (format t "Adjacent List: ~A~%" *adjacent-list*)
  (format t "Total sum: ~A~%" result))

