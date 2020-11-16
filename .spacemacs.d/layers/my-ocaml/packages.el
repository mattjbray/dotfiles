;;; packages.el --- my-ocaml layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Matt Bray <mattjbray@Matts-iMac.local>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

;;; Commentary:

;; See the Spacemacs documentation and FAQs for instructions on how to implement
;; a new layer:
;;
;;   SPC h SPC layers RET
;;
;;
;; Briefly, each package to be installed or configured by this layer should be
;; added to `my-ocaml-packages'. Then, for each package PACKAGE:
;;
;; - If PACKAGE is not referenced by any other Spacemacs layer, define a
;;   function `my-ocaml/init-PACKAGE' to load and initialize the package.

;; - Otherwise, PACKAGE is already referenced by another Spacemacs layer, so
;;   define the functions `my-ocaml/pre-init-PACKAGE' and/or
;;   `my-ocaml/post-init-PACKAGE' to customize the package as it is loaded.

;;; Code:

(defconst my-ocaml-packages
  '(tuareg)
  "The list of Lisp packages required by the my-ocaml layer.

Each entry is either:

1. A symbol, which is interpreted as a package to be installed, or

2. A list of the form (PACKAGE KEYS...), where PACKAGE is the
    name of the package to be installed or loaded, and KEYS are
    any number of keyword-value-pairs.

    The following keys are accepted:

    - :excluded (t or nil): Prevent the package from being loaded
      if value is non-nil

    - :location: Specify a custom installation location.
      The following values are legal:

      - The symbol `elpa' (default) means PACKAGE will be
        installed using the Emacs package manager.

      - The symbol `local' directs Spacemacs to load the file at
        `./local/PACKAGE/PACKAGE.el'

      - A list beginning with the symbol `recipe' is a melpa
        recipe.  See: https://github.com/milkypostman/melpa#recipe-format")

(defun my-ocaml/post-init-tuareg ()
  (progn
    (when (and (file-exists-p "/usr/local/bin/ocamlformat")
               (file-directory-p "~/.opam/default/share/emacs/site-lisp"))

      (add-to-list 'load-path "~/.opam/default/share/emacs/site-lisp")
      (require 'ocamlformat)


      ;;stop syntax error popup
      (setq ocamlformat-show-errors nil)

      (add-hook 'tuareg-mode-hook
                (lambda ()
                  (when ocaml-auto-ocamlformat
                    (add-hook 'before-save-hook 'ocamlformat-before-save nil t)))))

    (spacemacs|add-toggle ocamlformat
      :documentation "Toggle automatic ocamlformat on save."
      :status ocaml-auto-ocamlformat
      :on (progn
            (setq ocaml-auto-ocamlformat t)
            (add-hook 'before-save-hook 'ocamlformat-before-save nil t))
      :off (progn
             (setq ocaml-auto-ocamlformat nil)
             (remove-hook 'before-save-hook 'ocamlformat-before-save t)))

    (spacemacs/set-leader-keys-for-major-mode 'tuareg-mode
      "b=" 'ocamlformat
      "t=" 'spacemacs/toggle-ocamlformat)

    ;; Noop to stop tuareg-abbrev-hook error popping up when hitting escape
    (defun tuareg-abbrev-hook () ())

    (add-hook 'tuareg-mode-hook
              (lambda ()
                (setq-local comment-style 'indent)))

    (defun utop-jbuilder ()
      (interactive)
      (minibuffer-with-setup-hook
          (lambda ()
            (kill-whole-line)
            (insert "jbuilder utop . -- -emacs"))

        (call-interactively #'utop)))

    (with-eval-after-load 'merlin
      (defun merlin-jump-to-type-definition ()
        (interactive)
        (setq merlin-enclosing-types nil)
        (merlin--type-enclosing-query)
        (let ((type (car (elt merlin-enclosing-types 0))))
          (merlin-locate-ident type))))

    (spacemacs/set-leader-keys-for-major-mode 'tuareg-mode
      "scj" 'utop-jbuilder
      "st" 'tuareg-run-ocaml
      "eb" 'tuareg-eval-buffer
      "ep" 'tuareg-eval-phrase
      "er" 'tuareg-eval-region
      "gt" 'merlin-jump-to-type-definition
      )))

;;; packages.el ends here
