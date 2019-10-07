(defvar imandra-cli-file-path "imandra-repl-dev") ;; script running `docker run -it --rm ..` or symlink to imandra-service
;; (defvar imandra-syntax "reason")

(defvar imandra-prompt-regexp "^#\s-")

(defvar imandra-buffer-name "*Imandra*")

(defun imandra-repl-eval-string (string &optional mode)
  (interactive)
  (with-current-buffer imandra-buffer-name
    ;; Insert it at the end of the utop buffer
    (goto-char (point-max))
    (insert string)
    (insert imandra-phrase-terminator)
    ;; Send input to utop now, telling it to automatically add the
    ;; phrase terminator
    (comint-send-input)))

(defun imandra-repl-eval (start end &optional mode)
  "Eval the given region in utop."
  ;; Select the text of the region
  (imandra-repl-eval-string (buffer-substring-no-properties start end) mode))

(defun imandra-repl-eval-region (start end)
  "Eval the current region in utop."
  (interactive "r")
  (imandra-repl-eval start end :multi))

(defun imandra-repl--ml ()
  (interactive)
  (let* ((imandra-repl-program imandra-cli-file-path))

    (apply 'make-comint-in-buffer "Imandra" imandra-buffer-name
           imandra-repl-program nil "-raw"
           '("-require" "imandra-prelude"))

    (with-current-buffer imandra-buffer-name
      (imandra-repl-mode)
      (setq-local imandra-phrase-terminator ";;"))

    (pop-to-buffer-same-window imandra-buffer-name)))

(defun imandra-repl--re ()
  (interactive)
  (let* ((imandra-repl-program imandra-cli-file-path))

    (apply 'make-comint-in-buffer "Imandra" imandra-buffer-name
           imandra-repl-program nil "-raw"
           '("-reason" "-require" "imandra-prelude"))

    (with-current-buffer imandra-buffer-name
      (imandra-repl-mode)
      (setq-local imandra-phrase-terminator ";"))

    (pop-to-buffer-same-window imandra-buffer-name)))

(define-derived-mode imandra-repl-mode comint-mode "Imandra Repl"
  "Major mode for `imandra-repl`" nil "Imandra Repl"
  ;; (require 'tuareg)
  ;; (tuareg-install-font-lock)
  (setq comint-prompt-regexp imandra-prompt-regexp)
  (set (make-local-variable 'comint-input-sender-no-newline) t)
  (set (make-local-variable 'comint-input-sender) 'comint-simple-send)
  (set (make-local-variable 'comint-get-old-input) 'comint-get-old-input-default)
  (set (make-local-variable 'comint-process-echoes) t)
  (set (make-local-variable 'comint-prompt-read-only) t)
  ;; (set (make-local-variable 'font-lock-defaults) '(tuareg-font-lock-keywords t))
  (set (make-local-variable 'comint-eol-on-send) t))

(define-key imandra-repl-mode-map (kbd "C-c C-l") #'comint-clear-buffer)

(add-to-list 'auto-mode-alist '("\\.iml\\'" . tuareg-mode))
(add-to-list 'auto-mode-alist '("\\.ire\\'" . reason-mode))

(add-hook 'tuareg-mode-hook
          (lambda ()
            (when (string-match "\\.iml\\'" buffer-file-name)
              ;;(setq-local merlin-buffer-flags "-open Imandra_prelude -package imandra-prelude -addsuffix .iml:.imli -addsuffix .ire:.irei -assocsuffix .iml:imandra -assocsuffix .ire:imandra-reason")
              (setq-local merlin-command "imandra-merlin")
              )))

(add-hook 'reason-mode-hook
          (lambda ()
            ;; Currently doesnt quite work - something else seems to be interfering with merlin-buffer-flags (refmt?)
            (when (string-match "\\.ire\\'" buffer-file-name)
              (setq-local merlin-buffer-flags "-reader imandra-reason -package imandra-prelude -open Imandra_prelude"))))
