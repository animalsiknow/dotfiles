(defconst pollen-packages
  '(pollen-mode
    company-pollen))

(defun pollen/init-pollen-mode ()
  (use-package pollen-mode
    :defer t
    :mode ("\\.pp\\'" . pollen-mode)))

(defun pollen/init-company-pollen ()
  (use-package company-pollen
    :defer t))
