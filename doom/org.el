(after! org
  (global-set-key "\C-ca" 'org-agenda) ;; replaces embark ;; FIXME doesn't work?
  (global-set-key "\C-c\C-x\C-j" 'org-clock-goto)

  (setq org-refile-targets (quote (("daylog.org" :maxlevel . 1))))

  (define-key global-map "\M-?" 'org-capture)
  (setq org-default-notes-file "~/.org/daylog.org")
  (setq org-capture-templates
        '(
          ("t" "Todo" entry (file "~/.org/daylog.org")
           "* TODO %?\n %i" )
          ("n" "Note" entry (file "~/.org//daylog.org")
           "* %? :NOTE:\n %i %t" )
          ))

  ;; logging
  (setq org-log-into-drawer t)
  (setq org-log-done t)
  (setq org-archive-location "%s_archive::datetree/")


  (setq org-todo-keywords
        (quote
         (
          (sequence "TODO(t/!)" "INPROGRESS(i/!)" "WAITING(w/!)" "DONE(d/!)"))))


  ;; default to day view in the agenda
  (setq org-agenda-span 'day)
  (setq org-agenda-start-day "+0d")

  ;; Show DONE items in the log view, too
  (setq org-agenda-log-mode-items '(closed clock state))

  ;; Clock-in-and-out automatically
  (setq org-done-keywords '("DONE" "WAITING"))
  (setq org-clock-out-when-done '("DONE" "WAITING"))
  (defun org-clock-todo-change ()
    (if (string= org-state "INPROGRESS")
        (org-clock-in)
      (org-clock-out-if-current)))
  (add-hook 'org-after-todo-state-change-hook
            'org-clock-todo-change)

  (setq org-roam-directory "~/.config/zettelkasten/")
  (org-roam-db-autosync-mode)
  (setq org-roam-capture-templates
        '(
          ("c" "cmd" plain "%?"
       :target (file+head "cmd/%<%Y%m%d%H%M%S>-${slug}.org"
                          "#+title: ${title}\n")
       :unnarrowed t)
          )
        )
)
