# Automatically generated by boost-vcpkg-helpers/generate-ports.ps1

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO boostorg/log
    REF boost-1.73.0
    SHA512 150013753d5060618c431ed9a819e3ec666bdba42cf3d463335ca49d66b8d6e800d5419332011f5ce05f19bc9c67a1cebc547279bf2931258ff7753a67796f2f
    HEAD_REF master
)

file(READ "${SOURCE_PATH}/build/Jamfile.v2" _contents)
string(REPLACE "import ../../config/checks/config" "import config/checks/config" _contents "${_contents}")
string(REPLACE " <conditional>@select-arch-specific-sources" "#<conditional>@select-arch-specific-sources" _contents "${_contents}")
file(WRITE "${SOURCE_PATH}/build/Jamfile.v2" "${_contents}")
file(COPY "${CURRENT_INSTALLED_DIR}/share/boost-config/checks" DESTINATION "${SOURCE_PATH}/build/config")

file(READ ${SOURCE_PATH}/build/log-architecture.jam _contents)
string(REPLACE
    "\nproject.load [ path.join [ path.make $(here:D) ] ../../config/checks/architecture ] ;"
    "\nproject.load [ path.join [ path.make $(here:D) ] config/checks/architecture ] ;"
    _contents "${_contents}")
file(WRITE ${SOURCE_PATH}/build/log-architecture.jam "${_contents}")

include(${CURRENT_INSTALLED_DIR}/share/boost-build/boost-modular-build.cmake)
boost_modular_build(SOURCE_PATH ${SOURCE_PATH})
include(${CURRENT_INSTALLED_DIR}/share/boost-vcpkg-helpers/boost-modular-headers.cmake)
boost_modular_headers(SOURCE_PATH ${SOURCE_PATH})
