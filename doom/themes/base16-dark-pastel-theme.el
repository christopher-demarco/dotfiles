;;; base16-dark-pastel-theme.el --- Dark Pastel (Ghostty) for Emacs -*- lexical-binding: t; -*-
;;; Commentary:
;; Base16 theme generated from the Ghostty "Dark Pastel" palette.
;;; Code:

(require 'base16-theme)

(defvar base16-dark-pastel-theme-colors
  '(:base00 "#000000"   ; background
    :base01 "#b5d5ff"   ; selection / lighter bg
    :base02 "#555555"   ; bright black (palette 8)
    :base03 "#aaaaaa"   ; comments (midpoint)
    :base04 "#d4d4d4"   ; dark foreground
    :base05 "#ffffff"   ; foreground
    :base06 "#000000"   ; selection foreground
    :base07 "#ffffff"   ; bright white (palette 15)
    :base08 "#ff5555"   ; red (palette 1)
    :base09 "#ff5555"   ; bright red / orange (palette 9)
    :base0A "#ffff55"   ; yellow (palette 3)
    :base0B "#55ff55"   ; green (palette 2)
    :base0C "#55ffff"   ; cyan (palette 6)
    :base0D "#5555ff"   ; blue (palette 4)
    :base0E "#ff55ff"   ; magenta (palette 5)
    :base0F "#ff55ff") ; bright magenta (palette 13)
  "All colors for Base16 Dark Pastel are defined here.")

;; Define the theme
(deftheme base16-dark-pastel)

;; Add all the faces to the theme
(base16-theme-define 'base16-dark-pastel base16-dark-pastel-theme-colors)

;; Tone down hl-line (base01 is too bright on pure black)
(custom-theme-set-faces 'base16-dark-pastel
  '(hl-line ((t (:background "#1a1a1a"))))
  '(mode-line ((t (:background "#1a1a1a"))))
  '(mode-line-inactive ((t (:background "#111111"))))
  '(minibuffer-prompt ((t (:foreground "#aaaaaa")))))

;; Mark the theme as provided
(provide-theme 'base16-dark-pastel)

(provide 'base16-dark-pastel-theme)
;;; base16-dark-pastel-theme.el ends here
