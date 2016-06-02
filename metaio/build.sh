# No need to run this file directly; just do `conda build .`

# ax_cv_mexext=unknown ./configure --prefix=$PREFIX --with-matlab=no

echo "" | ./00boot

./configure --prefix=${PREFIX}

make

make install
