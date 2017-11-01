#!/bin/sh

TOPDIR=${TOPDIR:-$(git rev-parse --show-toplevel)}
SRCDIR=${SRCDIR:-$TOPDIR/src}
MANDIR=${MANDIR:-$TOPDIR/doc/man}

TCOIND=${TCOIND:-$SRCDIR/tcoind}
TCOINCLI=${TCOINCLI:-$SRCDIR/tcoin-cli}
TCOINTX=${TCOINTX:-$SRCDIR/tcoin-tx}
TCOINQT=${TCOINQT:-$SRCDIR/qt/tcoin-qt}

[ ! -x $TCOIND ] && echo "$TCOIND not found or not executable." && exit 1

# The autodetected version git tag can screw up manpage output a little bit
TCNVER=($($TCOINCLI --version | head -n1 | awk -F'[ -]' '{ print $6, $7 }'))

# Create a footer file with copyright content.
# This gets autodetected fine for tcoind if --version-string is not set,
# but has different outcomes for tcoin-qt and tcoin-cli.
echo "[COPYRIGHT]" > footer.h2m
$TCOIND --version | sed -n '1!p' >> footer.h2m

for cmd in $TCOIND $TCOINCLI $TCOINTX $TCOINQT; do
  cmdname="${cmd##*/}"
  help2man -N --version-string=${TCNVER[0]} --include=footer.h2m -o ${MANDIR}/${cmdname}.1 ${cmd}
  sed -i "s/\\\-${TCNVER[1]}//g" ${MANDIR}/${cmdname}.1
done

rm -f footer.h2m
