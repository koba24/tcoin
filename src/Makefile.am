# Copyright (c) 2013-2016 The Tcoin Core developers
# Distributed under the MIT software license, see the accompanying
# file COPYING or http://www.opensource.org/licenses/mit-license.php.

DIST_SUBDIRS = secp256k1 univalue

AM_LDFLAGS = $(PTHREAD_CFLAGS) $(LIBTOOL_LDFLAGS) $(HARDENED_LDFLAGS)
AM_CXXFLAGS = $(HARDENED_CXXFLAGS) $(ERROR_CXXFLAGS)
AM_CPPFLAGS = $(HARDENED_CPPFLAGS)
EXTRA_LIBRARIES =

if EMBEDDED_UNIVALUE
LIBUNIVALUE = univalue/libunivalue.la

$(LIBUNIVALUE): $(wildcard univalue/lib/*) $(wildcard univalue/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)
else
LIBUNIVALUE = $(UNIVALUE_LIBS)
endif

TCOIN_CONFIG_INCLUDES=-I$(builddir)/config
TCOIN_INCLUDES=-I$(builddir) -I$(builddir)/obj $(BDB_CPPFLAGS) $(BOOST_CPPFLAGS) $(LEVELDB_CPPFLAGS) $(CRYPTO_CFLAGS) $(SSL_CFLAGS)

TCOIN_INCLUDES += -I$(srcdir)/secp256k1/include
TCOIN_INCLUDES += $(UNIVALUE_CFLAGS)

LIBTCOIN_SERVER=libtcoin_server.a
LIBTCOIN_COMMON=libtcoin_common.a
LIBTCOIN_CONSENSUS=libtcoin_consensus.a
LIBTCOIN_CLI=libtcoin_cli.a
LIBTCOIN_UTIL=libtcoin_util.a
LIBTCOIN_CRYPTO=crypto/libtcoin_crypto.a
LIBTCOINQT=qt/libtcoinqt.a
LIBSECP256K1=secp256k1/libsecp256k1.la

if ENABLE_ZMQ
LIBTCOIN_ZMQ=libtcoin_zmq.a
endif
if BUILD_TCOIN_LIBS
LIBTCOINCONSENSUS=libtcoinconsensus.la
endif
if ENABLE_WALLET
LIBTCOIN_WALLET=libtcoin_wallet.a
endif

$(LIBSECP256K1): $(wildcard secp256k1/src/*) $(wildcard secp256k1/include/*)
	$(AM_V_at)$(MAKE) $(AM_MAKEFLAGS) -C $(@D) $(@F)

# Make is not made aware of per-object dependencies to avoid limiting building parallelization
# But to build the less dependent modules first, we manually select their order here:
EXTRA_LIBRARIES += \
  $(LIBTCOIN_CRYPTO) \
  $(LIBTCOIN_UTIL) \
  $(LIBTCOIN_COMMON) \
  $(LIBTCOIN_CONSENSUS) \
  $(LIBTCOIN_SERVER) \
  $(LIBTCOIN_CLI) \
  $(LIBTCOIN_WALLET) \
  $(LIBTCOIN_ZMQ)

lib_LTLIBRARIES = $(LIBTCOINCONSENSUS)

bin_PROGRAMS =
noinst_PROGRAMS =
TESTS =
BENCHMARKS =

if BUILD_TCOIND
  bin_PROGRAMS += tcoind
endif

if BUILD_TCOIN_UTILS
  bin_PROGRAMS += tcoin-cli tcoin-tx
endif

.PHONY: FORCE check-symbols check-security
# tcoin core #
TCOIN_CORE_H = \
  addrdb.h \
  addrman.h \
  base58.h \
  bloom.h \
  blockencodings.h \
  chain.h \
  chainparams.h \
  chainparamsbase.h \
  chainparamsseeds.h \
  checkpoints.h \
  checkqueue.h \
  clientversion.h \
  coins.h \
  compat.h \
  compat/byteswap.h \
  compat/endian.h \
  compat/sanity.h \
  compressor.h \
  consensus/consensus.h \
  core_io.h \
  core_memusage.h \
  cuckoocache.h \
  httprpc.h \
  httpserver.h \
  indirectmap.h \
  init.h \
  key.h \
  keystore.h \
  dbwrapper.h \
  limitedmap.h \
  memusage.h \
  merkleblock.h \
  miner.h \
  net.h \
  net_processing.h \
  netaddress.h \
  netbase.h \
  netmessagemaker.h \
  noui.h \
  policy/fees.h \
  policy/policy.h \
  policy/rbf.h \
  pow.h \
  protocol.h \
  random.h \
  reverselock.h \
  rpc/client.h \
  rpc/protocol.h \
  rpc/server.h \
  rpc/register.h \
  scheduler.h \
  script/sigcache.h \
  script/sign.h \
  script/standard.h \
  script/ismine.h \
  streams.h \
  support/allocators/secure.h \
  support/allocators/zeroafterfree.h \
  support/cleanse.h \
  support/events.h \
  support/lockedpool.h \
  sync.h \
  threadsafety.h \
  threadinterrupt.h \
  timedata.h \
  torcontrol.h \
  txdb.h \
  txmempool.h \
  ui_interface.h \
  undo.h \
  util.h \
  utilmoneystr.h \
  utiltime.h \
  validation.h \
  validationinterface.h \
  versionbits.h \
  wallet/coincontrol.h \
  wallet/crypter.h \
  wallet/db.h \
  wallet/rpcwallet.h \
  wallet/wallet.h \
  wallet/walletdb.h \
  warnings.h \
  zmq/zmqabstractnotifier.h \
  zmq/zmqconfig.h\
  zmq/zmqnotificationinterface.h \
  zmq/zmqpublishnotifier.h

obj/build.h: FORCE
	@$(MKDIR_P) $(builddir)/obj
	@$(top_srcdir)/share/genbuild.sh $(abs_top_builddir)/src/obj/build.h \
	  $(abs_top_srcdir)
libtcoin_util_a-clientversion.$(OBJEXT): obj/build.h

# server: shared between tcoind and tcoin-qt
libtcoin_server_a_CPPFLAGS = $(AM_CPPFLAGS) $(TCOIN_INCLUDES) $(MINIUPNPC_CPPFLAGS) $(EVENT_CFLAGS) $(EVENT_PTHREADS_CFLAGS)
libtcoin_server_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libtcoin_server_a_SOURCES = \
  addrman.cpp \
  addrdb.cpp \
  bloom.cpp \
  blockencodings.cpp \
  chain.cpp \
  checkpoints.cpp \
  httprpc.cpp \
  httpserver.cpp \
  init.cpp \
  dbwrapper.cpp \
  merkleblock.cpp \
  miner.cpp \
  net.cpp \
  net_processing.cpp \
  noui.cpp \
  policy/fees.cpp \
  policy/policy.cpp \
  pow.cpp \
  rest.cpp \
  rpc/blockchain.cpp \
  rpc/mining.cpp \
  rpc/misc.cpp \
  rpc/net.cpp \
  rpc/rawtransaction.cpp \
  rpc/server.cpp \
  script/sigcache.cpp \
  script/ismine.cpp \
  timedata.cpp \
  torcontrol.cpp \
  txdb.cpp \
  txmempool.cpp \
  ui_interface.cpp \
  validation.cpp \
  validationinterface.cpp \
  versionbits.cpp \
  $(TCOIN_CORE_H)

if ENABLE_ZMQ
libtcoin_zmq_a_CPPFLAGS = $(TCOIN_INCLUDES) $(ZMQ_CFLAGS)
libtcoin_zmq_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libtcoin_zmq_a_SOURCES = \
  zmq/zmqabstractnotifier.cpp \
  zmq/zmqnotificationinterface.cpp \
  zmq/zmqpublishnotifier.cpp
endif


# wallet: shared between tcoind and tcoin-qt, but only linked
# when wallet enabled
libtcoin_wallet_a_CPPFLAGS = $(AM_CPPFLAGS) $(TCOIN_INCLUDES)
libtcoin_wallet_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libtcoin_wallet_a_SOURCES = \
  wallet/crypter.cpp \
  wallet/db.cpp \
  wallet/rpcdump.cpp \
  wallet/rpcwallet.cpp \
  wallet/wallet.cpp \
  wallet/walletdb.cpp \
  policy/rbf.cpp \
  $(TCOIN_CORE_H)

# crypto primitives library
crypto_libtcoin_crypto_a_CPPFLAGS = $(AM_CPPFLAGS) $(TCOIN_CONFIG_INCLUDES) $(PIC_FLAGS)
crypto_libtcoin_crypto_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS) $(PIC_FLAGS)
crypto_libtcoin_crypto_a_SOURCES = \
  crypto/aes.cpp \
  crypto/aes.h \
  crypto/common.h \
  crypto/hmac_sha256.cpp \
  crypto/hmac_sha256.h \
  crypto/hmac_sha512.cpp \
  crypto/hmac_sha512.h \
  crypto/ripemd160.cpp \
  crypto/ripemd160.h \
  crypto/sha1.cpp \
  crypto/sha1.h \
  crypto/sha256.cpp \
  crypto/sha256.h \
  crypto/sha512.cpp \
  crypto/sha512.h \
  crypto/groestl.c \
  crypto/blake.c \
  crypto/blake2s-ref.c \
  crypto/bmw.c \
  crypto/cubehash.c \
  crypto/echo.c \
  crypto/jh.c \
  crypto/keccak.c \
  crypto/luffa.c \
  crypto/shavite.c \
  crypto/simd.c \
  crypto/skein.c \
  crypto/hamsi.c \
  crypto/whirlpool.c \
  crypto/shabal.c \
  crypto/fugue.c \
  crypto/haval.c \
  crypto/sph_sha2big.c \
  crypto/sph_types.h \
  crypto/sph_skein.h \
  crypto/sph_simd.h \
  crypto/sph_shavite.h \
  crypto/sph_shabal.h \
  crypto/sph_sha2.h \
  crypto/sph_luffa.h \
  crypto/sph_keccak.h \
  crypto/sph_jh.h \
  crypto/sph_haval.h \
  crypto/sph_hamsi.h \
  crypto/sph_groestl.h \
  crypto/sph_fugue.h \
  crypto/sph_echo.h \
  crypto/sph_cubehash.h \
  crypto/sph_bmw.h \
  crypto/sph_blake.h \
  crypto/sph_whirlpool.h \
  crypto/blake2.h \
  crypto/blake2-impl.h

# consensus: shared between all executables that validate any consensus rules.
libtcoin_consensus_a_CPPFLAGS = $(AM_CPPFLAGS) $(TCOIN_INCLUDES)
libtcoin_consensus_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libtcoin_consensus_a_SOURCES = \
  amount.h \
  arith_uint256.cpp \
  arith_uint256.h \
  consensus/merkle.cpp \
  consensus/merkle.h \
  consensus/params.h \
  consensus/validation.h \
  hash.cpp \
  hash.h \
  prevector.h \
  primitives/block.cpp \
  primitives/block.h \
  primitives/transaction.cpp \
  primitives/transaction.h \
  pubkey.cpp \
  pubkey.h \
  script/tcoinconsensus.cpp \
  script/interpreter.cpp \
  script/interpreter.h \
  script/script.cpp \
  script/script.h \
  script/script_error.cpp \
  script/script_error.h \
  serialize.h \
  tinyformat.h \
  uint256.cpp \
  uint256.h \
  utilstrencodings.cpp \
  utilstrencodings.h \
  version.h

# common: shared between tcoind, and tcoin-qt and non-server tools
libtcoin_common_a_CPPFLAGS = $(AM_CPPFLAGS) $(TCOIN_INCLUDES)
libtcoin_common_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libtcoin_common_a_SOURCES = \
  amount.cpp \
  base58.cpp \
  chainparams.cpp \
  coins.cpp \
  compressor.cpp \
  core_read.cpp \
  core_write.cpp \
  key.cpp \
  keystore.cpp \
  netaddress.cpp \
  netbase.cpp \
  protocol.cpp \
  scheduler.cpp \
  script/sign.cpp \
  script/standard.cpp \
  warnings.cpp \
  $(TCOIN_CORE_H)

# util: shared between all executables.
# This library *must* be included to make sure that the glibc
# backward-compatibility objects and their sanity checks are linked.
libtcoin_util_a_CPPFLAGS = $(AM_CPPFLAGS) $(TCOIN_INCLUDES)
libtcoin_util_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libtcoin_util_a_SOURCES = \
  support/lockedpool.cpp \
  chainparamsbase.cpp \
  clientversion.cpp \
  compat/glibc_sanity.cpp \
  compat/glibcxx_sanity.cpp \
  compat/strnlen.cpp \
  random.cpp \
  rpc/protocol.cpp \
  support/cleanse.cpp \
  sync.cpp \
  threadinterrupt.cpp \
  util.cpp \
  utilmoneystr.cpp \
  utilstrencodings.cpp \
  utiltime.cpp \
  $(TCOIN_CORE_H)

if GLIBC_BACK_COMPAT
libtcoin_util_a_SOURCES += compat/glibc_compat.cpp
endif

# cli: shared between tcoin-cli and tcoin-qt
libtcoin_cli_a_CPPFLAGS = $(AM_CPPFLAGS) $(TCOIN_INCLUDES)
libtcoin_cli_a_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
libtcoin_cli_a_SOURCES = \
  rpc/client.cpp \
  $(TCOIN_CORE_H)

nodist_libtcoin_util_a_SOURCES = $(srcdir)/obj/build.h
#

# tcoind binary #
tcoind_SOURCES = tcoind.cpp
tcoind_CPPFLAGS = $(AM_CPPFLAGS) $(TCOIN_INCLUDES)
tcoind_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
tcoind_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
tcoind_SOURCES += tcoind-res.rc
endif

tcoind_LDADD = \
  $(LIBTCOIN_SERVER) \
  $(LIBTCOIN_COMMON) \
  $(LIBUNIVALUE) \
  $(LIBTCOIN_UTIL) \
  $(LIBTCOIN_WALLET) \
  $(LIBTCOIN_ZMQ) \
  $(LIBTCOIN_CONSENSUS) \
  $(LIBTCOIN_CRYPTO) \
  $(LIBLEVELDB) \
  $(LIBMEMENV) \
  $(LIBSECP256K1)

tcoind_LDADD += $(BOOST_LIBS) $(BDB_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(MINIUPNPC_LIBS) $(EVENT_PTHREADS_LIBS) $(EVENT_LIBS) $(ZMQ_LIBS)

# tcoin-cli binary #
tcoin_cli_SOURCES = tcoin-cli.cpp
tcoin_cli_CPPFLAGS = $(AM_CPPFLAGS) $(TCOIN_INCLUDES) $(EVENT_CFLAGS)
tcoin_cli_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
tcoin_cli_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
tcoin_cli_SOURCES += tcoin-cli-res.rc
endif

tcoin_cli_LDADD = \
  $(LIBTCOIN_CLI) \
  $(LIBUNIVALUE) \
  $(LIBTCOIN_UTIL) \
  $(LIBTCOIN_CRYPTO)

tcoin_cli_LDADD += $(BOOST_LIBS) $(SSL_LIBS) $(CRYPTO_LIBS) $(EVENT_LIBS)
#

# tcoin-tx binary #
tcoin_tx_SOURCES = tcoin-tx.cpp
tcoin_tx_CPPFLAGS = $(AM_CPPFLAGS) $(TCOIN_INCLUDES)
tcoin_tx_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)
tcoin_tx_LDFLAGS = $(RELDFLAGS) $(AM_LDFLAGS) $(LIBTOOL_APP_LDFLAGS)

if TARGET_WINDOWS
tcoin_tx_SOURCES += tcoin-tx-res.rc
endif

tcoin_tx_LDADD = \
  $(LIBUNIVALUE) \
  $(LIBTCOIN_COMMON) \
  $(LIBTCOIN_UTIL) \
  $(LIBTCOIN_CONSENSUS) \
  $(LIBTCOIN_CRYPTO) \
  $(LIBSECP256K1)

tcoin_tx_LDADD += $(BOOST_LIBS) $(CRYPTO_LIBS)
#

# tcoinconsensus library #
if BUILD_TCOIN_LIBS
include_HEADERS = script/tcoinconsensus.h
libtcoinconsensus_la_SOURCES = $(crypto_libtcoin_crypto_a_SOURCES) $(libtcoin_consensus_a_SOURCES)

if GLIBC_BACK_COMPAT
  libtcoinconsensus_la_SOURCES += compat/glibc_compat.cpp
endif

libtcoinconsensus_la_LDFLAGS = $(AM_LDFLAGS) -no-undefined $(RELDFLAGS)
libtcoinconsensus_la_LIBADD = $(LIBSECP256K1)
libtcoinconsensus_la_CPPFLAGS = $(AM_CPPFLAGS) -I$(builddir)/obj -I$(srcdir)/secp256k1/include -DBUILD_TCOIN_INTERNAL
libtcoinconsensus_la_CXXFLAGS = $(AM_CXXFLAGS) $(PIE_FLAGS)

endif
#

CTAES_DIST =  crypto/ctaes/bench.c
CTAES_DIST += crypto/ctaes/ctaes.c
CTAES_DIST += crypto/ctaes/ctaes.h
CTAES_DIST += crypto/ctaes/README.md
CTAES_DIST += crypto/ctaes/test.c

CLEANFILES = $(EXTRA_LIBRARIES)

CLEANFILES += *.gcda *.gcno
CLEANFILES += compat/*.gcda compat/*.gcno
CLEANFILES += consensus/*.gcda consensus/*.gcno
CLEANFILES += crypto/*.gcda crypto/*.gcno
CLEANFILES += policy/*.gcda policy/*.gcno
CLEANFILES += primitives/*.gcda primitives/*.gcno
CLEANFILES += script/*.gcda script/*.gcno
CLEANFILES += support/*.gcda support/*.gcno
CLEANFILES += univalue/*.gcda univalue/*.gcno
CLEANFILES += wallet/*.gcda wallet/*.gcno
CLEANFILES += wallet/test/*.gcda wallet/test/*.gcno
CLEANFILES += zmq/*.gcda zmq/*.gcno

DISTCLEANFILES = obj/build.h

EXTRA_DIST = $(CTAES_DIST)


config/tcoin-config.h: config/stamp-h1
	@$(MAKE) -C $(top_builddir) $(subdir)/$(@)
config/stamp-h1: $(top_srcdir)/$(subdir)/config/tcoin-config.h.in $(top_builddir)/config.status
	$(AM_V_at)$(MAKE) -C $(top_builddir) $(subdir)/$(@)
$(top_srcdir)/$(subdir)/config/tcoin-config.h.in:  $(am__configure_deps)
	$(AM_V_at)$(MAKE) -C $(top_srcdir) $(subdir)/config/tcoin-config.h.in

clean-local:
	-$(MAKE) -C secp256k1 clean
	-$(MAKE) -C univalue clean
	-rm -f leveldb/*/*.gcda leveldb/*/*.gcno leveldb/helpers/memenv/*.gcda leveldb/helpers/memenv/*.gcno
	-rm -f config.h
	-rm -rf test/__pycache__

.rc.o:
	@test -f $(WINDRES)
	## FIXME: How to get the appropriate modulename_CPPFLAGS in here?
	$(AM_V_GEN) $(WINDRES) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(CPPFLAGS) -DWINDRES_PREPROC -i $< -o $@

.mm.o:
	$(AM_V_CXX) $(OBJCXX) $(DEFS) $(DEFAULT_INCLUDES) $(INCLUDES) $(AM_CPPFLAGS) \
	  $(CPPFLAGS) $(AM_CXXFLAGS) $(QT_INCLUDES) $(AM_CXXFLAGS) $(PIE_FLAGS) $(CXXFLAGS) -c -o $@ $<

check-symbols: $(bin_PROGRAMS)
if GLIBC_BACK_COMPAT
	@echo "Checking glibc back compat..."
	$(AM_V_at) READELF=$(READELF) CPPFILT=$(CPPFILT) $(top_srcdir)/contrib/devtools/symbol-check.py < $(bin_PROGRAMS)
endif

check-security: $(bin_PROGRAMS)
if HARDEN
	@echo "Checking binary security..."
	$(AM_V_at) READELF=$(READELF) OBJDUMP=$(OBJDUMP) $(top_srcdir)/contrib/devtools/security-check.py < $(bin_PROGRAMS)
endif

%.pb.cc %.pb.h: %.proto
	@test -f $(PROTOC)
	$(AM_V_GEN) $(PROTOC) --cpp_out=$(@D) --proto_path=$(<D) $<

if EMBEDDED_LEVELDB
include Makefile.leveldb.include
endif

if ENABLE_TESTS
include Makefile.test.include
endif

if ENABLE_BENCH
include Makefile.bench.include
endif

if ENABLE_QT
include Makefile.qt.include
endif

if ENABLE_QT_TESTS
include Makefile.qttest.include
endif
