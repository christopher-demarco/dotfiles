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

(defun cmd-markdown-insert-file-link ()
  "Insert a markdown link to a local file using vertico file completion."
  (interactive)
  (let* ((file (read-file-name "Link file: " nil nil t))
         (rel  (file-relative-name file))
         (text (read-string "Link text: " (file-name-base file))))
    (insert (format "[%s](%s)" text rel))))

(after! markdown-mode
  (map! :map markdown-mode-map
        "C-c C-l" #'cmd-markdown-insert-file-link))

(let ((work-el "~/.work.el"))
  (when (file-exists-p work-el)
    (load! work-el)
    (defun cmd-open-jira ()
      (interactive)
      (browse-url
       (replace-regexp-in-string "_" "-"
         (format jira-url (thing-at-point 'symbol)))))
    (global-set-key (kbd "C-x C-j") 'cmd-open-jira)))
