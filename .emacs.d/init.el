;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; Decision OS
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
      ;; Set cask
      (require 'cask "~/.cask/cask.el")
      (cask-initialize)
      )
  (message "This platform is not cygwin")
  )
(if (eq sysname 'darwin)
    ;; Share the clipboard
    (progn
      (defun copy-from-osx ()
	(shell-command-to-string "pbpaste"))
      (defun paste-to-osx (text &optional push)
	(let ((process-connection-type nil))
	  (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
	    (process-send-string proc text)
	    (process-send-eof proc))))
      (setq interprogram-cut-function 'paste-to-osx)
      (setq interprogram-paste-function 'copy-from-osx)
      ;; Set cask
      (require 'cask)
      (cask-initialize)
      )
  (message "This platform is not mac")
  )

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
;; Python
(use-package jedi-core
  :config (setq jedi:complete-on-dot t)
          (setq jedi:use-shortcuts t)
          (add-hook 'python-mode-hook 'jedi:setup)
          (add-to-list 'company-backends 'company-jedi))
(use-package py-autopep8
  :config (add-hook 'python-mode-hook 'py-autopep8-enable-on-save))
(use-package flymake-python-pyflakes
  :config (flymake-mode t)
          (add-hook 'python-mode-hook 'flymake-python-pyflakes-load))
;; Nyan mode
(use-package nyan-mode
  :init (nyan-mode 1))
