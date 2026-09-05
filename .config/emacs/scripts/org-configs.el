;; -*- lexical-binding: t; -*-
;; org-configs.el
;; Configurações referentes a org-mode

;; Diretório dos arquivos .org
(setq org-directory "~/org")
(setq org-agenda-files (list org-directory))
;; Quando uma task é marcada como DONE, o cronômetro da tarefa é encerrado.
(setq org-clock-out-when-done nil)
;; Um timestamp é gravado toda vez que uma tarefa for movida de TODO para DONE
(setq org-log-done 'time)
;; Prevent clock from stopping when marking subtasks as done
(setq org-clock-out-when-done nil)
;; org-attach global directory. add attachments in org files.
(setq org-attach-directory "~/org/attachments")

;; Org-auto-tangle
;(use-package org-auto-tangle
;  :defer t
;  :hook (org-mode . org-auto-tangle-mode)
;  :config
					;  (setq org-auto-tangle-default t))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/org")
  (org-roam-completion-everywhere t)
  :bind (("C-c n l" . org-roam-buffer-toggle)
	 ("C-c n f" . org-roam-node-find)
	 ("C-c n i" . org-roam-node-insert)
	 ("C-c n c" . org-roam-capture)
	 ("C-c n t" . org-roam-tag)
	 :map org-mode-map
	 ("C-M-i"   . completion-at-point))
  :config
  (org-roam-setup))

;; Templates de captura org-roam
(setq org-roam-capture-templates
  '(("f" "fleeting" plain "%?"
     :target (file+head "00-inbox/%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+filetags: :fleeting:\n")
     :unnarrowed t)

    ("l" "literature" plain "* Fonte\n%?\n\n* Ideias principais\n\n* Minhas reflexões\n"
     :target (file+head "03-resources/literature/%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+author: \n#+filetags: :literature:\n")
     :unnarrowed t)

    ("p" "permanent/zettel" plain "%?"
     :target (file+head "03-resources/permanent/%<%Y%m%d%H%M%S>-${slug}.org"
                         "#+title: ${title}\n#+filetags: :zettel:\n")
     :unnarrowed t)

    ("j" "projeto" plain "* Objetivo\n\n* Próximas ações\n%?"
     :target (file+head "01-projects/${slug}.org"
                         "#+title: ${title}\n#+filetags: :project:\n")
     :unnarrowed t)

    ("h" "hub/MOC" plain "Mapa de notas sobre ${title}.\n\n%?"
     :target (file+head "03-resources/permanent/%<%Y%m%d%H%M%S>-moc_${slug}.org"
                     "#+title: MOC - ${title}\n#+filetags: :hub:\n")
     :unnarrowed t)))

