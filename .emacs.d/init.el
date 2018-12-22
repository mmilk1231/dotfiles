;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Recognition OS
(setq sysname system-type)
(if (eq sysname 'cygwin)
    ;; Share the clipboard
    (progn
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
   ;; Share the clipboard
    (progn
      (defun copy-from-osx ()
	(shell-command-to-string "reattach-to-user-namespace pbpaste"))
      (defun paste-to-osx (text &optional push)
	(let ((process-connection-type nil))
	  (let ((proc (start-process "pbcopy" "*Messages*" "reattach-to-user-namespace" "pbcopy")))
	    (process-send-string proc text)
	    (process-send-eof proc))))
      (setq interprogram-cut-function 'paste-to-osx)
      (setq interprogram-paste-function 'copy-from-osx)
      )
  (message "This platform is not mac")
  )
(if (eq sysname 'gnu/linux)
    (progn
    )
  (message "This platform is not linux")
  )

;; Set cask
(require 'cask "~/.cask/cask.el")
(cask-initialize)
;; Company mode
(use-package company
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
;(global-linum-mode t)
(add-hook 'prog-mode-hook 'linum-mode)
(setq linum-format "%4d |")
;; Disable Git pager
(setenv "GIT_PAGER" "nkf -w|colordiff")
;; Auto-complete (Python)
(use-package company-quickhelp
  :config (company-quickhelp-mode 1))
(use-package jedi-core
  :config (setq jedi:complete-on-dot t)
          (setq jedi:use-shortcuts t)
          (add-hook 'python-mode-hook 'jedi:setup)
          (add-to-list 'company-backends 'company-jedi))
;; Code formatting (Python)
;; (use-package py-yapf
;;   :config (add-hook 'python-mode-hook 'py-yapf-enable-on-save))
;; Check syntax (Python)
(use-package flycheck
  :config (add-hook 'python-mode-hook 'flycheck-mode))
(use-package flycheck-popup-tip
  :config (add-hook 'flycheck-mode-hook 'flycheck-popup-tip-mode))
;; Highlight simbol
(use-package auto-highlight-symbol
  :config (global-auto-highlight-symbol-mode t)
          (custom-set-variables '(ahs-default-range (quote ahs-range-whole-buffer))))
;; Highlight annotation comment
(use-package fic-mode
  :config (add-hook 'prog-mode-hook '(lambda() (fic-mode t))))
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
        (setq LaTeX-command-default "latexmk")
  :mode ("\\.tex\\'" . latex-mode))
(use-package auctex-latexmk
  :ensure t
  :config (auctex-latexmk-setup)
          (setq TeX-view-program-selection
		'((output-dvi "Skim")
		  (output-pdf "Skim")))
          (setq TeX-view-program-list
		'(("Skim" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %s.pdf %b"))))
(use-package reftex
  :ensure t
  :init (setq reftex-plug-into-AUCTeX t)
        (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
        (add-hook 'latex-mode-hook 'turn-on-reftex))
(use-package server
  :ensure t
  :config (unless (server-running-p) (server-start)))
;; Nyan mode
(use-package nyan-mode
  :config (nyan-mode 1))
