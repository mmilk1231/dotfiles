;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
;; Do not check signature because of failure to verify signature
(setq package-check-signature nil)
;; Set cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)
;; Recognition OS
(setq sysname system-type)
;; Take over path from shell
(use-package exec-path-from-shell
  :if (memq window-system '(mac ns))
  :ensure t
  :config (exec-path-from-shell-initialize))
;; Bash completion
(use-package bash-completion
  :defer t
  :init (add-hook 'shell-dynamic-complete-functions 'bash-completion-dynamic-complete))
;; Company mode
(use-package company
  :defer t
  :init (add-hook 'after-init-hook 'global-company-mode))
;; Set the language to Japanese
(set-language-environment 'Japanese)
;; Use utf-8
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; Avoid text garbling in the shell
(add-hook 'shell-mode-hook(lambda ()(set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))
;; Do not show menubar
(menu-bar-mode -1)
;; Show line number
(when (version<= "26.0.50" emacs-version )
  (global-display-line-numbers-mode t))
;; Color theme
(use-package base16-theme
  :ensure t
  :config
  (load-theme 'base16-github t))
;; Disable Git pager
(setenv "GIT_PAGER" "nkf -w|colordiff")
;; Auto-complete (Python)
(use-package company-quickhelp
  :config (company-quickhelp-mode 1))
(use-package jedi-core
  :defer t
  :init (progn(add-hook 'python-mode-hook 'jedi:setup)
	      (add-to-list 'company-backends 'company-jedi))
  :config (progn(setq jedi:complete-on-dot t)
		(setq jedi:use-shortcuts t)))
;; Highlight simbol
;(use-package highlight-symbol
;  :ensure t
;  :defer t
;  :bind (("\M-n" . highlight-symbol-next)
;         ("\M-p" . highlight-symbol-prev)
;	 ("\C-x\C-a" . 'highlight-symbol-query-replace))
;  :init (add-hook 'prog-mode-hook 'highlight-symbol-mode)
;  :config (setq highlight-symbol-idle-delay 0))
(use-package auto-highlight-symbol
  :ensure t
  :defer t
  :init (add-hook 'prog-mode-hook 'auto-highlight-symbol-mode)
  :config (progn(setq ahs-default-range 'ahs-range-whole-buffer)
		(setq ahs-idle-interval 0)))
;; Highlight annotation comment
(use-package fic-mode
  :ensure t
  :defer t
  :init (add-hook 'prog-mode-hook '(lambda() (fic-mode t))))
;; Markdown
(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
	 ("\\.md\\'" . markdown-mode)
	 ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
;; LaTeX
(use-package auctex
  :ensure t
  :init (setq-default TeX-master nil)
  :mode ("\\.tex\\'" . latex-mode))
(use-package auctex-latexmk
  :ensure t
  :init (progn(add-hook 'LaTeX-mode-hook '(lambda () (setq TeX-command-default "LatexMk")))
              (add-hook 'latex-mode-hook '(lambda () (setq TeX-command-default "LatexMk"))))
  :config (auctex-latexmk-setup))
(use-package reftex
  :ensure t
  :init (progn(setq reftex-plug-into-AUCTeX t)
              (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
              (add-hook 'latex-mode-hook 'turn-on-reftex)))
(use-package server
  :ensure t
  :defer t
  :config (unless (server-running-p) (server-start)))
;; treemacs
(use-package treemacs
  :ensure t
  :defer t)
;; flycheck
(use-package flycheck
  :defer t
  :init (progn(add-hook 'python-mode-hook 'flycheck-mode)
	      (add-hook 'text-mode-hook 'flycheck-mode)
	      (add-hook 'markdown-mode-hook 'flycheck-mode)
	      (add-hook 'gfm-mode-hook 'flycheck-mode)
	      (add-hook 'latex-mode-hook 'flycheck-mode)
	      (add-hook 'LaTeX-mode-hook 'flycheck-mode))
;  :config (progn
;	    (flycheck-define-checker
;	     link-grammar "link-grammar check"
;	     :command ("linkgrammarengchkfile" source-inplace)
;	     :error-patterns ((warning line-start (file-name) ":" line ":" column ": "
;				       (id (one-or-more (not (any " "))))
;				       (message) line-end))
;	     :modes (text-mode markdown-mode gfm-mode latex-mode LaTeX-mode))
;	    (add-to-list 'flycheck-checkers 'link-grammar)
;	    (flycheck-define-checker
;	     proselint "A linter for prose."
;	     :command ("proselint" source-inplace)
;	     :error-patterns ((warning line-start (file-name) ":" line ":" column ": "
;				       (id (one-or-more (not (any " "))))
;				       (message) line-end))
;	     :modes (text-mode markdown-mode gfm-mode latex-mode LaTeX-mode))
;	    (add-to-list 'flycheck-checkers 'proselint))
)
(use-package flycheck-color-mode-line
  :defer t
  :init (eval-after-load "flycheck"
	    '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode)))
(use-package flycheck-popup-tip
  :defer t
  :init (eval-after-load "flycheck"
	    '(add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode)))
;; Nyan mode
(use-package nyan-mode
  :config (nyan-mode 1))
;; Settings depending on OS
(if (eq sysname 'cygwin)
    (progn
      ;; Share the clipboard
      (defun paste-from-cygwin ()
	(with-temp-buffer
	  (insert-file-contents "/dev/clipboard")
	  (buffer-string)))
      (defun cut-to-cygwin (text &optional push)
	(with-temp-file "/dev/clipboard"
	  (insert text)))
      (setq interprogram-cut-function 'cut-to-cygwin)
      (setq interprogram-paste-function 'paste-from-cygwin)
      )
  (message "This platform is not cygwin")
  )
(if (eq sysname 'darwin)
    (progn
      ;; Share the clipboard
      (defun copy-from-osx ()
	(shell-command-to-string "reattach-to-user-namespace pbpaste"))
      (defun paste-to-osx (text &optional push)
	(let ((process-connection-type nil))
	  (let ((proc (start-process "pbcopy" "*Messages*" "reattach-to-user-namespace" "pbcopy")))
	    (process-send-string proc text)
	    (process-send-eof proc))))
      (setq interprogram-cut-function 'paste-to-osx)
      (setq interprogram-paste-function 'copy-from-osx)
      ;; LaTeX
      (setq TeX-view-program-selection
            '((output-dvi "Skim")
	      (output-pdf "Skim")))
      (setq TeX-view-program-list
	    '(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %s.pdf %b")))
      )
  (message "This platform is not mac")
  )
(if (eq sysname 'gnu/linux)
    (progn
      ;; Share the clipboard
      (setq x-select-enable-clipboard t)
      (setq x-select-enable-primary t)
      (use-package xclip
	:config (xclip-mode t))
      )
  (message "This platform is not linux")
  )
