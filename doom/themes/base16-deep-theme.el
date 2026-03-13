;;; base16-deep-theme.el --- Deep (Ghostty) for Emacs -*- lexical-binding: t; -*-
;;; Commentary:
;; Base16 theme generated from the Ghostty "Deep" palette.
;;; Code:

(require 'base16-theme)

(defvar base16-deep-theme-colors
  '(:base00 "#090909"   ; background
    :base01 "#780002"   ; selection / lighter bg
    :base02 "#535353"   ; bright black (palette 8)
    :base03 "#909090"   ; comments (midpoint)
    :base04 "#aeaeae"   ; dark foreground
    :base05 "#cdcdcd"   ; foreground
    :base06 "#ececec"   ; selection foreground
    :base07 "#ffffff"   ; bright white (palette 15)
    :base08 "#d70005"   ; red (palette 1)
    :base09 "#fb0007"   ; bright red / orange (palette 9)
    :base0A "#d9bd26"   ; yellow (palette 3)
    :base0B "#1cd915"   ; green (palette 2)
    :base0C "#50d2da"   ; cyan (palette 6)
    :base0D "#5665ff"   ; blue (palette 4)
    :base0E "#b052da"   ; magenta (palette 5)
    :base0F "#e09aff") ; bright magenta (palette 13)
  "All colors for Base16 Deep are defined here.")

;; Define the theme
(deftheme base16-deep)

;; Add all the faces to the theme
(base16-theme-define 'base16-deep base16-deep-theme-colors)

;; Mark the theme as provided
(provide-theme 'base16-deep)

(provide 'base16-deep-theme)
;;; base16-deep-theme.el ends here
