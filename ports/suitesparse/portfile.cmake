include(vcpkg_common_functions)

vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

set(SUITESPARSE_VER 5.4.0)
set(SUITESPARSEWIN_VER 1.5.0)

# vcpkg_download_distfile(SUITESPARSE
#     URLS "http://faculty.cse.tamu.edu/davis/SuiteSparse/SuiteSparse-${SUITESPARSE_VER}.tar.gz"
#     FILENAME "SuiteSparse-${SUITESPARSE_VER}.tar.gz"
#     SHA512 8328bcc2ef5eb03febf91b9c71159f091ff405c1ba7522e53714120fcf857ceab2d2ecf8bf9a2e1fc45e1a934665a341e3a47f954f87b59934f4fce6164775d6
# )

# vcpkg_extract_source_archive_ex(
#     OUT_SOURCE_PATH SOURCE_PATH
#     ARCHIVE ${SUITESPARSE}
# )

vcpkg_from_github(
    OUT_SOURCE_PATH SUITESPARSEWIN_SOURCE_PATH
    REPO jlblancoc/suitesparse-metis-for-windows
    REF v${SUITESPARSEWIN_VER}
    SHA512 1e316323945c7efaafd51109aca15917c7db8859fd144dee23539e4e072b4ac7148233d1bc51c2a92fbbdf1652a1a0c0ea3f41b7d1e35b0aca6ea49d9ee8bfeb
    HEAD_REF master
    PATCHES
        suitesparse.patch
        add-find-package-metis.patch
        fix-cuda-errors.patch
)

# Copy suitesparse sources.
message(STATUS "Copying SuiteSparse source files...")
# Should probably remove everything but CMakeLists.txt files?
# file(GLOB SUITESPARSE_SOURCE_FILES ${SOURCE_PATH}/*)
# foreach(SOURCE_FILE ${SUITESPARSE_SOURCE_FILES})
#     file(COPY ${SOURCE_FILE} DESTINATION "${SUITESPARSEWIN_SOURCE_PATH}/SuiteSparse")
# endforeach()
# message(STATUS "Copying SuiteSparse source files... done")
message(STATUS "Removing integrated lapack and metis libs...")
file(REMOVE_RECURSE ${SUITESPARSEWIN_SOURCE_PATH}/lapack_windows)
file(REMOVE_RECURSE ${SUITESPARSEWIN_SOURCE_PATH}/metis)
message(STATUS "Removing integrated lapack and metis libs... done")

set(USE_VCPKG_METIS OFF)
if("metis" IN_LIST FEATURES)
    set(USE_VCPKG_METIS ON)
    set(ADDITIONAL_BUILD_OPTIONS "-DMETIS_SOURCE_DIR=${CURRENT_INSTALLED_DIR}")
endif()

set(USE_CUDA OFF)
if("cuda" IN_LIST FEATURES)
    set(USE_CUDA ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SUITESPARSEWIN_SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_METIS=OFF
        -DUSE_VCPKG_METIS=${USE_VCPKG_METIS}
        ${ADDITIONAL_BUILD_OPTIONS}
        -DWITH_CUDA=${USE_CUDA}
     OPTIONS_DEBUG
        -DSUITESPARSE_INSTALL_PREFIX="${CURRENT_PACKAGES_DIR}/debug"
     OPTIONS_RELEASE
        -DSUITESPARSE_INSTALL_PREFIX="${CURRENT_PACKAGES_DIR}"
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/suitesparse-${SUITESPARSE_VER})

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SUITESPARSEWIN_SOURCE_PATH}/SuiteSparse/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/suitesparse RENAME copyright)
file(INSTALL ${SUITESPARSEWIN_SOURCE_PATH}/LICENSE.md DESTINATION ${CURRENT_PACKAGES_DIR}/share/suitesparse RENAME copyright_suitesparse-metis-for-windows)
