# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

# ebuild generated by hackport 0.4.3

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
inherit haskell-cabal

DESCRIPTION="Binary serialisation for Haskell values using lazy ByteStrings"
HOMEPAGE="https://github.com/kolmodin/binary"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

RDEPEND=">=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-1.8
	test? ( dev-haskell/hunit
		>=dev-haskell/quickcheck-2.7
		>=dev-haskell/random-1.0.1.0
		dev-haskell/test-framework
		>=dev-haskell/test-framework-quickcheck2-0.3 )
"

CABAL_CORE_LIB_GHC_PV="7.10.* 7.11.2015*"
