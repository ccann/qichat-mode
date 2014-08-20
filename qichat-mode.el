(defvar qichat-mode-hook nil)
(defvar qichat-test-path "/home/ccanning/dev/qichat-mode")

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.top\\'" . qichat-mode))

(defconst qichat-font-lock-keywords-1
  (list
;; '("\"\\([^\"]+\\)\"" . font-lock-string-face)    
   '("^include:"  . font-lock-preprocessor-face)    
   '("^language:" . font-lock-preprocessor-face)    
   '("^topic:"    . font-lock-preprocessor-face)    
   '("^concept:"  . font-lock-builtin-face)         
   '("^dynamic:"  . font-lock-builtin-face)         
   '("^proposal:" . font-lock-builtin-face)
   '("^recover:"  . font-lock-preprocessor-face)
   '("\""         . font-lock-string-face)          
   ))

(defconst qichat-font-lock-keywords-2
  (append qichat-font-lock-keywords-1
          (eval-when-compile
            `( ;; definitions
              ("\\((e:\\)\\([[:alnum:]/_]+\\)" 2 font-lock-variable-name-face)
              ("\\(^e:\\)\\((\\)\\([[:alnum:]/_]+\\)" 3 font-lock-variable-name-face)
       ;;     ("\\(^concept:(\\)\\([[:alnum:]]+\\)" 2 font-lock-builtin-face)
       ;;     ("\\(\\^[[:alnum:]]+\\)\\((\\)\\([[:alnum:]]+\\)" 3 font-lock-function-name-face)
              ("\\(\\^[[:alnum:]]+\\)\\((\\)\\([[:alnum:]]+\\)" 1 font-lock-function-name-face)
              ("s?u[[:digit:]]?:" 0 font-lock-keyword-face)         ;; u:
              ("e:" 0 font-lock-keyword-face)         ;; e:
              ))))

(defconst qichat-font-lock-keywords-3
  (append qichat-font-lock-keywords-2
          (list
           '("~[[:alnum:]_\\/\\-]+\(\)" . font-lock-warning-face)           ;; ~Prompt.top
           '("~[[:alnum:]_\\/\\-]+"      . font-lock-string-face)           ;; ~concept
           '("$[[:alnum:]_\\/\\-]+"      . font-lock-variable-name-face)    ;; $variableName
       ;;  '("[#]+[[:space:][:alnum:]]+$" . font-lock-comment-face)   ;; ## comment
           '("\\^[[:alnum:]]+"    . font-lock-function-name-face)     ;; ^goto
           '("%[[:alnum:]_\\/\\-]+"      . font-lock-type-face)
           '("\\\\[[:alnum:]=]+\\\\" . font-lock-comment-face)        ;; \PAU=350\
       ;;  '("(\\|)"                  . font-lock-comment-face)
   )))

 
(defvar qichat-font-lock-keywords qichat-font-lock-keywords-3
  "Default highlighting expressions for QiChat mode")


(defvar qichat-mode-syntax-table
  (let ((st (make-syntax-table)))
    (modify-syntax-entry ?# "<" st)
    (modify-syntax-entry ?\n ">" st)
    (modify-syntax-entry ?\" "$" st)
    (modify-syntax-entry ?$ "." st)
    (modify-syntax-entry ?% "." st)
    st))

(defun qichat-insert-proposal ()
  (interactive)
  (insert "proposal: "))

(defun qichat-insert-user-rule-with-event ()
  (interactive)
  (insert "u:(e:)")
  (backward-char 1))

(defun qichat-insert-user-rule ()
  (interactive)
  (insert "u:()")
  (backward-char 1))

(defun qichat-insert-pause (n)
  (interactive "sPause duration: ")
  (insert (concat "\\\PAU=" n "\\"))
  )


(defvar qichat-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "C-c p") 'qichat-insert-proposal)
    (define-key map (kbd "C-c e") 'qichat-insert-user-rule-with-event)
    (define-key map (kbd "C-c u") 'qichat-insert-user-rule)
    (define-key map (kbd "C-c SPC") 'qichat-insert-pause)
    (define-key map (kbd "C-c t") 'qichat-test-buffer)
    
    map

    )
  "Key map for the Emacs QiChat Major Mode.")

(defun qichat-indent-line ()
  (interactive)
  (let ((col (+ (current-indentation) 4)))
    (save-excursion ;; saves the cursor position! Awesome!
      (indent-line-to col)))
  )

(defun qichat-test-buffer ()
  (interactive)
  ;;(message (buffer-file-name))
  (shell-command (concat "python " (concat qichat-test-path "/test_qichat.py") " " (buffer-file-name)))
  
  )



(define-derived-mode qichat-mode fundamental-mode "QiChat"
  "Major mode for editing qichat topic files"
  :syntax-table qichat-mode-syntax-table
  (setq-local comment-start "#")
  (setq-local font-lock-defaults '(qichat-font-lock-keywords))
  (setq-local indent-line-function 'qichat-indent-line)
  )


(provide 'qichat-mode)


