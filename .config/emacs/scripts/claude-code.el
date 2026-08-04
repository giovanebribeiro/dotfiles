;; Pré-requisitos
;; - Emacs 30.0 or higher
;; - Claude Code CLI installed and configured
;; - Required: transient (0.7.5+) inheritenv (0.2)
(use-package claude-code
  :ensure (claude-code :host github :repo "stevemolitor/claude-code.el")
  :bind ("C-c c" . claude-code-transient)
  :config
  ;; Optional: Start the Emacs server if not already running
  (unless (server-running-p) (server-start)))

(setq claude-code-terminal-backend 'vterm)
(setq claude-code-optimize-window-resize t)
(setq claude-code-no-delete-other-windows t)
(setq claude-code-toggle-auto-select t)

(with-eval-after-load 'claude-code
  (add-to-list 'display-buffer-alist
               '((lambda (buffer-or-name _)
                   (string-prefix-p "*claude:" (buffer-name (get-buffer buffer-or-name))))
                 (display-buffer-reuse-window display-buffer-in-side-window)
                 (side . right)
                 (slot . 1) ;; Optional: keeps it separate from vterm if both are open
                 (window-width . 0.4))))

(provide 'claude-code)
