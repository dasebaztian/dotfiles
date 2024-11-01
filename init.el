;; Mi config de emacs
(setq inhibit-startup-message t)

(defun l ()
  (interactive)
  (load-file (expand-file-name "init.el" user-emacs-directory)))


(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

(global-display-line-numbers-mode +1)
(set-frame-font "JetBrainsMono Nerd Font 15" nil t)

;; MELPA
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

;; refresh repo (only when needed)
(when (not package-archive-contents)
  (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

;; Backup files in other direcoty
(setq auto-save-file-name-transforms
  `((".*" "~/.emacs.d/saves/" t)))

(setq backup-directory-alist '(("." . "~/.emacs.d/saves/")))

(require 'display-line-numbers)
;; Keybinding
(global-set-key (kbd "C-<") 'shrink-window-horizontally)
(global-set-key (kbd "C->") 'enlarge-window-horizontally)

(global-set-key (kbd "S-C-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")  'shrink-window)
(global-set-key (kbd "S-C-<up>")    'enlarge-window)

(global-set-key (kbd "C-M-k") 'windmove-up)
(global-set-key (kbd "C-M-j") 'windmove-down)
(global-set-key (kbd "C-M-l") 'windmove-right)
(global-set-key (kbd "C-M-h") 'windmove-left)

(global-set-key (kbd "C-M-k") 'kill-current-buffer)
(global-set-key (kbd "C-M-y") 'link-hint-copy-link)
(global-set-key [C-tab] 'next-buffer)
(global-set-key (kbd "C-<return>") 'term)

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(setq web-mode-enable-auto-pairing t)


(require 'ox-reveal)
(setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")

