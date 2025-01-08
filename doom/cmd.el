;;; cmd.el -*- lexical-binding: t; -*-

(defun cmd-insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))
(global-set-key (kbd "C-c d") 'cmd-insert-date)

(defun cmd-insert-trace-python (&optional arg)
  (interactive "P")
  (if (equal arg nil)
      (insert "import pudb ; pudb.set_trace()")
    (save-excursion
      (goto-char 0)
      (delete-matching-lines "import pudb ; pudb.set_trace()"))))

(defun cmd-python-customizations ()
  "cmd"
  (define-key python-mode-map
    (kbd "C-c t")
    'cmd-insert-trace-python))
(add-hook 'python-mode-hook 'cmd-python-customizations)

(let ((work-el "~/.work.el"))
  (when (file-exists-p work-el)
    (load! work-el)
    (defun cmd-open-jira ()
      (interactive)
      (browse-url
       (replace-regexp-in-string "_" "-"
         (format jira-url (thing-at-point 'symbol)))))
    (global-set-key (kbd "C-x C-j") 'cmd-open-jira)))
