# Picture Of The Day

This module randomly selects a picture to be displayed as banner of Emacs' dashboard.
It does so by advising function `dashboard-choose-banner`.

*NOTE*: The picture may actually change every time the dashboard is refreshed.

## Installation

Put in a directory that appears in your Emacs' `load-path`.

## Usage

Add the following line to your emacs configuration:
```lisp
(require 'potd)
```

## Customization

The picture directory as well as the image types to look for can be customized.

```plain
M-x customize-group
potd
```
