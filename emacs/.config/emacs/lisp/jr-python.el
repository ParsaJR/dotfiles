(provide 'jr-python)


;; (with-eval-after-load 'eglot
;;   (add-to-list 'eglot-server-programs
;;                '((python-mode) "basedpyright-langserver" "--stdio"))
;;   (add-to-list 'eglot-server-programs
;;                '((python-ts-mode) "basedpyright-langserver" "--stdio")))

(use-package uv-mode
  :ensure t
  :hook (python-ts-mode . uv-mode-auto-activate-hook))

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(python-mode . ("rass" "basedruff") )))


(add-hook 'python-mode-hook
          (lambda ()
            (eglot-ensure)
            (add-hook 'after-save-hook 'eglot-format nil t)))
