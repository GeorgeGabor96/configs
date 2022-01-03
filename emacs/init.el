(setq inhibit-startup-message t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(tooltip-mode -1)
(set-fringe-mode 10)

(menu-bar-mode -1)

;; hightlight the current line
(global-hl-line-mode 1)

(setq visible-bell t)

(set-face-attribute 'default nil :font "Fira Code Retina" :height 130)

;; Initialize package sources
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
             ("melpa-stable" . "https://stable.melpa.org/packages/")
             ("org" . "https://orgmode.org/elpa/")
             ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; Line numbers
(column-number-mode)
(global-display-line-numbers-mode t)
(dolist (mode '(org-mode-hook
        term-mode-hook
        eshell-mode-hook))
  (add-hook mode (lambda() (display-line-numbers-mode 0))))

(use-package command-log-mode)

(use-package counsel
  :bind (("M-x" . counsel-M-x)
     ("C-x b" . counsel-ibuffer)
     ("C-x C-f" . counsel-find-file)
     :map minibuffer-local-map
     ("C-r" . counsel-minibuffer-history)))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper))
  :config
  (ivy-mode 1))

(use-package all-the-icons)

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1)
  :custom ((doom-modeline-height 15)))

(use-package doom-themes
  :init (load-theme 'doom-tomorrow-night t))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package ivy-rich
  :init (ivy-rich-mode 1))

(use-package helpful
  :ensure t
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package general
  :config
  (general-create-definer rune/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (rune/leader-keys
   "t" '(:ignore t :which-key "toggles")
   "tt" '(counsel-load-theme :which-key "choose theme")))

(use-package auto-complete
  :ensure t
  :init (progn (ac-config-default) (global-auto-complete-mode t)))

;; make j - left, k - up, l - down, ; - right
;; with C for chars and rows
(global-set-key (kbd "C-;") 'forward-char)
(global-set-key (kbd "C-j") 'backward-char)
(global-set-key (kbd "C-k") 'previous-line)
(global-set-key (kbd "C-l") 'next-line)
;; with M for words and paragraphs
(global-set-key (kbd "M-;") 'forward-word)
(global-set-key (kbd "M-j") 'backward-word)
(global-set-key (kbd "M-l") 'forward-paragraph)
(global-set-key (kbd "M-k") 'backward-paragraph)
;; make C-f go to end of line
(global-set-key (kbd "C-a") 'beginning-of-line)
(global-set-key (kbd "C-f") 'end-of-line)
(global-set-key (kbd "M-a") 'beginning-of-buffer)
(global-set-key (kbd "M-f") 'end-of-buffer)

;; delete the current line
(global-set-key (kbd "C-d") 'kill-line)
(global-set-key (kbd "M-d") 'kill-whole-line)
(global-set-key (kbd "C-S-d") 'kill-word)

;; make C-w switch between windows
(global-set-key (kbd "C-w") 'other-window)

;; make C-z be the undo
(global-set-key (kbd "C-p") 'undo)

;; copy to C-i, cut to M-i, paste to C-o
(global-set-key (kbd "M-i") 'kill-region)
(global-set-key (kbd "C-i") 'kill-ring-save)
(global-set-key (kbd "C-o") 'yank)

;; make emacs start in fullscreen
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))

(setq-default c-basic-offset 4
                        tab-width 4
                        indent-tabs-mode t)

;; make tab 4 spaces in text mode
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)
;; (setq c-basic-offset 'tab-width)
;; make a right split for start
(split-window-right)

