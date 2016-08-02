(setq org-agenda-files (list "~/cmd.org"))

(add-to-list 'auto-mode-alist'("\\.org" . org-mode))
(add-to-list 'auto-mode-alist'("\\.txt" . org-mode))
(add-hook 'org-agenda-mode-hook 'hl-line-mode)
	       
(global-set-key "\C-ca" 'org-agenda)

;; Automagically export agenda views to HTML whenever an org-mode
;; buffer is saved.
(add-hook 'org-mode-hook
	  '(lambda ()
	     (add-hook 'after-save-hook 'org-store-agenda-views nil t)
	     ))

;; Don't break drawers etc.
(setq org-insert-heading-respect-content t)

;; Capture is bonzer!
(define-key global-map "\M-?" 'org-capture)
(setq org-default-notes-file "~/.org/cmd.org")
(setq org-capture-templates
      '(
	("t" "Todo" entry (file "~/.org/cmd.org")
	 "* TODO %?\n  %i%U" )
	("n" "Note" entry (file "~/.org/cmd.org")
	 "* %? :NOTE:\n%i%U" )))

;; Log stuff into drawers
(setq org-log-done t
      org-log-into-drawer t
      )

;; Only consider children when calculating completion percent
(setq org-checkbox-hierarchical-statistics t)


;; Archive into a datetree
(setq org-archive-location "%s_archive::datetree/")

(setq org-todo-keywords
      (quote
       (
        (sequence "TODO(t)" "WAITING(w)" "DONE(d!)"))))

;; ;; Don't pollute effort estimate summary with DONE stuff
(setq org-agenda-skip-scheduled-if-done t)


(setq org-agenda-span 1)


(setq org-agenda-custom-commands
      '(
;;      (key desc type match settings files)
	("A" "Agenda" agenda nil nil ("~/tmp/today.html"))
	("T " "All" todo "TODO" nil ("~/tmp/todo.html"))
	("P" "Phone" tags-todo "PHONE" nil ("~/tmp/phone.html"))
	("E" "Errand" tags-todo "ERRAND" nil ("~/tmp/errand.html"))
	))

