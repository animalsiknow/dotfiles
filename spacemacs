;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-enable-lazy-installation 'unused
   dotspacemacs-ask-for-lazy-installation t
   dotspacemacs-configuration-layer-path '("~/.spacemacs-layers")
   dotspacemacs-configuration-layers
   '((auto-completion :variables
                      auto-completion-return-key-behavior nil
                      auto-completion-tab-key-behavior nil
                      auto-completion-complete-with-key-sequence "jk")
     better-defaults
     docker
     elixir
     elm
     emacs-lisp
     git
     helm
     html
     idris
     perl6
     rust
     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)
     (spell-checking :variables
                     spell-checking-enable-by-default nil)
     syntax-checking
     version-control
     yaml)
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
                               :size 18
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
   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers t
   dotspacemacs-folding-method 'evil
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("rg" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed))

(defun dotspacemacs/set-elm-paths ()
  (lexical-let* ((npm-root
                  (file-name-as-directory
                   (replace-regexp-in-string
                    "\n$"
                    ""
                    (shell-command-to-string "npm root"))))
                 (npm-bin (file-name-as-directory (concat npm-root ".bin"))))
    (setq-local elm-oracle-command (concat npm-bin "elm-oracle"))))

(defun dotspacemacs/user-init ())

(defun dotspacemacs/user-config ()
  (setq powerline-default-separator nil)
  (setq-default evil-shift-width 4)
  (spaceline-compile)

  (add-hook 'elm-mode-hook 'dotspacemacs/set-elm-paths))

(defun dotspacemacs/emacs-custom-settings ()
  "Emacs custom settings.
This is an auto-generated function, do not modify its content directly, use
Emacs customize menu instead.
This function is called at the very end of Spacemacs initialization."
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (yaml-mode xterm-color web-mode scss-mode perl6-mode paradox mwim linum-relative link-hint impatient-mode htmlize simple-httpd idris-mode hl-todo helm-swoop helm-projectile helm-make helm-company gitconfig-mode gitattributes-mode git-timemachine flycheck-rust flx-ido evil-nerd-commenter evil-matchit evil-magit editorconfig dumb-jump docker diff-hl define-word company-web browse-at-remote auto-compile packed alchemist adaptive-wrap ace-window ace-link avy company projectile iedit smartparens highlight flycheck gitignore-mode helm helm-core magit magit-popup git-commit ghub with-editor epl rust-mode spaceline powerline s dash yasnippet which-key use-package hydra exec-path-from-shell async evil org-plus-contrib yasnippet-snippets ws-butler winum web-completion-data volatile-highlights vi-tilde-fringe uuidgen unfill undo-tree toml-mode toc-org tagedit tablist symon string-inflection spinner spaceline-all-the-icons smeargle slim-mode shell-pop sass-mode restart-emacs rainbow-delimiters racer pug-mode prop-menu popwin persp-mode pcre2el password-generator overseer org-bullets open-junk-file ob-elixir neotree nameless multi-term move-text magit-gitflow macrostep lorem-ipsum less-css-mode json-mode indent-guide hungry-delete highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-themes helm-purpose helm-mode-manager helm-gitignore helm-flx helm-descbinds helm-css-scss helm-c-yasnippet helm-ag goto-chg google-translate golden-ratio git-messenger git-link git-gutter-fringe git-gutter-fringe+ fuzzy font-lock+ flyspell-correct-helm flycheck-pos-tip flycheck-perl6 flycheck-mix flycheck-elm flycheck-credo fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-mc evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode elm-mode elisp-slime-nav dockerfile-mode docker-tramp diminish counsel-projectile company-statistics column-enforce-mode clean-aindent-mode centered-cursor-mode cargo bind-key auto-yasnippet auto-highlight-symbol auto-dictionary aggressive-indent ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
