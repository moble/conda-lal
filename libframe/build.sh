# No need to run this file directly; just do `conda build .`

./configure --prefix=$PREFIX --disable-octave --disable-python --with-matlab=no

make

make install
