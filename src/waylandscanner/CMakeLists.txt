# SPDX-FileCopyrightText: Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
#
# SPDX-License-Identifier: BSD-3-Clause

liri_add_executable(waylandscanner
    SOURCES
        waylandscanner.cpp
    OUTPUT_NAME
        aurora-wayland-scanner
    INSTALL_DIRECTORY
        "${INSTALL_LIBEXECDIR}"
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
    LIBRARIES
        Qt::Core
        Qt::Xml
)

liri_finalize_executable(waylandscanner)

add_executable(Liri::waylandscanner ALIAS waylandscanner)
