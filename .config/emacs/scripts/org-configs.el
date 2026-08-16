;; org.el
;; Configurações referentes a org-mode

;; Diretório dos arquivos .org
(setq org-directory "~/org")
;; Quando uma task é marcada como DONE, o cronômetro da tarefa é encerrado.
(setq org-clock-out-when-done nil)
;; Um timestamp é gravado toda vez que uma tarefa for movida de TODO para DONE
(setq org-log-done 'time)

(with-eval-after-load 'org
  ;; Navegação de tópicos
  (define-key org-mode-map (kbd "<M-left>")  #'org-do-promote)
  (define-key org-mode-map (kbd "<M-right>") #'org-do-demote)
  )

;; Templates de captura
(defun org-capture-bookmark-tags ()
  "Prompt for tags with completion against existing bookmark tags."
  (save-window-excursion
    (let ((tags-list '()))
      (with-current-buffer (find-file-noselect "~/org/bookmarks.org")
        (save-excursion
          (goto-char (point-min))
          (while (re-search-forward "^:TAGS:\\s-*\\(.+\\)$" nil t)
            (let ((tag-string (match-string 1)))
              (dolist (tag (split-string tag-string "[,;]" t "[[:space:]]"))
                (push (string-trim tag) tags-list))))))
      (setq tags-list (sort (delete-dups tags-list) 'string<))
      (let ((selected-tags (completing-read-multiple "Tags (comma-separated): " tags-list)))
        (mapconcat 'identity selected-tags ", ")))))

(defun org-capture-ref-link (file)
  "Create a link to a contact in FILE."
  (let* ((headlines (org-map-entries
                     (lambda ()
                       (cons (org-get-heading t t t t)
                             (org-id-get-create)))
                     t
                     (list file)))
         (contact (completing-read "Contact: " (mapcar #'car headlines)))
         (id (cdr (assoc contact headlines))))
    (format "[[id:%s][%s]]" id contact)))

(with-eval-after-load 'org
  (setq org-capture-templates
        '(("t" "Todo" entry
           (file+headline "~/org/inbox.org" "Inbox")
           "* TODO %^{Task}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")

          ("e" "Event" entry
           (file+headline "~/org/calendar.org" "Events")
           "* %^{Event}\n%^{SCHEDULED}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:CONTACT: %(org-capture-ref-link \"~/org/contacts.org\")\n:END:\n%?")

          ("d" "Deadline" entry
           (file+headline "~/org/calendar.org" "Deadlines")
           "* TODO %^{Task}\nDEADLINE: %^{Deadline}T\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?")

          ("b" "Bookmark" entry
           (file+headline "~/org/bookmarks.org" "Inbox")
           "** [[%^{URL}][%^{Title}]]\n:PROPERTIES:\n:CREATED: %U\n:TAGS: %(org-capture-bookmark-tags)\n:END:\n\n"
           :empty-lines 0)

          ("c" "New Contact" entry
           (file "~/org/contacts.org")
           "* %^{Name} %^g
:PROPERTIES:
:EMAIL: %^{Email}
:XMPP: %^{XMPP}
:LOCATION: %^{Location}
:COMPANY: %^{Company}
:PHONE: %^{Phone}
:BIRTHDAY: %^{Birthday <YYYY-MM-DD +1y>}
:LAST_CONTACTED: [%<%Y-%m-%d>]
:NOTES: %^{Notes}
:END:
- %U Initial contact
%?"
           :empty-lines 1)

          ("C" "Contact interaction" item
           (function (lambda ()
                       (let* ((buf (or (find-buffer-visiting "~/org/contacts.org")
                                       (find-file-noselect "~/org/contacts.org")))
                              (headings (with-current-buffer buf
                                          (org-map-entries
                                           (lambda () (cons (org-get-heading t t t t) (point))))))
                              (choice (completing-read "Contact: " (mapcar #'car headings)))
                              (pos (cdr (assoc choice headings))))
                         (switch-to-buffer buf)
                         (goto-char pos)
                         (setq jb/--crm-marker (point-marker))
                         (org-end-of-meta-data t))))
           "- [%<%Y-%m-%d %a>] %?"
           :prepend t
           :after-finalize (lambda ()
                             (when (marker-buffer jb/--crm-marker)
                               (with-current-buffer (marker-buffer jb/--crm-marker)
                                 (goto-char jb/--crm-marker)
                                 (org-set-property "LAST_CONTACTED"
                                                   (format-time-string "[%Y-%m-%d]"))
                                 (save-buffer)
                                 (set-marker jb/--crm-marker nil)))))

          ("n" "Note" entry
           (file+headline "~/org/notes.org" "Inbox")
           "* [%<%Y-%m-%d %a>] %^{Title}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?"
           :prepend t))))

(use-package org-modern
  :ensure t
  :hook (org-mode . org-modern-mode)
  :config
  (setq org-modern-star '("●" "○" "◆" "◇" "▸")
        org-modern-todo t
        org-modern-progress t
        org-modern-priority t
        org-modern-tag t
        org-modern-hide-stars t
        org-modern-block-fringe t
        org-modern-todo-faces
        '(("TODO" . (:background "#b8c4b8" :foreground "#1a1d21"))
          ("STRT" . (:background "#b4bcc4" :foreground "#1a1d21"))
          ("WAIT" . (:background "#d4ccb4" :foreground "#1a1d21"))
          ("HOLD" . (:background "#d4ccb4" :foreground "#1a1d21"))
          ("DONE" . (:background "#3d424a" :foreground "#8b919a"))
          ("KILL" . (:background "#3d424a" :foreground "#8b919a" :strike-through t)))))

;; Setando um keybind para facilitar o org-capture
(global-set-key (kbd "C-S-c") 'org-capture)

(setq display-buffer-alist
      `(("\\*Capture\\*\\|CAPTURE-.*"
         (display-buffer-reuse-window display-buffer-at-bottom)
         (window-height . 0.3))
        ("\\*Calendar\\*"
         (display-buffer-reuse-window display-buffer-at-bottom)
         (window-height . 0.3))
        ("\\*Org Agenda\\*"
         (display-buffer-reuse-window display-buffer-at-bottom)
         (window-height . 0.4))))
  
(setq org-todo-keyword-faces '(("NEXT" . (:foreground "yellow" :weight bold)) ))

;; Hide the deadline prewarning prior to scheduled date.
(setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)

(provide 'org-configs)
