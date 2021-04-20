;;; packages.el --- my-ocaml layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2017 Sylvain Benner & Contributors
;;
;; Author: Dave Aitken <dave@murdock.local>
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
  '(dune tuareg reason-mode)
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
(defun my-reload-dir-locals-for-current-buffer ()
  "reload dir locals for the current buffer"
  (let ((enable-local-variables :all))
    (hack-dir-local-variables-non-file-buffer)))
(defun my-ocaml/format-on-save ()
  (when my-ocaml/format-on-save
    (lsp-format-buffer)))
(defun my-ocaml/init-tuareg ()
  (progn
      (add-hook 'tuareg-mode-hook
                (lambda ()
                  (setq-local comment-style 'indent)
                  (setq-local font-lock-maximum-decoration 0)
                  (lsp)
                  (add-hook 'before-save-hook 'my-ocaml/format-on-save nil t)))
      (spacemacs/set-leader-keys-for-major-mode 'tuareg-mode
        "gg" 'xref-find-definitions)))
(defun my-ocaml/init-reason-mode ()
  (progn
    (add-hook 'reason-mode-hook
              (lambda ()
                (lsp)
                (add-hook 'before-save-hook 'my-ocaml/format-on-save nil t)))
    (spacemacs/set-leader-keys-for-major-mode 'reason-mode
      "gg" 'xref-find-definitions)))


(defun my-ocaml/init-dune ()
  (use-package dune
    :defer t
    :init
    (progn
      (spacemacs/set-leader-keys-for-major-mode 'tuareg-mode
        "tP" 'dune-promote
        "tp" 'dune-runtest-and-promote)
      (spacemacs/declare-prefix-for-mode 'tuareg-mode "mt" "test")
      (spacemacs/declare-prefix-for-mode 'dune-mode "mc" "compile/check")
      (spacemacs/declare-prefix-for-mode 'dune-mode "mi" "insert-form")
      (spacemacs/declare-prefix-for-mode 'dune-mode "mt" "test")
      (spacemacs/set-leader-keys-for-major-mode 'dune-mode
        "cc" 'compile
        "ia" 'dune-insert-alias-form
        "ic" 'dune-insert-copyfiles-form
        "id" 'dune-insert-ignored-subdirs-form
        "ie" 'dune-insert-executable-form
        "ii" 'dune-insert-install-form
        "il" 'dune-insert-library-form
        "im" 'dune-insert-menhir-form
        "ip" 'dune-insert-ocamllex-form
        "ir" 'dune-insert-rule-form
        "it" 'dune-insert-tests-form
        "iv" 'dune-insert-env-form
        "ix" 'dune-insert-executables-form
        "iy" 'dune-insert-ocamlyacc-form
        "tP" 'dune-promote
        "tp" 'dune-runtest-and-promote)
      (add-to-list 'auto-mode-alist
                   '("\\(?:\\`\\|/\\)dune\\(?:\\.inc\\)?\\'" . dune-mode)))))

;;; packages.el ends here
