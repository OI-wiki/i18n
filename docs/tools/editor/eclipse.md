author: ouuan, Doveqise, partychicken, Xeonacid, StudyingFather

<!---Waiting for upstream PR-->
<!---WIP-->

This article will briefly introduce Eclipse.

## Introduction

Eclipse is a famous cross-platform open-source integrated development environment. Eclipse is initially used to develop in Java, and currently it is also used to develop in other programming language like C++, Python and PHP through plug-in. <!---注：Wikipedia对插件的表述为Plug-in-->

Eclipse itself is a framework platform. However, support from various plug-ins provides Eclipse good scalability. Therefore, many software developers choose Eclipse as their framework to develop their own IDE.

In the beginning, Eclipse is the next generation IDE developed by IBM as an alternative for business software Visual Age for Java. In November 2001, it was donated to open-source community, and now it is managed by Eclipse, a non-profit organization of software developers.

Advantages:

Drawbacks: 

缺点：实测这个 IDE 打开速度比 Visual Studio 慢，而且这个 IDE 更新速度玄学，插件更新速度跟不上 IDE 的更新速度，所以对于经常更新的同学很不友好。

优点：使用体验较好，而且许多知名公司都在使用，能够快速上手，所以比较推荐 OIer 用这个 IDE。

## Installation and Configuration Guide

For major linux distributes, eclipse is already in their package repositories. This instruction is based on Microsoft Windows. 

### Perquisites

You will need Java Runtime and MinGW.

#### Download & Install Java Runtime

As for August 18th, 2021, the latest Eclipse has integrated a Java runtime environment. You can also download an independent JRE from if needed.

![](./images/eclipse1-1.png)

![](./images/eclipse1-2.png)

![](./images/eclipse1-3.png)

#### Download & Install MinGW/TDM-GCC

TDM-GCC is a compiler suite for Microsoft Windows, providing latest stable GCC compiler and patched MinGW/MinGW-w64 runtime API.

The installer of TDM-GCC can be obtained from GitHub Release or SourceForge. Here we uses 

Start installation.

![](./images/eclipse1-4.png)

Select the version of installation. 

![](./images/eclipse1-5.png)

Select installation directory. The default is `C:\TDM-GCC-64`

![](./images/eclipse1-6.png)

Select components to install. Here we proceed with default settings.

![](./images/eclipse1-9.png)

Finish Installation.

![](./images/eclipse1-8.png)

### Install Eclipse

Heading to the homepage of Eclipse 

![](./images/eclipse2.png)

Download the C++ version installer of your operating system.

![](./images/eclipse3.png)

You will get a compressed file. Extract it and initiate a new project by entering directory information.

![](./images/eclipse4.png)

![](./images/eclipse5.png)

![](./images/eclipse6.png)

![](./images/eclipse7.png)

## Advanced Readings

The manual of Eclipse is detailed, therefore we recommend newly users to visit manual or google when encountering problems. And Eclipse's feel of use is similar to Visual Studio.

Similar to [Visual Studio Code](./vscode.md), Eclipse provides many plug-ins, which may help Eclipse be even easy to use.

## 参考资料与注释

[^ref1]: [Eclipse - 维基百科](https://zh.wikipedia.org/wiki/Eclipse)

[^ref2]: [曾经的 Java IDE 王者 Eclipse 真的没落了？21 款插件让它强大起来！](https://blog.csdn.net/csdnnews/article/details/78495979)
