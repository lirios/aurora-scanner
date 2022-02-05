Aurora Scanner
==============

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](http://www.gnu.org/licenses/gpl.txt)
[![GitHub release](https://img.shields.io/github/release/lirios/aurora-scanner.svg)](https://github.com/lirios/aurora-scanner)
[![GitHub issues](https://img.shields.io/github/issues/lirios/aurora-scanner.svg)](https://github.com/lirios/aurora-scanner/issues)
[![CI](https://github.com/lirios/aurora-scanner/workflows/CI/badge.svg?branch=develop)](https://github.com/lirios/aurora-scanner/actions?query=workflow%3ACI)

Converts Wayland protocol definition to C++ code.

## Dependencies

Qt >= 5.15.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)

The following modules and their dependencies are required:

 * [cmake](https://gitlab.kitware.com/cmake/cmake) >= 3.10.0
 * [cmake-shared](https://github.com/lirios/cmake-shared.git) >= 2.0.0

## Installation

```sh
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/path/to/prefix ..
make
make install # use sudo if necessary
```

Replace `/path/to/prefix` to your installation prefix.
Default is `/usr/local`.

## Licensing

Licensed under the terms of the GNU General Public License version 3 or,
at your option, any later version.
