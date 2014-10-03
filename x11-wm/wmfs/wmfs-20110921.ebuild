# Distributed under the terms of the GNU General Public License v2

EAPI="5"

GITHUB_COMMIT="b9e67982f8bf1c4992755c3bde6085a7f0a0e093"

DESCRIPTION="Windows Manager From Scratch"
HOMEPAGE="http://wmfs.info"
SRC_URI="https://github.com/xorg62/wmfs/archive/wmfs1/${GITHUB_COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~*"
IUSE="imlib2 xinerama xrandr"

S="${WORKDIR}/wmfs-${GITHUB_COMMIT}"

RDEPEND="!x11-wm/wmfs2
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXft
	imlib2? ( media-libs/imlib2 )
	xinerama? ( x11-libs/libXinerama )
	xrandr? ( x11-libs/libXrandr )"

DEPEND="${RDEPEND}"

src_prepare() {
	sed -e "s;PREFIX=/usr/local;PREFIX=/usr;g" \
		-i "${S}/configure" || die

	sed -e 's;MANPREFIX="$PREFIX/man";MANPREFIX=/usr/share/man;g' \
		-i "${S}/configure" || die

	sed -e 's;XDG_CONFIG_DIR="$PREFIX/etc/xdg";XDG_CONFIG_DIR=/etc/xdg;g' \
		-i "${S}/configure" || die
}

src_configure() {
	econf $(use_with imlib2) \
		$(use_with xinerama) \
		$(use_with xrandr)
}
