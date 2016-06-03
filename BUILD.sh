# This script builds all the necessary modules that are required for
# lalsuite and pycbc.

set -e  # Exit immediately if a command exits with a non-zero status.
set -x  # Print commands and their arguments as they are executed.

# Make sure the conda environment has been set up, and everything updated
conda create -y --name lal python=2.7 anaconda || :
source activate lal
conda update -y --all
pip install --upgrade pip

# Sort out the paths
CONDA_ROOT=$(conda info --root)
CONDA_ENV_PATH=${CONDA_ENV_PATH:-$CONDA_ROOT}
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# This function will be used (depending on DIR) to build and upload each package
build_and_upload () {
    if [ -z "$1" ]
    then
        echo "No parameters passed; need sub-directory to work in"
        exit 1
    fi
    cd ${DIR}/$1
    conda build --no-anaconda-upload --python 2.7 .
    anaconda upload --force $(conda build --output --python 2.7 .)
}

# Do the first batch of builds -- lalsuite and its dependencies
build_and_upload libframe
build_and_upload metaio
build_and_upload gsl
build_and_upload lalsuite

# Install lalsuite and set up the environment as needed
conda install -y -c ${CONDA_CHANNEL:-moble} lalsuite
mkdir -p ${CONDA_ENV_PATH}/etc/conda/activate.d
cat <<EOF > ${CONDA_ENV_PATH}/etc/conda/activate.d/env_vars.sh
#!/bin/sh
DIR="\$( cd "\$( dirname "\${BASH_SOURCE[0]}" )" && pwd )"
source \${DIR}/../../lalsuiterc
source \${DIR}/../../glue-user-env.sh
unset PYTHONPATH  # PYTHONPATH screws up conda
EOF
source ${CONDA_ENV_PATH}/etc/lalsuiterc
source ${CONDA_ENV_PATH}/etc/glue-user-env.sh
unset PYTHONPATH  # PYTHONPATH screws up conda

# Now, proceed with pycbc
build_and_upload pycbc-glue
build_and_upload pycbc-pylal
build_and_upload pycbc


# install pegasus, dqsegdb, and GraceDB <http://ligo-cbc.github.io/pycbc/latest/html/install.html#installing-pycbc-in-a-virtual-environment>
# install python-cjson <http://ligo-cbc.github.io/pycbc/latest/html/install.html#installing-lalsuite-into-a-virtual-environment>
# install M2Crypto with `SWIG_FEATURES="-cpperraswarn -includeall -I/usr/include/openssl" pip install M2Crypto`

# conda install -y -c ${CONDA_CHANNEL:-moble} pycbc
