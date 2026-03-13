;;; base16-sunset-drive-theme.el --- Sunset Drive (Ghostty) for Emacs -*- lexical-binding: t; -*-
;;; Commentary:
;; Base16 theme generated from the Ghostty "Sunset Drive" palette.
;;; Code:

(require 'base16-theme)

(defvar base16-sunset-drive-theme-colors
  '(:base00 "#0f0f1a"   ; background
    :base01 "#202036"   ; selection / lighter bg
    :base02 "#3e3e4b"   ; bright black (palette 8)
    :base03 "#9595a4"   ; comments (midpoint)
    :base04 "#c1c1d1"   ; dark foreground
    :base05 "#ededfe"   ; foreground
    :base06 "#ededff"   ; selection foreground
    :base07 "#f8f8ff"   ; bright white (palette 15)
    :base08 "#ff0063"   ; red (palette 1)
    :base09 "#ff948b"   ; bright red / orange (palette 9)
    :base0A "#ffe900"   ; yellow (palette 3)
    :base0B "#00f992"   ; green (palette 2)
    :base0C "#00ffed"   ; cyan (palette 6)
    :base0D "#00a4ff"   ; blue (palette 4)
    :base0E "#ff57fd"   ; magenta (palette 5)
    :base0F "#ff93ff") ; bright magenta (palette 13)
  "All colors for Base16 Sunset Drive are defined here.")

;; Define the theme
(deftheme base16-sunset-drive)

;; Add all the faces to the theme
(base16-theme-define 'base16-sunset-drive base16-sunset-drive-theme-colors)

;; Mark the theme as provided
(provide-theme 'base16-sunset-drive)

(provide 'base16-sunset-drive-theme)
;;; base16-sunset-drive-theme.el ends here
