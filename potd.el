;;; potd.el --- Picture Of The Day for dashboard

;; Copyright (c) 2019 Damien Collard

;; Author: Damien Collard <damien.collard@laposte.net>
;; URL:
;; Version: 0.0.1
;; Keywords: convenience languages tools
;; Package-Requires: ((emacs "24.3") (dashboard "1.2.5"))

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

;; Picks a random image from a specified directory to be displayed as banner in
;; the dashboard.
;;
;; NOTE: It's actually not really "of the day" since it may change every time
;; the dashboard is refreshed.

;;; Code:

(require 'dashboard)

(defgroup potd nil
  "Randomly pick a picture to be used as dashboard banner."
  :prefix "potd-"
  :link '(url-link :tag "GitHub" "https://github.com/damiencollard/potd"))

(defcustom potd-directory "~/.emacs.d/images/"
  "Directory containing the files to pick from for the POTD."
  :group 'potd
  :type 'string)

(defcustom potd-image-extensions-regex "\\.\\(png\\|jpg\\|jpeg\\)$"
  "Regex of the image types that can be used as POTD."
  :group 'potd
  :type 'string)

(defun potd-pick ()
  "Pick a picture from the configured directory."
  (let* ((pics (directory-files potd-directory nil potd-image-extensions-regex))
         (idx (random (length pics))))
    (concat (file-name-as-directory potd-directory) (nth idx pics))))

(defun potd-dashboard-choose-banner (orig-fun &rest args)
  "Wrapper around `dashboard-choose-banner' to enable POTD.

Calls ORIG-FUN (the original `dashboard-choose-banner' function)
with arguments ARGS after picking a picture to be used as banner."
  (setq dashboard-startup-banner (potd-pick))
  (apply orig-fun args))

(advice-add 'dashboard-choose-banner :around #'potd-dashboard-choose-banner)

(provide 'potd)
;;; potd.el ends here
