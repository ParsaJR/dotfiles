;; Set up package.el to work with MELPA. It has more packages than elpa.
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; I use use-package for installing packages easily in my config
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(add-to-list 'load-path "~/.config/emacs/lisp/")

; General emacs settings.
(load "jr-general")

(load "jr-parsa" t)

(load "jr-python")

(load "jr-web")

(load "jr-golang")


(setq custom-file (locate-user-emacs-file "custom-vars.el"))
(load custom-file 'noerror 'nomessage)
