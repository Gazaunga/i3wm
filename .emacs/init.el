;;; .emacs --- my Emacs Init File

;; Copyright (C) 1988-2018 J.M. Ottley

;;
;;    ___ _ __ ___   __ _  ___ ___
;;   / _ \ '_ ` _ \ / _` |/ __/ __|
;;  |  __/ | | | | | (_| | (__\__ \
;; (_)___|_| |_| |_|\__,_|\___|___/
;;


(setq gc-cons-threshold 64000000)
(add-hook 'after-init-hook
          (lambda ()
            ;; restore after startup
            (setq gc-cons-threshold 800000)))

;; Load package
(require 'package)
(setq package-check-signature nil)
(setq package-enable-at-startup nil)
(setq package-archives '(("melpa-stable" . "https://stable.melpa.org/packages/")
                         ("gnu" . "https://elpa.gnu.org/packages/")
                         ("elpy" . "https://jorgenschaefer.github.io/packages/")
                         ("org" . "https://orgmode.org/elpa/")))
(package-initialize)

(setq inhibit-startup-screen t                    ;; Disable startup-screen
      initial-scratch-message ""
      garbage-collection-messages t               ;; Garbage Collector - show when working
      load-prefer-newer t                         ;; Always load newest byte code
      large-file-warning-threshold 200000000      ;; warn when opening files bigger than 200MB
      gnutls-min-prime-bits 4096                  ;; remove the warnings from the GnuTLS library when using HTTPS
      global-auto-revert-non-file-buffers t       ;; Also auto refresh dired, but be quiet about it
      auto-revert-verbose nil
      require-final-newline t                     ;; Newline at end of file
      sentence-end-double-space nil               ;; Don't assume that sentences should have two spaces after periods. This ain't a typewriter.
      global-subword-mode t                       ;;  Treat CamelCase subwords as unique
      confirm-kill-emacs 'y-or-n-p                ;; Don't ask `yes/no?', ask `y/n?'.
      history-length 1000
      savehist-save-minibuffer-history t
      savehist-autosave-interval nil ; save on kill only
      show-trailing-whitespace t
      show-paren-delay 0                          ;; small delay before showing a matching parenthesis
      visible-bell t                              ;; When you perform a problematic operation, flash the screen instead of ringing the terminal bell.
      version-control t                           ;; Version control
      vc-follow-symlinks t                        ;; don't ask for confirmation when opening symlinked file
      delete-old-versions t                       ;; delete excess backup versions silently
      vc-make-backup-files t                      ;; make backups file even when in version controlled dir
      create-lockfiles nil
      sentence-end-double-space nil               ;; sentence SHOULD end with only a point.
      fill-column 80                              ;; toggle wrapping text at the 80Th character
      enable-recursive-minibuffers t              ;; Allow recursive minibuffers
      default-directory "~/"                      ;; When opening a file, start searching at the user's home directory.
      ;;savehist-file "~/.emacs.d/configs/savehist" ;; Save minibuffer history
      ;;save-place-file "~/.emacs.d/configs/saveplace"
      bookmark-default-file "~/.emacs.d/configs/bookmarks" ;; bookmark
      backup-directory-alist `(("." . "~/.emacs.d/backups"))      ;; ; which directory to put backups file
      ;; auto-save-file-name-transforms '((".*" "~/.emacs.d/configs/auto-save-list/"
      ;; t))   ;;transform backups file name
      dired-recursive-deletes (quote top)         ;; ÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã¢â‚¬Â¦ÃƒÂ¢Ã¢â€šÂ¬Ã…â€œtopÃƒÆ’Ã†â€™Ãƒâ€šÃ‚Â¢ÃƒÆ’Ã‚Â¢ÃƒÂ¢Ã¢â€šÂ¬Ã…Â¡Ãƒâ€šÃ‚Â¬ÃƒÆ’Ã¢â‚¬Å¡Ãƒâ€šÃ‚Â means ask once
      dired-dwim-target t
      dired-recursive-deletes t                   ;; Dired can delete nonempty directories including all their contents
      dired-hide-details-mode t
      eldoc-idle-delay 0.1                        ;; eldoc-mode
      eldoc-echo-area-use-multiline-p nil         ;; eldoc-mode
      ;; text-scale-mode-step 0.8
      text-quoting-style 'grave                   ;; Quoting style for warnings
      ring-bell-function 'ignore                  ;; disable the annoying bell ring
      ;; scroll-step 1                               ;; keyboard scroll one line at a time
      scroll-conservatively 101                   ;; automatic scrolling never centers point, no matter how far point moves;
      scroll-preserve-screen-position t           ;; scroll commands to keep point at the same screen position, so that scrolling back to the same screen conveniently returns point to its original position
      line-number-mode t
      suggest-key-bindings t                      ;; message says that command has a key binding
      column-number-mode t
      buffer-file-coding-system 'utf-8            ;; UTF8
      coding-system-for-read 'utf-8
      coding-system-for-write 'utf-8
      make-pointer-invisible t                    ;; hide cursor while typing
      display-time-day-and-date t                 ;; date - hours - day(name/number)
      display-time-24hr-format t                  ;; display time in the mini-buffer
      display-time-default-load-average nil
      electric-indent-mode nil                    ;; No electric indent
      save-interprogram-paste-before-kill t       ;; Save clipboard data of other programs in the kill ring when possible
      apropos-sort-by-scores t                    ;; sort results by relevancy
      ediff-diff-options "-w"                     ;; A saner ediff
      delete-by-moving-to-trash t                 ;; affected files or directories into the operating system's Trash, instead of deleting them outright
      ediff-split-window-function 'split-window-horizontally
      ediff-window-setup-function 'ediff-setup-windows-plain
      ;; split-width-threshold nil                   ;; never split the window (nice for rtags and compile errors).
      ;; split-height-threshold nil
      browse-url-browser-function 'browse-url-xdg-open ;; Open URLs with xdg-open
      register-separator ?+                       ;; separate individual collected pieces using a separator
      user-full-name "gazbit"
      user-mail-address "jeremy.ottley@gmail.com")



;; Disabling warnings

(progn
  ;; (put 'scroll-left 'disabled nil)
  ;; (put 'dired-find-alternate-file 'disabled nil)
  ;; stop warning prompt for some commands. There's always undo.
  (put 'narrow-to-region 'disabled nil)
  (put 'narrow-to-page 'disabled nil)
  (put 'upcase-region 'disabled nil)
  (put 'downcase-region 'disabled nil)
  (put 'erase-buffer 'disabled nil)
  (put 'downcase-region 'disabled nil)            ;; Downcase Region
  (put 'dired-find-alternate-file 'disabled nil)
  )

;; Yet another useful variables

;; When something changes a file, automatically refresh the buffer containing that file so they can't get out of sync.
(global-auto-revert-mode t)

(size-indication-mode t)

;; No blinking
(blink-cursor-mode 0)

;; delete the selection with a keypress
(delete-selection-mode t)

;; Turn on transient-mark-mode.
(transient-mark-mode t)

;; (save-place-mode 1)
(savehist-mode t)

;; Register separator
;; (set-register register-separator "\n\n")

;; Turn on syntax highlighting whenever possible.
(global-font-lock-mode t)

;; Visually indicate matching pairs of parentheses.
(show-paren-mode 1)

;; Time
(display-time-mode)

;; Undo/Redo
;; (winner-mode 1)
;; (remove-hook 'minibuffer-setup-hook 'winner-save-unconditionally)



;; Hooks


  (add-hook 'prog-mode-hook #'hs-minor-mode) ;; folding
  (add-hook 'before-save-hook 'delete-trailing-whitespace)  ;; Delete trail
  (add-hook 'focus-out-hook #'garbage-collect) ;; Garbage-collect on focus-out, Emacs should feel snappier.
  ;; (add-hook 'window-setup-hook #'delete-other-windows) ;; Don't open with splits
  (add-hook 'dired-mode-hook
            (lambda ()
              (define-key dired-mode-map (kbd "^")
                (lambda () (interactive) (find-alternate-file "..")))
                                          ; was dired-up-directory
              ))


;; Bootstrap 'use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package org) ;; get readme.org working to use above instead

;;; Put emacs in org-mode everytime you open a file in .org, .ref, .notes, or an encrypted version of it.

(setq auto-mode-alist
  '(
    ("\\.org$" . org-mode)  
    ("\\.org.gpg$" . org-mode)  
    ("\\.ref$" . org-mode)
    ("\\.ref.gpg$" . org-mode)
    ("\\.notes$" . org-mode)
))

;;; Switch to org buffer on startup

(switch-to-buffer (get-buffer-create (generate-new-buffer-name "*scratch-org*")))
(insert "* TODO ")
(org-mode)
(setq org-agenda-files '("~/gtd/inbox.org"
                         "~/gtd/gtd.org"
                         "~/gtd/tickler.org"))

(setq org-capture-templates '(("t" "Todo [inbox]" entry
                               (file+headline "~/gtd/inbox.org" "Tasks")
                               "* TODO %i%?")
                              ("T" "Tickler" entry
                               (file+headline "~/gtd/tickler.org" "Tickler")
                               "* %i%? \n %U")))

(setq org-refile-targets '(("~/gtd/gtd.org" :maxlevel . 3)
                           ("~/gtd/someday.org" :level . 1)
                           ("~/gtd/tickler.org" :maxlevel . 2)))

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(setq org-agenda-custom-commands 
      '(("o" "At the office" tags-todo "@office"
         ((org-agenda-overriding-header "Office")))))

(setq org-agenda-custom-commands 
      '(("o" "At the office" tags-todo "@office"
         ((org-agenda-overriding-header "Office")
          (org-agenda-skip-function #'my-org-agenda-skip-all-siblings-but-first)))))

(defun my-org-agenda-skip-all-siblings-but-first ()
  "Skip all but the first non-done entry."
  (let (should-skip-entry)
    (unless (org-current-is-todo)
      (setq should-skip-entry t))
    (save-excursion
      (while (and (not should-skip-entry) (org-goto-sibling t))
        (when (org-current-is-todo)
          (setq should-skip-entry t))))
    (when should-skip-entry
      (or (outline-next-heading)
          (goto-char (point-max))))))
		  
(defun org-current-is-todo ()
  (string= "TODO" (org-get-todo-state)))

(use-package evil
  :ensure t
  :init
  (evil-mode 1))
(use-package evil-surround
  :ensure t
  :init
  (progn
    (global-evil-surround-mode 1)
    (global-set-key [(meta z)] 'undo-tree-undo)
    (global-set-key [(meta shift z)] 'undo-tree-redo)))
;; this one bugs for js?
(use-package evil-matchit
  :ensure t
  :init
  (global-evil-matchit-mode 1))
(use-package evil-nerd-commenter
  :ensure t
  :init
  (progn
    (evilnc-default-hotkeys)
    ;; default binding is M-;
    (global-set-key (kbd "M-/") 'evilnc-comment-or-uncomment-lines)))
(use-package evil-leader
  :ensure t
  :init
  (progn
    (global-evil-leader-mode 1)
    (evil-leader/set-leader "SPC")))
(use-package ace-jump-mode
  :ensure t
  :init
  (progn
    (evil-leader/set-key "SPC" 'evil-ace-jump-char-mode)))

;; TODO: check evil-exchange, evil-snipe, evil-lisp-state, evil-escape

(use-package git-gutter
  :ensure t
  :init
  (progn
    (global-git-gutter-mode t)
    (git-gutter:linum-setup)))

(use-package helm
  :ensure t
  :init
  (progn
    (helm-mode 1)
    (global-set-key [(meta shift p)] 'helm-M-x)
    ;; I don't even know what half of these do. but why the heck don't emacs ppl get ST's fuzzy match
    (setq helm-recentf t
          ;; see fiplr below
          helm-M-x-fuzzy-match t
          helm-buffers-fuzzy-matching t
          helm-locate-fuzzy-match t
          helm-semantic-fuzzy-match t
          helm-imenu-fuzzy-match t
          helm-apropos-fuzzy-match t
          helm-lisp-fuzzy-completion t)
    ))

(use-package color-theme-sanityinc-tomorrow
  :ensure t
  :init
  (progn
    (color-theme-sanityinc-tomorrow-blue)
    ))

;; Built-in packages
;; It is somewhat surprising the amount of built-in packages are bundled with emacs. Lets enhance them!

;; Recentf

(use-package recentf
  :ensure nil
  :init
  (recentf-mode 1)
  (run-at-time nil (* 5 60) 'recentf-save-list)
  (setq
   ;; recentf-save-file (expand-file-name "recentf" prelude-savefile-dir)
   recentf-max-saved-items 1000
   recentf-max-menu-items 60
   ;; disable recentf-cleanup on Emacs start, because it can cause
   ;; recentf-auto-cleanup 'never ;; problems with remote files
   recentf-auto-cleanup 600  ;; clean up the recent files
   ;; exclude ** from recentfiles buffer
   recentf-exclude '("^/var/folders\\.*"
                     "COMMIT_MSG"
                     "[0-9a-f]\\{32\\}-[0-9a-f]\\{32\\}\\.org"
                     "github.*txt$"
                     "COMMIT_EDITMSG\\'"
                     ".*-autoloads\\.el\\'"
                     "recentf"
                     ".*pang$" ".*cache$"
                     "[/\\]\\.elpa/")))


;; emacs daemon
(server-start)

;; Display on frame title the name of the file, host and some information
(setq frame-title-format
'("emacs%@" (:eval (system-name)) ": " (:eval (if (buffer-file-name)
(abbreviate-file-name (buffer-file-name))
"%b")) " [%*]"))

;; remove toolbar
(tool-bar-mode -1)

;; disable to scroll bar
(scroll-bar-mode -1)

;; make cursor the width of the character it is under
;; i.e. full width of a TAB
(setq x-stretch-cursor t)

;; keep a list of recently opened files, available using F7
(recentf-mode 1)
(global-set-key (kbd "<f7>") 'recentf-open-files)

;; to have a smart C-a navigation
(defun smarter-move-beginning-of-line (arg)
  "Move point back to indentation of beginning of line.
Move point to the first non-whitespace character on this line.
If point is already there, move to the beginning of the line.
Effectively toggle between the first non-whitespace character and
the beginning of the line.
If ARG is not nil or 1, move forward ARG - 1 lines first.  If
point reaches the beginning or end of the buffer, stop there."
  (interactive "^p")
  (setq arg (or arg 1))
  ;; Move lines first
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))
;; remap C-a to `smarter-move-beginning-of-line'
(global-set-key [remap move-beginning-of-line]
                'smarter-move-beginning-of-line)


;; Turn on font-lock mode to color text in certain modes 
(global-font-lock-mode t)

;; Show line and column position of cursor
(column-number-mode 1)

;; Make sure spaces are used when indenting code
(setq-default indent-tabs-mode nil)

;; Using single space after dots to define the end of sentences
(setq sentence-end-double-space nil)

;; Add proper word wrapping
(global-visual-line-mode t)

;; C-home goes to the start, C-end goes to the end of the file
(global-set-key (kbd "<C-home>")
  (lambda()(interactive)(goto-char(point-min))))
(global-set-key (kbd "<C-end>")
  (lambda()(interactive)(goto-char(point-max))))

;; save cursor position between sessions
(require 'saveplace)
(setq-default save-place t)

;; make all "yes or no" prompts show "y or n" instead
(fset 'yes-or-no-p 'y-or-n-p)

;; Toggles between horizontal and vertical layout of two windows
(defun toggle-window-split ()
  (interactive)
  (if (= (count-windows) 2)
      (let* ((this-win-buffer (window-buffer))
             (next-win-buffer (window-buffer (next-window)))
             (this-win-edges (window-edges (selected-window)))
             (next-win-edges (window-edges (next-window)))
             (this-win-2nd (not (and (<= (car this-win-edges)
                                         (car next-win-edges))
                                     (<= (cadr this-win-edges)
                                         (cadr next-win-edges)))))
             (splitter
              (if (= (car this-win-edges)
                     (car (window-edges (next-window))))
                  'split-window-horizontally
                'split-window-vertically)))
        (delete-other-windows)
        (let ((first-win (selected-window)))
          (funcall splitter)
          (if this-win-2nd (other-window 1))
          (set-window-buffer (selected-window) this-win-buffer)
          (set-window-buffer (next-window) next-win-buffer)
          (select-window first-win)
          (if this-win-2nd (other-window 1))))))
(global-set-key (kbd "C-c m") 'toggle-window-split)

;; For searching and replacing
(setq search-highlight t                 ;; highlight when searching... 
  query-replace-highlight t)             ;; ...and replacing
(setq completion-ignore-case t           ;; ignore case when completing...
  read-file-name-completion-ignore-case t) ;; ...filenames too

;; key board / input method settings
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(set-language-environment "UTF-8")       ; prefer utf-8 for language settings
(set-input-method nil)                   ; no funky input for normal editing;
(setq read-quoted-char-radix 10)         ; use decimal, not octal

;; Word count in selected region
(defun count-words-region ()
  (interactive)
  (message "Word count: %s" (how-many "\\w+" (point) (mark))))

;; To put deleted files in trash can
(setq delete-by-moving-to-trash t)

;; Backup and file versions
;; to save the backups on .emacs.d
(setq backup-directory-alist
      `(("." . ,(concat user-emacs-directory "backup/")))
      tramp-backup-directory-alist backup-directory-alist)
;; to keep some old versions of all files edited with Emacs
(setq delete-old-versions t
  kept-new-versions 20
  kept-old-versions 20
  version-control t) ;;to also backup files under version control
