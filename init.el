(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector (vector "#c5c8c6" "#cc6666" "#b5bd68" "#f0c674" "#81a2be" "#b294bb" "#8abeb7" "#1d1f21"))
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(column-number-mode t)
 '(custom-safe-themes (quote ("fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" default)))
 '(delete-selection-mode t)
 '(fci-rule-color "#282a2e")
 '(hl-paren-colors (quote ("#d54e53" "#e78c45" "#e7c547" "#b9ca4a" "#70c0b1" "#7aa6da" "#c397d8")))
 '(inhibit-startup-screen t)
 '(initial-scratch-message nil)
 '(scroll-bar-mode nil)
 '(current-language-environment "UTF-8")
 '(tool-bar-mode nil))

;; Fix the PATH variable
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

(when window-system (set-exec-path-from-shell-PATH))

;; Package.el customization
(package-initialize)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives 
  '("marmalade" . "http://marmalade-repo.org/packages/"))

;; PLUGINS

;; Line numbers
(global-linum-mode t)

;; Vim-mode (Evil-mode)
;; (require 'evil)
;; (require 'evil-paredit)
;; (evil-mode 1)
;; (setq evil-default-cursor t)

;; Textmate mode
;; (require 'textmate)                     
;; (textmate-mode)

;; web-mode
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xhtml?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.htm?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php?\\'" . web-mode))

;; Paredit
(add-hook 'clojure-mode-hook 'paredit-mode)
;;(add-hook 'nrepl-mode-hook 'paredit-mode)
;(add-hook 'clojure-mode-hook 'rainbow-delimiters-mode)
(highlight-parentheses-mode t)
(add-hook 'clojure-mode-hook 'highlight-parentheses-mode)

;; Nrepl
;; (setenv "PATH" (concat (getenv "HOME") "/bin:" (getenv "PATH")))
;; (setq exec-path (cons "~/bin" exec-path))
;; (add-hook 'nrepl-interaction-mode-hook 'nrepl-turn-on-eldoc-mode)
;; (setq nrepl-popup-stacktraces nil)
;; (add-to-list 'same-window-buffer-names "*nrepl*") 
;; (add-hook 'nrepl-mode-hook 'paredit-mode) 

;; Super Tab
(require 'smart-tab)
(global-smart-tab-mode 1)

;; Relative line numbers
;; (require 'linum-relative)
;; (set-face-foreground 'linum-relative-current-face nil)
;; (set-face-background 'linum-relative-current-face nil)

;; APPEARENCE

;; Set color-theme
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)     
     ;; (color-theme-sanityinc-tomorrow-night)
     ;; (color-theme-sanityinc-tomorrow-bright)
     ;; (color-theme-sanityinc-tomorrow-blue)
     ;; (color-theme-sanityinc-tomorrow-eighties)
     (color-theme-solarized-dark)
     ;; (color-theme-solarized-light)
     ))

(set-face-attribute 'default nil :height 120 :font "Monaco")

(setq-default indent-tabs-mode nil)
(setq tab-width 2)
(setq-default truncate-lines t)

;; Set parentheses color
(defface esk-paren-face
   '((((class color) (background dark))
      (:foreground "grey40"))
     (((class color) (background light))
      (:foreground "grey55")))
   "Face used to dim parentheses."
   :group 'starter-kit-faces)

(font-lock-add-keywords 'clojure-mode
                        '(("(\\|)" . 'esk-paren-face)))

;; WHITESPACES
;; (require 'whitespace)
;; (add-hook 'after-save-hook 'whitespace-cleanup)
;; (setq whitespace-line-column 90)
;; highlight trainling spaces, empty lines and etc
;; (setq whitespace-style '(face empty tabs lines-tail trailing))
;; (global-whitespace-mode t)
(define-key global-map (kbd "RET") 'newline-and-indent)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;start emacs deamon
(server-force-delete)
(server-start)
;; quiet, please! No dinging!
(setq visible-bell 'top-bottom)
(setq ring-bell-function `(lambda ()))

;; Helm!
;;(helm-mode 1)                           
;;(global-set-key (kbd "M-SPC") 'helm-mini)

;; Cider (previous nrepl) setup 
(require 'cider)
(setq nrepl-hide-special-buffers t)
(setq cider-repl-pop-to-buffer-on-connect nil)
(setq cider-repl-display-in-current-window t)
(add-hook 'cider-repl-mode-hook 'paredit-mode)

;; Auto completion stuff
(require 'auto-complete-config)
(ac-config-default)

(require 'ac-nrepl)
(add-hook 'cider-repl-mode-hook 'ac-nrepl-setup)
(add-hook 'cider-mode-hook 'ac-nrepl-setup)
(eval-after-load "auto-complete"
  '(add-to-list 'ac-modes 'cider-repl-mode))

(defun set-auto-complete-as-completion-at-point-function ()
  (setq completion-at-point-functions '(auto-complete)))

(add-hook 'auto-complete-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-repl-mode-hook 'set-auto-complete-as-completion-at-point-function)
(add-hook 'cider-mode-hook 'set-auto-complete-as-completion-at-point-function)

(define-key cider-mode-map (kbd "C-c C-d") 'ac-nrepl-popup-doc)

(global-set-key [next] 'previous-buffer)
(global-set-key [prior] 'previous-buffer)

;; For Java development requires eclipse and eclimd 
(require 'eclim)
(global-eclim-mode)
(require 'eclimd)

(require 'ac-emacs-eclim-source)
(ac-emacs-eclim-config)

(require 'company)
(require 'company-emacs-eclim)
(company-emacs-eclim-setup)
(global-company-mode t)

(require 'ido)
(ido-mode t)
