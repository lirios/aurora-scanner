# SPDX-FileCopyrightText: 2023 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

add_executable(waylandscanner waylandscanner.cpp)

set_target_properties(waylandscanner PROPERTIES OUTPUT_NAME aurora-wayland-scanner)

target_link_libraries(waylandscanner
    PRIVATE
        Qt6::Core
        Qt6::Xml
)

add_executable(Liri::waylandscanner ALIAS waylandscanner)

install(
    TARGETS waylandscanner
    DESTINATION ${KDE_INSTALL_BINDIR}
)
