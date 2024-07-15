#!/usr/bin/env bash

set -e

# Put conda-build compiler flags into a variable already used in the
# Makefile by overriding it, including some of what it included originally.
# Hopefully, this will pass conda-build's @rpath and make the library
# relocatable.

# CCFLAGS="${CFLAGS} ${CXXFLAGS} ${LDFLAGS} -m64 -O3"
# CCFLAGS="${CXXFLAGS} ${LDFLAGS} -m64 -O3"
CCFLAGS="${CXXFLAGS} ${LDFLAGS}"

# if [[ `uname` == 'Linux' ]]; then
#     # g++
#     CCFLAGS="${CCFLAGS} -DLinux"
# else
#     # Apple Clang
#     CCFLAGS="${CCFLAGS} -DDarwin"
# fi

echo "make all CC=${CC} CCFLAGS=${CCFLAGS}"
make all CC=${CC} CCFLAGS=${CCFLAGS}
# make all CC=${CC} CCFLAGS=${CCFLAGS} LIB=${PREFIX}/lib

# copy dynamic libraries into standard location
cp lib/* $PREFIX/lib/

# copy headers into standard location
mkdir -p $PREFIX/include/geotesscpp
cp GeoTessCPP/include/* $PREFIX/include/geotesscpp
cp GeoTessCPPExamples/include/AK135Model.h $PREFIX/include/geotesscpp
cp GeoTessAmplitudeCPP/include/* $PREFIX/include/geotesscpp

