(setq org-agenda-files (list "~/cmd.org"))

(add-to-list 'auto-mode-alist'("\\.org" . org-mode))
(add-to-list 'auto-mode-alist'("\\.txt" . org-mode))
	       
(global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)
;; (setq org-hide-leading-stars nil)
;; (setq org-insert-heading-respect-content t)
;; (setq org-cycle-separator-lines 0)
;; ;; (setq org-blank-before-new-entry (quote ((heading)
;; ;;                                          (plain-list-item))))
;; (setq org-special-ctrl-k t)
;; (setq org-log-done t)
;; (setq org-log-into-drawer t)
;; (global-set-key (kbd "C-c C-w") 'org-refile)



;; (define-key global-map "\M-?" 'org-capture)
;; (setq org-default-notes-file "~/working/refile.org")

;; (setq org-capture-templates
;;       '(
;; 	("t" "Todo" entry (file "~/working/refile.org")
;;          "* TODO %?\n  %i%U" )
;;         ("i" "Interruption" entry (file "~/working/refile.org")
;;          "* TODO %? :i:\n %U" )
;;         ("n" "Note" entry (file "~/working/refile.org")
;;          "* %? :NOTE:\n%i%U" )))


;; ;; Stop the annoying mouse highlight of the agenda
;; ;; (remove-hook 'org-finalize-agenda-hook
;; ;;     (lambda () (remove-text-properties
;; ;;                (point-min) (point-max) '(mouse-face t))))


;; ;; Refiling
;; ;; Targets include this file and any file contributing to the agenda -
;; ;; up to 5 levels deep
;; (setq org-refile-targets 
;;       (quote ((org-agenda-files :maxlevel . 5))))
;; ;; how to choose refile targets
;; (setq org-refile-use-outline-path 'file)
;; (setq org-outline-path-complete-in-steps t)


;; ;; for great convenience
;; (defun kill-org-buffers ()
;;   (interactive)
;;   (dolist (buffer (buffer-list))
;;     (let ((fname (buffer-file-name buffer))
;;           (pattern "\.org"))
;;       (when (and fname (string-match pattern fname))
;;         (message (concat "Killing " fname))
;;         (kill-buffer buffer)))))



(add-hook 'org-agenda-mode-hook 'hl-line-mode)

;; ;; ;; Most everything below here cribbed shamelessly from Bernt Hansen
;; ;; http://doc.norang.ca/org-mode.html
(setq org-todo-keywords
      (quote
       (
        (sequence "TODO(t)" "WAITING(w)" "DONE(d!)"))))







;; (setq org-use-fast-todo-selection t)
;; (setq org-todo-state-tags-triggers
;;       (quote (("KEIL" ("KEIL" . t))
;;               ("SHANKAR" ("SHANKAR" . t))
;;               ("DEODHAR" ("DEODHAR" . t)))))


;; (setq org-stuck-projects '("/PROJECT" ("TODO" "WAITING" "INPROGRESS" "DEODHAR" "KEIL" "SHANKAR") nil ""))


;; ;; Don't pollute effort estimate summary with DONE stuff



;; (setq org-hierarchical-checkbox-statistics t)




;; ;; Narrow to a subtree
;; (global-set-key (kbd "<f5>") 'bh/org-todo)

;; (defun bh/org-todo ()
;;   (interactive)
;;   (org-narrow-to-subtree)
;;   (org-show-todo-tree nil))

;; (global-set-key (kbd "<S-f5>") 'bh/widen)

;; (defun bh/widen ()
;;   (interactive)
;;   (widen)
;;   (org-reveal))




;;; Random notes about org-mode

;; Add    &   remove current file from org-agenda-files
;; C-c [      C-c ]

;; C-c . inserts a timestamp!

(setq org-agenda-span 1)

(setq org-agenda-custom-commands
      '(("A" agenda ""
	 ((org-agenda-with-colors nil))
	 ("~/.org/today.html"))
	("T" alltodo ""
	 ((org-agenda-with-colors nil))
	 ("~/.org/todo.html"))
	))
