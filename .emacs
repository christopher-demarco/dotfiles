; basic stuff



(server-start)
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(transient-mark-mode t)
(show-paren-mode 1)
(column-number-mode t)
(auto-compression-mode 1)
(setq redisplay-dont-pause t)


(menu-bar-mode -1)
(require 'mouse)
(xterm-mouse-mode t)

	 

;; don't interfere with tmux and anyway I bind this myself in the WM
(define-key global-map (kbd "C-z") nil)

;; Type unicode with C-x 8 <cr>
;263a☺
;;C-x 8 <cr> 263a ;☺
(global-set-key "\M-_" (lambda () (interactive) (insert "--")));; the unicode character messes up the line spacing :-/


;; Make it easier to copy to OSX clipboard
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



;; How do I undefine python-mode's py-mark-def-or-class!?
(eval-after-load "python-mode" '(define-key py-mode-map "\C-\M-h" 'backward-kill-word))


;; TRAMP
;; Should be built-in to tramp-mode:
(setq tramp-default-method "ssh")
(setq mode-line-remote
      '(:eval
        (let ((host-name
               (or (file-remote-p default-directory 'host)
                   (system-name))))
          (if (string-match "^[^0-9][^.]*\\(\\..*\\)" host-name)
              (substring host-name 0 (match-beginning 1))
            host-name))))
(defconst my-mode-line-buffer-identification
  (list
   '(:eval
     (let ((host-name
            (if (file-remote-p default-directory)
                (tramp-file-name-host
                 (tramp-dissect-file-name default-directory))
              (system-name))))
       (if (string-match "^[^0-9][^.]*\\(\\..*\\)" host-name)
           (substring host-name 0 (match-beginning 1))
         host-name)))
   ": %12b"))
(setq-default
 mode-line-buffer-identification
 my-mode-line-buffer-identification)
(add-hook
 'dired-mode-hook
 '(lambda ()
    (setq
     mode-line-buffer-identification
     my-mode-line-buffer-identification)))
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


;; Why is this not builtin?
(if (file-exists-p "~/.emacs.d/apache-mode.el")
    (load-file "~/.emacs.d/apache-mode.el")
)
(if (file-exists-p "~/.emacs.d/splode.el")
    (load-file "~/.emacs.d/splode.el")
)
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


;; Load org-mode elsewhere
(if (file-exists-p "~/.emacs.d/cmd_org.el")
     (load-file "~/.emacs.d/cmd_org.el"))


(push "~/.emacs.d/lib/markdown-mode" load-path)
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(setq auto-mode-alist
      (cons '("\\.md" . markdown-mode) auto-mode-alist))



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

;; ;; If you are reading Info in Emacs, you can select a new independent Info
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



;; M-x toggle-debug-on-error





;;(custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(cursor ((t (:background "cyan"))))
 ;; '(hl-line ((t (:background "PaleTurquoise1" :foreground "blue"))))
;;  '(region ((((class color) (min-colors 88) (background light) (type ns)) (:background "PaleTurquoise1")))))
;;)



(put 'narrow-to-region 'disabled nil)


;; ;; disable aquamacs annoyances
;; (aquamacs-autoface-mode -1) ; no mode-specific faces, everything in Monaco
;; (set-face-attribute 'mode-line nil :inherit 'unspecified) ; show modeline in Monaco
;; (set-face-attribute 'echo-area nil :family 'unspecified)  ; show echo area in Monaco
;; ;; (remove-hook 'text-mode-hook 'smart-spacing-mode)


(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;;(add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
;;(load-theme 'solarized-dark t)
;;(load-theme 'wombat)



;; ;;;;Disable theme bg in terminal (it makes me sad to need this)
;; (defun on-frame-open (frame)
;;   (if (not (display-graphic-p frame))
;;       (set-face-background 'default "unspecified-bg" frame )))
;; (add-hook 'after-make-frame-functions 'on-frame-open)



;; for 750-words
;; (add-to-list 'load-path "~/.emacs.d/wc-mode")
;; (require 'wc-mode)
;;(global-set-key "\C-cw" 'wc-mode)

(push "~/.emacs.d/lib/yaml-mode" load-path)
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

(push "/usr/local/share/emacs/site-lisp/json-mode" load-path)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(aquamacs-additional-fontsets nil t)
 '(aquamacs-customization-version-id 216 t)
 '(aquamacs-tool-bar-user-customization nil t)
 '(custom-safe-themes
   (quote
    ("cdbd0a803de328a4986659d799659939d13ec01da1f482d838b68038c1bb35e8" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "303488aa27ce49f658a7ba4035e93380421e394ec2799ae8fd952d08808c7235" "02414c4cfbbe9805b89a5ec66d3d3deb4ae1e4795ed2092eab240ca0cb79ea96" "828d47ac5f3c9c5c06341b28a1d0ebd9f0a0a9c4074504626148f36c438321c2" "3b7e62b9884f1533f8eac5d21b252e5b8098274d7d9096521db84e4f10797ae3" default)))
 '(gpm-mouse-mode nil)
 '(org-startup-indented t)
 '(sentence-end "[.?!][]\"')}]*\\($\\|     \\| \\)[
     ]*")
 '(tool-bar-mode nil))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-variable-name-face ((t nil)))
 '(highlight ((t (:background "color-17"))))
 '(mode-line ((t (:background "#222222" :foreground "white" :box (:line-width -1 :style released-button)))))
 '(mode-line-inactive ((t (:inherit mode-line :background "black" :foreground "white" :box (:line-width -1 :color "grey75") :weight light))))
 '(org-hide ((t (:foreground "black"))))
 '(org-level-1 ((t nil)))
 '(org-level-2 ((t nil)))
 '(org-level-3 ((t nil)))
 '(org-level-4 ((t nil)))
 '(org-level-5 ((t nil)))
 '(org-level-6 ((t nil)))
 '(org-level-7 ((t nil)))
 '(org-level-8 ((t nil)))
 '(region ((t (:background "color-17")))))


;; I *really* should do this properly >:-(
(require 'info)
(info-initialize)
(push "/usr/local/Cellar/org-mode/8.3.4/share/info/emacs/org-mode" Info-directory-list)
(push "/usr/local/Cellar/gawk/4.1.3_1/share/info" Info-directory-list)
