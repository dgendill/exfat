About
-----

This is a fork of https://github.com/relan/exfat that *includes a Dockerfile that will run the build process in a Ubuntu 18.04 (Bionic Beaver) container and allow you copy the resulting exfatfsck 4.0 binary to your system*.

Ubuntu 18.04 does not have exfatfsck 4.0 in the package repository, so you can follow these steps to get a version of `exfatfsck 4.0` on your system.

First, you'll need to have [docker](https://www.docker.com/) installed and have a clone of this repo. Run the commands from the root directory of the repository.

Second, you'll build the docker image using the Dockerfile. The image will be named `exfatfsck-image`.

```
docker image build --file Dockerfile -t exfatfsck-image .
```

Once that completes, the resulting image should now have exfatfsck 4.0 in the `/usr/local/sbin/exfatfsck` directory.

Now create a bin folder where exfatfsck should be copied.

```
mkdir bin
```

To copy the file out of the image, you'll need to run the image as a container, and copy the file. The following command will start a temporary container, copy the file to the `bin` directory, and then remove the temporary image.

```
docker cp $(docker create --name temp exfatfsck-image):/usr/local/sbin/exfatfsck ./bin/exfatfsck && docker rm temp
```

You should now have `exfatfsck` in the `bin` folder and can run it.

About
-----

This project aims to provide a full-featured [exFAT][1] file system implementation for Unix-like systems. It consists of a [FUSE][2] module (fuse-exfat) and a set of utilities (exfat-utils).

Supported operating systems:

* GNU/Linux
* Mac OS X 10.5 or later
* FreeBSD

Most GNU/Linux distributions already have fuse-exfat and exfat-utils in their repositories, so you can just install and use them. The next chapter describes how to compile them from source.

Compiling
---------

To build this project on GNU/Linux you need to install the following packages:

* [git][4]
* [autoconf][5]
* [automake][6]
* [pkg-config][7]
* fuse-devel (or libfuse-dev)
* [gcc][8]
* [make][9]

On Mac OS X:

* autoconf
* automake
* pkg-config
* [OSXFUSE][10]
* [Xcode][11] (legacy versions include autotools but their versions are too old)

On OpenBSD:

* git
* autoconf (set AUTOCONF_VERSION environment variable)
* automake (set AUTOMAKE_VERSION environment variable)

Get the source code, change directory and compile:

    git clone https://github.com/relan/exfat.git
    cd exfat
    autoreconf --install
    ./configure
    make

Then install driver and utilities (from root):

    make install

You can remove them using this command (from root):

    make uninstall

Mounting
--------

Modern GNU/Linux distributions (with [util-linux][12] 2.18 or later) will mount exFAT volumes automatically. Anyway, you can mount manually (from root):

    mount.exfat-fuse /dev/spec /mnt/exfat

where /dev/spec is the [device file][13], /mnt/exfat is a mountpoint.

Feedback
--------

If you have any questions, issues, suggestions, bug reports, etc. please create an [issue][3]. Pull requests are also welcome!

[1]: https://en.wikipedia.org/wiki/ExFAT
[2]: https://en.wikipedia.org/wiki/Filesystem_in_Userspace
[3]: https://github.com/relan/exfat/issues
[4]: https://www.git-scm.com/
[5]: https://www.gnu.org/software/autoconf/
[6]: https://www.gnu.org/software/automake/
[7]: http://www.freedesktop.org/wiki/Software/pkg-config/
[8]: https://gcc.gnu.org/
[9]: https://www.gnu.org/software/make/
[10]: https://osxfuse.github.io/
[11]: https://en.wikipedia.org/wiki/Xcode
[12]: https://www.kernel.org/pub/linux/utils/util-linux/
[13]: https://en.wikipedia.org/wiki/Device_file
