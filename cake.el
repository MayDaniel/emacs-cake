(require 'cl)

(defgroup cake nil
  "Run Cake commands from Emacs."
  :prefix "cake-"
  :group 'applications)

(defun cake-command (args)
  (interactive "sArguments: ")
  (compile (concat "cake " args)))

(defmacro defun-cake-task (task)
  `(defun ,(intern (concat "cake-" task)) ()
     (interactive)
     (cake-command ,task)))

(defmacro defun-cake-interactive-task (task)
  `(defun ,(intern (concat "cake-" task)) (args)
     (interactive "sArguments: ")
     (cake-command (concat ,task " " args))))

(dolist (task '(compile deps clean deps autotest jar uberjar bin install release upgrade war uberwar version kill stop restart reload ps kill autodoc))
  (eval `(defun-cake-task ,(symbol-name task))))

(dolist (task '(help run test eval filter swank))
  (eval `(defun-cake-interactive-task ,(symbol-name task))))

(provide 'cake)
