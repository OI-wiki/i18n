## Communication

This project mainly uses [Issues](https://github.com/OI-wiki/i18n/issues) for communication.

Ww will open an English telegram channel soon. Please stay tuned! Meanwhile, if you wish to join the discussion in Chinese, you can join [@OIwiki](https://t.me/OIwiki).

## Contributing

Please refer to the [How to Contribute](./htc.md) page.

## F.A.Q.

### Where is the table of contents

The table of contents is in the [mkdocs.yml](https://github.com/OI-wiki/i18n/blob/master/mkdocs.yml#L17) under the project root directory.

### How to modify the content of a topic

In top right corner of the page, there is an edit button <i class="md-icon">edit</i>. Click it and confirm you have read [how to contribute](./htc.md), and it will jump to the corresponding file on GitHub.

Or you can read the table of contents in [(mkdocs.yml)](https://github.com/OI-wiki/i18n/blob/master/mkdocs.yml#L17) to find the file location.

### How to add a topic

1.  You can open an issue, indicating what you want to add.
2.  You can open a pull request, add a new topic in the table of contents in [(mkdocs.yml)](https://github.com/OI-wiki/i18n/blob/master/mkdocs.yml#L17), and Create an empty `.md` file in the corresponding location under the [docs](https://github.com/OI-wiki/i18n/tree/master/docs) folder.

!!! warning "Warning"
    When editing an .md file, do not write a title at the beginning.

### How to write a commit message

We recommend using [commitizen/cz-cli](https://github.com/commitizen/cz-cli) to standardize the commit message (not mandatory).

### The cloned project on client is too slow

If you have installed `git bash`, you can add a few restrictions to reduce downloads:

```bash
git clone https://github.com/OI-wiki/i18n.git --depth=1 -b master
```

Reference: <https://blog.csdn.net/FreeApe/article/details/46845555> 

### I have not installed Python 3

You can visit [Python official website](https://www.python.org/downloads/) for more information.

### The pip version is too low

After entering cmd/shell,

```bash
python -m pip install --upgrade pip
```

### I failed to install dependencies

You might want to check the following setup: network? permissions? error message?

### I have cloned the project, why can't it be deployed

Check if the dependencies are installed?

### I cloned the repo a long time ago, how to update to the latest version

Reference: <https://help.github.com/articles/syncing-a-fork/> 。

### How to update if the previous dependencies are installed

```bash
pip install -U -r requirements.txt
```

### Why is my markdown format messed up

You can refer to [MkDocs instructions](https://www.mkdocs.org/).

We are currently using [remark-lint](https://github.com/remarkjs/remark-lint) to automate the format correction. There may be some problems with the [configuration](https://github.com/OI-wiki/i18n/blob/master/.remarkrc). You are welcome to suggest the edits.

#### GitHub does not display my mathematical formulas?

Yes, the GitHub preview does not show mathematical formulas. But please be assured that mkdocs supports them and can be used normally. All syntax supported by MathJax can be used.

#### Why is my math formula garbled

If it is an inline formula (using `$$` ), the currently known problem is that you need to leave blank spaces on both sides of the `$$`, and `$$` should be put **individually** on one line (and DO NOT add spaces in the beginning). The format is as follows:

```text
// Blank line
$$
a_i
$$
// Blank line
```

#### Why is my formula not displayed properly in the table of contents?

Yes, this is a bug in python-markdown and would probably be fixed in the near future.

If you want to avoid double formulas in the table of contents now, you can refer to <https://github.com/OI-wiki/OI-wiki/blame/master/docs/string/sam.md#L82>

```text
### ending position <script type="math/tex">endpos</script>
```

In the table of contents it will become:

```text
ending position endpos
```

Note: Please try to avoid introducing MathJax formulas in the catalog now.

### How to individually declare copyright information for a page

Please refer to the usage of [Metadata](https://squidfunk.github.io/mkdocs-material/extensions/metadata/#usage). Just add a line at the beginning of the page.

For example:

```text
copyright: SATA
```

Note: The default is ‘CC BY-SA 4.0 and SATA’.

### How to turn off word count for a page (now turned off default)

Please refer to the usage of [Metadata](https://squidfunk.github.io/mkdocs-material/extensions/metadata/#usage). Just add a line at the beginning of the page.

For example:

```text
pagetime:
```

### Why does the author page does not have my name

This is because the GitHub API cannot track statistics after the file directory changes. To solve this problem, We are manually maintaining a list of authors in the file header. If you have contributed to a part of a page, but not recorded by the author of the page, you can add your GitHub ID to the `author` field of the file header in the format of `author: Ir1d, cjsoft`. The two adjacent IDs are separated by `,·` (comma and space).

Note: The ID recorded here is the address corresponding to the GitHub Profile (that is, the url after clicking the upper right corner profile on the GitHub)

### How to use redirect file

The `_redirects` file is used to generate the [configuration of netlify](https://docs.netlify.com/routing/redirects/#syntax-for-the-redirects-file) and [file for redirection](https://github.com/OI-wiki/i18n/blob/master/scripts/gen_redirect.py).

Each line represents a redirection rule, denoting the URL of the start and end of the jump (excluding the domain name):

```text
/path/to/src /path/to/desc
```

Note: All redirections are 301, and only need to be modified when the URL in the modification directory causes a dead link.