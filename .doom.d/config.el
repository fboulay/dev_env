;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Florian Boulay"
      user-mail-address "florian@boulay.eu")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant)
(setq doom-themes-treemacs-theme "doom-colors")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; Configure org mode
(setq org-hide-emphasis-markers t)
(setq org-ellipsis " ▼")

;; Set faces for heading levels
(with-eval-after-load 'org-faces (dolist (face '((org-level-1 . 1.2)
                (org-level-2 . 1.1)
                (org-level-3 . 1.05)
                (org-level-4 . 1.0)
                (org-level-5 . 1.1)
                (org-level-6 . 1.1)
                (org-level-7 . 1.1)
                (org-level-8 . 1.1)))
  (set-face-attribute (car face) nil :weight 'regular :height (cdr face))))


(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
;; Enable relative line numbers
(setq display-line-numbers-type 'relative)

(after! org
  (setq org-roam-directory "~/org/roam/")
  (setq org-roam-index-file "~/org/roam/index.org"))

;; Allow cursor to pass the end of line, especially when moving forward sexp
(setq evil-move-beyond-eol t)

;; Delete files by moving them to trash.
(setq-default delete-by-moving-to-trash t
              trash-directory nil) ;; Use freedesktop.org trashcan

;; Show list of buffers when splitting.
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

;;
;; Use <tab> for completion
;;(global-set-key (kbd "TAB") #'company-indent-or-complete-common)

(after! company
  (define-key company-active-map (kbd "<tab>") #'company-complete-selection))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
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
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Treemacs config
(add-hook 'window-setup-hook #'treemacs 'append)
(after! treemacs
    (add-hook! 'treemacs-mode-hook (setq window-divider-mode -1
                                     variable-pitch-mode 1
                                     treemacs-follow-mode 1)))

;; beacon highlights the line we are moving to
(use-package! beacon)
(after! beacon
  (beacon-mode 1))

;; Focus is highlighting the region we are working on. Is it working  ?
(use-package! focus)

;; enable word-wrap (almost) everywhere
(+global-word-wrap-mode +1)

;; Specific config for projectile not to index home directory
(after! projectile
  (setq projectile-project-root-files-bottom-up
        (remove ".git" projectile-project-root-files-bottom-up))
  (setq projectile-project-search-path
        '("~/fboulay/workspace"
          "~/fboulay/.doom.d"
          "~/fboulay/.config"))) ;; ("dir" . depth))

;; Auto save mode
(use-package! super-save
  :ensure t
  :config
  (setq auto-save-default t ;; nil to switch off the built-in `auto-save-mode', maybe leave it t to have a backup!
        super-save-exclude '(".gpg")
        super-save-remote-files nil
        super-save-auto-save-when-idle t)
  (super-save-mode +1))

(setq auto-save-default t) ;; enable built-in `auto-save-mode'

;; Customize undo-fu package: more memory and fine grained undo in insert mode
;; Increase undo history limits even more
(after! undo-fu
  (setq undo-limit        10000000     ;; 1MB   (default is 160kB, Doom's default is 400kB)
        undo-strong-limit 100000000    ;; 100MB (default is 240kB, Doom's default is 3MB)
        undo-outer-limit  1000000000)) ;; 1GB   (default is 24MB,  Doom's default is 48MB)

(after! evil
  (setq evil-want-fine-undo t)) ;; By default while in insert all changes are one big blob

;;
;; global and backward functions
;;
(defun marker-is-point-p (marker)
  "test if marker is current point"
  (and (eq (marker-buffer marker) (current-buffer))
       (= (marker-position marker) (point))))

(defun push-mark-maybe ()
  "push mark onto `global-mark-ring' if mark head or tail is not current location"
  (if (not global-mark-ring) (error "global-mark-ring empty")
    (unless (or (marker-is-point-p (car global-mark-ring))
                (marker-is-point-p (car (reverse global-mark-ring))))
      (push-mark))))


(defun backward-global-mark ()
  "use `pop-global-mark', pushing current point if not on ring."
  (interactive)
  (push-mark-maybe)
  (when (marker-is-point-p (car global-mark-ring))
    (call-interactively 'pop-global-mark))
  (call-interactively 'pop-global-mark))

(defun forward-global-mark ()
  "hack `pop-global-mark' to go in reverse, pushing current point if not on ring."
  (interactive)
  (push-mark-maybe)
  (setq global-mark-ring (nreverse global-mark-ring))
  (when (marker-is-point-p (car global-mark-ring))
    (call-interactively 'pop-global-mark))
  (call-interactively 'pop-global-mark)
  (setq global-mark-ring (nreverse global-mark-ring)))

(map! :leader
      ;; <leader> x will invoke the dosomething command
      :desc "Go backward"
      "<left>" #'backward-global-mark
      ;; <leader> y will print "Hello world" in the minibuffer
      :desc "Go forward"
      "<right>" #'forward-global-mark
      )

(map! :leader
 :desc "Change dictionnary to fr"
 "<f5>"
 (lambda ()
   (interactive)
   (ispell-change-dictionary "francais")))

(map! :leader
 :desc "Change dictionnary to en"
 "<f6>"
 (lambda ()
   (interactive)
   (ispell-change-dictionary "english")))


;; Automatically detect language for Flyspell
(use-package! guess-language
  :hook text-mode
  :config
  (setq guess-language-langcodes '((en . ("en_US" "English"))
                                   (fr . ("fr_FR" "French")))
        guess-language-languages '(en fr)
        guess-language-min-paragraph-length 40)
  :diminish guess-language-mode)

(after! doom-modeline
  (setq doom-modeline-major-mode-icon t
        doom-modeline-major-mode-color-icon t
        doom-modeline-buffer-state-icon t))

;; wet suggestions to appear faster
(setq which-key-idle-delay 0.5 ;; Default is 1.0
      which-key-idle-secondary-delay 0.05) ;; Default is nil

;; Replace 'evil' word in suggestion by a character
;; (setq which-key-allow-multiple-replacements t)


;; (after! which-key
  ;; (pushnew! which-key-replacement-alist
            ;; '(("" . "\\`+?evil[-:]?\\(?:a-\\)?\\(.*\\)") . (nil . "◂\\1"))
            ;; '(("\\`g s" . "\\`evilem--?motion-\\(.*\\)") . (nil . "◃\\1"))))

(after! meghanada
  (setq meghanada-java-path "/home/fboulay/.sdkman/candidates/java/current/bin/java")
  (setq meghanada-maven-path "/home/fboulay/.sdkman/candidates/maven/3.6.3/bin/mvn"))
