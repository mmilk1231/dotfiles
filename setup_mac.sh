#!/bin/bash

# Set parameters
readonly PYTHON_VER="3.7.0"
readonly BOOST_VER="1.68.0"
readonly QT_VER="5.10"
readonly GOI_VER="1.56.1"
readonly POPPLER_VER="0.67.0"

# XCode
xcode-select --install

# Homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade
brew doctor

# Anyenv
git clone https://github.com/riywo/anyenv ~/.anyenv
source ~/.bash_profile
    
# Python (pyenv, pyenv-virtualenv)
anyenv install pyenv
git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
source ~/.bash_profile
env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install $PYTHON_VER
pyenv global $PYTHON_VER

# flycheck dependency
pip install epc flake8 virtualenv

# Emacs with cask
brew install emacs cask reattach-to-user-namespace
cd ~/.emacs.d/
cask install

# Roboschool dependecy
## Boost
source ~/.bash_profile
git clone --recursive https://github.com/boostorg/boost.git ~/Documents/boost
cd ~/Documents/boost
git checkout "boost-${BOOST_VER}"
./bootstrap.sh --with-python="$(pyenv prefix)/bin/python3"
./b2 install

## Bullet3
source ~/.bash_profile
git clone https://github.com/olegklimov/bullet3 -b roboschool_self_collision ~/Documents/bullet3
mkdir ~/Documents/bullet3/build
cd    ~/Documents/bullet3/build
cmake -DBUILD_SHARED_LIBS=ON -DUSE_DOUBLE_PRECISION=1 -DCMAKE_INSTALL_PREFIX:PATH=$ROBOSCHOOL_PATH/roboschool/cpp-household/bullet_local_install -DBUILD_CPU_DEMOS=OFF -DBUILD_BULLET2_DEMOS=OFF -DBUILD_EXTRAS=OFF  -DBUILD_UNIT_TESTS=OFF -DBUILD_CLSOCKET=OFF -DBUILD_ENET=OFF -DBUILD_OPENGL3_DEMOS=OFF ..
make -j4
make install

# Roboschool
brew install cmake tinyxml assimp ffmpeg qt
git clone https://github.com/openai/roboschool.git ~/Documents/roboschool
pip install -e $ROBOSCHOOL_PATH

# Pympress dependency
## GObject Introspection
brew install gtk+3 libffi automake
source ~/.bash_profile
git clone https://github.com/GNOME/gobject-introspection.git ~/Documents/gobject-introspection
cd ~/Documents/gobject-introspection
git checkout "$GOI_VER"
./autogen.sh
./configure --with-python="$(pyenv prefix)/bin/python3"
make -j4
make install

## Pygobject
pip install pygobject

## Poppler
brew install openjpeg gettext glib
git clone https://anongit.freedesktop.org/git/poppler/poppler.git ~/Documents/poppler
git checkout "poppler-${POPPLER_VER}"
mkdir ~/Documents/poppler/build
cd ~/Documents/poppler/build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MACOSX_RPATH=OFF ..
make -j4
make install

# Pympress
pip install pympress