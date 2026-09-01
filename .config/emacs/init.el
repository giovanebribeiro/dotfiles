;; -*- lexical-binding: t -*-
;; My main configuration file.
(require 'org)
(org-babel-load-file (expand-file-name "config.org" user-emacs-directory))

;; By default, there is not a file to put the configuration set by emacs' wizards.
;; Otherwise, my configs will mix with the emacs's and the final result is a mess.
(setq custom-file (expand-file-name "init-custom.el" user-emacs-directory))
(load custom-file 'noerror)

