# SPDX-FileCopyrightText: 2022 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
#
# SPDX-License-Identifier: BSD-3-Clause

cmake_minimum_required(VERSION 3.19)

project("AuroraScanner"
    VERSION "0.0.0"
    DESCRIPTION "Converts Wayland protocol definition to C++ code"
    LANGUAGES CXX C
)

## Only build on the appropriate platforms.
if(NOT (CMAKE_SYSTEM_NAME MATCHES "Linux" OR CMAKE_SYSTEM_NAME MATCHES "Darwin" OR CMAKE_SYSTEM_NAME MATCHES "QNX"))
    message(NOTICE "Skipping the build as the condition \"Linux OR Darwin OR QNX\" is not met.")
    return()
endif()

## Enable feature summary at the end of the configure run:
include(FeatureSummary)

## Find Qt:
find_package(Qt6
    REQUIRED
    COMPONENTS
        Core
        Xml
)

## ECM:
find_package(ECM 5.245.0 REQUIRED NO_MODULE)
list(APPEND CMAKE_MODULE_PATH ${ECM_MODULE_PATH})

## Installation directories:
include(KDEInstallDirs)

## Compiler settings:
set(KDE_SKIP_NULLPTR_WARNINGS_SETTINGS TRUE)
include(KDECompilerSettings NO_POLICY_SCOPE)

## Enable keywords such as emit:
# TODO: Replace keywords such as emit with Q_EMIT
remove_definitions(-DQT_NO_KEYWORDS)

## CMake settings:
include(KDECMakeSettings)

## Project setup:
qt_standard_project_setup(REQUIRES 6.6)

## Disable use of C++ API deprecated in Qt 5.15
add_compile_definitions(QT_DISABLE_DEPRECATED_UP_TO=0x050F00)

## Add subdirectories:
add_subdirectory(src/waylandscanner)
