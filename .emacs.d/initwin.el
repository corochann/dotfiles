;; ---------------------------------------------
;; 基本設定
;; ---------------------------------------------

;; (setq default-directory "c:/Users/kosuke")            ; 初期ディレクトリを設定 これやっちゃダメ。エラーが起きた。（重くなって、終了したくてもできない。）
;; (setq default-directory "c:/Users/kosuke")            ; 初期ディレクトリを設定 これやっちゃダメ。

;(cd "~/")	       	; C:/Users/kosukeを初期ディレクトリにする

;; paren-mode 括弧をハイライト
(setq show-paren-delay 0)
(show-paren-mode t)
;; parenのスタイル: expressionは括弧内も強調表示
;(setq show-paren-style 'expression)
(setq show-paren-style 'parenthesis)
;; フェイスを変更する
(set-face-background 'show-paren-match-face "SlateBlue2") ;括弧のbackgroundに色付けする。嫌ならnilにすればいい。
;(set-face-underline-p 'show-paren-match-face nil)  ;underlineがいいならこっちのnilを"color"に変更



;; load-pathを追加する関数を定義
(defun add-to-load-path (&rest paths)
  (let(path)
    (dolist (path paths paths)
      (let((default-directory
	     (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; 引数のディレクトリとそのサブディレクトリをload-pathに追加
(add-to-load-path "elisp" "conf" "public_repos")


;; auto-installの設定
(when (require 'auto-install nil t)
  ;; Install directoryの設定
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWikiに登録されているelispの名前を取得
  (auto-install-update-emacswiki-package-name t)
  ;; 必要であればプロキシの設定を行う
  ;; (setq url-proxy-services '(("http" . "localhost:8339")))
  ;; install-elispの関数を利用可能にする
  (auto-install-compatibility-setup))


;; /elisp/auto-install.el の読み込み
;; (load "auto-install")

;; redo+の設定
(when (require 'redo+ nil t)
  ;; C-'にredoを割り当て
  ;;
 (global-set-key (kbd "C-'") 'redo)
  ;; 日本語キーボードの場合C-.などが良いかも
  (global-set-key (kbd "C-.") 'redo)
		  )

;;; anything
;;  (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   ;; 候補を表示するまでの時間。デフォルトは0.5
   anything-idle-delay 0.3
   ;; タイプして再描画するまでの時間。デフォルトは0.1
   anything-input-idle-delay 0.2
   ;; 候補の最大表示数。デフォルトは50
   anything-candidate-number-limit 100
   ;; 候補が多いときに体感速度を早くする
   anything-quick-update t
   ;; 候補選択ショートカットをアルファベットに
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root権限でアクションを実行するときのコマンド
    ;; デフォルトは"su"
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anythingcomplete nil t)
    ;; lispシンボルの補完候補の再検索時間
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    ;; describe-bindingsをAnythingに置き換える
    (descbinds-anything-install)))
;; M-yにanything-show-kill-ringを割り当てる
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;; 要color-moccur.el
(when (require 'anything-c-moccur nil t)
  (setq
   ;; anything-c-moccur用 'anything-idle-delay'
   anything-c-moccur-anything-idle-delay 0.1
   ;; バッファの情報をハイライトする
   anything-c-moccur-higligt-info-line-flag t
   ;; 現在選択中の候補の位置をほかのwindowsに表示する
   anything-c-moccur-enable-initial-pattern t)
  ;; C-M-oにanything-c-moccur-occur-by-moccurを割り当てる
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))







;; ---------------------------------------------
;; キーバインド
;; ---------------------------------------------

; バッファ一覧を使い易く
(global-set-key "\C-x\C-b" 'buffer-menu)

; C-hをバックスペースに
(global-set-key "\C-h" 'delete-backward-char)

; C-h に割り当てられている関数 help-command を C-x C-h に割り当てる
(define-key global-map "\C-x\C-h" 'help-command)

; help-for-help を F1に
(global-set-key [f1] 'help-for-help)



;(add-to-list 'load-path "~/.emacs.d/elisp/")
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp//ac-dict")
;(ac-config-default)


; auto-completeの設定
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
  "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;; color-moccurの設定
(when (require 'color-moccur nil t)
  ;; M-oにoccur-by-moccurを割り当て
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; スペース区切りでAND検索
  (setq moccur-spig-word t)
  ;; ディレクトリ検索のとき除外するファイル
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  ;; Migemoを利用できる環境であればMigemoを使う
  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (setq moccur-use-migemo t)))
;; 24.3からこの文いれないとエラーになるとか？？
(setq search-whitespace-regexp nil)

;; moccur-editの設定
(require 'moccur-edit nil t)

;; undohistの設定
(when (require 'undohist nil t)
  (undohist-initialize))

;; undo-treeの設定
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; package.elの設定
(when (require 'package nil t)
  ;; パッケージレポジトリにMarmaladeと開発者運営のELPAを追加
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  ;; インストールしたパッケージにロードパスを通して読み込む
  (package-initialize))

;; point-undoの設定
(when (require 'point-undo nil t)
  ;;(define-key global-map [f5] 'point-undo)
  ;;(define-key global-map [f6] 'point-redo)
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo)
  )


;; cssm-mode の設定
;; css-mode を上書きしている。元のcss-modeを利用したい場合はcssm-modeを利用しているcss-mode.elとcss-mode.elcを削除すればいい
(defun css-mode-hooks ()
  "css-mode hooks"
  ;; インデントをCスタイルにする
  (setq cssm-indent-function #'cssm-c-style-indenter)
  ;; インデント幅を2にする
  (setq cssm-indent-level 2)
  ;; インデントにタブ文字を使わない
  (setq-default indent-tabs-mode nil)
  ;; 閉じかっこの前に改行を挿入する
  (setq cssm-newline-before-closing-bracket t))

(add-hook 'css-mode-hook 'css-mode-hooks)


;;; ruby minor mode の各種設定
;; ruby-electric
;; 括弧の自動挿入
(require 'ruby-electric nil t)
;; endに対応する行のハイライト
(when (require 'ruby-block nil t)
  (setq ruby-block-highlight-toggle t))
;; インタラクティブRubyを利用する
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

;; ruby-mode-hook用の関数を定義
(defun ruby-mode-hooks ()
  (inf-ruby-keys)
  (ruby-electric-mode t)
  (ruby-block-mode t))
;; ruby-mode-hookに追加
(add-hook 'ruby-mode-hook 'ruby-mode-hooks)


;;flymakeの読み込み
(require 'flymake nil t)
;; flymake-cursorの読み込み。
(require 'flymake-cursor nil t)


;; flymakeで下のラインいエラーメッセージを表示
(defun my-flymake-display-err-menu-for-current-line ()
  "Displays the error/warning for the current line via popup-tip"
  (interactive)
  (let* ((line-no (flymake-current-line-no))
         (line-err-info-list (nth 0 (flymake-find-err-info flymake-err-info line-no)))
         (menu-data (flymake-make-err-menu-data line-no line-err-info-list)))
    (if menu-data
        (popup-tip (mapconcat #'(lambda (err)
                                  (nth 0 err))
                              (nth 1 menu-data) "\n")))))

;; エラー文をジャンプする　コマンド割り当て。
(global-set-key "\M-n" 'flymake-goto-next-error)
(global-set-key "\M-p" 'flymake-goto-prev-error)




;;; C言語系のFlymakeの設定
(add-hook 'c++-mode-hook
	  '(lambda ()
	     (flymake-mode t)))
;; Makefileの種類を定義
(defvar flymake-makefile-filenames
  '("Makefile" "makefile" "GNUmakefile")
  "File names for make.")

;; Makefileがなければコマンドを直接利用するコマンドラインを生成
(defun flymake-get-make-gcc-cmdline (source base-dir)
  (let (found)
    (dolist (makefile flymake-makefile-filenames)
      (if (file-readable-p (concat base-dir "/" makefile))
	  (setq found t)))
    (if found
	(list "make"
	      (list "-s"
		    "-C"
		    base-dir
		    (concat "CHK_SOURCES=" source)
		    "SYNTAX_CHECK_MODE=1"
		    "check-syntax"))
      (list (if (string= (file-name-extension source) "c") "gcc" "g++")
	    (list "-o"
		  "/dev/null"
		  "-fsyntax-only"
		  "-Wall"
		  source)))))

;; Flymake初期化関数の生成
(defun flymake-simple-make-gcc-init-impl
  (create-temp-f use-relative-base-dir
		 use-relative-source build-file-name get-cmdline-f)
  "Create syntax check command line for a directly checked source file.
Use CREATE-TEMP-F for creating temp copy."
  (let* ((args nil)
	 (source-file-name buffer-file-name)
	 (buildfile-dir (file-name-directory source-file-name)))
    (if buildfile-dir
	(let* ((temp-source-file-name
		(flymake-init-create-temp-buffer-copy create-temp-f)))
	  (setq args
		(flymake-get-syntax-check-program-args
		 temp-source-file-name
		 buildfile-dir
		 use-relative-base-dir
		 use-relative-source
		 get-cmdline-f))))
    args))

;; 初期関数の定義
(defun flymake-simple-make-gcc-init ()
  (message "%s" (flymake-simple-make-gcc-init-impl
		 'flymake-create-temp-inplace t t "Makefile"
		 'flymake-get-make-gcc-cmdline))
  (flymake-simple-make-gcc-init-impl
   'flymake-create-temp-inplace t t "Makefile"
   'flymake-get-make-gcc-cmdline))

;; 拡張子 .c,.cpp, .c++などの時に上記関数を利用
(add-to-list 'flymake-allowed-file-name-masks
;;	     '("a.cpp"
;;	     '(".+\.\(c\|cpp\|c++\)"
	     '("\\.\\(?:c\\(?:pp\\|xx\\|\\+\\+\\)?\\|CC\\)\\'"
	       flymake-simple-make-gcc-init))



;;;Flycheckによるflymakeの実装。
(require 'flycheck)
;; Python
;(add-hook 'python-mode-hook 'flycheck-mode)

;; Ruby
;(add-hook 'ruby-mode-hook 'flycheck-mode)

;; Latex
;;; YaTeX-mode
(setq auto-mode-alist  (cons (cons "\\.tex$" 'yatex-mode) auto-mode-alist))
(autoload 'yatex-mode "yatex" "Yet Another LaTeX mode" t)
;(setq load-path (cons "~/src/yatex" load-path))
(setq tex-command "platex")
;;;プレビューワの設定
(setq dvi2-command "c:/w32tex/dviout/dviout") ;windows用の設定
;(setq dvi2-command "xdvi -geo 950x940+0+0 -s 3 -display $DISPLAY")

;;印刷コマンド
(setq dviprint-command-format "dvipdfmx %s ")
;(setq dviprint-command-format "dvips -f %f %t %s | lpr")
(setq dviprint-from-format "-p %b")
(setq dviprint-to-format "-l %e")

;; 文章作成時の日本語文字コード
;; 0: no-converion
;; 1: Shift JIS (windows & dos default)
;; 2: ISO-2022-JP (other default)
;; 3: EUC
;; 4: UTF-8
(setq YaTeX-kanji-code 1)
;;help file
(setq YaTeX-help-file "~/.vine-opt/share/emacs/site-lisp/YATEXHLP.jp")

;;;カスタマイズ
;;;AMS-LaTeX を使う
(setq YaTeX-use-AMS-LaTeX t)

;;section型補間の規定値
;(setq section-name "section")

;;Begin ショートカットの禁止(いきなり補完入力)
;(setq YaTeX-no-begend-shortcut t)

;;数式の色付け
(if (featurep 'hilit19)
      (hilit-translate
       formula 'DeepPink1))

;;[prefix] g で相手のファイルがなかったら新規作成 
(setq YaTeX-create-file-prefix-g t)

;;数式モードの";"補間の強化
(setq YaTeX-math-sign-alist-private
      '(("q"         "quad"          "__")
	("qq"        "qquad"         "____")
	("ls"        "varlimsup"     "___\nlim")
	("li"        "varliminf"     "lim\n---")
	("il"        "varinjlim"     "lim\n-->")
       ;("st"        "text{ s.~t. }" "s.t.")
	("bigop"     "bigoplus"      "_\n(+)~")
	("bigot"     "bigotimes"     "_\n(x)\n ~")
	("pl"        "varprojlim"    "lim\n<--")
	))
;;数式モードの","補間
(setq YaTeX-math-funcs-list
      '(("s"	"sin"           "sin")
	("c"    "cos"           "cos") 
	("t"    "tan"           "tan")
	("hs"	"sinh"          "sinh")
	("hc"   "cosh"          "cosh")
	("ht"   "tanh"          "tanh")
	("S"	"arcsin"        "arcsin")
	("C"    "arccos"        "arccos")
	("T"    "arctan"        "arctan")
	("se"   "sec"           "sec")
	("cs"   "csc"           "csc")
	("cot"  "cot"           "cot")
	("l"    "ln"            "ln")
	("L"    "log"           "log")
	("e"    "exp"           "exp")
	("M"    "max"           "max")
	("m"    "min"           "min")
	("su"   "sup"           "sup")
	("in"   "inf"           "inf")
	("di"   "dim"           "dim")
	("de"   "det"           "det")
	("i"    "imath"         "i")
	("j"    "jmath"         "j")
	("I"    "Im"            "Im")
	("R"    "Re"            "Re")
	))
(setq YaTeX-math-key-list-private
      '(("," . YaTeX-math-funcs-list)
	))

;; Yatex-mode の hook 設定
(add-hook 'yatex-mode-hook
	  '(lambda()
	    (local-set-key "\C-c\C-c" "\C-ctj")
	    (fset 'align-for-YaTeX
   [?\C-c ?b ?  ?a ?l ?i ?g ?n return])
	    (local-set-key "\C-c\C-a" 'align-for-YaTeX)
	    ))



;;; multi-termの設定
;(when (require 'multi-term nil t)
;  ;; 使用するシェルを指定
;  (setq multi-term-program "c:/shell.w32-ix86/bash.exe") ;;これはWindows専用の設定
;  )

;; ELScreenの設定
;; prefix keyの変更(初期値C-z)
;; (setq elscreen-prefix-key (kbd "C-t"))
(when (require 'elscreen nil t)
  ;; C-z C-zを利用した場合にEmacs DefaultのC-zを利用する
  (if window-system
      (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
    (define-key elscreen-map (kbd "C-z") 'suspend-emacs)))
