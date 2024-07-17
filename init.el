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
(setq backup-directory-alist `(("." . "~/.emacs.d/saves")))

;; Scrolling
(setq scroll-conservatively 101) ;; value greater than 100 gets rid of half page jumping
(setq mouse-wheel-scroll-amount '(3 ((shift) . 3))) ;; how many lines at a time
(setq mouse-wheel-progressive-speed t) ;; accelerate scrolling

;; DOOM/Them settings

(use-package doom-modeline
  :ensure t
  :config
  (doom-modeline-mode 1))

(require 'display-line-numbers)
                                        ; this defines the modes where there aren't line numbers
(defcustom display-line-numbers-exempt-modes '(org-mode matlab-shell-mode dashboard-mode
                                                        which-key-mode vterm-mode eshell-mode
                                                        shell-mode term-mode ansi-term-mode treemacs-mode neotree-mode)
  "Major modes on which to disable the linum mode, exempts them from global requirement."
  :group 'display-line-numbers
  :type 'list
  :version "green")

(defun display-line-numbers--turn-on ()
  "Turn on line numbers but excempting certain majore modes defined in `display-line-numbers-exempt-modes'."
  (if (and
       (not (member major-mode display-line-numbers-exempt-modes))
       (not (minibufferp)))
      (display-line-numbers-mode)))

;; enable line numbers mode
(global-display-line-numbers-mode)
(set-default 'truncate-lines t)


(use-package doom-themes
  :ensure t)


(setq doom-themes-enable-bold t    ;; if nil, bold is universally disabled
      doom-themes-enable-italic t) ;; if nil, italics is universally disabled


(defun toggle-theme ()
  (interactive)
  (cond ((eq (car custom-enabled-themes) 'doom-one)
          (mapc #'disable-theme custom-enabled-themes)
          (load-theme 'doom-one-light t))
        ((eq (car custom-enabled-themes) 'doom-one-light)
          (mapc #'disable-theme custom-enabled-themes)
          (load-theme 'doom-one t))))
(global-set-key (kbd "C-x t") 'toggle-theme)
;; load this theme
(load-theme 'doom-one t)
;; Icons/Emojis

(use-package all-the-icons
  :ensure t)
(use-package emojify
  :ensure t
  :hook (after-init . global-emojify-mode))

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

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-set-heading-icons t)
  (setq dashboard-center-content t)
  (setq dashboard-set-file-icons t)
  (setq dashboard-banner-logo-title "")
  (setq dashboard-startup-banner 'logo)
  :config
  (dashboard-setup-startup-hook)
  (add-to-list 'dashboard-items '(agenda) t)
  (setq dashboard-week-agenda t)
  (setq dashboard-filter-agenda-entry 'dashboard-no-filter-agenda)
  ;; insert items (name . max_count)
  (setq dashboard-items '((recents . 15)
                          (agenda . 5)))
  
  (setq dashboard-item-shortcuts '((recents . "r")

                                 (agenda    . "a")
                                 ))
)


(use-package rainbow-mode
  :ensure t
  :hook ((python-mode . rainbow-mode)
         (web-mode . rainbow-mode)
         (LaTeX-mode . rainbow-mode)
         (shell-mode . rainbow-mode)
         (lisp-mode . rainbow-mode)
         (emacs-lisp-mode . rainbow-mode)
         (text-mode . rainbow-mode)
         (conf-unix-mode . rainbow-mode)
         (org-mode . rainbow-mode)))

  (use-package rainbow-delimiters
    :ensure t
    :hook ((org-mode . rainbow-delimiters-mode)
           (lisp-mode . rainbow-delimiters-mode)
           (emacs-lisp-mode . rainbow-delimiters-mode)))

(use-package org-bullets
  :ensure t
  :hook (org-mode . org-bullets-mode))

(add-hook 'org-mode-hook 'org-indent-mode) ;; indent headings and content 

;; create directory and files if dir doesn't exist
(unless (file-exists-p "~/org")
  (make-directory "~/org" t)
  (write-region "" nil "~/org/agenda.org"))

;; set variables
(setq org-directory "~/org/"
      org-agenda-files '("~/org/agenda.org")
      org-ellipsis " ▼ " ;; better than ...
      org-hide-emphasis-markers t        ;; hide /, * for emphasis
      org-src-preserve-indentation nil   ;; preserve indentarion when exporting code blocks
      org-src-tab-acts-natively t
      org-edit-src-content-indentation 2 ;; indent the code
      org-image-actual-width '(500)      ;; width for Org images
      org-src-fontify-natively t         ;; use native block codes
      org-confirm-babel-evaluate nil)    ;; don't ask for evaluation babel

;; start Org mode with visual-line-mode
(add-hook 'org-mode-hook 'visual-line-mode)

;; start with all headings folded (press S-TAB to unfold)
(add-hook 'org-mode-hook 'org-overview)

(setq ring-bell-function 'ignore)
(setq org-startup-with-inline-images t)
