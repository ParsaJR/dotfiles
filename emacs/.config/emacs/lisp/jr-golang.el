; sets golang-specific configuration...

(provide 'jr-golang)


(use-package go-mode
  :ensure t)

(require 'go-mode)

(defun jr-find-definition ()
  (interactive)
  (call-interactively 'xref-find-definitions)
  (recenter-top-bottom))


(defun jr-eglot-organize-imports ()
  (ignore-errors
  (call-interactively 'eglot-code-action-organize-imports)))


(defun jr-eglot-format-buffer ()
  (ignore-errors
  (call-interactively #'eglot-format-buffer)))

(defun jr-go-mode-hook ()
  (add-hook 'before-save-hook #'jr-eglot-format-buffer -10 t)
  (add-hook 'before-save-hook #'jr-eglot-organize-imports nil t)

  (setq compilation-scroll-output 'first-error)

  (evil-define-key '(normal visual) 'global (kbd "g d") 'jr-find-definition)
  (evil-define-key '(normal visual) 'global (kbd "K") 'eglot-hover-eldoc-function)

  (setq-local tab-width 4))

(add-hook 'go-mode-hook #'jr-go-mode-hook)
(add-hook 'go-mode-hook #'eglot-ensure)
(add-hook 'go-mode-hook 'auto-fill-mode)
