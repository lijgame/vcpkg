include(vcpkg_common_functions)

include(${CURRENT_INSTALLED_DIR}/share/qt5modularscripts/qt_modular_library.cmake)

qt_modular_library(qtdeclarative 858d33bfcd5b87904bb08e0fec04665d3f43ed84de4f4336f4ef4ad2f2bd6d4ea79c048c8f8f8adfd4c30d6a9e01cd46175dc0e5a1335a000c57c0d0058999bd)

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/tools/qt5-declarative/platforminputcontexts)
