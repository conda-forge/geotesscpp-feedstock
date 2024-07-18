#!/usr/bin/env bash

set -e

# Put conda-build compiler flags into a variable already used in the
# Makefile by overriding it. Hopefully, this will pass conda-build's @rpath and
# make the library relocatable.
CCFLAGS="${CXXFLAGS} ${LDFLAGS}"

# install_name is where the library thinks it is.
# if [[ `uname` == 'Linux' ]]; then
#     CCFLAGS="${CCFLAGS} -Wl,-install_name,@rpath/libgeotesscpp.${SHLIB_EXT}"
# else
#     CCFLAGS="${CCFLAGS} -Wl,-install_name,@rpath/libgeotesscpp.${SHLIB_EXT}"
# fi


# LIB is the output location of the library, which also tells linking programs
# where to look for it.  $PREFIX is an absolute path on the build machine that
# should be overwritten by patchelf or install_name_tool to make it relocatable.
make libraries CC=${CC} LIB=${PREFIX}/lib CCFLAGS="${CCFLAGS}"

# copy dynamic libraries into standard location
# This should be done already if LIB is set properly
# cp lib/* $PREFIX/lib/

# See if the absolute paths were properly patched.
if [[ `uname` == 'Linux' ]]; then
    readelf -d -r $PREFIX/lib/libgeotess*
else
    objdump -p $PREFIX/lib/libgeotess*
fi

# copy headers into standard location
mkdir -p $PREFIX/include/geotesscpp
cp GeoTessCPP/include/* $PREFIX/include/geotesscpp
cp GeoTessCPPExamples/include/AK135Model.h $PREFIX/include/geotesscpp
cp GeoTessAmplitudeCPP/include/* $PREFIX/include/geotesscpp

