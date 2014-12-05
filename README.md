# qichat-mode

An Emacs major mode for editing and interacting with qichat files. First and foremost provides syntax highlighting for topic files, as well as some input and testing utilities.

This is a work in progress and I'll be adding keybindings and functionality semi-regularly.


## Installation

Add the following to your `init.el`, replacing :

```elisp
(add-to-list 'load-path "path/to/qichat-mode")
(require 'qichat-mode)
```

And you’re done!

## Keybindings

```elisp
C-c p    ;; insert proposal ==> proposal:
C-c u    ;; insert user rule ==> u:()
C-c e    ;; insert user rule and event ==> u:(e:)
C-c SPC  ;; insert pause, prompt for duration ==> \\PAU=___\\
C-c t    ;; test buffer (requires an active local naoqi session)
```

## Misc.

I've found subword-mode to be useful with QiChat

```elisp
(subword-mode 1)  ;; navigate camelCase words
```

## TODO
- add autocompletion
- fix some issues with regex and tab from beginning of line
- much more
