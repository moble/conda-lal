# Running this script should be enough to install lalsuite and pycbc,
# and set up the environment appropriately.  After this is executed,
# you should be able to get back to this environment with the command
#
#   source activate lal
#
# which sets up the conda environment, but also sources the LAL
# environment scripts.  Note, however, that after the LAL scripts are
# run, they cannot be undone (unlike conda's), so the environment will
# be affected until you start a new shell.

set -e  # Exit immediately if a command exits with a non-zero status.
set -x  # Print commands and their arguments as they are executed.

# Set up the conda environment, and update everything
conda create -y --name lal python=2.7 anaconda
source activate lal
conda update -y --all
pip install --upgrade pip
CONDA_ENV_PATH=${CONDA_ENV_PATH:-$(conda info --root)}

# Install pycbc
conda install -y -c ${CONDA_CHANNEL:-moble} pycbc

# Automatically set environment flags when this conda env is activated
# Note that LAL doesn't remember what flags it set, so there's no way
# to undo this; the environment will be polluted after `deactivate`.
mkdir -p ${CONDA_ENV_PATH}/etc/conda/activate.d
cat <<EOF > ${CONDA_ENV_PATH}/etc/conda/activate.d/env_vars.sh
#!/bin/sh
DIR="\$( cd "\$( dirname "\${BASH_SOURCE[0]}" )" && pwd )"
source \${DIR}/../../lalsuiterc
source \${DIR}/../../glue-user-env.sh
unset PYTHONPATH  # PYTHONPATH screws up conda
EOF

# Set those environment flags now
source ${CONDA_ENV_PATH}/etc/lalsuiterc
source ${CONDA_ENV_PATH}/etc/glue-user-env.sh
unset PYTHONPATH  # PYTHONPATH screws up conda


# install pegasus, dqsegdb, and GraceDB <http://ligo-cbc.github.io/pycbc/latest/html/install.html#installing-pycbc-in-a-virtual-environment>
# install python-cjson <http://ligo-cbc.github.io/pycbc/latest/html/install.html#installing-lalsuite-into-a-virtual-environment>
# install M2Crypto with `SWIG_FEATURES="-cpperraswarn -includeall -I/usr/include/openssl" pip install M2Crypto`

# conda install -y -c ${CONDA_CHANNEL:-moble} pycbc
