
set -e

rm -rf SPIRV-Cross 
rm -rf SPIRV-Cross.xcframework

git clone https://github.com/KhronosGroup/SPIRV-Cross
cd SPIRV-Cross 
git checkout tags/sdk-1.3.243.0

# macOS build
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release \
      "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DCMAKE_INSTALL_PREFIX="$(pwd)/install" \
      ..
make -j8 install
cd ..

# iOS build
mkdir build_ios
cd build_ios

# from https://cmake.org/cmake/help/latest/manual/cmake-toolchains.7.html#cross-compiling-for-ios-tvos-or-watchos
cmake -GXcode \
      -DCMAKE_SYSTEM_NAME=iOS \
     "-DCMAKE_OSX_ARCHITECTURES=arm64;x86_64" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET=11.0 \
      -DCMAKE_XCODE_ATTRIBUTE_ONLY_ACTIVE_ARCH=NO \
      -DCMAKE_IOS_INSTALL_COMBINED=YES \
      -DMACOSX_BUNDLE_GUI_IDENTIFIER=org.khronos.spirv-cross \
      .. 

xcodebuild -configuration Release install
xcodebuild -configuration Release -sdk iphonesimulator install

cd ..

# move libraries into place
mkdir libs
#libtool -o libs/glslang_macos.a build/install/lib/*.a
#libtool -o libs/glslang_ios.a build_ios/build/UninstalledProducts/iphoneos/*.a
#libtool -o libs/glslang_ios_simulator.a build_ios/build/UninstalledProducts/iphonesimulator/*.a

#xcodebuild -create-xcframework \
#           -library libs/glslang_macos.a \
#           -headers build/install/include \
#           -library libs/glslang_ios.a \
#           -headers build/install/include \
#           -library libs/glslang_ios_simulator.a \
#           -headers build/install/include \
#           -output glslang.xcframework

mv SPIRV-Cross.xcframework ..
cd ..

