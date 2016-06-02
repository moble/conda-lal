# No need to run this file directly; just do `conda build -c moble -c conda-forge .` in this directory

export LALSUITE_SRCDIR=${SRC_DIR}
export LALSUITE_PREFIX=${PREFIX}

./00boot

./configure --prefix=${PREFIX} --enable-swig-python

make

make install
