# SPDX-FileCopyrightText: Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
#
# SPDX-License-Identifier: BSD-3-Clause

qt_add_executable(waylandscanner
    MANUAL_FINALIZATION
    waylandscanner.cpp
)

set_target_properties(waylandscanner PROPERTIES OUTPUT_NAME aurora-wayland-scanner)

qt_finalize_target(waylandscanner)

target_link_libraries(waylandscanner PUBLIC
    Qt6::Core
    Qt6::Xml
)

add_executable(Liri::waylandscanner ALIAS waylandscanner)

install(
    TARGETS waylandscanner
    DESTINATION ${KDE_INSTALL_BINDIR}
)
