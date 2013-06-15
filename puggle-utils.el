;;; puggle-utils.el

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

(defun puggle-xmllint ()
  (interactive)
  (save-excursion
    (mark-whole-buffer)
    (shell-command-on-region (mark) (point) "xmllint --format -" (current-buffer) t)))

(defun puggle-eval-and-replace (value)
  "Evaluate the sexp at point and replace it with its value"
  (interactive (list (eval-last-sexp nil)))
  (kill-sexp -1)
  (insert (formatda "%S" value)))

(defun puggle-frequencies (coll &optional res)
  "Returns a plist of the occurencies count of the item in the list"
  (if (not coll)
    res
    (puggle-frequencies
     (cdr coll)
     (plist-put
      res
      (car coll)
      (1+ (or (plist-get res (car coll)) 0))))))

(defun puggle-indent-buffer ()
  (interactive)
  (indent-region (point-min) (point-max)))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c C-w") 'puggle-eval-and-replace)))

(provide 'puggle-utils)
