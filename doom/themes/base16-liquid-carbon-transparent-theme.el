;;; base16-liquid-carbon-transparent-theme.el --- Liquid Carbon Transparent (Ghostty) for Emacs -*- lexical-binding: t; -*-
;;; Commentary:
;; Base16 theme generated from the Ghostty "Liquid Carbon Transparent" palette.
;;; Code:

(require 'base16-theme)

(defvar base16-liquid-carbon-transparent-theme-colors
  '(:base00 "#000000"   ; background
    :base01 "#7dbeff"   ; selection / lighter bg
    :base02 "#404040"   ; bright black (palette 8)
    :base03 "#778181"   ; comments (midpoint)
    :base04 "#93a1a1"   ; dark foreground
    :base05 "#afc2c2"   ; foreground
    :base06 "#000000"   ; selection foreground
    :base07 "#bccccc"   ; bright white (palette 15)
    :base08 "#ff3030"   ; red (palette 1)
    :base09 "#ff3030"   ; bright red / orange (palette 9)
    :base0A "#ccac00"   ; yellow (palette 3)
    :base0B "#559a70"   ; green (palette 2)
    :base0C "#7ac4cc"   ; cyan (palette 6)
    :base0D "#0099cc"   ; blue (palette 4)
    :base0E "#cc69c8"   ; magenta (palette 5)
    :base0F "#cc69c8") ; bright magenta (palette 13)
  "All colors for Base16 Liquid Carbon Transparent are defined here.")

;; Define the theme
(deftheme base16-liquid-carbon-transparent)

;; Add all the faces to the theme
(base16-theme-define 'base16-liquid-carbon-transparent base16-liquid-carbon-transparent-theme-colors)

;; Mark the theme as provided
(provide-theme 'base16-liquid-carbon-transparent)

(provide 'base16-liquid-carbon-transparent-theme)
;;; base16-liquid-carbon-transparent-theme.el ends here
