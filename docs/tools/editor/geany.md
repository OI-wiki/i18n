author: xingjiapeng, MingqiHuang

# Geany

Geany is a lightweight, easy-to-use text editor. It is friendly for beginners in Linux environment.

Like Dev-C++, it supports single file compilation.

However, it is compatible in Linux, Windows and macOS.

The homepage of Geany is <https://geany.org/>

## Pros & Cons

### Pros

1. Lightweight;
2. Support for single file compilation;
3. No much need to configure;
4. Cross-platform.

### Cons

1. Not many users;
2. An access control issue was reported in macOS Catalina [^1].
3. No syntax highlighting by default when creating a new document. You may need to manually set filetype.

## Installation

### Windows/macOS

It is simple - just download installer from its official site and install it.

### Linux

#### Using Package Manager

Linux users can install Geany via package managers. For example, in debian-based distributions like Ubuntu or NOI Linux, run the following command and it will be automatically installed:

```bash
sudo apt install geany
```

#### Build from Source

1. Obtain sources from its repository or homesite
2. Run the following commands in terminal:

```bash
./configure
make
sudo make install
```

Note: you may need install a dependency `libgtk2.0-dev` if it reports `No package 'gtk+-2.0' found`.

## Skills

### Switch filetype

Click `Document -> Set Filetype` to switch filetype.

For example, click `Document -> Set Filetype -> Programming Source -> C++ Source`, and you will see its syntax highlighting has been converted to C++.

### Set File Template

Create a new folder `templates/files` under configuration directory, where files inside are template files. Restart Geany, and you will find `File -> New (With Template)` in menubar.

The current configuration file path can be found in the second and third line of `Help -> Debug Message`.

The following is default configuration file path of templates for macOS and Linux:

- System-wide directory: `/usr/share/geany/templates/files/`
- User directory: `~/.config/geany/templates/files/`[^2]

## Troubleshoot

### Compatibility with Deepin Terminal

In `Edit -> Preferences -> Tools -> Terminal`, replace it with the following command:

```bash
deepin-terminal -x "/bin/sh" %c
```

And click `Apply` to apply changes.

## References & Footnotes

[^1]: <https://github.com/geany/geany/issues/2344>

[^2]: <https://wiki.geany.org/config/templates>

[^3]: Deepin Wiki <https://wiki.deepin.org/>
