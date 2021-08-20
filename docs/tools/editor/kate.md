author: CoelacanthusHex, CamberLoid (as translator)

<!--- WIP: Wait for PR OI-Wiki/OI-Wiki#3474 -->

## Introduction

Kate is a feature-packed cross-platform editor. It comes with a variety of plugins, including an embedded terminal that lets you launch console commands directly from Kate, powerful search and replace plugins, and a preview plugin that is able to show markdown, HTML and even SVG file. Kate supports swap files to recover data on system crash, auto complete with argument hints, and [LSP (Language Server Protocol)](https://microsoft.github.io/language-server-protocol/) for more powerful auto complete.

## Download and Installation Guide

One can visit [the homepage and Kate](https://kate-editor.org) and enter [the get-it page](https://kate-editor.org/get-it/). For major GNU/Linux distributions, Kate is already included in their package repositories with out-of-the-box feature. In the following guide we take Microsoft Windows as an example to explain how to install.  

![Installation method on Windows](images/kate-1-windows-install-1.png)

As shown in the illustration, they are install via MS Store, install via Chocolatey, download a stable release installer, download a nightly build installer, and build it from source. To install via Microsoft Store, just follow the link and install it; To install it via Chocolatey (if chocolatey is installed), one need to open Powershell and type `choco install kate`; To install via other two installer options one needs to follow the link and then he/she may see a page similar to the following screenshot: 

![](images/kate-2-windows-install-2.png)

Where installer with `.appx` extension is the package of Microsoft Store version but requires manually installation, while installer with `.exe` is an executable installer. For both of them, just download and double-click to install.

## Usages and Features

### Swap Files to Avoid Data Loss

Similar to Vim, Kate will write unsaved modified buffer to a swap file, generally named with `.kate-swp` extension after the original file name. If accident happens, like power failure or program crash, unsaved modifications won't be lost in the next start.

### Syntax Highlighting

Kate supports syntax highlighting for over 300 languages. Generally, Kate will choose the correct language to apply syntax highlighting. However, when Kate makes mistake on syntax highlighting, one can select the correct language manually by clicking the button in the right bottom corner. 

#### Write Your Own Syntax Definition Files

Despites the supports of syntax highlighting for over 300 languages, it is unable to avoid some language from being not covered. In this situation, users can write their syntax highlight definition files.

A list of built-in definition files is here: [Syntax Highlighting - Kate](https://kate-editor.org/syntax/). For grammar, one can refer to [Working with Syntax Highlighting](https://docs.kde.org/trunk5/en/kate/katepart/highlight.html) when writing. To install or test a syntax definition file after finishing writing, place it according to [Syntax definition files](https://github.com/KDE/syntax-highlighting#syntax-definition-files). [CoelacanthusHex/dotfiles@80a913c/pam_env.xml](https://github.com/CoelacanthusHex/dotfiles/blob/80a913cc5b90d7878eb0ed77b8df2d9b97926272/kate/.local/share/katepart5/syntax/pam_env.xml) is a definition file written by the author for reference.

### Switch Editor Language

Click the `Setting` in the menu bar, and select `Configure Language`, then select the editor language. Note that one can select a fallback language.

### Encoding and EOL

Kate is able to detect the encoding of current editing file. In case of mistakenly detection, the user can select the correct encoding manually by clicking the fourth button in thr right bottom corner.

Besides, it is able to detect the end-of-line symbol of the current file. In case of mistakenly detection, the user can click `Tool` in the menu bar, and then select `End of line` to select the correct end-of-line symbol manually.

### Search and Replace

Click `Edit`→`Find` (Shortcut: <kbd>Ctrl</kbd> + <kbd>F</kbd>) to open the incremental search bar in the bottom. Click `Edit`→`Replace` (Shortcut: <kbd>Ctrl</kbd> + <kbd>R</kbd>) to open the power search and replace bar in the bottom. Besides, clicking the `Search and Replace` button in the left bottom will also open the Search in Files tool view.

The detailed usage is not much different from other editors. However, Kate supports some extra features, such as:

1. Case sensitive;
2. Support of Regular Expression, including capturing group feature;
3. The rance from current file to multi files, and even the current project;
4. Perform replacing the result of searching.

### Language Server Protocol

Kate supports LSP Client since version 19.12. In the beginning, it only supports C/C++, D, Fortran, Go, LaTeX/BibTeX, OCaml, Python, Rust. And now it supports languages lists below:

|  Language  |                                       LSP Server                                       |
| :--------: | :------------------------------------------------------------------------------------: |
|    Bash    |        [bash-language-server](https://github.com/bash-lsp/bash-language-server)        |
|    LaTeX   |                          [texlab](https://texlab.netlify.com/)                         |
|   BibTeX   |                          [texlab](https://texlab.netlify.com/)                         |
|      C     |                     [clangd](https://clang.llvm.org/extra/clangd/)                     |
|     C++    |                     [clangd](https://clang.llvm.org/extra/clangd/)                     |
|      D     |                      [serve-d](https://github.com/Pure-D/serve-d)                      |
|   Fortran  |               [fortls](https://github.com/hansec/fortran-language-server)              |
|     Go     |                        [gopls](https://golang.org/x/tools/gopls)                       |
|   Haskell  | [haskell-language-server-wrapper](https://github.com/haskell/haskell-language-server") |
| JavaScript |  [typescript-language-server](https://github.com/theia-ide/typescript-language-server) |
|    OCaml   |                     [ocamllsp](https://github.com/ocaml/ocaml-lsp)                     |
|    Perl    |        [Perl-LanguageServer](https://github.com/richterger/Perl-LanguageServer)        |
|   Python   |               [pyls](https://github.com/palantir/python-language-server)               |
|    Rust    |                         [rls](https://github.com/rust-lang/rls)                        |
| TypeScript |  [typescript-language-server](https://github.com/theia-ide/typescript-language-server) |
|      R     |           [RLanguageServer](https://github.com/REditorSupport/languageserver)          |
|     zig    |                         [zls](https://github.com/zigtools/zls)                         |

When open a file in a specific language, Kate will automatically call the appropriate LSP server.

#### 增加配置

Furthermore, users can also write their LSP configuration file manually. Here is an example:

```json
{
    "servers": {
        "bibtex": {
            "use": "latex",
            "highlightingModeRegex": "^BibTeX$"
        },
        "c": {
            "command": ["clangd", "-log=error", "--background-index"],
            "commandDebug": ["clangd", "-log=verbose", "--background-index"],
            "url": "https://clang.llvm.org/extra/clangd/",
            "highlightingModeRegex": "^(C|ANSI C89|Objective-C)$"
        },
        "cpp": {
            "use": "c",
            "highlightingModeRegex": "^(C\\+\\+|ISO C\\+\\+|Objective-C\\+\\+)$"
        },
        "haskell": {
            "command": ["haskell-language-server-wrapper", "--lsp"],
            "rootIndicationFileNames": ["*.cabal", "stack.yaml", "cabal.project", "package.yaml"],
            "url": "https://github.com/haskell/haskell-language-server",
            "highlightingModeRegex": "^Haskell$"
        },
        "latex": {
            "command": ["texlab"],
            "url": "https://texlab.netlify.com/",
            "highlightingModeRegex": "^LaTeX$"
        },
        "rust": {
            "command": ["rls"],
            "rootIndicationFileNames": ["Cargo.lock", "Cargo.toml"],
            "url": "https://github.com/rust-lang/rls",
            "highlightingModeRegex": "^Rust$"
        }
    }
}
```

In which, each item in `server` represents a language. For this language, the array `command` represents the command to spin up an LSP Server, the elements in which is a result of the actual command split by a space; The `url` represents the website of the LSP Server; `rootIndicationFileNames` represent the file used to determine the root directory of a project; `highlightingModeRegex` is used to determine which LSP to use by matching the name of specific syntax highlighting; If `use` exist then its value represents the syntax highlighting configuration with the name to use.

The configuration is located in `Setting`→`Configure Kate`→`LSP Client`→`User Server Settings`, where `LSP Client` is available after enabling it in `Plugins`.

### 内置终端

Pressing <kbd>F4</kbd> or clicking `Terminal Panel` located in the left bottom corner can open or close the embedded terminal. The working directory will automatically be the same of the current editing file, and will follow the change of the file selected. The rest are not much different from general terminals.

### External Tools

点击 `工具`→`外部工具` 可执行。

点击 `工具`→`外部工具`→`配置` 可以配置外部工具。

#### 添加外部工具

##### 从预置配置中添加

进入配置页面后，点击左下角 `添加`→`从默认工具添加`，然后点击对应工具即可。

##### 手写配置添加

进入配置页面后，点击左下角 `添加`→`添加工具`，然后按提示填写即可。注意可点击如下标志查看可使用的变量。

![](images/kate-3-var.png)

#### 常用的外部工具

##### 编译并执行单个 C++ 文件

打开任意 C++ 源文件，在外部工具里找到 `编译执行 cpp`，点击即可。

##### Git Blame

打开任意文件，在外部工具里找到 `git blame`，点击之后，会打开一个窗口，展示 git blame 的结果。

##### 格式化

打开任意源文件，在外部工具里找到 `用 xxx 格式化`，点击即可。

此处注意，`clang-format` 可格式化选中的文本。

## See Also

- [Kate Homepage](https://kate-editor.org)
- [Kate Features](https://kate-editor.org/about-kate)
- [The Kate Handbook](https://docs.kde.org/stable5/en/kate/kate/kate.pdf)
- [Configuration of User](https://docs.kde.org/trunk5/en/kate/kate/kate-application-plugin-lspclient.html#Configuration)