(setq org-agenda-files (list "~/cmd.org"))



;; ** A really nice feature - agenda restriction to subtree               :NOTE:
;;    [2011-03-17 Thu 10:56]
;; 
;;    C-c C-a < < a
;; 
;;    ('<' cycles through unrestricted, restrict-to-buffer, restrict-to-subtree)


;;(require 'info)
;; ;(push "/Applications/Emacs.app/Cntents/Resources/info" Info-directory-list)
;;(push "/usr/local/share/info" Info-directory-list)

;; (push "/usr/local/share/emacs/site-lisp" load-path)
;; (require 'org-install)
;; ;(load "~/.emacs.d/org-7.01g/contrib/lisp/org-checklist")
;; (load "~/.emacs.d/org-7.5/contrib/lisp/org-checklist")

;;(global-visual-line-mode 1)

(add-to-list 'auto-mode-alist'("\\.org" . org-mode))
(add-to-list 'auto-mode-alist'("\\.txt" . org-mode))
	       
	       
;; (global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)
;; (define-key global-map "\C-c\C-x\C-j" 'org-clock-goto)
;; (setq org-hide-leading-stars nil)
;; (setq org-insert-heading-respect-content t)
;; (setq org-cycle-separator-lines 0)
;; ;; (setq org-blank-before-new-entry (quote ((heading)
;; ;;                                          (plain-list-item))))
;; (setq org-special-ctrl-k t)
;; (setq org-log-done t)
;; (setq org-clock-into-drawer t)
;; (setq org-log-into-drawer t)
;; (global-set-key (kbd "C-c C-w") 'org-refile)
;; (setq org-agenda-repeating-timestamp-show-all t)
;; (setq org-agenda-log-mode-items (quote(clock)))
;; (setq org-agenda-clockreport-parameter-plist (quote (:link nil :maxlevel 2)))
;; (setq org-agenda-start-with-clockreport-mode nil)

;; ;; (defun org-mobile-pullpush nil nil (org-save-all-org-buffers)
;; ;;   (org-mobile-pull)
;; ;;   (org-mobile-push))
;; ;;(define-key org-agenda-mode-map (kbd "S") 'org-mobile-pullpush)
;; ;; how very annoying, this keymap isn't available at startup >:-b
;; ;; should modify this in org-agenda-mode-hook...

;; ;;(setq org-mobile-directory "~/working/finances/Dropbox/MobileOrg")
;; (setq org-mobile-directory "/scpc:sphinx:~/org")
;; (setq org-mobile-inbox-for-pull "~/working/refile.org")

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


;; (setq org-agenda-time-grid 
;;       (quote ((daily today require-timed) "----------------" (600 700 900 1000 1100 1200 1300 1400 1500 1600 1700))))
;; (setq org-use-tag-inheritance t)
;; (setq org-use-property-inheritance  t)

;; (add-hook 'org-agenda-mode-hook 'hl-line-mode)

;; ;; Effort estimates and summary in the agenda
;; (setq org-global-properties '(("Effort_ALL" . "0:10 0:20 0:30 0:40 0:50 1:00 1:10 1:20 1:30 0:01")))
;; (setq org-columns-default-format "%40ITEM(Task) %17Effort(Estimate){:} %CLOCKSUM")


;; ;; ;; Most everything below here cribbed shamelessly from Bernt Hansen
;; ;; http://doc.norang.ca/org-mode.html
(setq org-todo-keywords
      (quote
       (
        (sequence "TODO(t)" "WAITING(w)" "DONE(d!)"))))

;; (setq org-todo-keyword-faces
;;       '(("TODO" . (:foreground "PaleTurquoise1" :background "gray80"))
;;         ("INPROGRESS" . (:foreground "PaleTurquoise1" :background "gray80"))
;;         ("PROJECT" . (:foreground "PaleTurquoise1" :background "gray80"))
;;         ("WAITING" . (:foreground "PaleTurquoise1" :background "gray80"))
;;         ("KEIL" . (:foreground "PaleTurquoise1" :background "gray80"))
;;         ("SHANKAR" . (:foreground "PaleTurquoise1" :background "gray80"))
;;         ("SOMEDAY" . (:foreground "white" :background "gray80"))
;;         ("NEXT" . (:foreground "white" :background "gray80"))
;;         ("PROJECT" . (:foreground "white" :background "gray80"))
;;          ))

        
;; (setq org-tag-alist '(
;;                       ("ADELS" . ?A)("KEIL" . ?K)("SHANKAR" . ?S)
;;                       ("AYD" . ?Y)("HACK" . ?#)("PROJECT" . ?P)("WRITE" . ?r)
;;                       ("MAYBE" . ?M)("NOTE" . ?N)
;;                       (:startgroup . nil)
;;                       ("@home" . ?h)("@work" . ?w)("@shopping" . ?$)("@phone" . ?f)
;;                       (:endgroup . nil)
;;                       (:startgroup . nil)("i" . ?i)("s" . ?s)
;;                       (:endgroup . nil)
;;                       (:startgroup . nil)("d" . ?d)("o" . ?o)
;;                       (:endgroup . nil)))






;; (setq org-use-fast-todo-selection t)
;; (setq org-todo-state-tags-triggers
;;       (quote (("KEIL" ("KEIL" . t))
;;               ("SHANKAR" ("SHANKAR" . t))
;;               ("DEODHAR" ("DEODHAR" . t)))))


;; (setq org-stuck-projects '("/PROJECT" ("TODO" "WAITING" "INPROGRESS" "DEODHAR" "KEIL" "SHANKAR") nil ""))
;; (setq org-clock-in-switch-to-state "INPROGRESS")
;; (setq org-clock-out-remove-zero-time-clocks t)


;; ;; Keep tasks with dates off the global todo lists
;; (setq org-agenda-todo-ignore-with-date t)
;; (setq org-agenda-tags-todo-honor-ignore-options t)

;; ;; Don't pollute effort estimate summary with DONE stuff
;; (setq org-agenda-skip-scheduled-if-done t)
;; (setq org-agenda-skip-deadline-if-done t)

;; ;; Don't put deadlines on the agenda
;; (setq org-deadline-warning-days 7)



;; (setq org-hierarchical-checkbox-statistics t)


;; ;; This is the magic that makes / RET in the agenda work so nice
;; ;; Again, cribbed from Bernt
;; (defun cmd/weekday-p ()
;;   (let ((wday (nth 6 (decode-time))))
;;     (and (< wday 6) (> wday 0))))
;; (defun cmd/working-p ()
;;   (let (( hour (nth 2 (decode-time))))
;;     (and (cmd/weekday-p) (and (>= hour 8) (>= hour 20)))))
;; (defun cmd/org-auto-exclude-function (tag)
;;   (and (cond
;;        ((string= tag "@work")
;; 	(string= tag "@phone")
;;         (cmd/working-p))
;;        ((string= tag "@home")
;;         (not (cmd/working-p))))
;;        (concat "-" tag)))
;; (setq org-agenda-auto-exclude-function 'cmd/org-auto-exclude-function)


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


;; (setq org-agenda-custom-commands
;;       '(("a" "Block agenda"
;;          ((agenda "" ((org-agenda-ndays 1)))
;;           (todo "INPROGRESS|WAITING")
;;           (tags "REFILE")
;;           (tags-todo "-@shopping-REPEATING-WRITE/TODO")
;; 	  (tags-todo "WRITE")
;;           ))
;;         ("A" agenda "" ((org-agenda-ndays 1)))
;;         ("K" tags "KEIL")
;;         ("S" tags "SHANKAR")
;;         ("D" tags "DEODHAR")
;;         ("y" tags-todo "AYD" nil ("~/working/finances/Dropbox/Public/yani.html"))
;;         ("h" tags-todo "@home" nil ("~/working/finances/Dropbox/Public/home.html"))
;;         ("$" tags-todo "@shopping/TODO" nil ("~/working/finances/Dropbox/Public/shopping.html"))
;;         ("f" tags "@phone-scheduled/TODO" nil ("~/working/finances/Dropbox/Public/phone.html") )
;; 	("w" tags "WRITE" nil ("~/working/finances/Dropbox/Public/write.html"))
;; ))
