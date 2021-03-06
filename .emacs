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
 '(custom-enabled-themes (quote (wombat)))
 '(ecb-options-version "2.40")
 '(ecb-primary-secondary-mouse-buttons (quote mouse-1--mouse-2))
 '(show-paren-mode t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Courier New" :foundry "outline" :slant normal :weight normal :height 151 :width normal)))))

(dolist (charset '(kana han symbol cjk-misc bopomofo))
(set-fontset-font (frame-parameter nil 'font)
charset
(font-spec :family "Microsoft Yahei" :size 18)))

(let ((class '((class color) (min-colors 89))))
  (custom-set-faces
   `(default ((,class (:background "#242424" :foreground "#f6f3e8"))))
   `(cursor ((,class (:background "#656565"))))
   ;; Highlighting faces
   `(highlight ((,class (:background "Black" :foreground nil
			 :underline nil))))))

(load-file "~/.emacs.d/htmlize.el")

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


;(setq y "org")
(defun mycompile()
  (interactive)
  (save-buffer)
  (cond
   ((string-equal ".org" (substring (buffer-file-name) (search ".org" buffer-file-name)))
    (org-export-dispatch)
    )
   
   ((string-equal ".cpp" (substring (buffer-file-name) (search ".cpp" buffer-file-name)))
    (compile (format "g++ %s -o %s -Wall -g3" (buffer-file-name) (substring buffer-file-name 0 -4)))
    )

   ((string-equal ".c" (substring (buffer-file-name) (search ".c" buffer-file-name)))
    (compile (format "gcc %s -o %s -Wall -g3" (buffer-file-name) (substring buffer-file-name 0 -2)))
    )
   )
  )

(defun run()
  (interactive)
  (save-buffer)
  (cond 
   ((string-equal system-type "gnu/linux")
    (shell-command (format "gnome-terminal -- bash -c \"time %s; read n -1\"" (substring buffer-file-name 0 -4))))
   
   ((string-equal system-type "windows-nt")
    (shell-command (format "echo @echo off ^& %s.exe >> tmp.bat" (substring buffer-file-name 0 -4)))
    (shell-command "echo echo -------------------------------- ^& echo Process exited with return value ^%errorlevel^% ^& pause ^& exit >> tmp.bat")
    (shell-command "start tmp.bat")
    (shell-command "del tmp.bat")
    )
   )
  )

(global-set-key [f7] 'mycompile) ;;use f7 for compile
(global-set-key [f8] 'run)
(global-set-key [f9] 'gdb)

(defun split()
  (interactive)
  (delete-other-windows)
  (split-window-right)
  (enlarge-window-horizontally 22)
  (other-window 1)
  (split-window-below)
  (other-window 1)
  (other-window 1)
  (shell)
  (compile (format "g++ %s" (buffer-file-name))))
(global-set-key [f6] 'split)

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

(require 'package)
(package-initialize)
(add-to-list'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

;(setq gdb-many-windows t) ;;many windows for gdb

;(add-to-list 'load-path "G:/data/.emacs.d/paredit")
;(require 'paredit)
;(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
;(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
;(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
;(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
;(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
;(setq paredit-mode t)

(add-to-list 'load-path "~/.emacs.d/popup")
(add-to-list 'load-path "~/.emacs.d/auto-complete")
(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/auto-complete/dict")
(ac-config-default)

(add-to-list 'load-path "~/.emacs.d/yasnippet")
(require 'yasnippet)
(setq yas-snippet-dirs '("~/.emacs.d/snippets"))
(yas-global-mode 1)


;(add-to-list 'load-path "~/.emacs.d/color-theme")
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-gray30)
;(color-theme-calm-forest)

                                        ;
;(add-to-list 'load-path "~/.emacs.d/cedet")
;(load-file "~/.emacs.d/cedet/common/cedet.el")
;(global-ede-mode 1)
;(semantic-load-enable-gaudy-code-helpers)
;(global-srecode-minor-mode 1)

(add-to-list 'load-path "~/.emacs.d/ecb")
(require 'ecb)
;(ecb-activate)
(setq ecb-tip-of-the-day nil)
(setq stack-trace-on-error nil)
(setq ecb-auto-activate t)
(ecb-activate)

(load-file "~/.emacs.d/tabbar.el")
(require 'tabbar)
(tabbar-mode t)
(set-face-attribute 'tabbar-default nil
                    :family "Consolas"
                    :background "#5E5E5E"
                    :foreground "#CECECE"
                    :height 1.0
                    )
;; 设置左边按钮外观：外框框边大小和颜色
(set-face-attribute 'tabbar-button nil
                    :inherit 'tabbar-default
                    :box '(:line-width 1 :color "#5E5E5E")
                    )
;; 设置当前tab外观：颜色，字体，外框大小和颜色
(set-face-attribute 'tabbar-selected nil
                    :inherit 'tabbar-default
                    :foreground "White"
                    :background "#2E2E2E"
                    :box '(:line-width 2 :color "#2E2E2E")
                    ;; :overline "black"
                    ;; :underline "black"
                    :weight 'bold
                    )
;; 设置非当前tab外观：外框大小和颜色
(set-face-attribute 'tabbar-unselected nil
                    :inherit 'tabbar-default
                    ;:foreground "White"
                    :background "#5E5E5E"
                    :box '(:line-width 2 :color "#5E5E5E")
                    )


(defun refresh-file ()
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))
 
(global-set-key [(f5)] 'refresh-file)
(setq org-indent-mode t)

(global-set-key [apps] "    ")

;helm-emms
;(add-to-list 'load-path "G:/data/.emacs.d/helm-emms")
;(load-file "G:/data/.emacs.d/helm-emms/helm-emms.el")
;(require 'helm-emms)
;(autoload 'helm-emms "helm-emms" nil t)

;w3m
;(add-to-list 'load-path "G:/data/.emacs.d/w3m-el")
;(require 'w3m-load) 
;(add-to-list 'exec-path "G:/data/.emacs.d/w3m")
;(require 'w3m)

(add-to-list 'load-path "~/.emacs.d/smex")
(require 'smex)
(smex-initialize)
(global-set-key(kbd "M-x") 'smex)
(global-set-key(kbd "M-X") 'smex-major-mode-commands)
;;This is your old M-x.
(global-set-key(kbd "C-c C-c M-x") 'execute-extended-command)

;(add-to-list 'load-path "D:/data/.emacs.d/flycheck")
;(require 'flycheck)

(add-to-list 'load-path "~/.emacs.d/powerline")
(require 'powerline)
(powerline-default-theme)


(defun display-buffer-at-bottom--display-buffer-at-bottom-around (orig-fun &rest args)
  "Bugfix for ECB: cannot use `display-buffer-at-bottom', call
`display-buffer-use-some-window' instead in ECB frame."
  (if (and ecb-minor-mode (equal (selected-frame) ecb-frame))
      (apply 'display-buffer-use-some-window args)
    (apply orig-fun args)))
(advice-add 'display-buffer-at-bottom :around #'display-buffer-at-bottom--display-buffer-at-bottom-around)

