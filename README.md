Tcoin Core integration/staging tree
=====================================

[![Build Status](https://travis-ci.org/tcoin/tcoin.svg?branch=master)](https://travis-ci.org/tcoin/tcoin)

https://tcoincore.org

What is Tcoin?
----------------

Tcoin is an experimental digital currency that enables instant payments to
anyone, anywhere in the world. Tcoin uses peer-to-peer technology to operate
with no central authority: managing transactions and issuing money are carried
out collectively by the network. Tcoin Core is the name of open source
software which enables the use of this currency.

For more information, as well as an immediately useable, binary version of
the Tcoin Core software, see https://tcoin.org/en/download, or read the
[original whitepaper](https://tcoincore.org/tcoin.pdf).

License
-------

Tcoin Core is released under the terms of the MIT license. See [COPYING](COPYING) for more
information or see https://opensource.org/licenses/MIT.

Development Process
-------------------

The `master` branch is regularly built and tested, but is not guaranteed to be
completely stable. [Tags](https://github.com/tcoin/tcoin/tags) are created
regularly to indicate new official, stable release versions of Tcoin Core.

The contribution workflow is described in [CONTRIBUTING.md](CONTRIBUTING.md).

The developer [mailing list](https://lists.linuxfoundation.org/mailman/listinfo/tcoin-dev)
should be used to discuss complicated or controversial changes before working
on a patch set.

Developer IRC can be found on Freenode at #tcoin-core-dev.

Testing
-------

Testing and code review is the bottleneck for development; we get more pull
requests than we can review and test on short notice. Please be patient and help out by testing
other people's pull requests, and remember this is a security-critical project where any mistake might cost people
lots of money.

### Automated Testing

Developers are strongly encouraged to write [unit tests](src/test/README.md) for new code, and to
submit new unit tests for old code. Unit tests can be compiled and run
(assuming they weren't disabled in configure) with: `make check`. Further details on running
and extending unit tests can be found in [/src/test/README.md](/src/test/README.md).

There are also [regression and integration tests](/qa) of the RPC interface, written
in Python, that are run automatically on the build server.
These tests can be run (if the [test dependencies](/qa) are installed) with: `qa/pull-tester/rpc-tests.py`

The Travis CI system makes sure that every pull request is built for Windows, Linux, and OS X, and that unit/sanity tests are run automatically.

### Manual Quality Assurance (QA) Testing

Changes should be tested by somebody other than the developer who wrote the
code. This is especially important for large or high-risk changes. It is useful
to add a test plan to the pull request description if testing the changes is
not straightforward.

Translations
------------

Changes to translations as well as new translations can be submitted to
[Tcoin Core's Transifex page](https://www.transifex.com/projects/p/tcoin/).

Translations are periodically pulled from Transifex and merged into the git repository. See the
[translation process](doc/translation_process.md) for details on how this works.

**Important**: We do not accept translation changes as GitHub pull requests because the next
pull from Transifex would automatically overwrite them again.

Translators should also subscribe to the [mailing list](https://groups.google.com/forum/#!forum/tcoin-translators).

Special Instructions for Tcoin
--------------------------------

You can build it on a UNIX/Linux machine using the doc/build-unix.md file.

The default P2P port is 9285. The default RPC port is 9286.

You can mine using cpuminer-multi, available here: https://github.com/tpruvot/cpuminer-multi.

You can mine using the following command:

`./cpuminer -a x17 -o http://localhost:9286 -u YourRPCuserName -p YourRPCpassword --coinbase-addr=tKe1UcMpA1Ldv5i27mjq7N4mEvbiNc5yLL`

You can generate a new address using:

tcoin-cli getnewaddress
