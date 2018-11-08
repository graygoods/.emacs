
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ecb-options-version "2.40"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight normal :height 151 :width normal)))))

(require 'linum)
(global-linum-mode t) ;;line num

(setq-default indent-tabs-mode nil) 
(setq c-basic-offset 4)
(setq default-tab-width 4) ;;tab width

(require 'generic-x)
(require 'electric)
(electric-pair-mode t)
(electric-layout-mode  t)
(electric-indent-mode t) ;;electric pair

(show-paren-mode t)
(setq show-paren-style 'parenthesis) ;;show paren

(require 'hl-line)
(global-hl-line-mode t) ;;high light line

(defun mycompile()
  (interactive)
  (save-buffer)
  (compile (format "g++ %s -g"(buffer-file-name)))
  )
(global-set-key [f7] 'mycompile) ;;use f7 for compile
(global-set-key [f8] 'shell)
(global-set-key [f9] 'gdb)

;;set transparent effect
(global-set-key [(f4)] 'loop-alpha)
(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))
(defun loop-alpha ()
  (interactive)
  (let ((h (car alpha-list)))                ;; head value will set to
    ((lambda (a ab)
       (set-frame-parameter (selected-frame) 'alpha (list a ab))
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ) (car h) (car (cdr h)))
    (setq alpha-list (cdr (append alpha-list (list h))))
    )
  )

(setq gdb-many-windows t) ;;many windows for gdb

(add-to-list 'load-path "~/.emacs.d/auto-complete")
(add-to-list 'load-path "~/.emacs.d/popup")
(require 'auto-complete)
(require 'auto-complete-config)

(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
(ac-config-default)

(defun my-ac-config ()
  (setq ac-clang-flags
	(mapcar(lambda (item)(concat "-I" item))
	       (split-string
		C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/include/c++
		C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/include/c++/x86_64-w64-mingw32
		C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/include/c++/backward
		C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/include
		C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/../../../../include
		C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/include-fixed
		C:/Program Files (x86)/Dev-Cpp/MinGW64/bin/../lib/gcc/x86_64-w64-mingw32/4.9.2/../../../../x86_64-w64-mingw32/include
		))))

(add-to-list 'load-path "~/.emacs.d/color-theme")
(require 'color-theme)
(color-theme-initialize)
(color-theme-gray30)
;(color-theme-calm-forest)

;;(add-to-list 'load-path "~/.emacs.d/ecb")
;;(require 'ecb)
;;(global-set-key [f11] 'ecb-activate)

(defun refresh-file ()
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))
 
(global-set-key [(f5)] 'refresh-file)

(defun split()
  (interactive)
  (delete-other-windows)
  (split-window-right)
  (enlarge-window-horizontally 15)
  (other-window 1)
  (split-window-below)
  (other-window 1)
  (other-window 1)
  (shell)
  (compile (format "g++ %s" (buffer-file-name)))
  (enlarge-window 8)
  (split-window-below)
  (split-window-right)
  (find-file (format "in.in"))
  (other-window 1)
  (find-file (format "out.out")))
(global-set-key [f6] 'split)



