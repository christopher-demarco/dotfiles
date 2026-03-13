;;; ghostty.el --- Import Ghostty themes as base16 Emacs themes -*- lexical-binding: t; -*-
;;; Commentary:
;; Provides `ghostty-import-theme' to convert a Ghostty terminal theme into a
;; base16-theme compatible .el file in ~/.config/doom/themes/.
;;; Code:

(defvar ghostty-themes-directory
  "/Applications/Ghostty.app/Contents/Resources/ghostty/themes/"
  "Directory containing bundled Ghostty theme files.")

(defun ghostty--parse-theme (content)
  "Parse Ghostty theme CONTENT string into an alist.
Returns an alist with symbol keys for UI colors (background, foreground,
selection-background, selection-foreground, cursor-color) and integer keys
for palette entries 0-15."
  (let (result)
    (dolist (line (split-string content "\n" t))
      (when (string-match "\\`\\([a-z-]+\\) *= *\\(.*\\)\\'" line)
        (let ((key (match-string 1 line))
              (val (match-string 2 line)))
          (if (string= key "palette")
              (when (string-match "\\`\\([0-9]+\\)=\\(#[0-9a-fA-F]+\\)\\'" val)
                (push (cons (string-to-number (match-string 1 val))
                            (downcase (match-string 2 val)))
                      result))
            (push (cons (intern key) (downcase val)) result)))))
    result))

(defun ghostty--color-midpoint (c1 c2)
  "Return the RGB midpoint of hex colors C1 and C2 (e.g. \"#aabbcc\")."
  (let ((r1 (string-to-number (substring c1 1 3) 16))
        (g1 (string-to-number (substring c1 3 5) 16))
        (b1 (string-to-number (substring c1 5 7) 16))
        (r2 (string-to-number (substring c2 1 3) 16))
        (g2 (string-to-number (substring c2 3 5) 16))
        (b2 (string-to-number (substring c2 5 7) 16)))
    (format "#%02x%02x%02x" (/ (+ r1 r2) 2) (/ (+ g1 g2) 2) (/ (+ b1 b2) 2))))

(defun ghostty--map-base16-colors (parsed)
  "Map PARSED Ghostty alist to a base16 color plist.
PARSED is the alist returned by `ghostty--parse-theme'."
  (let* ((bg   (alist-get 'background parsed))
         (fg   (alist-get 'foreground parsed))
         (selbg (or (alist-get 'selection-background parsed) bg))
         (selfg (or (alist-get 'selection-foreground parsed) fg))
         (pal  (lambda (n) (alist-get n parsed)))
         (base03 (ghostty--color-midpoint (funcall pal 8) fg))
         (base04 (ghostty--color-midpoint base03 fg)))
    (list :base00 bg
          :base01 selbg
          :base02 (funcall pal 8)
          :base03 base03
          :base04 base04
          :base05 fg
          :base06 selfg
          :base07 (funcall pal 15)
          :base08 (funcall pal 1)
          :base09 (funcall pal 9)
          :base0A (funcall pal 3)
          :base0B (funcall pal 2)
          :base0C (funcall pal 6)
          :base0D (funcall pal 4)
          :base0E (funcall pal 5)
          :base0F (funcall pal 13))))

(defun ghostty--theme-slug (name)
  "Convert theme NAME to a slug: lowercase, spaces to hyphens."
  (replace-regexp-in-string " " "-" (downcase name)))

(defun ghostty--generate-theme-elisp (name colors)
  "Generate base16 theme elisp string for NAME with COLORS plist."
  (let* ((slug (ghostty--theme-slug name))
         (sym (concat "base16-" slug)))
    (concat
     (format ";;; %s-theme.el --- %s (Ghostty) for Emacs -*- lexical-binding: t; -*-\n" sym name)
     ";;; Commentary:\n"
     (format ";; Base16 theme generated from the Ghostty \"%s\" palette.\n" name)
     ";;; Code:\n"
     "\n"
     "(require 'base16-theme)\n"
     "\n"
     (format "(defvar %s-theme-colors\n" sym)
     (format "  '(:base00 \"%s\"   ; background\n" (plist-get colors :base00))
     (format "    :base01 \"%s\"   ; selection / lighter bg\n" (plist-get colors :base01))
     (format "    :base02 \"%s\"   ; bright black (palette 8)\n" (plist-get colors :base02))
     (format "    :base03 \"%s\"   ; comments (midpoint)\n" (plist-get colors :base03))
     (format "    :base04 \"%s\"   ; dark foreground\n" (plist-get colors :base04))
     (format "    :base05 \"%s\"   ; foreground\n" (plist-get colors :base05))
     (format "    :base06 \"%s\"   ; selection foreground\n" (plist-get colors :base06))
     (format "    :base07 \"%s\"   ; bright white (palette 15)\n" (plist-get colors :base07))
     (format "    :base08 \"%s\"   ; red (palette 1)\n" (plist-get colors :base08))
     (format "    :base09 \"%s\"   ; bright red / orange (palette 9)\n" (plist-get colors :base09))
     (format "    :base0A \"%s\"   ; yellow (palette 3)\n" (plist-get colors :base0A))
     (format "    :base0B \"%s\"   ; green (palette 2)\n" (plist-get colors :base0B))
     (format "    :base0C \"%s\"   ; cyan (palette 6)\n" (plist-get colors :base0C))
     (format "    :base0D \"%s\"   ; blue (palette 4)\n" (plist-get colors :base0D))
     (format "    :base0E \"%s\"   ; magenta (palette 5)\n" (plist-get colors :base0E))
     (format "    :base0F \"%s\") ; bright magenta (palette 13)\n" (plist-get colors :base0F))
     (format "  \"All colors for Base16 %s are defined here.\")\n" (capitalize-first-in-words name))
     "\n"
     ";; Define the theme\n"
     (format "(deftheme %s)\n" sym)
     "\n"
     ";; Add all the faces to the theme\n"
     (format "(base16-theme-define '%s %s-theme-colors)\n" sym sym)
     "\n"
     ";; Mark the theme as provided\n"
     (format "(provide-theme '%s)\n" sym)
     "\n"
     (format "(provide '%s-theme)\n" sym)
     (format ";;; %s-theme.el ends here\n" sym))))

(defun capitalize-first-in-words (s)
  "Capitalize the first letter of each word in S."
  (mapconcat #'capitalize (split-string s " ") " "))

;;;###autoload
(defun ghostty-import-theme (name)
  "Import the Ghostty theme NAME as a base16 Emacs theme.
Reads from `ghostty-themes-directory', generates a base16 theme file
in ~/.config/doom/themes/, and reports the theme symbol to use."
  (interactive
   (list (completing-read
          "Ghostty theme: "
          (directory-files ghostty-themes-directory nil "^[^.]"))))
  (let* ((path (expand-file-name name ghostty-themes-directory))
         (content (with-temp-buffer
                    (insert-file-contents path)
                    (buffer-string)))
         (parsed (ghostty--parse-theme content))
         (colors (ghostty--map-base16-colors parsed))
         (slug (ghostty--theme-slug name))
         (sym (concat "base16-" slug))
         (out-file (expand-file-name
                    (concat sym "-theme.el")
                    "~/.config/doom/themes/")))
    (with-temp-file out-file
      (insert (ghostty--generate-theme-elisp name colors)))
    (message "Wrote %s — use (setq doom-theme '%s)" out-file sym)))

(provide 'ghostty)
;;; ghostty.el ends here
