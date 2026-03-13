;;; base16-selenized-light-theme.el --- Selenized Light (Ghostty) for Emacs -*- lexical-binding: t; -*-
;;; Commentary:
;; Base16 theme generated from the Ghostty "Selenized Light" palette.
;;; Code:

(require 'base16-theme)

(defvar base16-selenized-light-theme-colors
  '(:base00 "#fbf3db"   ; background
    :base01 "#ece3cc"   ; selection / lighter bg
    :base02 "#909995"   ; bright black (palette 8)
    :base03 "#718081"   ; comments (midpoint)
    :base04 "#627377"   ; dark foreground
    :base05 "#53676d"   ; foreground
    :base06 "#00978a"   ; selection foreground
    :base07 "#3a4d53"   ; bright white (palette 15)
    :base08 "#d2212d"   ; red (palette 1)
    :base09 "#cc1729"   ; bright red / orange (palette 9)
    :base0A "#ad8900"   ; yellow (palette 3)
    :base0B "#489100"   ; green (palette 2)
    :base0C "#009c8f"   ; cyan (palette 6)
    :base0D "#0072d4"   ; blue (palette 4)
    :base0E "#ca4898"   ; magenta (palette 5)
    :base0F "#c44392") ; bright magenta (palette 13)
  "All colors for Base16 Selenized Light are defined here.")

;; Define the theme
(deftheme base16-selenized-light)

;; Add all the faces to the theme
(base16-theme-define 'base16-selenized-light base16-selenized-light-theme-colors)

;; Mark the theme as provided
(provide-theme 'base16-selenized-light)

(provide 'base16-selenized-light-theme)
;;; base16-selenized-light-theme.el ends here
