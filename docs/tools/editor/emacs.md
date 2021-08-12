author: ouuan, akakw1, Ir1d, partychicken, Xeonacid

This article is a tutorial of Emacs.

> Getting started to Emacs in 15 minutes.

## Introduction

Emacs is a editor which is easy to get started with simple few lines of configuration. However, to proficiently perform various works with Emacs still takes some times to getting familiar with.

As an introductory tutorial, this article only introduce basic functions of Emacs, and a more convenient way to write and debug codes.

## Getting Started

### Command

Commands play an important role in Emacs.

To enter a command, press application key[^note1] (note that Emacs doesn't assign this key in Windows and need manual configuration) or shortcut key <kbd>M-x</kbd> (in Emacs, the Meta key is bound to <kbd>Alt<kbd>). After inputting press enter to execute.

Usually we use `es` or `eshell` to open a built-in terminal Eshell (similar to a terminal).

Inputting commands usually can be replaced with shortcut keys.

### Buffer

Buffer means opened files and processes. When not saved, modifying in buffer wont affect actual file.

Buffers can be switched by clicking the name of buffer or using shortcut key.

### Compile, Debug and Execute

The entries of compile and debug are in top menu bar's "Tools" dropdown menu. User can also access it by commands or customized shortcut keys.

Besides, one can execute programs through terminal or built-in Eshell.

Debugging can be started after clicking *Debugger (GDB)*(gud-gdb) and inputting the file name. (Generally the file name should be autofilled, **but it may contain error** if performed "save-as" to the program or opened two need-to-debug programs.)

### Splitting Windows

This feature enables users to check separate buffers at the same time without switching it. It is convenient to test and debug code.

Splitting windows allows multiple windows to be displayed simultaneously, and it can be resized by dragging the edge of a window using mouse.

Here lists some shortcut keys:

- Delete Window  "C-x 0": Delete the selected window;
- Horizontally Splitting "C-x 3": Split the selected window into two windows, positioned side by side;
- Vertically Splitting "C-x 2": Split the selected window into two windows, one above another;

The recommended layout is to divide the window into four parts: horizontally split first, adjust its width to approximate 3/4 of the screen as editing window; Split another part horizontally, the left half as the window displaying information from debugger and compiler; Split the right part vertically, one opens the input file, the other opens the output file.

![](./images/emacs.png)

### Shortcut Keys

Emacs has various shortcut keys, which can improve working efficiency dramatically. User can customize shortcut keys or define mapping of shortcut keys.

Due to too many shortcut keys used by Emacs, they are different from system's.

For the convenience of description, we have the following agreements for shortcut key `C/M-?`:

| Character | Key      |
| -- | --------------- |
| C  | <kbd>Ctrl</kbd> |
| M  | <kbd>Alt</kbd>  |
| ?  | Certain keys    |

Generally there are three kinds of shortcut keys description:

- `F?`, `ESC`:Straightforwardly press the described keys;
- `M-?`, `C-?`, `C-M-?`: Press <kbd>Alt</kbd> or <kbd>Ctrl</kbd> or both with the `?` key;
- `? ?`: Press the first `?` firstly. After released press the second `?`.

Here are some commonly used shortcut keys in default:

- `C-x h`: Select all;
- `C-x left`, `C-x right`: Switch to previous or next buffer;
- `C-x d`: Open a directory;
- `C-x C-f`: Open a file. If not exist, create a new file and open it.

## Customize

Freshly installed Emacs is ugly and inconvenient to use. Therefore, it is needed for customization.

As it is hard to memorize the configuration, we recommend not to memorize configurations which can be directly set.

### Direct Setting Entries 

- Options: `Highlight Matching Parentheses` Toggle whether to highlight matching parentheses or not;
- Options: `Blink Cursor` Toggle whether cursor blinks or not;
- Options Show/Hide：`Tool Bar` Toggle whether to show toolbar. The default is show and we recommend not to;
- Options: `Use CUA Keys` When toggled, it allows one to use `C-c`, `C-v` to copy and paste;
- Options Customize-Emacs：`Custom Theme` Choose the color scheme. Option needs to be saved after chosen;
- Options：`Save Options`  **Save the configuration.**

### Configuration

The configuration file is `~/.emacs`, which is a hidden file under user's home directory (or, `$HOME\AppData\Roaming` if using Windows). If Emacs is started, it needs to be restarted to apply the configurations.

For offline programming competition, a recommended configuration is listed below.

```text
;;Configuration of one-key compile. You can add your arguments as will. Not recommend to use in offline competition. Not recommend to rely on.
(defun compile-file ()(interactive)(compile (format "g++ -o %s %s -g -lm -Wall" (file-name-sans-extension (buffer-name))(buffer-name))))
(global-set-key [f9] 'compile-file)
;;;;Configuration of shortcut key to compile. Note that not be conflict with one-key compile if it was set before.
;;(global-set-key [f9] 'compile)

(global-set-key (kbd "C-a") 'mark-whole-buffer) ;;Shortcut key to select all
(global-set-key (kbd "C-z") 'undo) ;;Shortcut key to undo
(global-set-key [f10] 'gud-gdb) ;;Shortcut key to debug with GDB
(global-set-key (kbd "RET") 'newline-and-indent) ;;New line with auto indent
(global-set-key (kbd "C-s") 'save-buffer) ;;Shortcut key to save buffer to file.
(setq-default kill-ring-max 65535) ;;Extend records that is able to undo

;;The following entry controls style of C++ code, which is generally rules of indents. 
;;;"bsd" New line for every curly bracket.
;;;"java" No new line for all curly bracket. `else` is after the right curly bracket.
;;;"awk" Only insert new line when defining class or function or along with namespace. `else` is after the right curly bracket.
;;;"linux" Only insert new line when defining class or function or along with namespace. `else` is after the right curly bracket. Generally, this style should have an indent of 8 spaces.
(setq-default c-default-style "awk")
```

??? "Full Configurations"
  ```text
    ;;Configuration of shortcut key to one-key compile.
    (defun compile-file ()(interactive)(compile (format "g++ -o %s %s -g -lm -Wall" (file-name-sans-extension (buffer-name))(buffer-name))))
    (global-set-key [f9] 'compile-file)
    ;;;;Configuration of shortcut key to compile. Note that not be conflict with one-key compile if it was set before.
    ;;(global-set-key [f9] 'compile)
    
    ;;Necessary for offline competition
    (global-set-key (kbd "C-a") 'mark-whole-buffer) ;;Shortcut key to select all
    (global-set-key (kbd "C-z") 'undo) ;;Shortcut key to undo
    (global-set-key [f10] 'gud-gdb) ;;Shortcut key to debug with GDB
    (global-set-key (kbd "RET") 'newline-and-indent) ;;New line with auto indent
    (global-set-key (kbd "C-s") 'save-buffer) ;;Shortcut key to save buffer to file.
    (setq-default kill-ring-max 65535) ;;Extend records that is able to undo
    ;;(define-key key-translation-map [apps] (kbd "M-x")) ;; For Windows, assign shortcut key for command. 
    
    ;;Configurations for indents
    ;;;Basic indent offset for C++.
    (setq-default c-basic-offset 4)
    ;;;Use tab for indent.
    (setq-default indent-tabs-mode t)
    ;;;Default width for a tab. Should be same to indent.
    (setq-default default-tab-width 4)
    (setq-default tab-width 4)
    
    ;;Configuration for default encoding environment.
    (set-language-environment "UTF-8")
    (set-default-coding-systems 'utf-8)
    
    ;;Not to display welcome screen.
    (setq-default inhibit-startup-screen t)
    
    ;;Set title
    (setq-default frame-title-format "")
    
    ;;Display line number
    (global-linum-mode t)
    
    ;;Highlight
    (global-hl-line-mode 1);;Highlight current line
    (show-paren-mode t);;Highlight brackets
    (global-font-lock-mode t);;Syntax highlighting 
    
    ;;Enable paste from and to external programs.
    (setq-default x-select-enable-clipboard t)
    
    ;;Set font to Ubuntu Mono with size of 16
    (set-default-font "Ubuntu Mono-16")
    ;(set-default-font "Consolas-16") ;; For Windows, it is recommended to use Consolas.
    
    ;;Enable support for mouse wheel
    (mouse-wheel-mode t)
    
    ;;Set cursor type to bar. The default is a filled box.
    (setq-default cursor-type 'bar)
    
    ;;Replace `yes/no` with `y/n`
    (fset 'yes-or-no-p 'y-or-n-p)
    
    ;;Opacity
    (set-frame-parameter (selected-frame) 'alpha (list 85 60))
    (add-to-list 'default-frame-alist (cons 'alpha (list 85 60)))
    
    ;;Reduce the number of lines when scrolling the page to avoid scrolling through the entire page.
    (setq-default scroll-margin 3 scroll-conservatively 10000)
    
    ;;Optimize the structure of file tree
    (ido-mode t)
    
    ;;Color scheme
    (setq default-frame-alist
             '((vertical-scroll-bars)
               (top . 25)
               (left . 45)
               (width . 120)
               (height . 40)
               (background-color . "grey15")
               (foreground-color . "grey")
               (cursor-color . "gold1")
               (mouse-color . "gold1")
               (tool-bar-lines . 0)
               (menu-bar-lines . 1)
               (scroll-bar-lines . 0)
               (right-fringe)
               (left-fringe)))
    
    (set-face-background 'highlight "gray5")
    (set-face-foreground 'region "cyan")
    (set-face-background 'region "blue")
    (set-face-foreground 'secondary-selection "skyblue")
    (set-face-background 'secondary-selection "darkblue")
    (set-cursor-color "wheat")
    (set-mouse-color "wheat")
    
    (custom-set-variables
     '(ansi-color-faces-vector
       [default default default italic underline success warning error])
    ;;Enable C-x, C-c, C-v for cut, copy and paste
     '(cua-mode t nil (cua-base))
     '(show-paren-mode t)
    ;;Hide toolbar
     '(tool-bar-mode nil))
    ;;Toggle cursor blink off
     '(blink-cursor-mode nil)
    (custom-set-faces)
  ```

### Advanced Reading 
<!---不使用Further的原因是因为这不是外部文档-->

To start Emacs in terminal, start it with arguments `-nw`. Emacs has many variants, e.g., [GCC Emacs]() which uses native-comp to reduce latency and its pure GTK variant, Emacs Macport which is optimized for macOS.

Emacs has a centralized software repository. After configured one can install extensions by `M-x package-install`. Using a Mirror([Example](https://mirrors.bfsu.edu.cn/help/elpa/). Find your nearest!) is helpful to accelerate download speed.

Emacs can work with Language server protocol to improve editing experience. Currently the recommended backend for C++ is [Clangd](https://clangd.llvm.org/). The frontend can be [Eglot](https://github.com/joaotavora/eglot) or [Emacs LSP](https://emacs-lsp.github.io/lsp-mode/). [This article](https://github.com/joaotavora/eglot#historical-differences-to-lsp-modeel) may be helpful when choosing frontend.

Org Mode documents with extension of `.org` can be transformed to Markdown through [Pandoc](https://pandoc.org/)

## References and Footnotes

[^note1]: Or the menu key. The key's primary function is to launch a context menu. Usually it is the first key left to <kbd>Ctrl</kbd>.
