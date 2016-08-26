;; these things get backed up by Dropbox
(setq org-agenda-files (list "~/.org/cmd.org")
      bookmark-default-file "~/.org/bookmarks"
      bookmark-save-flag 1)


(add-to-list 'auto-mode-alist'("\\.org" . org-mode))
(add-to-list 'auto-mode-alist'("\\.txt" . org-mode))
(add-hook 'org-agenda-mode-hook 'hl-line-mode)
	       
(global-set-key "\C-ca" 'org-agenda)

;; Export agenda views to HTML whenever an org-mode buffer is saved.
;;;; Ensure the export directory exists
(setq export-dir (expand-file-name "~/tmp/org-export"))
(when (not (file-exists-p export-dir))
  (make-directory export-dir t))
(when (eq nil (car (file-attributes "/Users/demarco/tmp/org-export")))
  (delete-file export-dir)
  (make-directory export-dir))
;;;; Function to push to s3
(defun agenda-export-push nil
  (interactive)
  (let ((process-connection-type nil))
    (let ((proc (start-process "s3sync" "*Messages*" "aws" "--profile" "cmd" "s3" "sync" export-dir "s3://cmd-orgtest" "--acl" "public-read"))))))
;;;; Every time org-mode starts, add hooks
(add-hook 'org-mode-hook
	  '(lambda ()
	     (add-hook 'after-save-hook 'org-store-agenda-views nil t)
	     (add-hook 'after-save-hook 'agenda-export-push t t)))


;; Don't break things
(setq org-insert-heading-respect-content t
      org-catch-invisible-edits "error")

;; Capture is bonzer!
(define-key global-map "\M-?" 'org-capture)
(setq org-default-notes-file "~/.org/cmd.org")
(setq org-capture-templates
      '(
	("t" "Todo" entry (file "~/.org/cmd.org")
	 "* TODO %?\n  %i" )
	("m" "Meeting" entry (file "~/.org/cmd.org")
	 "* TODO %? :MEETING:\n%i" )
	("n" "Note" entry (file "~/.org/cmd.org")
	 "* %? :NOTE:\n%i" )
	))

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
	("A" "Agenda" agenda nil nil ("~/tmp/org-export/today.html"))
	("T " "All" todo "TODO" nil ("~/tmp/org-export/todo.html"))
	("P" "Phone" tags-todo "PHONE" nil ("~/tmp/org-export/phone.html"))
	("E" "Errand" tags-todo "ERRAND" nil ("~/tmp/org-export/errand.html"))
	))

;; (setq org-agenda-custom-commands
;;       '(
;; 	("A" "Agenda" agenda nil nil ("~/.org/today.html"))
;; 	("T " "All" todo "TODO" nil ("~/.org/todo.html"))
;; 	("P" "Phone" tags-todo "PHONE" nil ("~/.org/phone.html"))
;; 	("E" "Errand" tags-todo "ERRAND" nil ("~/.org/errand.html"))
;; 	))
