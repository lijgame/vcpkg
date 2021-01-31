# Automatically generated by scripts/boost/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/nowide
    REF boost-1.75.0
    SHA512 15f836928459477339e11780b7ead2aa7f1721ec5c443a5370e1d6dd732228185f9055cbad169982aa6dee3d5c9efdce3076d9228d12cebfbe40475490503128
    HEAD_REF master
)

file(READ "${SOURCE_PATH}/build/Jamfile.v2" _contents)
string(REPLACE "import ../../config/checks/config" "import config/checks/config" _contents "${_contents}")
string(REPLACE "check-target-builds ../config//cxx11_moveable_fstreams" "check-target-builds ../check_movable_fstreams.cpp" _contents "${_contents}")
string(REPLACE "check-target-builds ../config//lfs_support" "check-target-builds ../check_lfs_support.cpp" _contents "${_contents}")
file(WRITE "${SOURCE_PATH}/build/Jamfile.v2" "${_contents}")
file(COPY "${CURRENT_INSTALLED_DIR}/share/boost-config/checks" DESTINATION "${SOURCE_PATH}/build/config")
file(COPY "${SOURCE_PATH}/config/check_lfs_support.cpp" "${SOURCE_PATH}/config/check_movable_fstreams.cpp" DESTINATION "${SOURCE_PATH}/build/config")
include(${CURRENT_INSTALLED_DIR}/share/boost-build/boost-modular-build.cmake)
boost_modular_build(
    SOURCE_PATH ${SOURCE_PATH}
    BOOST_CMAKE_FRAGMENT "${CMAKE_CURRENT_LIST_DIR}/b2-options.cmake"
)
include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
