(defconst pony-packages
  '(company
    flycheck
    flycheck-pony
    ponylang-mode))

(defun pony/post-init-company ()
  (spacemacs|add-company-backends :backends company-capf :mode ponylang-mode))

(defun pony/post-init-flycheck ()
  (spacemacs/enable-flycheck 'ponylang-mode))

(defun pony/init-flycheck-pony ()
  (use-package flycheck-pony :if (configuration-layer/package-used-p 'flycheck)))

(defun pony/init-ponylang-mode ()
  (use-package ponylang-mode
    :defer t
    :config
    (progn
      (add-hook 'ponylang-mode-hook
                (lambda ()
                  (set-variable 'indent-tabs-mode nil)
                  (set-variable 'tab-width 2)))
      (spacemacs/set-leader-keys-for-major-mode 'ponylang-mode
        "c" 'spacemacs/pony-compile))))
