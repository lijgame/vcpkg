set packages=eigen3 rapidxml glfw3 glm xerces-c gflags mpir mpfr glew gtest libpng flann tbb tiff libjpeg-turbo libgeotiff boost log4cplus[unicode] freeimage gumbo qt5 glog tinyxml2 suitesparse ceres[suitesparse] opencv3[eigen] protobuf[zlib] spdlog
vcpkg install --triplet recon %packages% --recurse
vcpkg export --triplet  recon %packages% --zip
