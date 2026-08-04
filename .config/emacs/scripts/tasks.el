;; Setando os estados das tarefas
(setq org-todo-keywords
      '((sequence "TODO(t)" "NEXT(n)" "|" "CANCELLED(c)" "DONE(d)")))


;; Customized view for the daily workflow. (Command: ", a n")
  (setq org-agenda-custom-commands
        '(("n" "My Weekly Agenda"
           ((agenda "" nil)
            (todo "NEXT" nil)
            (todo "TODO" nil)
            (todo "DONE" nil))
           nil)))

(setq org-todo-keyword-faces '(("NEXT" . (:foreground "yellow" :weight bold))
                                ("CANCELLED" . (:foreground "red" :weight bold))))

;; Hide the deadline prewarning prior to scheduled date.
(setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)

(provide 'tasks)
