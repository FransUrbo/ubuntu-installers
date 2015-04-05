This is Ubuntu installer components with ZoL support.

It is based on the Debian GNU/Linux installer from https://github.com/zfsonlinux/debian-installers.git.

The following branches with the remote repositories have
had changes that is related to ZoL:

    base-installer    http://bazaar.launchpad.net/~ubuntu-core-dev/base-installer/ubuntu
    debian-installer  http://bazaar.launchpad.net/~ubuntu-core-dev/debian-installer/ubuntu
    grub-installer    http://bazaar.launchpad.net/~ubuntu-core-dev/grub-installer/ubuntu
    partman-target    http://bazaar.launchpad.net/~ubuntu-core-dev/partman-target/ubuntu
    partman-zfs       git://anonscm.debian.org/d-i/partman-zfs.git

The repo is NOT intended for casual use, it is merely intended to be
used by people wanting to help perfecting the Ubuntu installer.

Once Ubuntu have accepted ZoL into it's repository, this
repository will be deleted.


In addition to the repos above, you'll also need the latest tags from
the following repos:

    pkg-spl           git://github.com/zfsonlinux/pkg-spl.git
    pkg-zfs           git://github.com/zfsonlinux/pkg-zfs.git
    grub              git://github.com:zfsonlinux/grub.git


Packages needs to be created from all of these repos, then checkout
the debian-installer branch, cd into it's build directory, put the
udeb packages in the 'localudebs' directory and then issue the command
"make_d-i.sh" found in the 'master' branch of this repo.

This because we need to do some 'hacking' - the ZoL components doesn't
(yet) exists in Ubuntu, so we need to get the ZoL installer
components AND all the non-modified components from the ZoL package
archive.

This is a flaw in the debian installer, which can't have multiple sources,
so all the non-modified components ALSO needs to be in the ZoL archive.
