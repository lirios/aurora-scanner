# SPDX-FileCopyrightText: 2021-2023 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
# SPDX-License-Identifier: BSD-3-Clause

include(CMakeParseArguments)

function(aurora_generate_wayland_protocol_client_sources target)
    cmake_parse_arguments(_arg "" "" "FILES" ${ARGN})
    if(DEFINED _arg_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unknown arguments passed to aurora_generate_wayland_protocol_client_sources: (${_arg_UNPARSED_ARGUMENTS}).")
    endif()

    get_target_property(target_binary_dir "${target}" BINARY_DIR)

    if(NOT TARGET Wayland::waylandscanner)
        find_program(__wayland_scanner_exe NAMES "wayland-scanner" NO_CACHE REQUIRED)
        add_executable(Wayland::waylandscanner IMPORTED)
        set_target_properties(Wayland::waylandscanner PROPERTIES IMPORTED_LOCATION "${__wayland_scanner_exe}")
    endif()

    if(NOT TARGET Aurora::waylandscanner)
        find_program(__aurora_wayland_scanner_exe NAMES "aurora-wayland-scanner" NO_CACHE REQUIRED)
        add_executable(Aurora::waylandscanner IMPORTED)
        set_target_properties(Aurora::waylandscanner PROPERTIES IMPORTED_LOCATION "${__aurora_wayland_scanner_exe}")
    endif()

    foreach(protocol_file IN LISTS _arg_FILES)
        get_filename_component(protocol_name "${protocol_file}" NAME_WLE)
        if(NOT IS_ABSOLUTE "${protocol_file}")
            set(protocol_file "${CMAKE_CURRENT_SOURCE_DIR}/${protocol_file}")
	endif()

        set(c_code_path "${target_binary_dir}/wayland_generated/wayland-${protocol_name}-protocol.c")
        set(c_header_path "${target_binary_dir}/wayland_generated/wayland-${protocol_name}-client-protocol.h")
        set(cpp_code_path "${target_binary_dir}/wayland_generated/aurora-client-${protocol_name}.cpp")
        set(cpp_header_path "${target_binary_dir}/wayland_generated/aurora-client-${protocol_name}.h")

        file(MAKE_DIRECTORY "${target_binary_dir}/wayland_generated")

        set_source_files_properties(
            "${c_code_path}"
            "${c_header_path}"
            "${cpp_code_path}"
            "${cpp_header_path}"
            PROPERTIES
                GENERATED ON
                SKIP_AUTOMOC ON
        )
        set_source_files_properties(
            "${c_header_path}"
            "${cpp_header_path}"
            PROPERTIES
                LIRI_PRIVATE_HEADER ON
        )

        add_custom_command(
            OUTPUT "${c_header_path}"
            COMMAND Wayland::waylandscanner --strict --include-core-only client-header "${protocol_file}" "${c_header_path}"
            DEPENDS "${protocol_file}"
        )
        add_custom_command(
            OUTPUT "${c_code_path}"
            COMMAND Wayland::waylandscanner --strict --include-core-only public-code "${protocol_file}" "${c_code_path}"
            DEPENDS "${protocol_file}" "${c_header_path}"
        )

        add_custom_command(
            OUTPUT "${cpp_header_path}"
            COMMAND Aurora::waylandscanner client-header "${protocol_file}" "" > "${cpp_header_path}"
            DEPENDS "${protocol_file}" "${c_header_path}"
        )
        add_custom_command(
            OUTPUT "${cpp_code_path}"
            COMMAND Aurora::waylandscanner client-code "${protocol_file}" "" > "${cpp_code_path}"
            DEPENDS "${protocol_file}" "${c_header_path}" "${cpp_header_path}"
        )

        target_sources("${target}"
            PRIVATE
                "${c_code_path}"
                "${c_header_path}"
                "${cpp_code_path}"
                "${cpp_header_path}"
        )
    endforeach()

    target_include_directories("${target}" PRIVATE "${target_binary_dir}/wayland_generated")
endfunction()

function(aurora_generate_wayland_protocol_server_sources target)
    cmake_parse_arguments(_arg "" "" "FILES" ${ARGN})
    if(DEFINED _arg_UNPARSED_ARGUMENTS)
        message(FATAL_ERROR "Unknown arguments passed to aurora_generate_wayland_protocol_server_sources: (${_arg_UNPARSED_ARGUMENTS}).")
    endif()

    get_target_property(target_binary_dir "${target}" BINARY_DIR)

    if(NOT TARGET Wayland::waylandscanner)
        find_program(__wayland_scanner_exe NAMES "wayland-scanner" NO_CACHE REQUIRED)
        add_executable(Wayland::waylandscanner IMPORTED)
        set_target_properties(Wayland::waylandscanner PROPERTIES IMPORTED_LOCATION "${__wayland_scanner_exe}")
    endif()

    if(NOT TARGET Aurora::waylandscanner)
        find_program(__aurora_wayland_scanner_exe NAMES "aurora-wayland-scanner" NO_CACHE REQUIRED)
        add_executable(Aurora::waylandscanner IMPORTED)
        set_target_properties(Aurora::waylandscanner PROPERTIES IMPORTED_LOCATION "${__aurora_wayland_scanner_exe}")
    endif()

    foreach(protocol_file IN LISTS _arg_FILES)
        get_filename_component(protocol_name "${protocol_file}" NAME_WLE)
        if(NOT IS_ABSOLUTE "${protocol_file}")
            set(protocol_file "${CMAKE_CURRENT_SOURCE_DIR}/${protocol_file}")
	endif()

        set(c_code_path "${target_binary_dir}/wayland_generated/wayland-${protocol_name}-protocol.c")
        set(c_header_path "${target_binary_dir}/wayland_generated/wayland-${protocol_name}-server-protocol.h")
        set(cpp_code_path "${target_binary_dir}/wayland_generated/aurora-server-${protocol_name}.cpp")
        set(cpp_header_path "${target_binary_dir}/wayland_generated/aurora-server-${protocol_name}.h")

        file(MAKE_DIRECTORY "${target_binary_dir}/wayland_generated")

        set_source_files_properties(
            "${c_code_path}"
            "${c_header_path}"
            "${cpp_code_path}"
            "${cpp_header_path}"
            PROPERTIES
                GENERATED ON
                SKIP_AUTOMOC ON
        )
        set_source_files_properties(
            "${c_header_path}"
            "${cpp_header_path}"
            PROPERTIES
                LIRI_PRIVATE_HEADER ON
        )

        add_custom_command(
            OUTPUT "${c_header_path}"
            COMMAND Wayland::waylandscanner --strict --include-core-only server-header "${protocol_file}" "${c_header_path}"
            DEPENDS "${protocol_file}"
        )
        add_custom_command(
            OUTPUT "${c_code_path}"
            COMMAND Wayland::waylandscanner --strict --include-core-only public-code "${protocol_file}" "${c_code_path}"
            DEPENDS "${protocol_file}" "${c_header_path}"
        )

        add_custom_command(
            OUTPUT "${cpp_header_path}"
            COMMAND Aurora::waylandscanner server-header "${protocol_file}" "" > "${cpp_header_path}"
            DEPENDS "${protocol_file}" "${c_header_path}"
        )
        add_custom_command(
            OUTPUT "${cpp_code_path}"
            COMMAND Aurora::waylandscanner server-code "${protocol_file}" "" > "${cpp_code_path}"
            DEPENDS "${protocol_file}" "${c_header_path}" "${cpp_header_path}"
        )

        target_sources("${target}"
            PRIVATE
                "${c_code_path}"
                "${c_header_path}"
                "${cpp_code_path}"
                "${cpp_header_path}"
        )
    endforeach()

    target_include_directories("${target}" PRIVATE "${target_binary_dir}/wayland_generated")
endfunction()
