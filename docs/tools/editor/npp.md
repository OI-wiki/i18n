author: ouuan, CBW2007, partychicken, StudyingFather, Xeonacid, Henry-ZHR

This article was last translated on August 31st, 2021, with commit []().

## Introduction

Notepad++ is a text editor running in Windows. It has support of a variety of languages, encodings, and also highlighting and autocomplete for various programming languages. Its logo is cute too. ![npp-logo](./images/npp-logo.webp)

Its features are more powerful than other editors=, such as, more stable when opening large files, and no problems when performing undo repeatedly. No need to manually save when closing a file because it automatically saves it into buffer. Besides, when correctly configured, its size will be as small as 10MB, even able to be portable in your USB flash device.

## Download and Installation

???+note "Attention"
    This original guide uses version 7.7.1 as a demo, and the translated version uses 8.1.3. However, the latest build won't be much different from demo. For better experience, please use the latest build as much as possible.

To download the software, visit the [home page](https://notepad-plus-plus.org/) or [some reliable third-party website], click [Download](https://notepad-plus-plus.org/downloads) page and choose the version to download (the latest is recommended). **Please pay attention to the processor architecture(32-bit x86, 64-bit x64 or ARM64).** We strongly recommend to download 64-bit x64 build if you processor's architecture is x86_64, as most plug-ins only support 64-bit build of Notepad++. In case of compatibility, you can also choose 32-bit build.

There is three ways to install:

1. Installer: The traditional way to install;
2. Compressed Package: All files are in a compressed package. Only requires decompress and ready-to-go. Helpful when you are not likely to use installer.
3. Minimalist Compressed Package: No theme, no plug-ins and patches.

Here uses installer as an example:

![npp-install-1](./images/npp-install-1.png)

<!---双击安装包，进入安装界面，选择语言，接受协议，选择安装位置不在赘述，接下来选择安装内容：-->

![npp-install-2](./images/npp-install-2.png)

<!--- 这原文就是解释英文所以不翻了
-->
<!---
介绍一下（按顺序）

1. 自动完成功能
2. 自带插件功能
3. 自动升级插件
4. 自定义插件功能
5. 安装多国语言
6. 软件主题商店
7. 添加到右键菜单
-->

![npp-install-3](./images/npp-install-3.png)

The second option, "Don't use %APPDATA%", is helpful when the user want to install it to a portable device.

## Getting Started

In this section, we mainly talk about fundamental and outstanding features.

### Find and Replace

To open a "Find" window, click `Search` -> `Find` in the menubar, or shortcut key <kbd>Ctrl</kbd> + <kbd>F</kbd>.

![npp-search](./images/npp-search.png)

To open a `Replace` window, click `Search` -> `Replace` in the menubar, or press shortcut key <kbd>Ctrl</kbd> + <kbd>H</kbd>.

![npp-replace](./images/npp-replace.png)

Actually, both of them are different tabs of the same window, and the user can switch between them by clicking the tabs.

The search-and-replace feature of Notepad++ is not much different with other editors', but it has more supports, such as:

1. Strict match, or case-sensitive match;
2. Match in all opened documents;
3. Escape characters, e.g., '\\r', '\\n';
4. Regular expressions;
5. Counting

### Periodic Backup

![npp-settings-1](./images/npp-settings-1.png)

With this feature, the user may less worry about accidentally progression lost.

However, this feature only takes snapshot for your editing files but not actually save. So it is recommended to have a good habit of saving. The user can also enable `Auto Save` plugin from built-in plugins. To learn more please see [Advanced -> Plugins](./#_14)

### Bookmark

To place/cancel a bookmark, locate to the line needed and press <kbd>Ctrl</kbd> + <kbd>F2</kbd>. A blue dot will be placed in front of bookmarked line.

Press <kbd>F2</kbd> to locate to next bookmark.

The user can also enable `Bookmarks` plugin from built-in plugins if complaining about inconveniences.

### Syntax Highlighting

To choose language applying to highlighting, right-click the left-bottom corner "XXX file" and select one language, such as C/C++, PASCAL and Markdown. You can even define your own syntax highlighting.

You can change the default highlighting in `Settings—>Preferences`(menu bar) -> `New Document -> Default language`(new window) if you want to get rid of selecting language every time you open a file.

You can also enable `Markdown Viewer` in built-in plugins if you need to render markdown documents.

### Show All Characters

![npp-settings-2](./images/npp-settings-2.png)

To make invisible characters visible, like spaces, tabs and newlines, click the button tagged by red rectangle and those characters will be clearly appeared on the editor

### Automatic Recognition of Encoding and End-of-line

Notepad++ is able to automatically recognize the encoding of current file. 

To view a file in a different encoding, click `Encoding -> [the encoding you want to use]` in menu bar. To convert file into another with different encoding, click `Encoding -> Convert to [the encoding]`

Notepad++ is also able to automatically recognize which end-of-line character is used, `CR`, `LF` or `CRLF`. You won't worry about line endings' disappearance of download file.

From the information bar in the bottom, you can check the end-of-line character of current file, where something like "Windows(CR LF)" appears. To change the end-of-line character of current file, right-click it and choose one. This will be more intuitively with "Show all characters"

## Advanced

This section is for users with advanced requirements.

### Macro

Macro is helpful when there are repeated tasks to be done. In the following example, we are going to replace "abcde" with "afce" in odd lines using macros with two steps

#### Recording Macro

![npp-macro-rec](./images/npp-macro-rec.gif)

Translation:
1. Click `Macro` in menu bar, and click `Start Recording`;
2. Operate **using keyboard**;
3. When finishing, click `Macro -> Stop Recording`.


#### Applying Macro

![npp-macro-use](./images/npp-macro-use.gif)

Translated version:
1. Move cursor to next place:
2. Click `Macro -> Playback`;
3. You will see it is modified;
4. Repeat until complete.

#### Massive Task Automation with Macro

For more tasks, we need to slightly change the way we operate with macro.

Firstly is for recording. You must locate the cursor to the beginning or ending by pressing <kbd>Home</kbd> or <kbd>End</kbd> first, then adjust location with arrow key horizontally and apply modification. Finally you must move cursor to next line to process using arrow key.

In previous example, another approach is pressing <kbd>End</kbd> first, and then <kbd>←</kbd>, <kbd>Backspace</kbd>,<kbd>←</kbd>, <kbd>Backspace</kbd>, <kbd>F</kbd>. Finally press <kbd>↓</kbd> twice and stop recording

Then, to replay macro, locate cursor to first line to process, and then click `Macro` -> `Run a Macro Multiple times`, set how many times to run and click `Run`. 

#### Save Macro

To save a marco, click `Macro` -> `Save Current Recorded Macro` in menubar, and set the name and shortcut. This feature is convenient for further using.

### Plugins

#### Plugins Admin

Click `Plugins` in the menubar, and it will list all installed plugins. To manage plugins, click `Plugins Admin` then.

#### Enable Plugin from Plugin Admin

1. In the tab `Available`, toggle on plugins needed.
2. Click `Install` in upper right corner. After confirmation Notepad++ will restart and download selected plugin.

#### Manually Install Plugins

1. Download the plugin file first.[^note1] Please download plugins **in the correct architecture**.
2. Find a file named `XXX.dll`, which is usually named after the name of plugin.
3. Open plugin folder by clicking `Plugin` -> `Open Plugin Folder` in menubar.
4. Place downloaded file to the folder, and restart Notepad++.
5. (Optional) Delete copied `.dll` file, **but not the generated directories**.

Tips: If unsuccessful for many times, you can try create a new folder with the plugin's name and place downloaded `.dll` file to newly created directory.

#### Update Plugins

In plugin admins, select `Update` tab and toggle plugins that require an update, and click `Update` in the upper right corner.

#### Remove Plugins

In plugin admins, select `Remove` tab and toggle plugins that need to be removed, and click `Remove` in the upper right corner.

### Build Development Environment with Notepad++

Notepad++ is not only an editor. It is godlike. With correctly configuration it can even work as an IDE by compile code in one click. In the following example, we are going to configure an environment for C++. 

1. Make sure a C++ compiler has been installed and executables are added to `$(PATH)` environment variables. We also recommend to download ConsolePauser, a plugin for Dev-C++[^2], and add it to `$(PATH)` too.

2. Click `Run` -> `Run` in menubar and a `Run...` dialog will show up.

3. Type the following commands separately as your need, click `Save`, and set up the name and shortcut key, like `Compile` or `Run`.
   ```shell
    #Compile
    cmd /c g++.exe -o $(CURRENT_DIRECTORY)\$(NAME_PART).exe $(FULL_CURRENT_PATH)
    #Run
    cmd /c $(CURRENT_DIRECTORY)\$(NAME_PART).exe $(FULL_CURRENT_PATH) & pause
    #Debug with gdb
    cmd /c gdb $(CURRENT_DIRECTORY)\$(NAME_PART).exe

    #If ConsolePauser is available, you can use the following commands instead for better experience. Remember to add it environment variables.

    #Compile
    cmd /c (start ConsolePauser "g++.exe -o $(CURRENT_DIRECTORY)\$(NAME_PART).exe $(FULL_CURRENT_PATH)")
    #Run
    cmd /c (start ConsolePauser "$(CURRENT_DIRECTORY)\$(NAME_PART).exe")
    #Debug with gdb
    cmd /c (start ConsolePauser "gdb $(CURRENT_DIRECTORY)\$(NAME_PART).exe")
   ```

4. Enjoy it!

<!---Easter eggs are omitted.-->