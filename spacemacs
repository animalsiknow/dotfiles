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
     markdown
     org
     perl6
     pony
     ruby
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
   dotspacemacs-excluded-packages '()
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
   dotspacemacs-themes '(gruvbox spacemacs-dark spacemacs-light)
   dotspacemacs-colorize-cursor-according-to-state t
   dotspacemacs-default-font '("PragmataPro Liga"
                               :size 20
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
   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-smart-closing-parenthesis nil
   dotspacemacs-highlight-delimiters 'all
   dotspacemacs-persistent-server nil
   dotspacemacs-search-tools '("rg" "grep")
   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed))

(defun dotspacemacs/configure-rust-mode ()
  (setq rust-match-angle-brackets nil)
  (lexical-let ((old-do-auto-fill #'rust-do-auto-fill))
    (defun rust-do-auto-fill ()
      (when (nth 4 (syntax-ppss)) (funcall old-do-auto-fill)))))

(defun dotspacemacs/elm-mode-hook ()
  (define-key elm-mode-map (kbd "TAB") 'elm-indent-cycle))

(defconst pragmatapro-prettify-symbols-alist
  (mapcar (lambda (s)
            `(,(car s)
              .
              ,(vconcat
                (apply 'vconcat
                       (make-list
                        (- (length (car s)) 1)
                        (vector (decode-char 'ucs #X0020) '(Br . Bl))))
                (vector (decode-char 'ucs (cadr s))))))
          '(("[ERROR]"   #XE380)
            ("[DEBUG]"   #XE381)
            ("[INFO]"    #XE382)
            ("[WARN]"    #XE383)
            ("[WARNING]" #XE384)
            ("[ERR]"     #XE385)
            ("[FATAL]"   #XE386)
            ("[TRACE]"   #XE387)
            ("[FIXME]"   #XE388)
            ("[TODO]"    #XE389)
            ("[BUG]"     #XE38A)
            ("[NOTE]"    #XE38B)
            ("[HACK]"    #XE38C)
            ("[MARK]"    #XE38D)
            ("!!"        #XE900)
            ("!="        #XE901)
            ("!=="       #XE902)
            ("!!!"       #XE903)
            ("!≡"        #XE904)
            ("!≡≡"       #XE905)
            ("!>"        #XE906)
            ("!=<"       #XE907)
            ("#("        #XE920)
            ("#_"        #XE921)
            ("#{"        #XE922)
            ("#?"        #XE923)
            ("#>"        #XE924)
            ("##"        #XE925)
            ("#_("       #XE926)
            ("%="        #XE930)
            ("%>"        #XE931)
            ("%>%"       #XE932)
            ("%<%"       #XE933)
            ("&%"        #XE940)
            ("&&"        #XE941)
            ("&*"        #XE942)
            ("&+"        #XE943)
            ("&-"        #XE944)
            ("&/"        #XE945)
            ("&="        #XE946)
            ("&&&"       #XE947)
            ("&>"        #XE948)
            ("$>"        #XE955)
            ("***"       #XE960)
            ("*="        #XE961)
            ("*/"        #XE962)
            ("*>"        #XE963)
            ("++"        #XE970)
            ("+++"       #XE971)
            ("+="        #XE972)
            ("+>"        #XE973)
            ("++="       #XE974)
            ("--"        #XE980)
            ("-<"        #XE981)
            ("-<<"       #XE982)
            ("-="        #XE983)
            ("->"        #XE984)
            ("->>"       #XE985)
            ("---"       #XE986)
            ("-->"       #XE987)
            ("-+-"       #XE988)
            ("-\\/"      #XE989)
            ("-|>"       #XE98A)
            ("-<|"       #XE98B)
            (".."        #XE990)
            ("..."       #XE991)
            ("..<"       #XE992)
            (".>"        #XE993)
            (".~"        #XE994)
            (".="        #XE995)
            ("/*"        #XE9A0)
            ("//"        #XE9A1)
            ("/>"        #XE9A2)
            ("/="        #XE9A3)
            ("/=="       #XE9A4)
            ("///"       #XE9A5)
            ("/**"       #XE9A6)
            (":::"       #XE9AF)
            ("::"        #XE9B0)
            (":="        #XE9B1)
            (":≡"        #XE9B2)
            (":>"        #XE9B3)
            (":=>"       #XE9B4)
            (":("        #XE9B5)
            (":-("       #XE9B6)
            (":)"        #XE9B7)
            (":-)"       #XE9B8)
            (":/"        #XE9B9)
            (":\\"       #XE9BA)
            (":3"        #XE9BB)
            (":D"        #XE9BC)
            (":P"        #XE9BD)
            (":>:"       #XE9BE)
            (":<:"       #XE9BF)
            ("<$>"       #XE9C0)
            ("<*"        #XE9C1)
            ("<*>"       #XE9C2)
            ("<+>"       #XE9C3)
            ("<-"        #XE9C4)
            ("<<"        #XE9C5)
            ("<<<"       #XE9C6)
            ("<<="       #XE9C7)
            ("<="        #XE9C8)
            ("<=>"       #XE9C9)
            ("<>"        #XE9CA)
            ("<|>"       #XE9CB)
            ("<<-"       #XE9CC)
            ("<|"        #XE9CD)
            ("<=<"       #XE9CE)
            ("<~"        #XE9CF)
            ("<~~"       #XE9D0)
            ("<<~"       #XE9D1)
            ("<$"        #XE9D2)
            ("<+"        #XE9D3)
            ("<!>"       #XE9D4)
            ("<@>"       #XE9D5)
            ("<#>"       #XE9D6)
            ("<%>"       #XE9D7)
            ("<^>"       #XE9D8)
            ("<&>"       #XE9D9)
            ("<?>"       #XE9DA)
            ("<.>"       #XE9DB)
            ("</>"       #XE9DC)
            ("<\\>"      #XE9DD)
            ("<\">"      #XE9DE)
            ("<:>"       #XE9DF)
            ("<~>"       #XE9E0)
            ("<**>"      #XE9E1)
            ("<<^"       #XE9E2)
            ("<!"        #XE9E3)
            ("<@"        #XE9E4)
            ("<#"        #XE9E5)
            ("<%"        #XE9E6)
            ("<^"        #XE9E7)
            ("<&"        #XE9E8)
            ("<?"        #XE9E9)
            ("<."        #XE9EA)
            ("</"        #XE9EB)
            ("<\\"       #XE9EC)
            ("<\""       #XE9ED)
            ("<:"        #XE9EE)
            ("<->"       #XE9EF)
            ("<!--"      #XE9F0)
            ("<--"       #XE9F1)
            ("<~<"       #XE9F2)
            ("<==>"      #XE9F3)
            ("<|-"       #XE9F4)
            ("<<|"       #XE9F5)
            ("<-<"       #XE9F7)
            ("<-->"      #XE9F8)
            ("<<=="      #XE9F9)
            ("<=="       #XE9FA)
            ("==<"       #XEA00)
            ("=="        #XEA01)
            ("==="       #XEA02)
            ("==>"       #XEA03)
            ("=>"        #XEA04)
            ("=~"        #XEA05)
            ("=>>"       #XEA06)
            ("=/="       #XEA07)
            ("=~="       #XEA08)
            ("==>>"      #XEA09)
            ("≡≡"        #XEA10)
            ("≡≡≡"       #XEA11)
            ("≡:≡"       #XEA12)
            (">-"        #XEA20)
            (">="        #XEA21)
            (">>"        #XEA22)
            (">>-"       #XEA23)
            (">=="       #XEA24)
            (">>>"       #XEA25)
            (">=>"       #XEA26)
            (">>^"       #XEA27)
            (">>|"       #XEA28)
            (">!="       #XEA29)
            (">->"       #XEA2A)
            ("??"        #XEA40)
            ("?~"        #XEA41)
            ("?="        #XEA42)
            ("?>"        #XEA43)
            ("???"       #XEA44)
            ("?."        #XEA45)
            ("^="        #XEA48)
            ("^."        #XEA49)
            ("^?"        #XEA4A)
            ("^.."       #XEA4B)
            ("^<<"       #XEA4C)
            ("^>>"       #XEA4D)
            ("^>"        #XEA4E)
            ("\\\\"      #XEA50)
            ("\\>"       #XEA51)
            ("\\/-"      #XEA52)
            ("@>"        #XEA57)
            ("|="        #XEA60)
            ("||"        #XEA61)
            ("|>"        #XEA62)
            ("|||"       #XEA63)
            ("|+|"       #XEA64)
            ("|->"       #XEA65)
            ("|-->"      #XEA66)
            ("|=>"       #XEA67)
            ("|==>"      #XEA68)
            ("|>-"       #XEA69)
            ("|<<"       #XEA6A)
            ("||>"       #XEA6B)
            ("|>>"       #XEA6C)
            ("|-"        #XEA6D)
            ("||-"       #XEA6E)
            ("~="        #XEA70)
            ("~>"        #XEA71)
            ("~~>"       #XEA72)
            ("~>>"       #XEA73)
            ("[["        #XEA80)
            ("]]"        #XEA81)
            ("\">"       #XEA90)
            ("_|_"       #XEA97)
            )))

(defun dotspacemacs/add-pragmatapro-prettify-symbols-alist ()
  (dolist (alias pragmatapro-prettify-symbols-alist)
    (push alias prettify-symbols-alist)))

(defun dotspacemacs/user-init ())

(defun dotspacemacs/user-config ()
  (setq powerline-default-separator nil
        flycheck-check-syntax-automatically '(save mode-enabled)
        prettify-symbols-unprettify-at-point 'right-edge)

  (setq-default evil-shift-width 4
                rust-indent-offset 4)
  (spaceline-compile)

  (add-hook 'prog-mode-hook #'dotspacemacs/add-pragmatapro-prettify-symbols-alist)
  (dotspacemacs/configure-rust-mode)
  (add-hook 'elm-mode-hook #'dotspacemacs/elm-mode-hook)
  (global-prettify-symbols-mode t))

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
    (ponylang-mode flycheck-pony yasnippet-snippets yaml-mode xterm-color ws-butler winum which-key web-mode web-beautify volatile-highlights vi-tilde-fringe uuidgen use-package unfill toml-mode toc-org tagedit symon string-inflection spaceline-all-the-icons smeargle slim-mode shell-pop seeing-is-believing scss-mode sass-mode rvm ruby-tools ruby-test-mode ruby-refactor ruby-hash-syntax rubocop rspec-mode robe restart-emacs rbenv rake rainbow-delimiters racer pug-mode prettier-js popwin persp-mode perl6-mode password-generator paradox overseer orgit org-projectile org-present org-pomodoro org-mime org-download org-bullets org-brain open-junk-file ob-elixir neotree nameless mwim multi-term move-text mmm-mode minitest markdown-toc magit-svn magit-gitflow macrostep lorem-ipsum link-hint indent-guide impatient-mode idris-mode hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-xref helm-themes helm-swoop helm-purpose helm-projectile helm-mode-manager helm-make helm-gitignore helm-git-grep helm-flx helm-descbinds helm-css-scss helm-company helm-c-yasnippet helm-ag gruvbox-theme google-translate golden-ratio gnuplot gitignore-templates gitconfig-mode gitattributes-mode git-timemachine git-messenger git-link git-gutter-fringe git-gutter-fringe+ gh-md fuzzy font-lock+ flyspell-correct-helm flycheck-rust flycheck-pos-tip flycheck-perl6 flycheck-mix flycheck-elm flycheck-credo flx-ido fill-column-indicator fancy-battery eyebrowse expand-region evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-org evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-magit evil-lisp-state evil-lion evil-indent-plus evil-iedit-state evil-goggles evil-exchange evil-escape evil-ediff evil-cleverparens evil-args evil-anzu eval-sexp-fu eshell-z eshell-prompt-extras esh-help emmet-mode elm-test-runner elm-mode elisp-slime-nav editorconfig dumb-jump dotenv-mode doom-modeline dockerfile-mode docker diminish diff-hl define-word counsel-projectile company-web company-statistics column-enforce-mode clean-aindent-mode chruby centered-cursor-mode cargo bundler browse-at-remote auto-yasnippet auto-highlight-symbol auto-dictionary auto-compile alchemist aggressive-indent ace-window ace-link ace-jump-helm-line ac-ispell))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
)