;; Templates de Captura (C-S-c)
(setq org-capture-templates
   '(
     ;; Esse é o caso mais comum. No fluxo, para adicionar o TODO "Testar copy..." Com org-capture-templates você aponta 
     ;; direto para o heading "Ações" de um arquivo já existente, sem criar node novo nenhum:
     ("t" "task (choose project)" entry
       (file+function "~/org/01-projects/dummy.org"
        (lambda () (find-file (read-file-name "Projeto: " "~/brain/01-projects/"))
          (goto-char (point-max))))
        "** TODO %?\nSCHEDULED: %^t\n")

     ;; Notas diárias não deveriam virar 365 nodes separados no grafo do roam (isso infla o banco e polui buscas). 
     ;; O padrão certo é um único arquivo com árvore de datas:
     ("j" "journal diário" entry
      (file+olp+datetree "~/org/journal.org")
      "* %U %?\n"
      :tree-type week)

     ;; Capturar algo direto de outro contexto (navegador, terminal, e-mail)
     ;; org-capture-templates tem integração nativa com org-protocol, que permite 
     ;; capturar de fora do Emacs (extensão de navegador, por exemplo) direto para um heading específico.
     ;; Isso é útil quando você está lendo algo no navegador e quer jogar um trecho pro inbox sem trocar 
     ;; de janela mentalmente — de novo, é inbox bruto, não é (ainda) uma nota do Zettelkasten.
     ("w" "web quote" entry
      (file+headline "~/org/00-inbox/web-clips.org" "Clips não processados")
      "* %:description\n%U\nFonte: %:link\n\n%:initial\n")

     ;; Coisas tipo "registrei que gastei 20 min revisando X" — não é conhecimento, é log operacional:
     ("l" "log rápido" item
      (file+headline "~/org/log.org" "Log do dia")
      "- %U %?")

     ;; Uma nota genérica. Ainda não é uma fleeting note. Um rascunho de qualquer coisa.
     ("n" "Note" entry
      (file+headline "~/org/notes.org" "Inbox")
      "* [%<%Y-%m-%d %a>] %^{Title}\n:PROPERTIES:\n:CREATED: %U\n:CAPTURED: %a\n:END:\n%?"
      :prepend t)

     ("h" "hledger - transação" plain
      (file "~/org/02-areas/financas/%<%Y>.journal")
      "%(read-string \"Data (YYYY-MM-DD, vazio p/ hoje): \" nil nil (format-time-string \"%Y-%m-%d\"))  %^{Descrição}
          %^{Conta débito} R$ %^{Valor}
          %^{Conta crédito}\n\n"
      :empty-lines 1)

     ))


;; Alternativa mais performática: mantenha um arquivo que lista os agenda-files
;; e regenere com um comando manual/hook em vez de directory-files-recursively toda vez...
(setq org-agenda-files "~/org/.agenda-files")
;; ... e um comando para regenerar a lista quando necessário
(defun my/regenerate-agenda-files ()
  (interactive)
  (with-temp-file "~/org/.agenda-files"
    (dolist (f (append
                (directory-files-recursively "~/org/01-projects/" "\\.org$")
                (directory-files-recursively "~/org/02-areas/" "\\.org$")
		(list "~/org/daily/")))
      (insert f "\n"))))

(setq org-todo-keywords
  '((sequence "TODO(p)" "STRT(e)" "HOLD(a@/!)" "|" "DONE(f!)" "KILL(c@)")))

(setq org-todo-keyword-faces
  '(("TODO" . "orange") ("STRT" . "yellow")
    ("HOLD" . "red") ("DONE" . "green") ("KILL" . "gray")))

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
          ("HOLD" . (:background "#d4ccb4" :foreground "#1a1d21"))
          ("DONE" . (:background "#3d424a" :foreground "#8b919a"))
          ("KILL" . (:background "#3d424a" :foreground "#8b919a" :strike-through t)))))

;; O comando d (dashboard) você roda todo dia (C-c a d). O comando r é seu ritual semanal de revisão PARA — ele já filtra o que provavelmente deveria migrar para 04-archives/
(setq org-agenda-custom-commands
  '(("d" "Dashboard PARA"
     ((agenda "" ((org-agenda-span 'day)
                  (org-agenda-overriding-header "Hoje")))

      (tags-todo "project"
                 ((org-agenda-overriding-header "🚀 Projetos ativos")
                  (org-agenda-sorting-strategy '(priority-down))))

      (tags-todo "area"
                 ((org-agenda-overriding-header "🔁 Áreas de responsabilidade")))

      (todo "AGUARDANDO"
            ((org-agenda-overriding-header "⏳ Aguardando terceiros")))

      (tags "fleeting"
            ((org-agenda-overriding-header "📥 Inbox não processado")
             (org-agenda-files '("~/brain/00-inbox/"))))))

    ("r" "Revisão semanal PARA"
     ((tags-todo "project"
                 ((org-agenda-overriding-header "Projetos — ainda ativos?")))
      (tags-todo "area"
                 ((org-agenda-overriding-header "Áreas — revisão de rotina")))
      (todo "DONE|KILL"
            ((org-agenda-overriding-header "Candidatos a Archive")))))))


(provide 'org-configs)
