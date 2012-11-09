(let ((default-directory "~/.emacs.d/site-lisp/"))
  (setq load-path (cons default-directory load-path))
  (normal-top-level-add-subdirs-to-load-path))

;; GUIセッティング ========================================

;;Color
(if window-system (progn
   (set-background-color "Black")
   (set-foreground-color "LightGray")
   (set-cursor-color "Gray")
   (set-frame-parameter nil 'alpha 90)
   ))

(set-default-font "ricty-13.5:spacing=0")
(add-to-list 'default-frame-alist '(font . "ricty-13.5"))

;; 基本設定 ========================================

;; バックアップファイルを作らない
(setq backup-inhibited t)
(setq make-backup-files nil)
(setq delete-auto-save-files t)

;; バックアップファイル（ファイル名~）の設定
(setq backup-enable-predicate
      (lambda (name) nil))
;; 自動保存ファイル（#ファイル名#）の設定
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; UTF-8 セッティング
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-clipboard-coding-system 'sjis-mac)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)

;; auto follow synbolic link
(setq vc-follow-symlinks t)
(setq auto-revert-check-vc-info t)

;; Elisp : anything : すごいの ========================
(require 'anything-startup)
(global-set-key (kbd "C-c f") 'anything-recentf)
(global-set-key (kbd "M-y") 'anything-show-kill-ring) 
(global-set-key (kbd "C-x b") 'anything-for-files) 

;; Elisp : auto-install : オートインストール ========================
;(require 'auto-install)
;(setq auto-install-directory "~/.emacs.d/auto-install/")
;(auto-install-update-emacswiki-package-name t)
;(auto-install-compatibility-setup)

;; Elisp : jaspace : 全角空白を表示させる ========================
(require 'jaspace)
(setq jaspace-alternate-jaspace-string "□") ;; 全角空白を表示させる
(setq jaspace-alternate-eol-string "↓\n") ;; 改行記号を表示させる
(setq jaspace-highlight-tabs ?^) ;; タブを表示
(add-hook 'fundamental-mode-hook 'jaspace-mode)
(add-hook 'js2-mode-hook 'jaspace-mode)
(add-hook 'yaml-mode-hook 'jaspace-mode)
(add-hook 'perl-mode-hook 'jaspace-mode)
(add-hook 'cperl-mode-hook 'jaspace-mode)
(add-hook 'python-mode-hook 'jaspace-mode)
(add-hook 'ruby-mode-hook 'jaspace-mode)
(add-hook 'php-mode-hook 'jaspace-mode)
(add-hook 'xml-mode-hook 'jaspace-mode)
(add-hook 'html-mode-hook 'jaspace-mode)
(add-hook 'sgml-mode-hook 'jaspace-mode)
(add-hook 'text-mode-hook 'jaspace-mode)
(add-hook 'tt-mode-hook 'jaspace-mode)

;; ELisp : auto-complete  ========================
(require 'auto-complete)
(global-auto-complete-mode t)

;; 編集画面 =========================================

;; 行数表示
(global-linum-mode)
(setq linum-format "%4d  ")

;; 対応するカッコをハイライト
(show-paren-mode 1)

;; タイトルバーに現在のファイル名を表示する
(setq frame-title-format (format "%%f - Emacs@%s" (system-name)))

;; キーバインド ====================================

;; シフト + 矢印で範囲選択
;(setq pc-select-selection-keys-only t)
;(pc-selection-mode 1)
(setq shift-select-mode t)

;; commandキーとoptionキーを入れ替え
(setq ns-command-modifier (quote meta))
(setq ns-alternate-modifier (quote super))

;; Ctrl-H でヘルプを表示させずに Backspace を機能させる
(keyboard-translate ?\C-h ?\177)
;;(keyboard-translate ?\177 ?\C-h)

;; バッファ切り替え
(global-set-key "\M-n" 'next-buffer)
(global-set-key "\M-p" 'previous-buffer)

;; フレーム移動
(global-set-key (kbd "C-t")     'next-multiframe-window)
(global-set-key (kbd "C-S-t")   'previous-multiframe-window)

;; アンドゥ
(global-set-key (kbd "C-/")     'undo)

;; 拡張機能 ========================================

;; redo+
(require 'redo+)
(global-set-key (kbd "C-M-/") 'redo)
(setq undo-no-redo t)
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; ElScreen
;(setq elscreen-prefix-key "\C-z")
;(setq elscreen-display-tab t)
;(load "elscreen")
;(global-set-key "\M-t" 'elscreen-create)
;(global-set-key "\M-T" 'elscreen-clone)
;(global-set-key "\M-}" 'elscreen-next)
;(global-set-key "\M-{" 'elscreen-previous)

;; Align
(require 'align)

;; 言語対応

;; CSS ( css-mode )
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
      (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(setq cssm-indent-function #'cssm-c-style-indenter)

;; JS ( js2-mode )
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))

;; Ruby ( ruby-mode )
;; ruby-mode
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda () (inf-ruby-keys)))

;; ruby-electric
(require 'ruby-electric)
(add-hook 'ruby-mode-hook '(lambda () (ruby-electric-mode t)))
