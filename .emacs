; basic stuff

(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(transient-mark-mode t)

(column-number-mode t)
(auto-compression-mode 1)
(setq redisplay-dont-pause t)

(delete-selection-mode t)

;(global-hl-line-mode t)

(menu-bar-mode -1)
;; (require 'mouse)
;; (xterm-mouse-mode t)

;; don't interfere with tmux
(define-key global-map (kbd "C-z") nil)

;; why is this not the default
(setq-default show-trailing-whitespace t)

;; Type unicode with C-x 8 <cr>
;263a☺
;;C-x 8 <cr> 263a ;☺
;;C-x 8 <cr> 2318 ; ⌘
;; ♠♥♦♣ 2660 2665 2666 2663
;; 

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
  (setq interprogram-cut-function 'pbcopy))

(global-set-key "\M-T" 'transpose-lines)
(global-set-key "\M-#" 'comment-region)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-H" 'hl-line-mode)
(global-set-key "\M-%" 'query-replace-regexp)

(define-key global-map "\C-h" 'backward-delete-char)
(define-key global-map "\C-\M-h" 'backward-kill-word)
(setq mouse-yank-at-point t)


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


(defun unfill-region (beg end)
  "Unfill the region, joining text paragraphs into a single logical line."
  (interactive "*r")
  (let ((fill-column (point-max)))
    (fill-region beg end)))

		      



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


;; org mode
;; ; ; ;; ;;; ;;;;; ;;;;;;;; ;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;
(setq org-hide-leading-stars t)
(setq org-odd-levels-only nil)

;; (require 'org)
(require 'ox-md)
(setq org-agenda-files (list "~/Documents/org"))
(global-set-key "\C-ca" 'org-agenda)

(setq org-refile-targets (quote (("ticklers.org" :maxlevel . 1)
				 ("cmd.org" :maxlevel . 9)
				 ("inbox.org" :maxlevel . 1)
				 ("backlog.org" :maxlevel . 1)
				 ("incan.org" :maxlevel . 1)
				 ("okrs.org" :maxlevel . 1)
				 )))

(org-babel-do-load-languages 'org-babel-load-languages
			     '(
			       (shell . t)))


;; ;; Don't break things
;; (setq org-insert-heading-respect-content t
;;       org-catch-invisible-edits "error")

;; ;; Capture is bonzer!
(define-key global-map "\M-?" 'org-capture)
(setq org-default-notes-file "~/cmd/org/inbox.org")
(setq org-capture-templates
      '(
	("t" "Todo" entry (file "~/cmd/org/inbox.org")
	 "* TODO %?\n %i %t" )
	("n" "Note" entry (file "~/cmd/org/inbox.org")
	 "* %? :NOTE:\n %i %t" )
	))

;; logging
(setq org-log-done nil)
(setq org-log-into-drawer nil)

;; ;; Only consider children when calculating completion percent
;; (setq org-checkbox-hierarchical-statistics t)

;; Archive into a datetree
(setq org-archive-location "%s_archive::datetree/")

(setq org-todo-keywords
      (quote
       (
	(sequence "BLOCKED(b)" "TODO(t/!)" "INPROGRESS(i/!)" "WAITING(w/!)" "DONE(d/!)"))))

;; ;; ;; Don't pollute effort estimate summary with DONE stuff
;;(setq org-agenda-skip-scheduled-if-done t)

;; ;; ;; default to day view in the agenda
(setq org-agenda-span 1)

;; (setq org-agenda-custom-commands
;;       '(
;; 	("A" "Agenda" agenda nil nil ("~/cmd/Google Drive/org/agenda.txt"))
;; 	("T " "All" todo "TODO" nil ("~/cmd/Google Drive/org/todo.txt"))
;; 	("P" "Phone" tags-todo "PHONE" nil ("~/cmd/Google Drive/org/phone.txt"))
;; 	("E" "Errand" tags-todo "ERRAND" nil ("~/cmd/Google Drive/org/errand.txt"))
;; 	("W" "WAITING" todo "WAITING" nil ("~/cmd/Google Drive/waiting.txt"))
;; 	))



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
;;(load-theme 'sanityinc-solarized-light)
;;(load-theme 'wombat)
;;(load-theme 'spacemacs-dark t)
;;(load-theme 'spacemacs-light t)
;;(load-theme 'gruvbox-dark-hard t)
(load-theme 'cyberpunk t)
;;(load-theme 'monokai-theme t)

(defun on-after-init ()
  (set-face-background 'default "#000000" (selected-frame)))
(add-hook 'window-setup-hook 'on-after-init)


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
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#657b83"])
 '(beacon-color "#d33682")
 '(compilation-message-face 'default)
 '(cua-global-mark-cursor-color "#2aa198")
 '(cua-normal-cursor-color "#839496")
 '(cua-overwrite-cursor-color "#b58900")
 '(cua-read-only-cursor-color "#859900")
 '(fci-rule-color "#073642")
 '(flycheck-color-mode-line-face-to-color 'mode-line-buffer-id)
 '(frame-background-mode 'light)
 '(gpm-mouse-mode nil)
 '(highlight-changes-colors '("#d33682" "#6c71c4"))
 '(highlight-symbol-colors
   (--map
    (solarized-color-blend it "#002b36" 0.25)
    '("#b58900" "#2aa198" "#dc322f" "#6c71c4" "#859900" "#cb4b16" "#268bd2")))
 '(highlight-symbol-foreground-color "#93a1a1")
 '(highlight-tail-colors
   '(("#073642" . 0)
     ("#546E00" . 20)
     ("#00736F" . 30)
     ("#00629D" . 50)
     ("#7B6000" . 60)
     ("#8B2C02" . 70)
     ("#93115C" . 85)
     ("#073642" . 100)))
 '(hl-bg-colors
   '("#7B6000" "#8B2C02" "#990A1B" "#93115C" "#3F4D91" "#00629D" "#00736F" "#546E00"))
 '(hl-fg-colors
   '("#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36" "#002b36"))
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(ispell-highlight-face 'flyspell-incorrect)
 '(js-indent-level 2)
 '(nrepl-message-colors
   '("#dc322f" "#cb4b16" "#b58900" "#546E00" "#B4C342" "#00629D" "#2aa198" "#d33682" "#6c71c4"))
 '(org-fontify-done-headline nil)
 '(org-fontify-todo-headline nil)
 '(package-selected-packages
   '(fish-mode applescript-mode abyss-theme cyberpunk-theme grip-mode clojure-mode-extra-font-locking monokai-theme color-theme-sanityinc-tomorrow solarized-theme cider clojure-mode color-theme-sanityinc-solarized dockerfile-mode lua-mode gruvbox-theme graphviz-dot-mode json-mode nginx-mode nlinum ini-mode magit rainbow-delimiters go-mode xclip jinja2-mode smartparens ansible ansible-vault markdown-mode org terraform-mode spacemacs-theme yaml-mode))
 '(pdf-view-midnight-colors '("#fdf4c1" . "#1d2021"))
 '(sentence-end "[.?!][]\"')}]*\\($\\|     \\| \\)[
     ]*")
 '(show-paren-mode t)
 '(smartrep-mode-line-active-bg (solarized-color-blend "#859900" "#073642" 0.2))
 '(sp-show-pair-delay 0)
 '(sp-show-pair-from-inside t)
 '(term-default-bg-color "#002b36")
 '(term-default-fg-color "#839496")
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-background-mode nil)
 '(vc-annotate-color-map
   '((20 . "#dc322f")
     (40 . "#c8805d801780")
     (60 . "#bec073400bc0")
     (80 . "#b58900")
     (100 . "#a5008e550000")
     (120 . "#9d0091000000")
     (140 . "#950093aa0000")
     (160 . "#8d0096550000")
     (180 . "#859900")
     (200 . "#66aa9baa32aa")
     (220 . "#57809d004c00")
     (240 . "#48559e556555")
     (260 . "#392a9faa7eaa")
     (280 . "#2aa198")
     (300 . "#28669833af33")
     (320 . "#279993ccbacc")
     (340 . "#26cc8f66c666")
     (360 . "#268bd2")))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   '(unspecified "#002b36" "#073642" "#990A1B" "#dc322f" "#546E00" "#859900" "#7B6000" "#b58900" "#00629D" "#268bd2" "#93115C" "#d33682" "#00736F" "#2aa198" "#839496" "#657b83"))
 '(window-divider-mode nil)
 '(xterm-color-names
   ["#073642" "#dc322f" "#859900" "#b58900" "#268bd2" "#d33682" "#2aa198" "#eee8d5"])
 '(xterm-color-names-bright
   ["#002b36" "#cb4b16" "#586e75" "#657b83" "#839496" "#6c71c4" "#93a1a1" "#fdf6e3"]))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-done ((t (:foreground "darkslategray"))))
 '(org-hide ((t (:foreground "black"))))
 '(org-scheduled ((t (:foreground "darkgreen" :weight bold))))
 '(org-scheduled-today ((t (:foreground "green" :weight bold))))
 '(org-table ((t (:foreground "deepskyblue"))))
 '(outline-2 ((t (:inherit font-lock-constant-face))))
 '(outline-5 ((t (:inherit font-lock-variable-name-face))))
 '(show-paren-match ((t (:inverse-video t)))))

(server-start)
