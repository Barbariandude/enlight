# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/e_dbus/e_dbus-1.7.5.ebuild,v 1.1 2013/01/04 18:35:46 tommy Exp $

EAPI="2"

inherit autotools enlightenment

DESCRIPTION="Enlightenment's (Ecore) integration to DBus"
SRC_URI="http://download.enlightenment.org/releases/${P}.tar.bz2"

LICENSE="BSD-2"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="bluetooth +connman +libnotify ofono static-libs test-binaries +udev"

RDEPEND=""
DEPEND="${RDEPEND}"

src_prepare() {
	sed -i "s:1.7.5:1.7.4:g" configure.ac
	eautoreconf
}

src_configure() {
	MY_ECONF="
		$(use_enable bluetooth ebluez)
		$(use_enable connman econnman0_7x)
		$(use_enable doc)
		--disable-ehal
		$(use_enable libnotify enotify)
		$(use_enable ofono eofono)
		$(use_enable test-binaries edbus-test)
		$(use_enable test-binaries edbus-test-client)
		$(use_enable udev eukit)"
	if use test-binaries ; then
		MY_ECONF+="
			 $(use_enable bluetooth edbus-bluez-test)
			$(use_enable connman edbus-connman0_7x-test)
			$(use_enable libnotify edbus-notification-daemon-test)
			$(use_enable libnotify edbus-notify-test)
			$(use_enable ofono edbus-ofono-test)
			$(use_enable udev edbus-ukit-test)"
	else
		MY_ECONF+="
			 --disable-edbus-bluez-test
			--disable-edbus-connman0_7x-test
			--disable-edbus-notification-daemon-test
			--disable-edbus-notify-test
			--disable-edbus-ofono-test
			--disable-edbus-ukit-test
			--disable-edbus-async-test
			--disable-edbus-performance-test"
	fi
	enlightenment_src_configure
}
