(add-to-list 'load-path "~/.config/emacs/scripts")

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'load-path "~/.config/emacs/elpa")
;;(require 'elpaca-setup) ;; Elpaca package manager
(package-initialize)

(setq backup-directory-alist '((".*" . "~/.config/emacs/backups/")))

;;Esconder itens da interface
(menu-bar-mode -1)
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; Iniciar em fullscreen
(add-hook 'window-setup-hook 'toggle-frame-fullscreen t)

;;Inibir tela inicial
(setq inhibit-startup-screen t)

;; Habilita tab mode
(tab-bar-mode 1)

;;Font
(set-face-attribute 'default nil :font "JetBrainsMono Nerd Font" :height 80)

;;Quebra de linha automática em texto
(global-visual-line-mode 1)

;;Fechar parenteses automaticamente
(electric-pair-mode t)

;;Mostrar número de linhas
(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode -1)

;;Tema
(unless (package-installed-p 'gruvbox-theme)
    (package-refresh-contents)
    (package-install 'gruvbox-theme))
(load-theme 'gruvbox-dark-medium t)

;;(require 'claude-code)

(require 'org-configs)

(defun my/open-keybinding-file ()
"Open the keybindings file in a buffer and bind 'q' to kill it."
(interactive)
(let ((buf (find-file-noselect "~/.config/emacs/kb-list.org")))
  (with-current-buffer buf
    ;; Bind 'q' locally to kill this specific buffer
    (local-set-key (kbd "q") 'kill-current-buffer))
  (switch-to-buffer buf)))

(global-set-key (kbd "C-S-l") 'my/open-keybinding-file)

;; Load the config file
(global-set-key (kbd "C-c l") (lambda () (interactive) (load-file "~/.config/emacs/init.el")))
(global-set-key (kbd "C-c a") 'org-agenda)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :config
  (setq doom-modeline-height 35      ;; sets modeline height
        doom-modeline-bar-width 5    ;; sets right bar width
        doom-modeline-persp-name t   ;; adds perspective name to modeline
        doom-modeline-persp-icon t)) ;; adds folder icon next to persp name

;; ;; Disabling company mode in eshell, because it's annoying.
;; (setq company-global-modes '(not eshell-mode))

;; ;; Adding a keybinding for 'pcomplete-list' on F9 key.
;; (add-hook 'eshell-mode-hook
;;           (lambda ()
;;             (define-key eshell-mode-map (kbd "<f9>") #'pcomplete-list)))

;; ;; A function for easily creating multiple buffers of 'eshell'.
;; ;; NOTE: `C-u M-x eshell` would also create new 'eshell' buffers.
;; (defun eshell-new (name)
;;   "Create new eshell buffer named NAME."
;;   (interactive "sName: ")
;;   (setq name (concat "$" name))
;;   (eshell)
;;   (rename-buffer name))

;; (use-package eshell-toggle
;;   :custom
;;   (eshell-toggle-size-fraction 3)
;;   (eshell-toggle-use-projectile-root t)
;;   (eshell-toggle-run-command nil)
;;   (eshell-toggle-init-function #'eshell-toggle-init-ansi-term))

;;   (use-package eshell-syntax-highlighting
;;     :after esh-mode
;;     :config
;;     (eshell-syntax-highlighting-global-mode +1))

;;   ;; eshell-syntax-highlighting -- adds fish/zsh-like syntax highlighting.
;;   ;; eshell-rc-script -- your profile for eshell; like a bashrc for eshell.
;;   ;; eshell-aliases-file -- sets an aliases file for the eshell.

;;   (setq eshell-rc-script (concat user-emacs-directory "eshell/profile")
;;         eshell-aliases-file (concat user-emacs-directory "eshell/aliases")
;;         eshell-history-size 5000
;;         eshell-buffer-maximum-lines 5000
;;         eshell-hist-ignoredups t
;;         eshell-scroll-to-bottom-on-input t
;;         eshell-destroy-buffer-when-process-dies t
;;         eshell-visual-commands '("bash" "fish" "htop" "ssh" "top" "zsh")
;;	)



(use-package vterm-toggle
  :ensure t
  :after vterm
  :config
  (setq vterm-toggle-fullscreen-p nil)
  (setq vterm-toggle-scope 'project))

(with-eval-after-load 'vterm
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                   (let ((buffer (get-buffer buffer-or-name)))
                     (with-current-buffer buffer
                       (or (equal major-mode 'vterm-mode)
                           (string-prefix-p vterm-buffer-name (buffer-name buffer))))))
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (side . right)
                 (reusable-frames . visible)
                 (window-width . 0.4))))

;;(use-package tldr)
