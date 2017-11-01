
Debian
====================
This directory contains files used to package tcoind/tcoin-qt
for Debian-based Linux systems. If you compile tcoind/tcoin-qt yourself, there are some useful files here.

## tcoin: URI support ##


tcoin-qt.desktop  (Gnome / Open Desktop)
To install:

	sudo desktop-file-install tcoin-qt.desktop
	sudo update-desktop-database

If you build yourself, you will either need to modify the paths in
the .desktop file or copy or symlink your tcoin-qt binary to `/usr/bin`
and the `../../share/pixmaps/tcoin128.png` to `/usr/share/pixmaps`

tcoin-qt.protocol (KDE)

