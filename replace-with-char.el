;;; replace-with-char.el --- replace chars of a text object with a char -*- lexical-binding: t -*-

;; Copyright (C) 2015 by Filipe Silva (ninrod)

;; Author: Filipe Silva <filipe.silva@gmail.com>
;; URL: https://github.com/ninrod/replace-with-char
;; Version: 0.0.1
;; Package-Requires: ((evil "1.2.13") (emacs "24"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package provides an evil operator to replace chars of a text object with a given char.
;; one use case is fill the insides of a markdown table headline as follows (cursor is on []):
;;
;; |desc | item|
;; | []  |     |
;; -> zxi|-
;; |desc | item|
;; |-----|     |
;; -> wh.
;; |desc | item|
;; |-----|-----|

;;; Code:

;;; Settings:

(require 'evil)


(defgroup replace-with-char nil
  "replace chars of a text object with a char."
  :group 'replace-with-char
  :prefix 'replace-with-char-)

(defcustom replace-with-char-key (kbd "zx")
  "Key for the replace-with-char operator."
  :type 'string
  :group 'replace-with-char)

(evil-define-operator evil-operator-replace-with-char (beg end _ char)
  :move-point nil
  (interactive "<R>"
               (unwind-protect
                   (let ((evil-force-cursor 'replace))
                     (evil-refresh-cursor)
                     (list (evil-read-key)))
                 (evil-refresh-cursor)))
  (save-excursion
    (delete-region beg end)
    (goto-char beg)
    (let ((s (make-string (- end beg) char)))
      (insert s))))

(define-key evil-normal-state-map replace-with-char-key 'evil-operator-replace-with-char)

(provide 'replace-with-char)

;;; replace-with-char.el ends here
