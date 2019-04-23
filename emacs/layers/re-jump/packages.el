(defconst re-jump-packages
  '((re-jump :location (recipe :fetcher github
                               :repo "oliyh/re-jump.el"))))

(defun re-jump/init-re-jump ()
  (use-package re-jump))
