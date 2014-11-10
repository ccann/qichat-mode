# qichat-mode

An Emacs major mode for editing and interacting with qichat files.

This is a work in progress and I'll be adding keybindings and functionality regularly.


## Installation

Add the following to your `init.el`, replacing :

```elisp
(add-to-list 'load-path "path/to/qichat-mode")
(require 'qichat-mode)
```

And you’re done!

## Keybindings

```elisp
C-c p  ;; insert proposal
C-c u  ;; insert user rule
C-c e  ;; insert user rule and event
C-c SPC  ;; insert pause, specify length
C-c t  ;; test buffer (requires an active local naoqi session)
```

## Useful Hook

This is my qichat mode hook:

```elisp
(add-hook 'qichat-mode-hook (lambda ()
                              (linum-mode 1)  ;; show line numbers
                              (subword-mode 1)  ;; navigate camelCase words
                              (fci-mode 1)))  ;; turn on fill-column indicator
```

## TODO
- add autocompletion
- fix some issues with regex and tab from beginning of line
- much more
