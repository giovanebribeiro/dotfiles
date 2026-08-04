(add-to-list 'load-path "~/.config/emacs/elpa")
(add-to-list 'load-path "~/.config/emacs/scripts")

(require 'elpaca-setup) ;; Elpaca package manager
(require 'package)
(package-initialize)

(setq backup-directory-alist '((".*" . "~/.config/emacs/backups/")))

(require 'claude-code)

(require 'appearance)

(require 'tasks)
