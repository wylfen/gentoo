# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.9999

CABAL_FEATURES="bin lib profile haddock hoogle hscolour"
inherit haskell-cabal

DESCRIPTION="Memory mapped files for POSIX and Windows"
HOMEPAGE="http://hackage.haskell.org/package/mmap"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ppc ppc64 x86 ~ppc-macos ~x86-macos"
# IUSE="test"
IUSE=""

RESTRICT="test" # the test suite compile fails: Not in scope: data constructor `Permissions'

RDEPEND=">=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.6"
#		test? ( dev-haskell/hunit[profile?] )" # pcheck dislikes useless depends

src_configure() {
	cabal_src_configure # $(cabal_flag test mmaptest)
}

src_test() {
	# breaking the abstraction a bit, we're not supposed to know about ./setup
	# and how it works...
	./dist/build/mmaptest/mmaptest || die "tests failed"
}

src_install() {
	cabal_src_install

	rm "${D}/usr/bin/mmaptest"
	rmdir "${D}/usr/bin" 2> /dev/null # only if empty
}
