;; ---------------------------------------------
;; ��{�ݒ�
;; ---------------------------------------------

;; (setq default-directory "c:/Users/kosuke")            ; �����f�B���N�g����ݒ� ����������_���B�G���[���N�����B�i�d���Ȃ��āA�I���������Ă��ł��Ȃ��B�j
;; (setq default-directory "c:/Users/kosuke")            ; �����f�B���N�g����ݒ� ����������_���B

;(cd "~/")	       	; C:/Users/kosuke�������f�B���N�g���ɂ���

;; paren-mode ���ʂ��n�C���C�g
(setq show-paren-delay 0)
(show-paren-mode t)
;; paren�̃X�^�C��: expression�͊��ʓ��������\��
;(setq show-paren-style 'expression)
(setq show-paren-style 'parenthesis)
;; �t�F�C�X��ύX����
(set-face-background 'show-paren-match-face "SlateBlue2") ;���ʂ�background�ɐF�t������B���Ȃ�nil�ɂ���΂����B
;(set-face-underline-p 'show-paren-match-face nil)  ;underline�������Ȃ炱������nil��"color"�ɕύX



;; load-path��ǉ�����֐����`
(defun add-to-load-path (&rest paths)
  (let(path)
    (dolist (path paths paths)
      (let((default-directory
	     (expand-file-name (concat user-emacs-directory path))))
	(add-to-list 'load-path default-directory)
	(if (fboundp 'normal-top-level-add-subdirs-to-load-path)
	    (normal-top-level-add-subdirs-to-load-path))))))

;; �����̃f�B���N�g���Ƃ��̃T�u�f�B���N�g����load-path�ɒǉ�
(add-to-load-path "elisp" "conf" "public_repos")


;; auto-install�̐ݒ�
(when (require 'auto-install nil t)
  ;; Install directory�̐ݒ�
  (setq auto-install-directory "~/.emacs.d/elisp/")
  ;; EmacsWiki�ɓo�^����Ă���elisp�̖��O���擾
  (auto-install-update-emacswiki-package-name t)
  ;; �K�v�ł���΃v���L�V�̐ݒ���s��
  ;; (setq url-proxy-services '(("http" . "localhost:8339")))
  ;; install-elisp�̊֐��𗘗p�\�ɂ���
  (auto-install-compatibility-setup))


;; /elisp/auto-install.el �̓ǂݍ���
;; (load "auto-install")

;; redo+�̐ݒ�
(when (require 'redo+ nil t)
  ;; C-'��redo�����蓖��
  ;;
 (global-set-key (kbd "C-'") 'redo)
  ;; ���{��L�[�{�[�h�̏ꍇC-.�Ȃǂ��ǂ�����
  (global-set-key (kbd "C-.") 'redo)
		  )

;;; anything
;;  (auto-install-batch "anything")
(when (require 'anything nil t)
  (setq
   ;; ����\������܂ł̎��ԁB�f�t�H���g��0.5
   anything-idle-delay 0.3
   ;; �^�C�v���čĕ`�悷��܂ł̎��ԁB�f�t�H���g��0.1
   anything-input-idle-delay 0.2
   ;; ���̍ő�\�����B�f�t�H���g��50
   anything-candidate-number-limit 100
   ;; ��₪�����Ƃ��ɑ̊����x�𑁂�����
   anything-quick-update t
   ;; ���I���V���[�g�J�b�g���A���t�@�x�b�g��
   anything-enable-shortcuts 'alphabet)

  (when (require 'anything-config nil t)
    ;; root�����ŃA�N�V���������s����Ƃ��̃R�}���h
    ;; �f�t�H���g��"su"
    (setq anything-su-or-sudo "sudo"))

  (require 'anything-match-plugin nil t)

  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (require 'anything-migemo nil t))

  (when (require 'anythingcomplete nil t)
    ;; lisp�V���{���̕⊮���̍Č�������
    (anything-lisp-complete-symbol-set-timer 150))

  (require 'anything-show-completion nil t)

  (when (require 'auto-install nil t)
    (require 'anything-auto-install nil t))

  (when (require 'descbinds-anything nil t)
    ;; describe-bindings��Anything�ɒu��������
    (descbinds-anything-install)))
;; M-y��anything-show-kill-ring�����蓖�Ă�
(define-key global-map (kbd "M-y") 'anything-show-kill-ring)

;; �vcolor-moccur.el
(when (require 'anything-c-moccur nil t)
  (setq
   ;; anything-c-moccur�p 'anything-idle-delay'
   anything-c-moccur-anything-idle-delay 0.1
   ;; �o�b�t�@�̏����n�C���C�g����
   anything-c-moccur-higligt-info-line-flag t
   ;; ���ݑI�𒆂̌��̈ʒu���ق���windows�ɕ\������
   anything-c-moccur-enable-initial-pattern t)
  ;; C-M-o��anything-c-moccur-occur-by-moccur�����蓖�Ă�
  (global-set-key (kbd "C-M-o") 'anything-c-moccur-occur-by-moccur))







;; ---------------------------------------------
;; �L�[�o�C���h
;; ---------------------------------------------

; �o�b�t�@�ꗗ���g���Ղ�
(global-set-key "\C-x\C-b" 'buffer-menu)

; C-h���o�b�N�X�y�[�X��
(global-set-key "\C-h" 'delete-backward-char)

; C-h �Ɋ��蓖�Ă��Ă���֐� help-command �� C-x C-h �Ɋ��蓖�Ă�
(define-key global-map "\C-x\C-h" 'help-command)

; help-for-help �� F1��
(global-set-key [f1] 'help-for-help)



;(add-to-list 'load-path "~/.emacs.d/elisp/")
;(require 'auto-complete-config)
;(add-to-list 'ac-dictionary-directories "~/.emacs.d/elisp//ac-dict")
;(ac-config-default)


; auto-complete�̐ݒ�
(when (require 'auto-complete-config nil t)
  (add-to-list 'ac-dictionary-directories
  "~/.emacs.d/elisp/ac-dict")
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default))

;; color-moccur�̐ݒ�
(when (require 'color-moccur nil t)
  ;; M-o��occur-by-moccur�����蓖��
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  ;; �X�y�[�X��؂��AND����
  (setq moccur-spig-word t)
  ;; �f�B���N�g�������̂Ƃ����O����t�@�C��
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$")
  ;; Migemo�𗘗p�ł�����ł����Migemo���g��
  (when (and (executable-find "cmigemo")
	     (require 'migemo nil t))
    (setq moccur-use-migemo t)))
;; 24.3���炱�̕�����Ȃ��ƃG���[�ɂȂ�Ƃ��H�H
(setq search-whitespace-regexp nil)

;; moccur-edit�̐ݒ�
(require 'moccur-edit nil t)

;; undohist�̐ݒ�
(when (require 'undohist nil t)
  (undohist-initialize))

;; undo-tree�̐ݒ�
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;; package.el�̐ݒ�
(when (require 'package nil t)
  ;; �p�b�P�[�W���|�W�g����Marmalade�ƊJ���҉^�c��ELPA��ǉ�
  (add-to-list 'package-archives
	       '("marmalade" . "http://marmalade-repo.org/packages/"))
  (add-to-list 'package-archives '("ELPA" . "http://tromey.com/elpa/"))
  ;; �C���X�g�[�������p�b�P�[�W�Ƀ��[�h�p�X��ʂ��ēǂݍ���
  (package-initialize))

;; point-undo�̐ݒ�
(when (require 'point-undo nil t)
  ;;(define-key global-map [f5] 'point-undo)
  ;;(define-key global-map [f6] 'point-redo)
  (define-key global-map (kbd "M-[") 'point-undo)
  (define-key global-map (kbd "M-]") 'point-redo)
  )


;; cssm-mode �̐ݒ�
;; css-mode ���㏑�����Ă���B����css-mode�𗘗p�������ꍇ��cssm-mode�𗘗p���Ă���css-mode.el��css-mode.elc���폜����΂���
(defun css-mode-hooks ()
  "css-mode hooks"
  ;; �C���f���g��C�X�^�C���ɂ���
  (setq cssm-indent-function #'cssm-c-style-indenter)
  ;; �C���f���g����2�ɂ���
  (setq cssm-indent-level 2)
  ;; �C���f���g�Ƀ^�u�������g��Ȃ�
  (setq-default indent-tabs-mode nil)
  ;; ���������̑O�ɉ��s��}������
  (setq cssm-newline-before-closing-bracket t))

(add-hook 'css-mode-hook 'css-mode-hooks)


;;; ruby minor mode �̊e��ݒ�
;; ruby-electric
;; ���ʂ̎����}��
(require 'ruby-electric nil t)
;; end�ɑΉ�����s�̃n�C���C�g
(when (require 'ruby-block nil t)
  (setq ruby-block-highlight-toggle t))
;; �C���^���N�e�B�uRuby�𗘗p����
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")

;; ruby-mode-hook�p�̊֐����`
(defun ruby-mode-hooks ()
  (inf-ruby-keys)
  (ruby-electric-mode t)
  (ruby-block-mode t))
;; ruby-mode-hook�ɒǉ�
(add-hook 'ruby-mode-hook 'ruby-mode-hooks)


;;flymake�̓ǂݍ���
(require 'flymake nil t)
;; flymake-cursor�̓ǂݍ��݁B
(require 'flymake-cursor nil t)


;; flymake�ŉ��̃��C�����G���[���b�Z�[�W��\��
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

;; �G���[�����W�����v����@�R�}���h���蓖�āB
(global-set-key "\M-n" 'flymake-goto-next-error)
(global-set-key "\M-p" 'flymake-goto-prev-error)




;;; C����n��Flymake�̐ݒ�
(add-hook 'c++-mode-hook
	  '(lambda ()
	     (flymake-mode t)))
;; Makefile�̎�ނ��`
(defvar flymake-makefile-filenames
  '("Makefile" "makefile" "GNUmakefile")
  "File names for make.")

;; Makefile���Ȃ���΃R�}���h�𒼐ڗ��p����R�}���h���C���𐶐�
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

;; Flymake�������֐��̐���
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

;; �����֐��̒�`
(defun flymake-simple-make-gcc-init ()
  (message "%s" (flymake-simple-make-gcc-init-impl
		 'flymake-create-temp-inplace t t "Makefile"
		 'flymake-get-make-gcc-cmdline))
  (flymake-simple-make-gcc-init-impl
   'flymake-create-temp-inplace t t "Makefile"
   'flymake-get-make-gcc-cmdline))

;; �g���q .c,.cpp, .c++�Ȃǂ̎��ɏ�L�֐��𗘗p
(add-to-list 'flymake-allowed-file-name-masks
;;	     '("a.cpp"
;;	     '(".+\.\(c\|cpp\|c++\)"
	     '("\\.\\(?:c\\(?:pp\\|xx\\|\\+\\+\\)?\\|CC\\)\\'"
	       flymake-simple-make-gcc-init))



;;;Flycheck�ɂ��flymake�̎����B
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
;;;�v���r���[���̐ݒ�
(setq dvi2-command "c:/w32tex/dviout/dviout") ;windows�p�̐ݒ�
;(setq dvi2-command "xdvi -geo 950x940+0+0 -s 3 -display $DISPLAY")

;;����R�}���h
(setq dviprint-command-format "dvipdfmx %s ")
;(setq dviprint-command-format "dvips -f %f %t %s | lpr")
(setq dviprint-from-format "-p %b")
(setq dviprint-to-format "-l %e")

;; ���͍쐬���̓��{�ꕶ���R�[�h
;; 0: no-converion
;; 1: Shift JIS (windows & dos default)
;; 2: ISO-2022-JP (other default)
;; 3: EUC
;; 4: UTF-8
(setq YaTeX-kanji-code 1)
;;help file
(setq YaTeX-help-file "~/.vine-opt/share/emacs/site-lisp/YATEXHLP.jp")

;;;�J�X�^�}�C�Y
;;;AMS-LaTeX ���g��
(setq YaTeX-use-AMS-LaTeX t)

;;section�^��Ԃ̋K��l
;(setq section-name "section")

;;Begin �V���[�g�J�b�g�̋֎~(�����Ȃ�⊮����)
;(setq YaTeX-no-begend-shortcut t)

;;�����̐F�t��
(if (featurep 'hilit19)
      (hilit-translate
       formula 'DeepPink1))

;;[prefix] g �ő���̃t�@�C�����Ȃ�������V�K�쐬 
(setq YaTeX-create-file-prefix-g t)

;;�������[�h��";"��Ԃ̋���
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
;;�������[�h��","���
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

;; Yatex-mode �� hook �ݒ�
(add-hook 'yatex-mode-hook
	  '(lambda()
	    (local-set-key "\C-c\C-c" "\C-ctj")
	    (fset 'align-for-YaTeX
   [?\C-c ?b ?  ?a ?l ?i ?g ?n return])
	    (local-set-key "\C-c\C-a" 'align-for-YaTeX)
	    ))



;;; multi-term�̐ݒ�
;(when (require 'multi-term nil t)
;  ;; �g�p����V�F�����w��
;  (setq multi-term-program "c:/shell.w32-ix86/bash.exe") ;;�����Windows��p�̐ݒ�
;  )

;; ELScreen�̐ݒ�
;; prefix key�̕ύX(�����lC-z)
;; (setq elscreen-prefix-key (kbd "C-t"))
(when (require 'elscreen nil t)
  ;; C-z C-z�𗘗p�����ꍇ��Emacs Default��C-z�𗘗p����
  (if window-system
      (define-key elscreen-map (kbd "C-z") 'iconify-or-deiconify-frame)
    (define-key elscreen-map (kbd "C-z") 'suspend-emacs)))
