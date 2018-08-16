#!/bin/bash

readonly OPENCV_INSTALL=1
readonly BUILD_WITH_CUDA=0
readonly BUILD_WITH_GSTREAMER=0
readonly BUILD_WITH_FFMPEG=1
readonly OPENCV_VER="3.4.2"
readonly OPENCV_DIR="${HOME}/Documents"

# OS detection
if [ "$(uname)" = 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr $(uname -s) 1 5)" = 'Linux' ]; then
  OS='Linux'
elif [ "$(expr substr $(uname -s) 1 10)" = 'MINGW32_NT' ]; then
  OS='Cygwin'
else
  echo "Your platform ($(uname -a)) is not supported."
  exit 1
fi

# Clone opencv repo
if [ ! -d ${OPENCV_DIR}/opencv ]; then
    git clone https://github.com/opencv/opencv.git ${OPENCV_DIR}/opencv
fi
cd ${OPENCV_DIR}/opencv
git pull
git checkout $OPENCV_VER

# opencv_contrib
if [ ! -d ${OPENCV_DIR}/opencv_contrib ]; then
    git clone https://github.com/opencv/opencv_contrib.git ${OPENCV_DIR}/opencv_contrib
fi
cd ${OPENCV_DIR}/opencv_contrib
git pull
git checkout $OPENCV_VER

# build
rm -rf ${OPENCV_DIR}/opencv/build
mkdir ${OPENCV_DIR}/opencv/build
cd ${OPENCV_DIR}/opencv/build

PYTHON_VER=$(pyenv global)
PYTHON_VER=${PYTHON_VER%.*}
CMD="cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D PYTHON3_EXECUTABLE=$(pyenv prefix)/bin/python3 \
      -D PYTHON3_PACKAGES_PATH=$(pyenv prefix)/lib/python${PYTHON_VER}/site-packages \
      -D PYTHON3_INCLUDE_DIR=$(pyenv prefix)/include/python${PYTHON_VER}m \
      -D PYTHON3_NUMPY_INCLUDE_DIRS=$(pyenv prefix)/lib/python${PYTHON_VER}/site-packages/numpy/core/include \
      -D INSTALL_C_EXAMPLES=OFF \
      -D INSTALL_PYTHON_EXAMPLES=OFF \
      -D BUILD_EXAMPLES=OFF \
      -D BUILD_opencv_python2=OFF \
      -D BUILD_opencv_python3=ON \
      -D BUILD_opencv_java=OFF \
      -D CMAKE_BUILD_TYPE=RELEASE \
      -D WITH_LAPACK=OFF \
      -D OPENCV_EXTRA_MODULES_PATH=${OPENCV_DIR}/opencv_contrib/modules \ "

if [ $BUILD_WITH_CUDA = 1 ]; then
    CMD+="-D WITH_CUDA=ON \ "
fi
if [ $BUILD_WITH_GSTREAMER = 1 ]; then
    CMD+="-D WITH_GSTREAMER=ON \ "
fi
if [ $BUILD_WITH_FFMPEG = 1 ]; then
    CMD+="-D WITH_FFMPEG=ON \ "
fi
if [ $OS = 'Mac' ]; then
    CMD+="-D BUILD_opencv_dnn=OFF \ "
    CMD+="-D ENABLE_CXX11=ON \ "
    CMD+="-D PYTHON3_LIBRARY=$(pyenv prefix)/lib/libpython${PYTHON_VER}m.dylib "
elif [ $OS = 'Linux' ]; then
    CMD+="-D PYTHON3_LIBRARY=$(pyenv prefix)/lib/libpython${PYTHON_VER}m.so "
fi
CMD+=".."

echo "$CMD"
$CMD

if [ $OPENCV_INSTALL = 1 ]; then
    make -j4 && sudo make install
fi
