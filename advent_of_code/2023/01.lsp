(setf result 0)

(let ((in (open "./01_input.txt" :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil) while line do
          (setf first-digit nil)
          (setf last-digit nil)

          (loop for char across line do
                (if (digit-char-p char)
                    (progn
                      (if (not first-digit)
                          (setf first-digit (string char)))
                      (setf last-digit (string char)))))

          (when (and first-digit last-digit)
            (let* ((concatenated (concatenate 'string first-digit last-digit))
                   (sum (parse-integer concatenated)))
              (setf result (+ result sum))
              (format t "Concatenated: ~A, Sum: ~A~%" concatenated sum))))
    (close in)))

(format t "Total sum: ~A~%" result)
