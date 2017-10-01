# -------------------------------------------------------------------------------------------
# This script aims to help to init ubuntu server 17.04 with the following features enabled:
#   tcp fastopen
#   google bbr
# and install the following softwares:
#   docker-engine
#   docker-compose
# -------------------------------------------------------------------------------------------

#!/bi/bash

# enable tcp fastopen feature
if !(grep 'net.ipv4.tcp_fastopen=3' /etc/sysctl.conf > /dev/null)
then
  echo 'net.ipv4.tcp_fastopen=3' >> /etc/sysctl.conf
fi

# enable google bbr
if !(grep 'net.core.default_qdisc=fq' /etc/sysctl.conf > /dev/null)
then
  echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
fi

if !(grep 'net.ipv4.tcp_congestion_control=bbr' /etc/sysctl.conf > /dev/null)
then
  echo 'net.ipv4.tcp_congestion_control=bbr' >> /etc/sysctl.conf
fi

# install docker-engine
if !(which docker 1>&2 >/dev/null)
then
  echo 'begin to install docker-engine'
  curl -sSL https://get.daocloud.io/docker | sh # use script from daocloud to install docker-engine
  usermod -aG docker $(whoami)
fi

if !(which docker-compose 1>&2 >/dev/null)
then
  echo 'begin to install docker-engine'
  curl -L https://get.daocloud.io/docker/compose/releases/download/1.16.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose | sh # use script from daocloud to install docker-engine
  chmod +x /usr/local/bin/docker-compose
fi