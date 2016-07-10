(setq org-agenda-files (list "~/cmd.org"))

(add-to-list 'auto-mode-alist'("\\.org" . org-mode))
(add-to-list 'auto-mode-alist'("\\.txt" . org-mode))
(add-hook 'org-agenda-mode-hook 'hl-line-mode)
	       
(global-set-key "\C-ca" 'org-agenda)

;; Don't insert lines inside subtrees
(setq org-insert-heading-respect-content t)

;; Cool capture stuff, maybe re-use some day
;; (define-key global-map "\M-?" 'org-capture)
;; (setq org-default-notes-file "~/working/refile.org")
;; (setq org-capture-templates
;;       '(
;;     ("t" "Todo" entry (file "~/working/refile.org")
;;          "* TODO %?\n  %i%U" )
;;         ("i" "Interruption" entry (file "~/working/refile.org")
;;          "* TODO %? :i:\n %U" )
;;         ("n" "Note" entry (file "~/working/refile.org")
;;          "* %? :NOTE:\n%i%U" )))

;; Log stuff into drawers
(setq org-log-done t
      org-log-into-drawer t
      )

;; Only consider children when calculating completion percent
(setq org-checkbox-hierarchical-statistics t)


(setq org-todo-keywords
      (quote
       (
        (sequence "TODO(t)" "WAITING(w)" "DONE(d!)"))))

;; ;; Don't pollute effort estimate summary with DONE stuff
(setq org-agenda-skip-scheduled-if-done t)


(setq org-agenda-span 1)

(setq org-agenda-custom-commands
      '(("A" agenda ""
	 ((org-agenda-with-colors nil))
	 ("~/.org/today.html"))
	("T" alltodo ""
	 ((org-agenda-with-colors nil))
	 ("~/.org/todo.html"))
	))

