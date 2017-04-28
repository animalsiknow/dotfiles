;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs-base
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '("~/.spacemacs-layers")
   dotspacemacs-configuration-layers
   '((auto-completion :variables
                      auto-completion-return-key-behavior nil
                      auto-completion-tab-key-behavior nil
                      auto-completion-complete-with-key-sequence "jk")
     better-defaults
     emacs-lisp
     git
     helm
     idris
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     spacemacs-evil
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     syntax-checking
     version-control)
   dotspacemacs-additional-packages '()
   dotspacemacs-frozen-packages '()
   dotspacemacs-excluded-packages '(orgit)
   dotspacemacs-install-packages 'used-only))

(defun dotspacemacs/init ()
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil
   dotspacemacs-elpa-subdirectory nil
   dotspacemacs-editing-style 'vim
   dotspacemacs-verbose-loading nil
   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '((recents . 5) (projects . 7))
   dotspacemacs-startup-buffer-responsive t
   dotspacemacs-scratch-mode 'text-mode
   dotspacemacs-themes '(spacemacs-light spacemacs-dark)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("PragmataPro"
                               :size 16
                               :weight normal
                               :width normal
                               :powerline-scale 1.1)
   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-command-key "SPC"
   dotspacemacs-ex-command-key ":"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab nil
   dotspacemacs-remap-Y-to-y$ t
   dotspacemacs-retain-visual-state-on-shift t
   dotspacemacs-visual-line-move-text t
   dotspacemacs-ex-substitute-global t
   dotspacemacs-default-layout-name "default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts nil
   dotspacemacs-large-file-size 2
   dotspacemacs-auto-save-file-location 'cache
   dotspacemacs-max-rollback-slots 5
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom
   dotspacemacs-helm-use-fuzzy 'always
   dotspacemacs-enable-paste-transient-state t
   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup nil
   dotspacemacs-active-transparency 100
   dotspacemacs-inactive-transparency 100
   dotspacemacs-show-transient-state-title t
   dotspacemacs-show-transient-state-color-guide t
   dotspacemacs-mode-line-unicode-symbols t
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode t
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("rg" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed))

(defun dotspacemacs/user-init ())

(defun dotspacemacs/user-config ())

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
  This is an auto-generated function, do not modify its content directly, use
  Emacs customize menu instead.
  This function is called at the very end of Spacemacs initialization."
  (custom-set-variables
   '(package-selected-packages
     (quote
      (vi-tilde-fringe linum-relative idris-mode prop-menu evil-visual-mark-mode
       evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist
       highlight evil-numbers evil-nerd-commenter evil-mc evil-matchit
       evil-lisp-state smartparens evil-indent-plus evil-iedit-state iedit
       evil-exchange evil-ediff evil-args evil-anzu anzu xterm-color which-key
       use-package unfill smeargle shell-pop pcre2el mwim multi-term
       magit-gitflow macrostep hydra help-fns+ helm-themes helm-swoop
       helm-projectile helm-mode-manager helm-make helm-gitignore helm-flx
       helm-descbinds helm-company helm-c-yasnippet helm-ag gitconfig-mode
       gitattributes-mode git-timemachine git-messenger git-link
       git-gutter-fringe git-gutter-fringe+ fuzzy flyspell-correct-helm
       flycheck-pos-tip exec-path-from-shell evil-visualstar evil-magit
       evil-escape eshell-z eshell-prompt-extras esh-help elisp-slime-nav
       diff-hl company-statistics browse-at-remote bind-map auto-yasnippet
       auto-dictionary auto-compile ace-window ace-jump-helm-line ac-ispell))))
  (custom-set-faces))
