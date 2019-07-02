#!/bin/bash
sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake i3status suckless-tools feh i3lock rofi curl wget compton libxcb-shape0-dev

INST_DIR=~/dev
mkdir $INST_DIR
cd $INST_DIR

# clone the repository
git clone https://www.github.com/Airblader/i3 i3-gaps
cd i3-gaps

# compile & install
autoreconf --force --install
rm -rf build/
mkdir -p build && cd build/

# Disabling sanitizers is important for release versions!
# The prefix and sysconfdir are, obviously, dependent on the distribution.
../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
make
sudo make install

i3-config-wizard

I3=~/.config/i3/config
# Gaps 
echo 'for_window [class="^.*"] border pixel 0' >> $I3
echo 'gaps inner 10' >> $I3

# Background
cd $INST_DIR
wget -O ~/alpine.jpeg https://images.pexels.com/photos/427676/pexels-photo-427676.jpeg\?cs\=srgb\&dl\=adventure-alpine-alps-427676.jpg\&fm\=jpg
echo "exec --no-startup-id feh --bg-fill ~/alpine.jpeg" >> $I3
echo 'exec --no-startup-id nm-applet --sm-disable' >> $I3
echo 'exec --no-startup-id compton -b --config ~/.config/compton.conf' >> $I3

#Termite
sudo apt-get install -y git g++ libgtk-3-dev gtk-doc-tools gnutls-bin valac intltool libpcre2-dev libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev libxml2-utils gperf

cd $INST_DIR
git clone https://github.com/thestinger/vte-ng.git
cd vte-ng
./autogen.sh
make && sudo make install

cd $INST_DIR
git clone --recursive https://github.com/thestinger/termite.git
cd termite
make
sudo make install
sudo ldconfig
sudo mkdir -p /lib/terminfo/x
sudo ln -s /usr/local/share/terminfo/x/xterm-termite /lib/terminfo/x/xterm-termite
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite 60

cd $INST_DIR
git clone https://github.com/arcticicestudio/nord-termite.git
cd nord-termite
bash ./install.sh

# Opacity
echo 'opacity-rule = [ "90:class_g *?= 'x-terminal-emulator'" ];' >> ~/.config/compton.conf # Need to escape the single quotes
