// From $HOME/Desktop location
//BUILDING PDKs

sudo yum install  autoconf automake binutils  bison flex gcc gcc-c++ gettext libtool make patch pkgconfig redhat-rpm-config rpm-build rpm-sign ctags elfutils indent patchutils -y
wget "https://github.com/Kitware/CMake/releases/download/v3.13.0/cmake-3.13.0.tar.gz"
tar -xvzf cmake-3.13.0.tar.gz
cd cmake-3.13.0/
sudo ./bootstrap --prefix=/usr/local
sudo make -j$(nproc)
sudo make install 
rm -rf cmake-3.13.0.tar.gz
cd ../
sudo yum install subscription-manager -y
sudo yum makecache
sudo yum info clang
sudo yum repolist
sudo yum install yum-utils -y
sudo yum-config-manager --enable extras
sudo yum makecache
sudo yum install clang -y
sudo yum install gsl -y
sudo yum install gsl-devel -y
sudo yum install tcl tk -y
sudo yum install tcl-devel -y
sudo yum install tk-devel -y
sudo ln -s /usr/bin/tclsh8.5 /usr/bin/tcl
sudo yum install readline-devel -y
#sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm 
sudo yum update -y
sudo yum install -y python3
sudo yum install libX11-devel -y
sudo yum install libffi-devel -y
sudo yum install graphviz -y
sudo yum install  xorg-x11-server-Xorg xorg-x11-xauth xorg-x11-apps -y
sudo yum install libXt-devel -y
sudo yum install libXaw-devel -y
sudo yum install libX11-devel -y
sudo wget "http://opencircuitdesign.com/magic/archive/magic-8.3.60.tgz"
tar -xvzf magic-8.3.60.tgz
cd magic-8.3.60
sudo ./configure
sudo make
sudo make install
rm -rf magic-8.3.60.tgz
cd ../
mkdir pdks
cd  $PDK_ROOT
git clone https://github.com/google/skywater-pdk.git
cd skywater-pdk
#git checkout 5cd70ed19fee8ea37c4e8dbd5c5c3eaa9886dd23
git checkout 4e5e318e0cc578090e1ae7d6f2cb1ec99f363120
git submodule update --init libraries/sky130_fd_sc_hd/latest
make sky130_fd_sc_hd
cd $PDK_ROOT
#git clone https://github.com/RTimothyEdwards/open_pdks.git
git clone https://github.com/efabless/open_pdks.git -b rc2
cd open_pdks
#git checkout 48db3e1a428ae16f5d4c86e0b7679656cf8afe3d
#./configure --with-sky130-source=$PDK_ROOT/skywater-pdk/libraries --with-sky130-local-path=$PDK_ROOT
	#cd sky130
make
make install-local
cd ../../

//BUILDING OPENLANE
git clone https://github.com/efabless/openlane.git -b rc2
mv openlane openLANE_flow
sudo yum install -y git tcl tk libjpeg libgomp libXext libSM libXft libffi cairo gettext Xvfb
sudo yum install -y https://repo.ius.io/ius-release-el6.rpm
#sudo yum install -y https://repo.ius.io/ius-release-el7.rpm
sudo yum install tkinter
sudo pip3.6 install --upgrade pip && \
    pip install matplotlib && \
    pip install jinja2 && \
    pip install pandas
    pip install numpy
    pip install sympy
git clone https://github.com/HanyMoussa/SPEF_EXTRACTOR.git	
sudo yum install -y tcllib
wget "https://sourceforge.net/projects/ngspice/files/ng-spice-rework/33/ngspice-33.tar.gz"
tar -zxvf ngspice-33.tar.gz
cd ngspice-33
sudo yum install libtool libX11 libX11-devel libXaw libXaw-devel readline readline-devel
sudo sed -i 's/CFLAGS="/CFLAGS="-std=c99 /g' compile_linux.sh
sudo chmod 775 compile_linux.sh
sudo ./compile_linux.sh


cd $OPENLANE_ROOT
cp ./docker_build/tar/.tclshrc .
cd docker_build
make tar/openroad_tools.tar.gz
cd $OPENROAD/OpenDB_python/
sudo python3 setup.py install
rm -rf $OPENROAD/OpenDB_python

cd $OPENLANE_ROOT


