#export BUILD_HOME=<your path>/cmsgemos/../
if [[ -n "$GEM_OS_PROJECT" ]]; then
    echo GEM_OS_PROJECT $GEM_OS_PROJECT
else
    echo "GEM_OS_PROJECT not set, setting to 'cmsgemos'"
    export GEM_OS_PROJECT=cmsgemos
    echo GEM_OS_PROJECT $GEM_OS_PROJECT
fi

if [[ -n "$BUILD_HOME" ]]; then
    echo BUILD_HOME $BUILD_HOME
else
    echo "BUILD_HOME not set, please set BUILD_HOME to the directory above the root of your repository"
    echo " (export BUILD_HOME=<your path>/cmsgemos/../) and then rerun this script"
    return
fi

# The OS is not set in environment. We assume we are not cross-compiling, and try
# to guess the OS

if [[ -n "$XDAQ_OS" ]]; then
    echo XDAQ_OS $XDAQ_OS
else
    if [[ $(uname -s) = "Linux" ]]; then
        XDAQ_OS=linux
    elif [[ $(uname -s) = "Darwin" ]]; then
        XDAQ_OS=macosx
    fi
    echo XDAQ_OS $XDAQ_OS
    export XDAQ_OS
fi

## The platform is not set. Let's guess it
if [[ -n "$XDAQ_PLATFORM" ]]; then
    echo XDAQ_PLATFORM $XDAQ_PLATFORM
else
    if [[ $(uname -m) = "i386" ]]; then
        XDAQ_PLATFORM=x86
    elif [[ $(uname -m) = "i486" ]]; then
        XDAQ_PLATFORM=x86
    elif [[ $(uname -m) = "i586" ]]; then
        XDAQ_PLATFORM=x86
    elif [[ $(uname -m) = "i686" ]]; then
        XDAQ_PLATFORM=x86
    elif [[ $(uname -m) = "x86_64" ]]; then
        XDAQ_PLATFORM=x86_64
    elif [[ $(uname -m) = "Power" ]]; then
        XDAQ_PLATFORM=ppc
    elif [[ $(uname -m) = "Macintosh" ]]; then
        XDAQ_PLATFORM=ppc
    fi
    XDAQ_PLATFORM=${XDAQ_PLATFORM}_$(source $XDAQ_ROOT/config/checkos.sh)
    echo XDAQ_PLATFORM $XDAQ_PLATFORM
    export XDAQ_PLATFORM
fi

export LD_LIBRARY_PATH=${BUILD_HOME}/${GEM_OS_PROJECT}/gembase/lib/${XDAQ_OS}/${XDAQ_PLATFORM}:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${BUILD_HOME}/${GEM_OS_PROJECT}/gemutils/lib/${XDAQ_OS}/${XDAQ_PLATFORM}:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${BUILD_HOME}/${GEM_OS_PROJECT}/gemreadout/lib/${XDAQ_OS}/${XDAQ_PLATFORM}:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${BUILD_HOME}/${GEM_OS_PROJECT}/gemhardware/lib/${XDAQ_OS}/${XDAQ_PLATFORM}:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${BUILD_HOME}/${GEM_OS_PROJECT}/gemsupervisor/lib/${XDAQ_OS}/${XDAQ_PLATFORM}:${LD_LIBRARY_PATH}
export LD_LIBRARY_PATH=${BUILD_HOME}/${GEM_OS_PROJECT}/gemHwMonitor/lib/${XDAQ_OS}/${XDAQ_PLATFORM}:${LD_LIBRARY_PATH}
echo LD_LIBRARY_PATH $LD_LIBRARY_PATH
export GEM_ADDRESS_TABLE_PATH=${BUILD_HOME}/${GEM_OS_PROJECT}/setup/etc/addresstables
export GEM_PYTHON_PATH=${BUILD_HOME}/${GEM_OS_PROJECT}/setup/scripts/python
export PYTHONPATH=${GEM_PYTHON_PATH}:${PYTHONPATH}
export PATH=${GEM_PYTHON_PATH}:${PATH}
