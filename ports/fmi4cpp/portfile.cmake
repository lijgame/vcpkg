# Common Ambient Variables:
#   CURRENT_BUILDTREES_DIR    = ${VCPKG_ROOT_DIR}\buildtrees\${PORT}
#   CURRENT_PACKAGES_DIR      = ${VCPKG_ROOT_DIR}\packages\${PORT}_${TARGET_TRIPLET}
#   CURRENT_PORT_DIR          = ${VCPKG_ROOT_DIR}\ports\${PORT}
#   PORT                      = current port name (zlib, etc)
#   TARGET_TRIPLET            = current triplet (x86-windows, x64-windows-static, etc)
#   VCPKG_CRT_LINKAGE         = C runtime linkage type (static, dynamic)
#   VCPKG_LIBRARY_LINKAGE     = target library linkage type (static, dynamic)
#   VCPKG_ROOT_DIR            = <C:\path\to\current\vcpkg>
#   VCPKG_TARGET_ARCHITECTURE = target architecture (x64, x86, arm)
#

include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO NTNU-IHB/FMI4cpp
    REF v0.7.0
    SHA512 5846f5b28badb5b4836ffd9d284f602dd243df20d3c82cab5e2b62b8be37e0ab05b7422bca066f37ca67ee0d5b35abd2febe87f623fc3b9854d245e86e1e21fe
    HEAD_REF master
)

set(WITH_CURL OFF)
if("curl" IN_LIST FEATURES)
    set(WITH_CURL ON)
endif()

set(WITH_ODEINT OFF)
if("odeint" IN_LIST FEATURES)
    set(WITH_ODEINT ON)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DFMI4CPP_BUILD_TOOL=OFF
        -DFMI4CPP_BUILD_TESTS=OFF
        -DFMI4CPP_BUILD_EXAMPLES=OFF
        -DFMI4CPP_WITH_CURL=${WITH_CURL}
	-DFMI4CPP_WITH_ODEINT=${WITH_ODEINT}
)

vcpkg_install_cmake()
vcpkg_fixup_cmake_targets()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/fmi4cpp RENAME copyright)

vcpkg_copy_pdbs()
