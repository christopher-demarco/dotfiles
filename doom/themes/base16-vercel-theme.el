;;; base16-vercel-theme.el --- Vercel (Ghostty) for Emacs -*- lexical-binding: t; -*-
;;; Commentary:
;; Base16 theme generated from the Ghostty "Vercel" palette.
;;; Code:

(require 'base16-theme)

(defvar base16-vercel-theme-colors
  '(:base00 "#101010"   ; background
    :base01 "#005be7"   ; selection / lighter bg
    :base02 "#a8a8a8"   ; bright black (palette 8)
    :base03 "#d1d1d1"   ; comments (midpoint)
    :base04 "#e5e5e5"   ; dark foreground
    :base05 "#fafafa"   ; foreground
    :base06 "#fafafa"   ; selection foreground
    :base07 "#fefefe"   ; bright white (palette 15)
    :base08 "#fc0036"   ; red (palette 1)
    :base09 "#ff8080"   ; bright red / orange (palette 9)
    :base0A "#ffae00"   ; yellow (palette 3)
    :base0B "#29a948"   ; green (palette 2)
    :base0C "#00ac96"   ; cyan (palette 6)
    :base0D "#006aff"   ; blue (palette 4)
    :base0E "#f32882"   ; magenta (palette 5)
    :base0F "#f97ea8") ; bright magenta (palette 13)
  "All colors for Base16 Vercel are defined here.")

;; Define the theme
(deftheme base16-vercel)

;; Add all the faces to the theme
(base16-theme-define 'base16-vercel base16-vercel-theme-colors)

;; Mark the theme as provided
(provide-theme 'base16-vercel)

(provide 'base16-vercel-theme)
;;; base16-vercel-theme.el ends here
