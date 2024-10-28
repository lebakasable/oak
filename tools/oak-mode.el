;;; oak-mode.el --- Major Mode for editing Oak source code. -*- lexical-binding: t -*-

;;; Commentary:
;;
;; Major Mode for editing Oak source code.

(defconst oak-mode-syntax-table
  (with-syntax-table (copy-syntax-table)
    (modify-syntax-entry ?# ".")
    (modify-syntax-entry ?' "\"")
    (modify-syntax-entry ?+ ".")
    (modify-syntax-entry ?- ".")
    (modify-syntax-entry ?* ".")
    (modify-syntax-entry ?/ ".")
    (modify-syntax-entry ?% ".")
    (modify-syntax-entry ?< ".")
    (modify-syntax-entry ?> ".")
    (syntax-table))
  "Syntax table for `oak-mode'.")

(defun oak-syntax-propertize (start end)
  (goto-char start)
  (funcall
   (syntax-propertize-rules
    ("\\(##\\)[^#]*\\(#\\)" (1 "<") (2 ">"))
    ("\\(#\\)[^\n]*\\(\n\\)" (1 "<") (2 ">")))
   start end))

(defconst oak-highlights
  `((,(eval-when-compile
        (regexp-opt
         '("if" "else" "for" "match" "break" "return"
           "sizeof" "assert" "as" "use" "fn" "let"
           "const" "alias" "struct" "print")
         'symbols)) . font-lock-keyword-face)
    ("\\_<\\([0-9]+\\|[A-Z][A-Z0-9_]*\\|true\\|false\\)\\_>" . (1 font-lock-constant-face))
    ("\\_<\\([A-Z][A-Za-z0-9_]*\\|int\\|char\\|bool\\)\\_>" . (1 font-lock-type-face))
    ("\\([A-Za-z_][A-Za-z0-9_]*\\)\\s-*(" . (1 font-lock-function-name-face))))

;;;###autoload
(define-derived-mode oak-mode prog-mode "Oak"
  "Major Mode for editing Oak source code."
  :syntax-table oak-mode-syntax-table
  (setq-local syntax-propertize-function #'oak-syntax-propertize)
  (setq font-lock-defaults '(oak-highlights))
  (setq-local comment-start "# "))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.oak\\'" . oak-mode))

(provide 'oak-mode)
;;; oak-mode.el ends here
