;;; test-ghostty.el --- Tests for ghostty-import-theme -*- lexical-binding: t; -*-
;;; Commentary:
;; ERT tests for the Ghostty theme importer.
;;; Code:

(require 'ert)

(defvar test-ghostty--sunset-drive-input
  "palette = 0=#0a0a13
palette = 1=#ff0063
palette = 2=#00f992
palette = 3=#ffe900
palette = 4=#00a4ff
palette = 5=#ff57fd
palette = 6=#00ffed
palette = 7=#ededff
palette = 8=#3e3e4b
palette = 9=#ff948b
palette = 10=#00fcb9
palette = 11=#ffff68
palette = 12=#3ea0ff
palette = 13=#ff93ff
palette = 14=#38ffff
palette = 15=#f8f8ff
background = #0f0f1a
foreground = #ededfe
cursor-color = #ededfe
cursor-text = #0f0f1a
selection-background = #202036
selection-foreground = #ededff
"
  "Raw content of the Ghostty Sunset Drive theme file.")

(ert-deftest ghostty--parse-theme-test ()
  "Parsing Sunset Drive should extract all palette and UI colors."
  (let ((parsed (ghostty--parse-theme test-ghostty--sunset-drive-input)))
    (should (equal (alist-get 'background parsed) "#0f0f1a"))
    (should (equal (alist-get 'foreground parsed) "#ededfe"))
    (should (equal (alist-get 'selection-background parsed) "#202036"))
    (should (equal (alist-get 'selection-foreground parsed) "#ededff"))
    (should (equal (alist-get 0 parsed) "#0a0a13"))
    (should (equal (alist-get 1 parsed) "#ff0063"))
    (should (equal (alist-get 8 parsed) "#3e3e4b"))
    (should (equal (alist-get 15 parsed) "#f8f8ff"))))

(ert-deftest ghostty--color-midpoint-test ()
  "Midpoint of two colors should average each RGB channel (floor division)."
  (should (equal (ghostty--color-midpoint "#000000" "#ffffff") "#7f7f7f"))
  (should (equal (ghostty--color-midpoint "#abcdef" "#abcdef") "#abcdef"))
  (should (equal (ghostty--color-midpoint "#3e3e4b" "#ededfe") "#9595a4")))

(ert-deftest ghostty--map-base16-colors-test ()
  "Mapping Sunset Drive parsed data should produce the expected base16 palette."
  (let* ((parsed (ghostty--parse-theme test-ghostty--sunset-drive-input))
         (colors (ghostty--map-base16-colors parsed)))
    ;; Direct mappings
    (should (equal (plist-get colors :base00) "#0f0f1a"))   ; background
    (should (equal (plist-get colors :base01) "#202036"))   ; selection-background
    (should (equal (plist-get colors :base02) "#3e3e4b"))   ; palette 8
    (should (equal (plist-get colors :base05) "#ededfe"))   ; foreground
    (should (equal (plist-get colors :base06) "#ededff"))   ; selection-foreground
    (should (equal (plist-get colors :base07) "#f8f8ff"))   ; palette 15
    ;; Interpolated
    (should (equal (plist-get colors :base03) "#9595a4"))   ; midpoint(palette 8, fg)
    (should (equal (plist-get colors :base04) "#c1c1d1"))   ; midpoint(base03, fg)
    ;; Palette accent colors
    (should (equal (plist-get colors :base08) "#ff0063"))   ; palette 1
    (should (equal (plist-get colors :base09) "#ff948b"))   ; palette 9
    (should (equal (plist-get colors :base0A) "#ffe900"))   ; palette 3
    (should (equal (plist-get colors :base0B) "#00f992"))   ; palette 2
    (should (equal (plist-get colors :base0C) "#00ffed"))   ; palette 6
    (should (equal (plist-get colors :base0D) "#00a4ff"))   ; palette 4
    (should (equal (plist-get colors :base0E) "#ff57fd"))   ; palette 5
    (should (equal (plist-get colors :base0F) "#ff93ff")))  ; palette 13
  )

(ert-deftest ghostty--theme-slug-test ()
  "Theme name slugification."
  (should (equal (ghostty--theme-slug "Sunset Drive") "sunset-drive"))
  (should (equal (ghostty--theme-slug "Dracula") "dracula"))
  (should (equal (ghostty--theme-slug "3024 Night") "3024-night")))

(ert-deftest ghostty--generate-theme-elisp-test ()
  "Generated elisp for Sunset Drive should match the reference file."
  (let* ((parsed (ghostty--parse-theme test-ghostty--sunset-drive-input))
         (colors (ghostty--map-base16-colors parsed))
         (generated (ghostty--generate-theme-elisp "Sunset Drive" colors))
         (reference (with-temp-buffer
                      (insert-file-contents
                       "/Users/cdemarco/.config/doom/themes/base16-sunset-drive-theme.el")
                      (buffer-string))))
    (should (equal generated reference))))

(provide 'test-ghostty)
;;; test-ghostty.el ends here
