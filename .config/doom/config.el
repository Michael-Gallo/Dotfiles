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
; disable transparency 
(set-frame-parameter (selected-frame) 'alpha '(100 . 100))
(add-to-list 'default-frame-alist '(alpha . (100 . 100)))

(setq
 user-mail-address "michael.a.gallo95@gmail.com"
 user-full-name "Michael A Gallo"
 )

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

;; Tramp nonsense
(require 'tramp)
(add-to-list 'tramp-methods
       '("yadm"
       (tramp-login-program "yadm")
       (tramp-login-args (("enter")))
       (tramp-login-env (("SHELL") ("/bin/sh")))
       (tramp-remote-shell "/bin/sh")
       (tramp-remote-shell-args ("-c"))))
; MU4E Settings
(use-package mu4e
  :ensure nil
  :defer 20
  :config

  (setq mu4e-change-filenames-when-moving t)

  ;; Refresh mail using isync every  10 minutes

  )
;MU4E accounts
(require 'mu4e)
(add-to-list 'load-path "/usr/share/emacs/site-lisp/mu4e")
(setq mu4e-get-mail-command "mbsync -c ~/.config/mu4e/mbsyncrc -a"
      mu4e-update-interval  300
      )
(add-to-list 'load-path "/usr/local/share/emacs/site-lisp/mu4e")

(map!
 :leader
 :prefix ("m")
 :desc "open mu4e"        "m" #'mu4e
 :desc "update elfeed"        "u" #'elfeed-update

 )
;;(require 'smtpmail)


(load "~/.config/doom/email")
;; Magit and Yadm
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
  ; (require 'tramp)
  (with-current-buffer (magit-status "/yadm::")
    (yadm-minor-mode 1)))

; (with-eval-after-load 'tramp
 ; (add-to-list 'tramp-methods
                ; '("yadm"
                  ; (tramp-login-program "yadm")
                  ; (tramp-login-args (("enter")))
                  ; (tramp-remote-shell "/bin/bash")
                  ; (tramp-remote-shell-args ("-c"))))
  (defun yadm-stage ()
    (interactive)
    (let ((file
           (let ((default-directory "~/"))
             (read-file-name "Stage file: "))))
      (if (equal (expand-file-name file)
                 (expand-file-name "~/.yadm/"))
          (user-error "Can't stage yadm dir itself.")
        (magit-with-toplevel
          (magit-stage-1 nil (list file))))))

; )


;; Comments
(map!
 :leader
 :prefix ("c")
 :desc "toggle comment"        "c" #'comment-or-uncomment-region-or-line)
(defun comment-or-uncomment-region-or-line ()
    "Comments or uncomments the region or the current line if there's no active region."
    (interactive)
    (let (beg end)
        (if (region-active-p)
            (setq beg (region-beginning) end (region-end))
            (setq beg (line-beginning-position) end (line-end-position)))
        (comment-or-uncomment-region beg end)
        ))

; Display line numbers in elfeed
(defun my-display-numbers-hook ()
  (display-line-numbers-mode t)
  )
(add-hook 'elfeed-search-update-hook 'my-display-numbers-hook)
;; Elfeed feeds
(custom-set-variables
 '(elfeed-feeds
   (quote
    (

     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCY3A_5R_m3PXCn5XDhvBBsg") ; Adam Millard
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2cC48A261pBVKztLyzOAnA") ; Ask Sebby
     ("http://www.awkwardzombie.com/awkward.php"                                    ) ; Awkward Zombie
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCOFH59uoSs8SUF0L_p3W0sg") ; BadSeed
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCr3cBLTYmIK9kY0F_OdFWFQ") ; Casually explained
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2C_jShtL725hvbm1arSV9w") ; CGP Grey
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCg6gPGh8HU2U01vaFCAsvmQ") ; Chris Titus Tech
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCJQfl8QxjNen736AVO3ecFg") ; Clemps
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCFQMnBA3CS502aghlcr0_aw") ; CoffeeZilla
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC4QZ_LsYcvcq7qOsOhpAX4A") ; Cold Fusion
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCq6VFHwMzcMXbuKyG7SQYIg") ; Cr1tikal
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCQMyhrt92_8XM0KgZH6VnRg") ; Company Man
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC9WQRw8jgJhag-vkDNTDMRg") ; Coffee Break
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC7SeFWZYFmsm1tqWxfuOTPQ") ; Dankula
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCVls1GmFKf6WlTraIb_IaJg") ; Distrotube
     ("http://feeds.feedburner.com/Explosm"                                         ) ; Explosm
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCRXnOs1rjfLMYrtZ-0n29NA") ; Freedom Toons
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCLmzk98n_v2doN2Y20S-Zog") ; Gaming Brit Show
     ;; ("https://www.gematsu.com/feed")                                                 ; Gematsu
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC7dF9qfBMXrSlaaFFDvV_Yg") ; Gigguk
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCuCkxoKLYO_EQ2GeFtbM_bw") ; Half As Interesting
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCR1D15p_vdP3HkrH8wgjQRw") ; Internet Historian
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCGSGPehp0RWfca-kENgBJ9Q") ; Jreg
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCXuqSBlHAE6Xw-yeJA0Tunw") ; LinusTechTips
     ("https://videos.lukesmith.xyz/feeds/videos.xml?accountId=3") ;                    Luke Smith
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCb_sF2m3-2azOqeNEdMwQPw") ; Matthewmatosis
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCXX1iQGufHujuIvQ38MPKMA") ; MauLer
     ("https://feeds.feedburner.com/nerfnow/full")                                    ; Nerf Now
     ("http://feeds.penny-arcade.com/pa-mainsite")                                    ; Penny Arcade
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC2PA-AKmVpU6NKCGtZq_rKQ") ; PhilosophyTube
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCgNg3vwj3xt7QOrcIDaHdFg") ; Polymatter
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCXtrYuGksGkkyls50lPWvYQ") ; PPCIan
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC1JTQBa5QxZCpXrFSkMxmPw") ; Raycevik
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC1DTYW241WD64ah5BFWn4JA") ; SamONella
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0aanx5rpr7D1M7KCFYzrLQ") ; Shoe
     ("https://www.smbc-comics.com/comic/rss")                                        ;  SMBC
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCWqr2tH3dPshNhPjV5h1xRw") ; Super Bunny Hop
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCtZO3K2p8mqFwiKWb9k7fXA") ; TechAltar
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC0vBXGSyV14uvJ4hECDOl0Q") ; TechQuickie
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCCOD-tcFzMSiaNkSUB_KVjQ") ; Tonald
     ("http://feeds.feedburner.com/oatmealfeed")                                      ; The Oatmeal
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCHnyfMqiRRG1u-2MsSQLbXA") ; Veritasium
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UC9RM-iSvTu1uPJb8X5yp3EQ") ; Wendover Productions
     ("https://www.youtube.com/feeds/videos.xml?channel_id=UCVWhVAZwCdQsPZL-mDLcxPQ") ; Whitelight
     ))))
;; Elfeed shortcuts
(map!
 :leader
 :prefix ("e")
 :desc "open elfeed"        "e" #'elfeed
 :desc "update elfeed"        "u" #'elfeed-update
)
; alt-v universally pastes regardless of Mode
(evil-global-set-key 'normal (kbd "M-v") 'clipboard-yank)

;; Set relative line numbers
(setq display-line-numbers-type 'relative)
(setq display-line-numbers-mode 'relative)

; Set file assocations
;
;; (use-package openwith
;;   :if (not dw/is-termux)
;;   :config
;;   (setq openwith-associations
;;         (list
;;           (list (openwith-make-extension-regexp
;;                 '("mpg" "mpeg" "mp3" "mp4"
;;                   "avi" "wmv" "wav" "mov" "flv"
;;                   "ogm" "ogg" "mkv"))
;;                 "mpv"
;;                 '(file))
;;           (list (openwith-make-extension-regexp
;;                 '("xbm" "pbm" "pgm" "ppm" "pnm"
;;                   "png" "gif" "bmp" "tif" "jpeg")) ;; Removed jpg because Telega was
;;                   ;; causing feh to be opened...
;;                   "feh"
;;                   '(file))
;;           (list (openwith-make-extension-regexp
;;                 '("pdf"))
;;                 "zathura"
;;                 '(file))))
;;   (openwith-mode 1))
;; (use-package elpy
;;   :ensure t
;;   :init
;;   (elpy-enable)
;;   )
;; (setq elpy-rpc-virtualenv-path "~/Environments/emacs_main/")
;; (setq elpy-rpc-python-command "python3")
;; (setq python-shell-interpreter "~/Environments/emacs_main/bin/python3") ;; This is what `C-c C-c` will use
