# No need to run this file directly; just do `conda build -c moble -c conda-forge .`

export LALSUITE_SRCDIR=${SRC_DIR}
export LALSUITE_PREFIX=${PREFIX}

./00boot

./configure --prefix=${PREFIX} --enable-swig-python

# The automatically generated Makefiles have some inexplicable errors.
# But they can change (even for the same version), depending on the
# machine, so using normal patches (which can be given in meta.yaml)
# would be dangerous.  This should do a more robust job of fixing the
# errors.
# find ${SRC_DIR} -type f -name Makefile -exec perl ${RECIPE_DIR}/patch.pl {} \;

make

make install
