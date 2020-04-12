# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake kodi-addon

DESCRIPTION="Genesis Plus GX GameClient for Kodi"
HOMEPAGE="https://github.com/kodi-game/game.libretro.genplus"
SRC_URI=""

if [[ ${PV} == *9999 ]]; then
        SRC_URI=""
        EGIT_REPO_URI="https://github.com/kodi-game/game.libretro.genplus.git"
        inherit git-r3
else
        # see https://github.com/kodi-game/game.libretro.genplus/releases/
        KEYWORDS="~amd64 ~x86 ~arm64"
        CODENAME="Leia"
        SRC_URI="https://github.com/kodi-game/game.libretro.genplus/archive/${PV}-${CODENAME}.tar.gz -> ${P}.tar.gz"
        S="${WORKDIR}/game.libretro.genplus-${PV}-${CODENAME}"
fi

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
        =media-tv/kodi-18*
        games-emulation/libretro-genesis-plus-gx
        "
RDEPEND="
	media-plugins/kodi-game-libretro
        ${DEPEND}
        "
src_prepare() {
        echo 'find_library(GENESIS_PLUS_GX_LIB NAMES genesis_plus_gx_libretro${CMAKE_SHARED_LIBRARY_SUFFIX} PATH_SUFFIXES libretro)' > "${S}/Findlibretro-genesis-plus-gx.cmake" || die
        cmake_src_prepare
}
