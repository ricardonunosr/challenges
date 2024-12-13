(load "utils.lsp")

(let ((result 0)
      (available-red 12)
      (available-green 13)
      (available-blue 14)
      (in (open "./02_input.txt" :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil) 
          while line 
          do
          (progn
            (format t "RAW LINE: ~S~%" line)
            
            (let* ((colon (position #\: line))
                   (game-id (parse-integer line :start 5 :end colon))
                   (game-part (subseq line (+ colon 2))))
              
              (format t "Colon Position: ~A~%" colon)
              (format t "Game ID: ~A~%" game-id)
              (format t "Game Part: ~S~%" game-part)
              
              (let ((sets (split-sequence #\; game-part))
                    (max-red 0)
                    (max-green 0)
                    (max-blue 0)
                    (valid-game t))
                (format t "Sets: ~A~%" sets)
                
                (dolist (set sets)
                  (dolist (part (split-sequence #\, set))
                    (format t "Part: ~A~%" part)
                    (let* ((trimmed-part (string-trim '(#\Space) part)) 
                           (space (position #\Space trimmed-part))
                           (color (subseq trimmed-part (+ space 1) (length trimmed-part)))
                           (count (parse-integer trimmed-part :end space)))
                      (format t "Color: ~A, Count: ~A~%" color count)
                      (cond
                        ((string= color "red") (setf max-red (max max-red count)))
                        ((string= color "green") (setf max-green (max max-green count)))
                        ((string= color "blue") (setf max-blue (max max-blue count)))
                        (t (setf valid-game nil))))))
                  
                          (format t "Max Blue: ~A~%" max-blue) 
                          (format t "Max Green: ~A~%" max-green) 
                          (format t "Max Red: ~A~%" max-red) 
                (when (and valid-game
                           (<= max-red available-red)
                           (<= max-green available-green)
                           (<= max-blue available-blue))
                  (setf result (+ result game-id))))
          )))
    (close in)
  )
  (format t "Total sum: ~A~%" result))
