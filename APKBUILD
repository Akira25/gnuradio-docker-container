# Contributor: Marian Buschsieweke <marian.buschsieweke@posteo.net>
# Maintainer: Marian Buschsieweke <marian.buschsieweke@posteo.net>
# Modified: Martin Hübner <martin.hubner@web.de>
# pkgname=gnuradio-minimal
pkgname=gnuradio
# This package strips gnuradio down to a minimized version. It omits
# everything related to: Audio, Graphics, Docs and SDR-drivers. IO to
# flowgraphs can be handled by zmq sockets instead. SDRs and Audio to
# be handled by flowgraphs running on the host system.
pkgver=3.10.11.0
pkgrel=2
pkgdesc="General purpose DSP and SDR toolkit"
url="https://www.gnuradio.org"
# loongarch64, s390x: tests fail
# ppc64le: blocked by mpir
arch="all !loongarch64 !ppc64le !s390x"
license="GPL-3.0-or-later"
depends="
	py3-click
	py3-click-plugins
	py3-gobject3
	py3-mako
	py3-numpy
	py3-scipy
	py3-yaml
	py3-pyzmq
	cppzmq
	"
depends_dev="
	blas-dev
	boost-dev
	fftw-dev
	gmp-dev
	gsl-dev
	gsm-dev
	libsndfile-dev
	mpir-dev
	py3-numpy-dev
	py3-pybind11-dev
	py3-sphinx
	python3-dev
	spdlog-dev
	thrift-dev
	zeromq-dev
	"
makedepends="
	$depends_dev
	cmake
	graphviz
	libvolk-dev
	samurai
	"
checkdepends="xvfb-run"
subpackages="$pkgname-doc $pkgname-dev"
source="
	$pkgname-$pkgver.tar.gz::https://github.com/gnuradio/gnuradio/archive/v$pkgver.tar.gz
	fix-test-numpy2.patch
	"

build() {
	# inlining failed in call to 'always_inline' 'vsnprintf':
	# function body can be overwritten at link time
	export CXXFLAGS="$CXXFLAGS -flto=auto -U_FORTIFY_SOURCE"
	cmake -B build -G Ninja \
		-DCMAKE_BUILD_TYPE=RelWithDebInfo 	\
		-DCMAKE_INSTALL_PREFIX=/usr 		\
		-DCMAKE_INSTALL_LIBDIR=lib 			\
		-DENABLE_PYTHON=ON 					\
		-DENABLE_GR_ZEROMQ=ON 				\
		-DENABLE_GR_AUDIO=OFF	 			\
		-DENABLE_DOXYGEN=OFF				\
		-DENABLE_GRC=OFF 					\
		-DENABLE_GR_QTGUI=OFF 				\
		-DENABLE_GR_SOAPY=OFF				\
		-DENABLE_GR_UHD=OFF					\
		-DENABLE_GR_VIDEO_SDL=OFF			\
		-Wno-dev
	# cmake -LAH  # show all vars that get configured by cmake
	cmake --build build
}

package() {
	DESTDIR="$pkgdir" cmake --install build
}

check() {
	# remove failing tests
	case "$CARCH" in
	x86_64)
		sed -i build/gr-blocks/python/blocks/CTestTestfile.cmake \
			-e '/add_test(qa_rotator_cc /d'
		;;
	esac
	# filter_qa_fir_filter_with_buffer.cc: failing GLIBCXX assertion
	# needs pygccxml
	timeout 600 \
		xvfb-run -a ctest -E '(test_modtool|qa_throttle|qa_uncaught_exception|filter_qa_fir_filter_with_buffer.cc)' --output-on-failure --test-dir build
}

sha512sums="
faf47956924832b04c66469ba3bdf174876d25c41e0f1c1dde3755596d232e2d18f5dab7aa848463f2d23ec8bcda0283ee8ede34fd57b079fe3cdb62c6470a82  gnuradio-3.10.11.0.tar.gz
3b9d013321749b213d010d3cc3da52d4f1867dd1607a4fc78dffed17f2f3d55c05a959bacacd953d57239dbaee5be484c91e05defc212c5929c85de561593bee  fix-test-numpy2.patch
"
