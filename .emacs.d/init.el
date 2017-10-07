;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; 言語を日本語にする
(set-language-environment 'Japanese)
;; 極力UTF-8とする
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
;; shellの文字化けを回避
(add-hook 'shell-mode-hook(lambda ()(set-buffer-process-coding-system 'utf-8-unix 'utf-8-unix)))
;; メニューバーを表示しない
(menu-bar-mode -1)
;; OS判定
(setq sysname system-type)

(if (eq sysname 'cygwin)
    ;; クリップボードの共有
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
      ;; caskの設定
      (require 'cask "~/.cask/cask.el")
      (cask-initialize)
      )
  (message "This platform is not cygwin")
  )
(if (eq sysname 'darwin)
    ;; クリップボードの共有
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
      ;; caskの設定
      (require 'cask)
      (cask-initialize)
      )
  (message "This platform is not mac")
  )

(use-package nyan-mode
  :init (nyan-mode 1))
