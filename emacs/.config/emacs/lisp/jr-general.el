;; sets general emacs configuration. most configuration happens here.
;; if specific domains are started to grow, i will likely to seperate them.
(provide 'jr-general)

;; the default font is anything that is configured in the fontconfig.
(set-frame-font "Monospace-14" nil t)


; "C-/ to change the buffer input method to persian. So still i can use the
; emacs internal shortcuts like M-x and etc"
(setq default-input-method "farsi-isiri-9147")
(setq bidi-display-reordering 'mixed)
(setq bidi-paragraph-direction 'auto)

;; theme
(use-package catppuccin-theme
  :ensure t
  :config
  (load-theme 'catppuccin :no-confirm))

(defun doublesthat (number)
  "Double the number"
  (interactive "p")
  (message "The result is %d"(* number 2)))

(defun isGreaterthenfill(number)
  "Check if the number is greater than number or not"

  (if (> number fill-column)
      (message "It is bigger oh oh")
    (message "It's not bigger")
    )
  )


(isGreaterthenfill 9)

(global-set-key [C-tab] 'next-buffer)
(global-set-key [C-iso-lefttab] 'previous-buffer)
(global-set-key (kbd "C-c e b") 'eval-buffer)

(setq debug-on-error t)
(setq confirm-kill-emacs nil)

;; Select the help buffer after it opened.
(setq help-window-select t)

;; Move all the backup and auto-save files to somewhere else.
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t )))


(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)


;; auto pair
(electric-indent-mode t)
(electric-pair-mode t)

;; paren match font style
(set-face-foreground 'show-paren-match "red")


;; Of course, everything is UTF-8.
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Give some breathing room
(set-fringe-mode 10)        


;; Always ask for y/n, never yes/no.
(defalias 'yes-or-no-p 'y-or-n-p)


;; Don't ask to save files before compilation! just save them
(setq compilation-ask-about-save nil)

;; Don't ask to kill the current compilation! just kill it
(setq compilation-always-kill t)



;; Don’t ask to create parent directories when saving files, just
;; create them.
(add-hook 'before-save-hook
          (lambda ()
            (when buffer-file-name
              (let ((dir (file-name-directory buffer-file-name)))
                (when (not (file-exists-p dir))
                  (make-directory dir t))))))


;; use 80 characters for line wrapping
(setq-default fill-column 80)
(add-hook 'text-mode-hook 'auto-fill-mode)


;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Hide the top toolbar.
(menu-bar-mode -1)

;; remember the last cursor pointer.
(save-place-mode 1)

(setq use-dialog-box nil)

;; no cursor blinking.
(blink-cursor-mode nil)


;; Refresh file if it has changed.
(global-auto-revert-mode 1)
;; also for dired
(setq global-auto-revert-non-file-buffers t)

;; Open the *scratch* buffer by default, not the welcome message.
(setq inhibit-startup-screen t)

(setq compilation-always-kill t)


;; Use firefox for opening urls.
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "firefox")

;; display line numbers and column numbers in all modes.
(global-display-line-numbers-mode +1)
(setq display-line-numbers-type 'relative)
(setq column-number-mode t)

;; scroll margin
(setq scroll-margin 8)

(require 'recentf)

(recentf-mode t)

(setq erc-server "irc.libera.chat"
      erc-nick "parsajr"
      erc-user-full-name "Parsa Javan"
      erc-track-shorten-start 8
      erc-autojoin-channels-alist '(("irc.libera.chat","#systemcrafters", "#fedora"))
      erc-kill-buffer-on-part t
      erc-track-mode nil)



(use-package exec-path-from-shell
  :ensure t
  :config
  (exec-path-from-shell-initialize))


(use-package magit
  :ensure t)


(use-package org
    :ensure nil
    :config
    (add-to-list 'org-agenda-files '"~/org")

    (setq org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done))
    ;; TODO states
    (setq org-todo-keywords
	  '((sequence "TODO(t)" "PLANNING(p@)" "IN-PROGRESS(i)" "|" "DONE(d!)" "WONT-DO(w@/!)" )
	    ))

    (setq org-todo-keyword-faces
	  '(
	    ("TODO" . (:foreground "GoldenRod" :weight bold))
	    ("PLANNING" . (:foreground "DeepPink" :weight bold))
	    ("IN-PROGRESS" . (:foreground "Cyan" :weight bold))
	    ("DONE" . (:foreground "LimeGreen" :weight bold))
	    ("WONT-DO" . (:foreground "LimeGreen" :weight bold))
	    ))


     ;; When a TODO is set to a done state, record a timestamp
     (setq org-log-done 'time)

     ;; Follow the links
     (setq org-return-follows-link  t)

     (define-key global-map "\C-cl" 'org-store-link)
     (define-key global-map "\C-ca" 'org-agenda)
     (define-key global-map "\C-cc" 'org-capture)


     :hook (org-mode . org-indent-mode)
)



(use-package neotree
  :ensure t)

(use-package winner
  :ensure nil ; built-in
  :bind (("C-c <left>" . winner-undo)
	 ("C-c <right>" . winner-redo))
  ;; Initialize winner-mode immediately; it needs to record all window
  ;; configurations before the first invokation to be useful.
  :init
  (winner-mode t))

;; Save minibuffer history (for compile command etc.)
(use-package savehist
  :ensure nil
  :init
  (setq history-length 25)
  (savehist-mode 1))

(use-package super-save
  :ensure t
  :config
  (super-save-mode +1))

(defun display-startup-echo-area-message ()
  (message "Welcome 🛵"))

(setq evil-want-integration t) ; Optional, set to t by default
(setq evil-want-keybinding nil) ; Recommended for use with evil-collection
(setq evil-want-C-u-scroll t)



(use-package evil
  :ensure t
  :config
  (evil-set-leader nil (kbd "SPC"))
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state))


(use-package evil-collection
  :after evil
  :ensure t
  :config
  (evil-collection-init)
  (setq evil-collection-setup-minibuffer t)
  (setq evil-collection-want-find-usages-bindings nil))


(use-package ivy
  :ensure nil
  :bind (:map ivy-mode-map
              ("M-j" . ivy-next-line)
              ("M-k" . ivy-previous-line)
	      )
  :config (ivy-mode 1)
  (setq ivy-case-fold-search-default 'auto))

(use-package ivy-rich
  :ensure t
  :init
  (ivy-rich-mode 1))

;; C-w and C-y should use the PRIMARY selection (mouse-selected) *and*
;; the CLIPBOARD selection (copy function selected). When yanking,
;; both will be set. When inserting, the more recently changed one
;; will be used.
(setq x-select-enable-primary t)
(setq x-select-enable-clipboard t)


(use-package which-key
  :ensure t
  :config
  (which-key-mode 1)
  ;; show the window in the right side of the editor.
  (which-key-setup-side-window-right-bottom)
  )

;; Easy window switching with M-<direction>
(use-package windmove
  :ensure nil ; built-in
  :bind* (("<M-left>" . windmove-left)
	  ("<M-up>" . windmove-up)
	  ("<M-right>" . windmove-right)
	  ("<M-down>" . windmove-down)))

(use-package tramp
  :ensure nil
  :defer t
  :config
  ;; does not work in https://github.com/gokrazy/breakglass
  (setq tramp-histfile-override "/dev/null"))


(use-package drag-stuff
  :ensure t
  :config
  (define-key evil-visual-state-map (kbd "M-j") #'drag-stuff-down)
  (define-key evil-visual-state-map (kbd "M-k") #'drag-stuff-up))

;; Ido
(defun jr-lazy-ido-enable ()
  "since ido is loaded with Emacs, use-package cannot defer"
  (ido-mode 1)
  )

(use-package counsel
  :ensure t
  :bind (("M-x" . counsel-M-x))
  :config
  (setq ivy-initial-inputs-alist nil))


(use-package ido
  :ensure nil ; built-in
  :config
  (setq ido-enable-flex-matching t)
  (setq ido-create-new-buffer 'always)
  (setq-default confirm-nonexistent-file-or-buffer nil)
  (define-key evil-normal-state-map (kbd "<leader> f f") 'counsel-find-file)
  ;; counsel-projectile will fuzzy find on the nearest git repo that it found.
  (define-key evil-normal-state-map (kbd "<leader> SPC") 'counsel-projectile)
  (define-key evil-normal-state-map (kbd "<leader> g g") 'counsel-projectile-rg)
  (define-key evil-normal-state-map (kbd "<leader> b") 'counsel-ibuffer))

(use-package ido-vertical-mode
  :ensure t
  :config
  (ido-vertical-mode 1))


(use-package dockerfile-mode
  :ensure t)


(use-package projectile
  :ensure t
  :custom
  ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  (projectile-mode +1)
  (setq projectile-enable-caching t)
  (setq projectile-switch-project-action #'projectile-dired))


(use-package tramp
  :ensure nil
  :config
  (setq remote-file-name-inhibit-locks t
	tramp-use-scp-direct-remote-copying t
	remote-file-name-inhibit-auto-save-visited t)
  :defer t
  )

(use-package eglot
  :after xref
  :hook
  (go-mode . eglot-ensure)
  (c-mode . eglot-ensure)
  (python-ts-mode . eglot-ensure)
  (python-mode . eglot-ensure)
  (typescript-ts-mode . eglot-ensure)
  (js-ts-mode . eglot-ensure)
  :config
  (evil-define-key '(normal visual) 'global (kbd "M-.") 'xref-find-definitions)
  (evil-define-key '(normal visual) 'global (kbd "M-,") 'xref-go-back)
  (evil-define-key '(normal visual) 'global (kbd "g r r") 'xref-find-references)
  (evil-define-key '(normal visual) 'global (kbd "g r n") 'eglot-rename)
  (evil-define-key '(normal visual) 'global (kbd "g r i") 'eglot-find-implementation)
  (evil-define-key '(normal) 'global (kbd "<leader>ca") 'eglot-code-actions)

  )

(use-package pyvenv
  :ensure t)

(defun accumulate (lst op)
  (let (result)
    (while lst
      (push (funcall op (car lst)) result)
      (setq lst (cdr lst)))
    (nreverse result)))

(accumulate '(1 2 3 4) (lambda(x) (* x x)))


(defun acronym (phrase)
  (let (
	(words (split-string phrase "[ \f\t\n\r\v-]+"))
	(result ""))
    (while words
      (setq result (concat result (substring (car words) 0 1)))
      (setq words (cdr words))
      (upcase result)
    )
    (print result)
    )
  )

(acronym "Hello-World")

(use-package treesit-auto
  :ensure t
  :config
  (global-treesit-auto-mode))

(use-package dired
  :ensure nil
  :config
  (evil-collection-define-key 'normal 'dired-mode-map
    "h" 'dired-up-directory
    "l" 'dired-find-file))


(use-package tab-jump-out
  :ensure t
  :config
  (tab-jump-out-global-mode t))


(use-package magit
  :ensure nil)

(use-package yasnippet
  :ensure t
  :config
  (setq yas-snippet-dirs '("~/.config/emacs/snippets"))
  (yas-global-mode 1))

(use-package tldr
  :ensure t)

(use-package company
  :ensure t
  :custom
  (setq company-idle-delay
	(lambda () (if (company-in-string-or-comment) nil 0))) ; Do not show company when writing comments.
  (company-minimum-prefix-length 1)
  :config
  ; (setq completion-styles '(basic emacs22 ))

  (setq company-transformers '(company-sort-prefer-same-case-prefix))
  (evil-define-key '(insert) 'global (kbd "C-<SPC>") 'company-complete)
  :hook (after-init . global-company-mode))


(use-package company-box
  :ensure t
  :hook (company-mode . company-box-mode))



(use-package eldoc-box
  :ensure t)

(use-package eldoc
  :ensure t
  :config
  (global-eldoc-mode t)
  (eldoc-box-hover-mode t))

(defun my-test-select-window (window)
  (select-window window))

(setq display-buffer-alist
      '(("\\*eldoc\\*"
	 (display-buffer-reuse-window display-buffer-below-selected)
	 (body-function . my-test-select-window))))


(setq split-height-threshold 30)
(setq split-width-threshold 125)


;; Well...
(use-package lorem-ipsum
  :ensure t)

(use-package markdown-mode
  :ensure t
  :defer t)

(use-package json-mode
  :ensure t
  :defer t)

(use-package yaml-mode
  :ensure t
  :defer t
  :config
  (add-hook 'yaml-mode-hook
	    (lambda ()
	      (face-remap-add-relative 'font-lock-variable-name-face
				       (list :foreground (catppuccin-get-color 'blue)))))

  (add-to-list 'auto-mode-alist
	       '("\\.yaml\\'" . (lambda ()
				  (yaml-mode))))
  )


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; FUNCTIONS ;;
(defun remove-backslash-n-in-region (beg end)
  "Replace literal \"\\n\" with nothing in the region."
  (interactive "r")
  (save-excursion
    (goto-char beg)
    (while (search-forward "
" end t)
      (replace-match " " nil nil))))

(setq counsel-fzf-cmd "fd --type file | fzf -f \"%s\"")

(defun fzf ()
  "fuzzy find on the closest git repository"
  (interactive)
  (counsel-projectile))

(defun config ()
  "Invokes the counsel-fzf on ~/.config/emacs/"
  (interactive)
  (counsel-fzf nil "~/.config/emacs/lisp"))

(defun orgs ()
  "Invokes the counsel-fzf on ~/.config/emacs/"
  (interactive)
  (counsel-fzf nil "~/org"))


(defun jr-recompile ()
  "Interrupt current compilation and recompile"
  (interactive)
  (ignore-errors (kill-compilation))
  (recompile))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; KEYBINDINGS ;;

;; comment the selected line
(evil-define-key '(normal visual) 'global (kbd "g c") 'comment-line)

(defun hello()
  (interactive)
    (message "Welcome to hell."))

;; Go to the general configuration file.
(global-set-key [f7] (lambda() (interactive) (find-file "~/.config/emacs/lisp/jr-general.el")))


(bind-key* "C-4" 'jr-recompile)
