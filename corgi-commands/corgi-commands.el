;;; corgi-commands.el --- Custom commands included with Corgi
;;
;; Filename: corgi-commands.el
;; Package-Requires: ()
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;;; Commentary:
;;
;; Commands that are not available in vanilla emacs, and that are not worth
;; pulling in a separate package to provide them. These should eventually end up
;; in their own utility package, we do not want too much of this stuff directly
;; in the emacs config.
;;
;;; Code:

(require 'seq)

(defun corgi/switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer))))

(defun corgi/switch-to-last-elisp-buffer ()
  (interactive)
  (when-let ((the-buf (seq-find (lambda (b)
                                  (with-current-buffer b
                                    (derived-mode-p 'emacs-lisp-mode)))
                                (buffer-list))))
    (pop-to-buffer the-buf)))

(defun corgi/double-columns ()
  "Simplified version of spacemacs/window-split-double-column"
  (interactive)
  (delete-other-windows)
  (let* ((previous-files (seq-filter #'buffer-file-name
                                     (delq (current-buffer) (buffer-list)))))
    (set-window-buffer (split-window-right)
                       (or (car previous-files) "*scratch*"))
    (balance-windows)))

(defun corgi/open-init-el ()
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory)))

(defun corgi/open-bindings ()
  (interactive)
  (find-file (expand-file-name "corgi-bindings.el" user-emacs-directory)))

(defun corgi/emulate-tab ()
  "Emulates pressing <tab>, used for binding to TAB for tab key
support in terminals."
  (let ((cmd (key-binding (kbd "<tab>"))))
    (when (commandp cmd)
      (call-interactively cmd))))

(provide 'corgi-commands)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; corgi-commands.el ends here
