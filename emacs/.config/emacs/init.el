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

(load "jr-parsa")

(load "jr-python")

(load "jr-web")

(load "jr-golang")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(help-window-select t)
 '(package-selected-packages
   '(catppuccin-theme company-box counsel dockerfile-mode drag-stuff eldoc-box
		      evil-collection exec-path-from-shell ido-vertical-mode
		      ivy-rich json-mode lorem-ipsum magit markdown-mode neotree
		      projectile pyvenv super-save systemd tab-jump-out tldr
		      treesit-auto yaml-mode yasnippet)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
