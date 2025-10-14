;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
(package! beacon  ;; display a nice effect when moving the cursor in big increments
  :disable t) ;; Disabled because I am using the built-in nav-flash package instead
(package! focus 
  :disable t)
(package! adoc-mode) ;; simple mode for AsciiDoc documents
(package! super-save) ;; save automatically based on specific triggers
(package! guess-language
  :disable t)
(package! keycast)
(package! org-present)  ;; to display org-mode files like presentation
(package! visual-fill-column) ;; used with org-present
(package! org-auto-tangle
  :disable t)
(package! gitlab-ci-mode)
(package! jinx 
  :disable t)
(package! chatgpt-shell
  :disable t)
(package! gt)
(package! evil-smartparens)
(package! company-quickhelp :disable t) ;; company-box is used instead (built-in into doom)
(package! cider-eval-sexp-fu)
(package! golden-ratio
  :disable t) ;; zoom has better config options
(package! zoom)
(package! org-cv
  :recipe (:host github :repo "Titan-C/org-cv"
            :files ("*.el"))
  :disable t)
(package! rainbow-blocks
  :disable t)
(package! prism
  :recipe (:host github :repo "alphapapa/prism.el" :files ("*.el"))
  :disable t)
(package! topsy
  :disable t)
;; (package! gptel)
(package! kaocha-runner)
(package! verb) ;; Call HTTP endpoints from org files
(package! selection-highlight-mode
  :recipe (:host github :repo "balloneij/selection-highlight-mode"))
(package! evil-matchit)
(package! vertico-posframe
  :disable t) ;; sometimes it is not working as expected
(package! blamer)
(package! hugsql-ghosts    ;; Does not work in most cases
  :disable t)
(package! codeium :recipe (:host github :repo "Exafunction/codeium.el")
  :disable t) ;; hard to have the completions alongside LSP completions
(package! git-link)
(package! casual-dired ;; not very useful
  :disable t)
(package! hiccup-cli)
(package! difftastic)
(package! separedit)
(package! feature-mode)
(package! pulsar) ;; same as beacon and nav-flash
(package! org-modern-indent
  :recipe (:host github :repo "jdtsmith/org-modern-indent"))
;; I pin some packages to have a more recent version
;; (package! cider :pin "2bafc1ec67308de500ce7ce8ac8f79eae449dee8") ;; version 1.12.0
;; (package! clojure-mode :pin "25d713a67d8e0209ee74bfc0153fdf677697b43f") ;; version 5.18.1
;; (package! magit-todos :pin "d85518d45d329cc0b465cc3b84910b7c66b3fc42")
;; version 1.7
;; (package! consult :pin "22d759c1335fae314a751d4b9f42c89f3d8848ef") ;; pin because of https://github.com/minad/consult/issues/1015
;; (package! smartparens
;;           ;; until https://github.com/Fuco1/smartparens/issues/1212 is resolved
;;           :pin "603325ab3d1186fb10da5c2a7ec1afb88018d792")
