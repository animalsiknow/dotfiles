;;; packages.el --- typer layer packages file for Spacemacs.
;;
;; Copyright (c) 2012-2018 Sylvain Benner & Contributors
;;
;; Author: Simon Génier <simon.genier@protonmail.com>
;; URL: https://github.com/syl20bnr/spacemacs
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3

(defconst typer-packages
  '((typer-mode :location local)))

(defun typer/init-typer-mode ()
  (use-package typer-mode :mode "\\.type\\'"))
