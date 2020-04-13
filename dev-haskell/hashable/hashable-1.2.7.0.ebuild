# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

# ebuild generated by hackport 0.5.5.9999
#hackport: flags: sse41:cpu_flags_x86_sse4_1,sse2:cpu_flags_x86_sse2,integer-gmp:gmp

CABAL_FEATURES="lib profile haddock hoogle hscolour" # Drop test-suite: circular depend
# break circular dependencies:
# https://github.com/gentoo-haskell/gentoo-haskell/issues/810
CABAL_FEATURES+=" nocabaldep"
inherit haskell-cabal

DESCRIPTION="A class for types that can be converted to a hash value"
HOMEPAGE="https://github.com/tibbe/hashable"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="+cpu_flags_x86_sse2 cpu_flags_x86_sse4_1 examples +gmp"

RESTRICT=test # circular deps: hashable[test]->quickcheck->semigroups->hashable

RDEPEND=">=dev-haskell/text-0.11.0.5:=[profile?]
	>=dev-lang/ghc-7.4.1:=
"
DEPEND="${RDEPEND}"

src_prepare() {
	default

	cabal_chdeps \
		'base >= 4.4 && < 4.12' 'base >= 4.4'
}

src_configure() {
	haskell-cabal_src_configure \
		$(cabal_flag examples examples) \
		$(cabal_flag gmp integer-gmp) \
		$(cabal_flag cpu_flags_x86_sse2 sse2) \
		$(cabal_flag cpu_flags_x86_sse4_1 sse41)
}
