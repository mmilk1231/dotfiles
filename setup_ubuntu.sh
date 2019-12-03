#!/bin/bash

# Set parameters
readonly PYTHON_VER="3.7.3"
readonly EMACS_VER="26"
readonly BOOST_VER="1.68.0"
readonly QT_VER="5.10"
readonly GOI_VER="1.56.1"
readonly POPPLER_VER="0.67.0"
readonly ROS_VER="KINETIC"

readonly PYENV_PYTHON_INSTALL=0
readonly SYSTEM_PYTHON_INSTALL=0
readonly ROS_INSTALL=0
readonly ROBOSCHOOL_INSTALL=0
readonly PYMPRESS_INSTALL=0

# To expand alises
shopt -s expand_aliases

# Anyenv
git clone https://github.com/riywo/anyenv ~/.anyenv
source ~/.bash_profile

# Anyenv update
mkdir -p $(anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
anyenv install --init

if [ $PYENV_PYTHON_INSTALL = 1 ]; then
    # Python (pyenv, pyenv-virtualenv)
    anyenv install pyenv
    git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.anyenv/envs/pyenv/plugins/pyenv-virtualenv
    source ~/.bash_profile
    env PYTHON_CONFIGURE_OPTS="--enable-shared" pyenv install $PYTHON_VER
    pyenv global $PYTHON_VER
fi

if [ $SYSTEM_PYTHON_INSTALL = 1 ]; then
    # System Python
    sudo apt install -y python
    # pip for system Python
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    sudo python get-pip.py
    sudo rm get-pip.py
    pyenv global system
fi

# ROS Kinetic and its dependency
if [ $ROS_INSTALL = 1 ]; then
    # ROS Kinetic
    if [ $ROS_VER = "KINETIC" ]; then
	~/dotfiles_private/setup_ubuntu_ros_kinetic.sh
    fi
fi

# flycheck dependency
pip install epc flake8 virtualenv

# Emacs and its dependency
## Emacs
sudo add-apt-repository ppa:kelleyk/emacs
sudo apt update
sudo apt install -y "emacs${EMACS_VER}"
sudo update-alternatives --config emacs

## xclip
sudo apt install -y xclip

## Cask
curl -fsSL https://raw.githubusercontent.com/cask/cask/master/go | python
cd ~/.emacs.d/
cask install

# Japanese
sudo apt install -y ibus-mozc

# Terminator
sudo add-apt-repository ppa:gnome-terminator
sudo apt update
sudo apt install -y terminator
sudo update-alternatives --config x-terminal-emulator

# GitKraken
if [ type gitkraken > /dev/null 2>&1 ]; then
    wget https://release.gitkraken.com/linux/gitkraken-amd64.deb
    sudo dpkg -i gitkraken-amd64.deb
    sudo rm gitkraken-amd64.deb
fi

# Roboschool and its dependency
if [ $ROBOSCHOOL_INSTALL = 1 ]; then
    # Roboschool dependecy
    ## Boost
    source ~/.bash_profile
    git clone --recursive https://github.com/boostorg/boost.git ~/boost
    cd ~/boost
    git checkout "boost-${BOOST_VER}"
    ./bootstrap.sh --with-python="$(pyenv prefix)/bin/python3"
    ./b2 install --prefix=$HOME/local

    ## Bullet3
    source ~/.bash_profile
    git clone https://github.com/olegklimov/bullet3 -b roboschool_self_collision ~/bullet3
    mkdir ~/bullet3/build
    cd    ~/bullet3/build
    cmake -DBUILD_SHARED_LIBS=ON -DUSE_DOUBLE_PRECISION=1 -DCMAKE_INSTALL_PREFIX:PATH=$ROBOSCHOOL_PATH/roboschool/cpp-household/bullet_local_install -DBUILD_CPU_DEMOS=OFF -DBUILD_BULLET2_DEMOS=OFF -DBUILD_EXTRAS=OFF  -DBUILD_UNIT_TESTS=OFF -DBUILD_CLSOCKET=OFF -DBUILD_ENET=OFF -DBUILD_OPENGL3_DEMOS=OFF ..
    make -j4
    make install

    # Roboschool
    sudo apt install -y cmake ffmpeg pkg-config qtbase5-dev libqt5opengl5-dev libassimp-dev libpython3.5-dev libtinyxml-dev
    git clone https://github.com/openai/roboschool.git ~/roboschool
    pip install -e $ROBOSCHOOL_PATH
fi

# Pympress and its dependency
if [ $PYMPRESS_INSTALL = 1 ]; then
    :
    # Pympress dependency
    ## GObject Introspection
    # brew install gtk+3 libffi automake
    # source ~/.bash_profile
    # git clone https://github.com/GNOME/gobject-introspection.git ~/gobject-introspection
    # cd ~/gobject-introspection
    # git checkout "$GOI_VER"
    # ./autogen.sh
    # ./configure --with-python="$(pyenv prefix)/bin/python3"
    # make -j4
    # make install

    ## Pygobject
    # pip install pygobject

    ## Poppler
    # brew install openjpeg gettext glib
    # git clone https://anongit.freedesktop.org/git/poppler/poppler.git ~/poppler
    # git checkout "poppler-${POPPLER_VER}"
    # mkdir ~/poppler/build
    # cd ~/poppler/build
    # cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_MACOSX_RPATH=OFF ..
    # make -j4
    # make install

    # Pympress
    # pip install pympress
fi
