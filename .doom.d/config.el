;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Some functionality uses this to identify you, e.g. GPG configuration, email

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

; set theme
(setq doom-theme 'doom-one)
(setq org-directory "~/org/")

;; Set relative line numbers
(setq display-line-numbers-type 'relative)

(setq
 user-mail-address "michael.a.gallo95@gmail.com"
 user-full-name "Michael A Gallo"
 )
;;(requiire 'smtpmail)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
; EXTENSIONS


;; TESTING REDDIT YADM

;MU4E

(require 'mu4e)
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(setq mu4e-get-mail-command "mbsync -c ~/.emacs.d/mu4e/.mbsyncrc -a"
     mu4e-update-interval  300)

;; Magit and Yadm
 ;; cc(global-set-key (kbd "C-x .") 'yadm-status)
(map!
 :leader
 :prefix ("g")
 :desc "yadm status"        "y" #'yadm-status)




(defun yadm--files ()
  (let ((default-directory "~/"))
    (cl-delete-if-not
     #'file-exists-p
     (process-lines "yadm" "ls-tree" "--full-tree" "-r" "--name-only" "HEAD"))))

(defun yadm-find-file ()
  (interactive)
  (let ((default-directory  "~/"))
    (find-file
     (completing-read "Yadm file: " (yadm--files)))))

(defun yadm-dired ()
  (interactive)
  (let ((default-directory "~/"))
    (with-current-buffer (dired `("*yadm*" ,@(yadm--files)))
      (setq-local revert-buffer-function
                  (lambda (&rest args)
                    (setq dired-directory
                          (cons (car dired-directory)
                                (yadm--files)))
                    (apply #'dired-revert args))))))

(define-minor-mode yadm-minor-mode
  "A minor mode for magit yadm buffers."
  :keymap (let ((map (make-sparse-keymap)))
            (define-key map (kbd "C-x d") 'yadm-dired)
            (define-key map (kbd "C-x C-f") 'yadm-find-file)
            (define-key map "s" 'yadm-stage)
            map))

(defun yadm-status ()
  (interactive)
  (require 'tramp)
  (with-current-buffer (magit-status "/yadm::")
    (yadm-minor-mode 1)))

(with-eval-after-load 'tramp
  (add-to-list 'tramp-methods
               '("yadm"
                 (tramp-login-program "yadm")
                 (tramp-login-args (("enter")))
                 (tramp-remote-shell "/bin/bash")
                 (tramp-remote-shell-args ("-c"))))
  (defun yadm-stage ()
    (interactive)
    (let ((file
           (let ((default-directory "~/"))
             (read-file-name "Stage file: "))))
      (if (equal (expand-file-name file)
                 (expand-file-name "~/.yadm/"))
          (user-error "Can't stage yadm dir itself.")
        (magit-with-toplevel
          (magit-stage-1 nil (list file)))))))


;; Comments
(map!
 :leader
 :prefix ("c")
 :desc "comment"        "c" #'comment-or-uncomment-region-or-line)
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        ))
