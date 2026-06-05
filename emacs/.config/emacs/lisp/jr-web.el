(defun vue-eglot-init-options2 (_server)
  (let ((tsdk-path
         (expand-file-name
          "lib"
          (string-trim-right
           (shell-command-to-string
            "npm list --global --parseable typescript | head -n1")))))
    `(:typescript (:tsdk ,tsdk-path)
      :vue (:hybridMode :json-false))))

(define-derived-mode pbgc-vue-mode web-mode "pbVue"
  "A major mode derived from web-mode, for editing .vue files with LSP support.")

(add-to-list 'auto-mode-alist '("\\.vue\\'" . pbgc-vue-mode))


(defun pbgc-vue-custom ()
  (corfu-mode)
  (eglot-ensure))

(put 'pbgc-vue-mode 'eglot-language-id "vue")

(add-hook 'pbgc-vue-mode-hook 'pbgc-vue-custom)

(with-eval-after-load 'eglot
  (add-to-list 'eglot-server-programs
               '(pbgc-vue-mode
                 . ("vue-language-server"
                    "--stdio"
                    :initializationOptions
                    vue-eglot-init-options2))))

;; (with-eval-after-load 'eglot
;;   (add-to-list 'eglot-server-programs
;;                '(pbgc-vue-mode
;;                  . ("rass"
;;                     "vuetailwind"
;; 		    ))))


(provide 'jr-web)
;;; jr-web.el ends here
