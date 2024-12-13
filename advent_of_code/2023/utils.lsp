(defun split-sequence (delimiter sequence)
  "Splits a string by a delimiter character into a list of substrings."
  (let ((result '())   ; List to store the result
        (current '())) ; List to accumulate the current part
    (dotimes (i (length sequence) result)
      (let ((char (aref sequence i)))  ; Get the character at position i
        (if (eql char delimiter)
            (progn
              (when current  ; Only push if there's accumulated content
                (push (coerce (nreverse current) 'string) result))
              (setq current '()))  ; Reset current part when delimiter is found
            (push char current))))  ; Accumulate current part

    ;; After the loop, if there's still something left in current, push it to result
    (when current
      (push (coerce (nreverse current) 'string) result))

    (nreverse result)))  ; Reverse the result list for correct order
