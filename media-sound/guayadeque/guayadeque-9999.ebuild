# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

WX_GTK_VER=3.0

if [[ ${PV} == *9999 ]]; then
	SCM="git-r3"
	EGIT_REPO_URI=${EGIT_REPO_URI:-https://github.com/anonbeat/guayadeque}
	EGIT_BRANCH=${EGIT_BRANCH:-master}
fi

inherit cmake-utils vcs-snapshot wxwidgets $SCM

DESCRIPTION="Music management program designed for all music enthusiasts"
HOMEPAGE="https://guayadeque.org/"
if [[ ${PV} != *9999 ]]; then
	COMMIT=...
	SRC_URI="https://github.com/anonbeat/${PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
else
	KEYWORDS=""
fi

LICENSE="GPL-3+"
SLOT="0"
IUSE="appindicator ipod +minimal"

# No test available, Making src_test fail
RESTRICT="test"

GST_DEPS="
	media-libs/gnonlin:1.0
	media-plugins/gst-plugins-libav:1.0
	media-plugins/gst-plugins-libnice:1.0
	media-plugins/gst-plugins-pulse:1.0
	media-plugins/gst-plugins-soup:1.0
	media-libs/gst-plugins-bad:1.0
	media-libs/gst-plugins-ugly:1.0
"
RDEPEND="
	dev-db/sqlite:3
	>=dev-db/wxsqlite3-3.2.1
	dev-libs/glib:2
	media-libs/flac
	media-libs/gst-plugins-base:1.0
	media-libs/gst-plugins-good:1.0
	media-libs/gstreamer:1.0
	>=media-libs/taglib-1.6.4
	net-misc/curl
	sys-apps/dbus
	x11-libs/wxGTK:${WX_GTK_VER}[X]
	appindicator? ( >=dev-libs/libindicate-0.7 )
	ipod? ( media-libs/libgpod )
	!minimal? ( ${GST_DEPS} )"
DEPEND="${RDEPEND}
	app-arch/unzip
	sys-devel/gettext
	virtual/pkgconfig"

# echo $(cat po/CMakeLists.txt | grep ADD_SUBDIRECTORY | sed 's#ADD_SUBDIRECTORY( \(\w\+\) )#\1#')
LANGS=( bg ca_ES cs de el es fr hr hu is it ja nb nl pl pt pt_BR ru sk sr sr@latin sv th tr uk )

pkg_setup() {
	setup-wxwidgets
}

src_unpack() {
	if [[ ${PV} = *9999 ]]; then
		git-r3_src_unpack
		#cd "${S}"
		#cp "${FILESDIR}"/GIT-VERSION-GEN .
	fi
}

src_prepare() {
	cmake-utils_src_prepare

	# remove bundled libs
	rm -rf src/wx/wxsql* src/wxsqlite3 || die

	# comment out unused languages
	cd po || die
	local l
	for l in "${LANGS[@]}"; do
		! has ${l} ${LINGUAS-${l}} && cmake_comment_add_subdirectory ${l}
	done
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_IPOD=$(usex ipod)
		-DENABLE_LIBINDICATE=$(usex appindicator)
	)
	cmake-utils_src_configure
}

pkg_postinst() {
	if use minimal; then
		elog "If you are missing functionalities consider setting USE=-minimal"
		elog "or install any of the following packages:"

		local pkg
		for pkg in ${GST_DEPS}; do
			elog "\t ${pkg}"
		done
	fi
}
