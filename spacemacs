;; -*- mode: dotspacemacs -*-

(defun dotspacemacs/layers ()
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '("~/.spacemacs-layers")
   dotspacemacs-configuration-layers `(auto-completion
                                       agda
                                       c-c++
                                       clojure
                                       colors
                                       elixir
                                       elm
                                       emacs-lisp
                                       git
                                       go
                                       javascript
                                       lua
                                       haskell
                                       html
                                       idris
                                       markdown
                                       perl
                                       purescript
                                       racket
                                       react
                                       (ruby :variables
                                             ruby-version-manager 'chruby
                                             ruby-enable-enh-ruby-mode t)
                                       rust
                                       shell
                                       (syntax-checking :variables
                                                        syntax-checking-enable-tooltips nil)
                                       version-control
                                       yaml)
   dotspacemacs-additional-packages '()
   dotspacemacs-excluded-packages '()
   dotspacemacs-delete-orphan-packages t))

(defun dotspacemacs/init ()
  (setq-default dotspacemacs-elpa-https t
                dotspacemacs-editing-style 'vim
                dotspacemacs-themes '(solarized-dark solarized-light)
                dotspacemacs-leader-key "SPC"
                dotspacemacs-major-mode-leader-key ","
                dotspacemacs-command-key ":"
                dotspacemacs-guide-key-delay 0.4
                dotspacemacs-colorize-cursor-according-to-state t
                dotspacemacs-active-transparency 100
                dotspacemacs-inactive-transparency 100
                dotspacemacs-mode-line-unicode-symbols t
                dotspacemacs-smooth-scrolling t
                dotspacemacs-feature-toggle-leader-on-jk nil
                dotspacemacs-smartparens-strict-mode nil
                dotspacemacs-persistent-server nil
                dotspacemacs-highlight-delimiters nil
                dotspacemacs-default-font '("PragmataPro"
                                            :size 18
                                            :weight normal
                                            :width normal)))

(defun sgnr/term-send-meta-backspace ()
  (interactive)
  (term-send-raw-string "\C-w"))

(defun sgnr/use-local-eslint ()
  (lexical-let* ((project-root (projectile-project-root))
                 (eslint-path (concat (file-name-as-directory project-root) "node_modules/.bin/eslint")))
    (when (file-executable-p eslint-path)
      (setq flycheck-javascript-eslint-executable eslint-path))))

(defun sgnr/use-local-rubocop ()
  (lexical-let* ((project-root (projectile-project-root))
                 (rubocop-path (concat (file-name-as-directory project-root) "bin/rubocop")))
    (when (file-executable-p rubocop-path)
      (setq flycheck-ruby-rubocop-executable rubocop-path))))

(defun sgnr/symbol-with-hash-rocket-region ()
  (list
   (save-excursion
     (if (looking-at-p ":")
         (point)
       (search-backward ":" (line-beginning-position) t)))
   (save-excursion
     (when (and (looking-at-p ":") (not (eolp)))
       (forward-char))
     (if (re-search-forward "=>" (line-end-position) t)
         (1+ (point))
       (line-end-position)))))

(defun sgnr/ruby-to-new-style-hash ()
  (interactive)
  (when (and (not (ruby-tools-string-at-point-p)) (ruby-tools-symbol-at-point-p))
    (let* ((region (sgnr/symbol-with-hash-rocket-region))
           (min (nth 0 region))
           (max (nth 1 region))
           (content
            (buffer-substring-no-properties min max)))
      (setq content
            (replace-regexp-in-string ":\\([a-zA-Z_][a-zA-Z_0-9]*\\)\s*=>" "\\1:" content))
      (let ((orig-point (point)))
        (delete-region min max)
        (insert content)
        (goto-char orig-point)))))

(defun dotspacemacs/user-init ()
  (menu-bar-mode -1)
  (setq-default require-final-newline t)
  (setq auto-completion-return-key-behavior nil
        auto-completion-tab-key-behavior 'complete
        enh-ruby-add-encoding-comment-on-save nil))

(defun dotspacemacs/user-config ()
  (add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.mrb$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.gemspec$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("Gemfile$" . enh-ruby-mode))
  (add-to-list 'auto-mode-alist '("\\.js$" . react-mode))
  (add-to-list 'auto-mode-alist '("\\.js.erb$" . react-mode))

  (setq powerline-default-separator nil)
  (spaceline-compile)

  (setq projectile-enable-caching nil
        enable-remote-dir-locals t
        undo-limit 200000
        flycheck-check-syntax-automatically '(save mode-enabled)
        magit-fetch-arguments '("--prune")
        rust-format-on-save t)

  (spacemacs/set-leader-keys "<SPC>" 'avy-goto-word-1)
  (spacemacs/set-leader-keys-for-major-mode 'enh-ruby-mode
    "x=" 'sgnr/ruby-to-new-style-hash)

  (with-eval-after-load 'flycheck
    (flycheck-add-mode 'javascript-eslint 'web-mode))

  (spaceline-toggle-version-control-off)
  (global-hl-line-mode 0)

  (setq elm-format-on-save t
        elm-format-command "elm-format-0.17")

  (add-hook 'before-save-hook 'delete-trailing-whitespace)

  (add-hook
   'term-mode-hook
   '(lambda ()
      (define-key term-raw-map (kbd "M-<backspace>") 'sgnr/term-send-meta-backspace)
      (define-key term-raw-map (kbd "M-x") 'helm-M-x)
      (define-key term-raw-map (kbd "M-:") 'eval-expression)))

  (add-hook
   'c-mode-hook
   '(lambda ()
      (setq c-basic-offset 2)
      (setq evil-shift-width 2)
      (c-toggle-auto-newline 0)
      (c-set-offset 'arglist-intro 2)
      (c-set-offset 'arglist-close 0)
      (c-set-offset 'inextern-lang 0)))

  (setq enh-ruby-program "/opt/rubies/2.2.3p172-shopify/bin/ruby")
  (add-hook
   'enh-ruby-mode-hook
   '(lambda ()
      (chruby "2.2")
      (sgnr/use-local-rubocop)
      (ruby-tools-mode)
      (define-key ruby-tools-mode-map "#" nil)
      (setq enh-ruby-deep-indent-paren nil
            evil-shift-width 2)))
  (remove-hook 'enh-ruby-mode-hook 'rubocop-mode)

  (add-hook
   'yaml-mode-hook
   '(lambda ()
      (modify-syntax-entry ?_ "w")))

  (add-hook
   'react-mode-hook
   '(lambda ()
      (sgnr/use-local-eslint)))
  (remove-hook 'react-mode-hook 'js2-minor-mode)

  (add-hook
   'web-mode-hook
   '(lambda ()
      (let ((file-name (buffer-file-name)))
       (when (and (stringp file-name)
                  (member (file-name-extension file-name) '("js")))
        (sgnr/use-local-eslint)
        (web-mode-set-content-type "jsx")
        (tern-mode 1)))
      (setq web-mode-enable-auto-pairing nil)
      (setq web-mode-markup-indent-offset 2)
      (setq web-mode-attr-indent-offset 2)
      (setq web-mode-code-indent-offset 2)))

  (add-hook
   'json-mode-hook
   '(lambda ()
      (setq js-indent-level 2)
      (setq json-reformat:indent-width 2)))

  (setq haskell-process-type 'stack-ghci)
  (setq flycheck-disabled-checkers '(haskell-ghc ruby))
  (add-hook
   'haskell-mode-hook
   '(lambda ()
      (turn-off-smartparens-mode)
      (turn-off-show-smartparens-mode)))

  (add-hook
   'rust-mode-hook
   '(lambda ()
      (setq racer-rust-src-path
            (cond
             ((string-equal system-type "windows-nt")
              "/Users/Simon/Source/github.com/rust-lang/rust/src")
             (t (substitute-in-file-name "$HOME/src/github.com/rust-lang/rust/src"))))))

  (add-hook
   'c-mode-hook
   '(lambda ()
      (setq tab-width 8)))

  (add-hook
   'markdown-mode-hook
   '(lambda ()
      (sp-pair "`" nil :actions :rem)))

  (add-hook
   'css-mode-hook
   '(lambda ()
      (setq css-indent-offset 2))))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (racket-mode faceup yaml-mode xterm-color ws-butler window-numbering which-key web-mode web-beautify volatile-highlights vi-tilde-fringe vagrant-tramp vagrant uuidgen use-package toml-mode toc-org tagedit spacemacs-theme spaceline solarized-theme smeargle slim-mode shell-pop scss-mode sass-mode rvm ruby-tools ruby-test-mode rubocop rspec-mode robe restart-emacs rbenv rake rainbow-mode rainbow-identifiers rainbow-delimiters racer quelpa pug-mode psci psc-ide popwin persp-mode perl6-mode paradox orgit org-plus-contrib org-bullets open-junk-file ob-elixir neotree multi-term move-text mmm-mode minitest markdown-toc magit-gitflow macrostep lua-mode lorem-ipsum livid-mode linum-relative link-hint less-css-mode json-mode js2-refactor js-doc intero info+ indent-guide idris-mode ido-vertical-mode hungry-delete hlint-refactor hl-todo hindent highlight-parentheses highlight-numbers highlight-indentation hide-comnt help-fns+ helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-hoogle helm-gitignore helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag haskell-snippets google-translate golden-ratio go-guru go-eldoc gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md flycheck-rust flycheck-pos-tip flycheck-mix flycheck-haskell flycheck-elm flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eshell-z eshell-prompt-extras esh-help enh-ruby-mode emmet-mode elm-mode elisp-slime-nav dumb-jump disaster diff-hl define-word company-web company-tern company-statistics company-go company-ghci company-ghc company-cabal company-c-headers column-enforce-mode color-identifiers-mode coffee-mode cmm-mode cmake-mode clojure-snippets clj-refactor clean-aindent-mode clang-format cider-eval-sexp-fu chruby cargo bundler auto-yasnippet auto-highlight-symbol auto-compile alchemist aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
