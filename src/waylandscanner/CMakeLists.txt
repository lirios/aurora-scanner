# SPDX-FileCopyrightText: 2023 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

add_executable(waylandscanner waylandscanner.cpp)

set_target_properties(waylandscanner PROPERTIES OUTPUT_NAME aurora-wayland-scanner)

target_link_libraries(waylandscanner
    PRIVATE
        Qt6::Core
        Qt6::Xml
)

add_executable(Aurora::waylandscanner ALIAS waylandscanner)

install(
    TARGETS waylandscanner
    DESTINATION ${KDE_INSTALL_BINDIR}
)

## Package:

set(_cmakeconfig_install_dir "${KDE_INSTALL_CMAKEPACKAGEDIR}/AuroraScanner")

include(CMakePackageConfigHelpers)

configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/AuroraScannerConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/AuroraScannerConfig.cmake"
    INSTALL_DESTINATION
        "${_cmakeconfig_install_dir}"
)

write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/AuroraScannerConfigVersion.cmake"
    VERSION
        "${PROJECT_VERSION}"
    COMPATIBILITY
        AnyNewerVersion
)

install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/AuroraScannerConfig.cmake"
        "${CMAKE_CURRENT_BINARY_DIR}/AuroraScannerConfigVersion.cmake"
        "${CMAKE_CURRENT_SOURCE_DIR}/AuroraScannerMacros.cmake"
    DESTINATION
        "${_cmakeconfig_install_dir}"
    COMPONENT
        Devel
)
