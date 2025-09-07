(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org"   . "https://orgmode.org/elpa/")
			 ("elpa"  . "https://elpa.gnu.org/packages/")))
(setq package-enable-at-startup nil)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(set-face-attribute 'default nil :font "Mononoki Nerd Font" :height 120)

(setq make-backup-files nil)
(setq auto-save-default nil)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(column-number-mode)
(global-set-key (kbd "C-=") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)
(defalias 'yes-or-no-p 'y-or-n-p)
(electric-pair-mode 1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode 0)
(setq frame-resize-pixelwise t)
(setq window-resize-pixelwise t)
(global-display-line-numbers-mode 1)
(global-visual-line-mode t)
(global-hl-line-mode t)
(add-to-list 'default-frame-alist '(internal-border-width . 10))
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror)


(add-to-list 'default-frame-alist '(alpha . (95 . 95)))
(setq inhibit-startup-message t)
(setq use-dialog-box nil)


(use-package doom-themes
	     :config
	     (setq doom-themes-enable-bold t
		   doom-themes-enable-italic t)
	     (load-theme 'doom-gruvbox t)
	     (doom-themes-visual-bell-config)
	     (doom-themes-neotree-config)
	     (setq doom-themes-treemacs-theme "doom-gruvbox") ; use "doom-colors" for less minimal icon theme
	     (doom-themes-treemacs-config)
	     (doom-themes-org-config))
(setq doom-theme 'doom-gruvbox)
(with-eval-after-load 'evil
		      (setq evil-normal-state-tag   nil
			    evil-emacs-state-tag    nil
			    evil-insert-state-tag   nil
			    evil-motion-state-tag   nil
			    evil-visual-state-tag   nil
			    evil-operator-state-tag nil))

(use-package evil
	     :init
	     (setq evil-want-integration t)
	     (setq evil-want-keybinding nil)
	     (setq evil-vsplit-window-right t)
	     (setq evil-split-window-below t)
	     (evil-mode))
(use-package evil-collection
	     :after evil
	     :config
	     (setq evil-collection-mode-list '(dashboard dired ibuffer))
	     (evil-collection-init))

(use-package marginalia
	     :init
	     (marginalia-mode))

(use-package company
  :hook (after-init . global-company-mode))

;; notes
(use-package org-roam
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/notes")
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert))
  :config
  (org-roam-setup))

;; Language Servers
(require 'eglot)
;C/C++
(add-to-list 'eglot-server-programs '((c++-mode c-mode) "clangd"))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)
(add-hook 'go-mode-hook 'eglot-ensure)
