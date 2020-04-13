# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.3.2.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="An efficient packed Unicode text type"
HOMEPAGE="https://github.com/bos/text"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="developer"

RDEPEND=">=dev-lang/ghc-6.10.4:="
DEPEND="${RDEPEND}
		>=dev-haskell/cabal-1.8
		test? ( >=dev-haskell/hunit-1.2
			>=dev-haskell/quickcheck-2.4
			dev-haskell/random
			>=dev-haskell/test-framework-0.4
			>=dev-haskell/test-framework-hunit-0.2
			>=dev-haskell/test-framework-quickcheck2-0.2
		)"

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag developer developer)
}
