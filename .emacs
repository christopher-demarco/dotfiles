; basic stuff
(server-start)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(transient-mark-mode t)
;; (show-paren-mode 1)
;; (setq show-paren-delay 0)
;(show-smartparens-global-mode +1)

(column-number-mode t)
(auto-compression-mode 1)
(setq redisplay-dont-pause t)

(delete-selection-mode t)

(menu-bar-mode -1)
;; (require 'mouse)
;; (xterm-mouse-mode t)

;; don't interfere with tmux and anyway I bind this myself in the WM
(define-key global-map (kbd "C-z") nil)

;; Type unicode with C-x 8 <cr>
;263a☺
;;C-x 8 <cr> 263a ;☺
;;C-x 8 <cr> 2318 ; ⌘
;; ♠♥♦♣ 2660 2665 2666 2663
;; 


;; FIXME: This and sentence-spacing and lotsa more go into ENGLISH section
(global-set-key "\M-_" (lambda () (interactive) (insert "--")));; the unicode character messes up the line spacing :-/
(add-hook 'text-mode-hook
	  '(lambda ()
	     (setq indent-tabs-mode nil)
	     (setq tab-width 4)))



;;Make it easier to copy to OSX clipboard
(when (memq system-type '(darwin))
  ;; this could also be (eq system-type 'darwin) but lists are funner
  (defun pbcopy (text &optional push)
    (let ((process-connection-type nil))
      (let ((proc (start-process "pbcopy" nil "pbcopy")))
	(process-send-string proc text)
	(process-send-eof proc))))
  (setq interprogram-cut-function 'pbcopy)
  )

(global-set-key "\M-T" 'transpose-lines)
(global-set-key "\M-#" 'comment-region)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-H" 'hl-line-mode)
(global-set-key "\M-%" 'query-replace-regexp)

(define-key global-map "\C-h" 'backward-delete-char)
(define-key global-map "\C-\M-h" 'backward-kill-word)
(setq mouse-yank-at-point t)

(add-to-list 'exec-path "/opt/local/bin")
(add-to-list 'exec-path "~/bin")
(add-to-list 'exec-path "/usr/local/bin")



;; MELPA; see https://melpa.org/#/getting-started
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

(push "~/.emacs.d/lib" load-path)

(autoload 'applescript-mode "applescript-mode"
  "Major mode for editing AppleScript source." t)
(add-to-list 'auto-mode-alist '("\\.scpt$" . applescript-mode))

(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))



;; ;; How do I undefine python-mode's py-mark-def-or-class!?
(eval-after-load "python-mode" '(define-key py-mode-map "\C-\M-h" 'backward-kill-word))

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


;; ;; TRAMP
;; ;; Should be built-in to tramp-mode:
;; (setq tramp-default-method "ssh")
;; (setq mode-line-remote
;;       '(:eval
;;         (let ((host-name
;;                (or (file-remote-p default-directory 'host)
;;                    (system-name))))
;;           (if (string-match "^[^0-9][^.]*\\(\\..*\\)" host-name)
;;               (substring host-name 0 (match-beginning 1))
;;             host-name))))
;; (defconst my-mode-line-buffer-identification
;;   (list
;;    '(:eval
;;      (let ((host-name
;;             (if (file-remote-p default-directory)
;;                 (tramp-file-name-host
;;                  (tramp-dissect-file-name default-directory))
;;               (system-name))))
;;        (if (string-match "^[^0-9][^.]*\\(\\..*\\)" host-name)
;;            (substring host-name 0 (match-beginning 1))
;;          host-name)))
;;    ": %12b"))
;; (setq-default
;;  mode-line-buffer-identification
;;  my-mode-line-buffer-identification)
;; (add-hook
;;  'dired-mode-hook
;;  '(lambda ()
;;     (setq
;;      mode-line-buffer-identification
;;      my-mode-line-buffer-identification)))

;; It's *UNSAFE* to backup files edited via tramp or mailcrypt!
;; (plus they're annoying)
(setq make-backup-files nil)
(setq backup-inhibited t)

;; Let's have proper syntax!
(setq sentence-end-double-space nil)

(add-hook 'go-mode-hook
	  (lambda ()
	    (setq tab-width 2)))

;; slepping
(setq-default ispell-program-name "/usr/local/bin/aspell")
(autoload 'flyspell-mode "flyspell" "On-the-fly spelling checker." t)
(defun turn-on-flyspell ()
  "Force flyspell-mode on using a positive arg.  For use in hooks."
  (interactive)
  (flyspell-mode 1))
(add-hook 'text-mode-hook 'turn-on-flyspell)
(add-hook 'org-mode-hook 'turn-on-flyspell)


(autoload 'apache-mode "apache-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.htaccess\\'"   . apache-mode))
(add-to-list 'auto-mode-alist '("httpd\\.conf\\'"  . apache-mode))
(add-to-list 'auto-mode-alist '("srm\\.conf\\'"    . apache-mode))
(add-to-list 'auto-mode-alist '("access\\.conf\\'" . apache-mode))
(add-to-list 'auto-mode-alist '("sites-\\(available\\|enabled\\)/" . apache-mode))
(add-to-list 'auto-mode-alist '("\\.tmpl\\'" . html-helper-mode))


(defun cmd-insert-date ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))
(global-set-key (kbd "C-c d") 'cmd-insert-date)


(require 'org)
(global-set-key "\C-ca" 'org-agenda)


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
	("n" "Note" entry (file "~/.org/cmd.org")
	 "* %? :NOTE:\n  %i %t" )
	))

;; Log stuff into drawers
(setq org-log-done nil)
(setq org-log-into-drawer t)

;; Only consider children when calculating completion percent
(setq org-checkbox-hierarchical-statistics t)

;; Archive into a datetree
(setq org-archive-location "%s_archive::datetree/")

(setq org-todo-keywords
      (quote
       (
	(sequence "TODO(t)" "INPROGRESS(i)" "WAITING(w)" "DONE(d!)"))))

;; ;; Don't pollute effort estimate summary with DONE stuff
(setq org-agenda-skip-scheduled-if-done t)

(setq org-agenda-span 1)

(setq org-agenda-custom-commands
      '(
	("A" "Agenda" agenda nil nil ("~/cmd/Google Drive/org/agenda.txt"))
	("T " "All" todo "TODO" nil ("~/cmd/Google Drive/org/todo.txt"))
	("P" "Phone" tags-todo "PHONE" nil ("~/cmd/Google Drive/org/phone.txt"))
	("E" "Errand" tags-todo "ERRAND" nil ("~/cmd/Google Drive/org/errand.txt"))
	("W" "WAITING" todo "WAITING" nil ("~/cmd/Google Drive/waiting.txt"))
	))



;; ; ; ;; ;;; ;;;;; ;;;;;;;; ;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;
;; ;;  Random awesomenessess...
;; ;;
;; ;;  c-x c-e eval-last-sexp
;; ;;
;; ;;  view-lossage
;; ;;
;; ;;  dabbrev-expand (M-/) (word completion!)
;; ;;
;; ;;  'occur
;; ;;
;; ;; exchange-point-and-mark' (C-x C-x)
;; ;; yank mark from mark ring (C-u C-<SPC>
;; ;;
;; ;; back-to-indentation (M-m)
;; ;;
;; ;; C-x r w <register>  \
;; ;;                      } Write & read window configuration incl. contents
;; ;; C-x r j <register>  /
;; ;;
;; ;; Specify SSH port number in tramp-mode:
;; ;; /ssh:user@host#portnum:/some/path/to/a/file


;; ;; Macro-commands
;; ;; M-x name-last-kbd-macro give name to macro (for saving)
;; ;; M-x insert-keyboard-macro save named macro into file
;; ;; M-x load-file load macro
;; ;; M-x macroname execute macroname


;; ;; TRAMP
;; ;; tramp-cleanup-all-buffers



;; ;; 2.5 `M-n' creates a new independent Info buffer in Emacs
;; ;; ========================================================

;; ;; If you are reading Info in Emacs",  you can select a new independent Info
;; ;; buffer in a new Emacs window by typing `M-n'.  The new buffer starts
;; ;; out as an exact copy of the old one, but you will be able to move
;; ;; independently between nodes in the two buffers.  (In Info mode, `M-n'
;; ;; runs the Emacs command `clone-buffer'.)

;; ;;    In Emacs Info, you can also produce new Info buffers by giving a
;; ;; numeric prefix argument to the `m' and `g' commands.  `C-u m' and `C-u
;; ;; g' go to a new node in exactly the same way that `m' and `g' do, but
;; ;; they do so in a new Info buffer which they select in another window.

;; ;;    Another way to produce new Info buffers in Emacs is to use a numeric
;; ;; prefix argument for the `C-h i' command (`info') which switches to the
;; ;; Info buffer with that number.  Thus, `C-u 2 C-h i' switches to the
;; ;; buffer `*info*<2>', creating it if necessary.

;; ;; C-x =  Display lots of stuff about point, including byte count
;; ;; C-u C-x s = save all buffers

;; ;; M-x describe-face 


;; ;; M-x dict

;; ;; Search in all buffers
;; ;; multi-occur: – Search specified buffers to a string
;; ;; multi-occur-in-matching-buffers: Allows one to search a subset of one’s open buffers or files specified as a regexp:
;; ;; Given .* as its first argument this allows one to search all currently open files for a given regular expression.
;; ;; Given a prefix argument and .* as its first argument this allows one to search all currently open buffers for a regexp.
;; ;; Found at http://argandgahandapandpa.wordpress.com/2008/07/27/searching-multiple-buffers-emacs/

;; `C-c C-o` is (org-open-at-point), which opens a link


(put 'narrow-to-region 'disabled nil)

;;(load-theme 'solarized t)
;;(load-theme 'solarized-dark t)
;;(load-theme 'sanityinc-solarized-dark)
;;(load-theme 'wombat)
;;(load-theme 'spacemacs-dark t)
;;(load-theme 'spacemacs-light t)
;;(load-theme 'gruvbox-dark-hard t)
(load-theme 'cyberpunk t)
;;(load-theme 'monokai-theme t)


(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))




;; clojure
(defun clj nil
  (interactive)
  (cider-jack-in nil))





(push "/usr/local/share/emacs/site-lisp/json-mode" load-path)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" default)))
 '(gpm-mouse-mode nil)
 '(js-indent-level 2)
 '(org-startup-indented t)
 '(package-selected-packages
   (quote
    (color-theme-sanityinc-solarized dockerfile-mode lua-mode gruvbox-theme graphviz-dot-mode json-mode nginx-mode nlinum ini-mode magit rainbow-delimiters go-mode xclip jinja2-mode smartparens ansible ansible-vault markdown-mode org terraform-mode spacemacs-theme yaml-mode)))
 '(sentence-end "[.?!][]\"')}]*\\($\\|     \\| \\)[
     ]*")
 '(show-paren-mode t)
 '(sp-show-pair-delay 0)
 '(sp-show-pair-from-inside t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
