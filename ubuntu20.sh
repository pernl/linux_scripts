sudo apt update
sudo apt upgrade
sudo apt install i3-wm
sudo apt install -y libxcb1-dev libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev libxcb-icccm4-dev libyajl-dev libstartup-notification0-dev libxcb-randr0-dev libev-dev libxcb-cursor-dev libxcb-xinerama0-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev autoconf libxcb-xrm0 libxcb-xrm-dev automake i3status suckless-tools feh i3lock rofi curl wget compton libxcb-shape0-dev
sudo apt-get install -y git g++ libgtk-3-dev gtk-doc-tools gnutls-bin valac intltool libpcre2-dev libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev libxml2-utils gperf zsh
sudo apt install vim
sudo apt-get install libtool
ssh-keygen -t rsa -b 4096 -C "pernlundberg@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
sudo apt-get install xclip
xclip -sel clip < ~/.ssh/id_rsa.pub

# Vte ng, dependency for termite
INST_DIR=~/dev
mkdir $INST_DIR
cd $INST_DIR
git clone https://github.com/thestinger/vte-ng.git
cd vte-ng
./autogen.sh
sed -i '823 i public int dummy;' bindings/vala/app.vala
make && sudo make install

# Termite install and config
cd $INST_DIR
git clone --recursive https://github.com/thestinger/termite.git
cd termite
make
sudo make install
sudo ldconfig
sudo mkdir -p /lib/terminfo/x
sudo ln -s /usr/local/share/terminfo/x/xterm-termite /lib/terminfo/x/xterm-termite
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite 60

# Nord theme for termite
cd $INST_DIR
git clone https://github.com/arcticicestudio/nord-termite.git
cd nord-termite
bash ./install.sh

# Opacity
echo 'opacity-rule = [ "90:class_g *?= 'x-terminal-emulator'" ];' >> ~/.config/compton.conf # Need to escape the single quotes

I3=~/.config/i3/config
wget -O ~/alpine.jpg https://images.pexels.com/photos/427676/pexels-photo-427676.jpeg\?cs\=srgb\&dl\=adventure-alpine-alps-427676.jpg\&fm\=jpg
echo "exec --no-startup-id feh --bg-fill ~/alpine.jpg" >> $I3
echo 'exec --no-startup-id nm-applet --sm-disable' >> $I3
echo 'exec --no-startup-id compton -b --config ~/.config/compton.conf' >> $I3
# Remove option window
echo 'for_window [class="^.*"] border pixel 0' >> $I3

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Python
sudo apt install python3-pip libssl-dev python3-venv
cd
python3 -m venv py38_venv
sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 10
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 10

