
   19  sudo sed -i "s/debian/jenkins/g" /etc/hostname /etc/hosts
   20  sudo reboot
   21  sudo useradd -m -s /bin/bash jenkins
   22  sudo su jenkins
   23  sudo apt update
   24  sudo apt install openjdk-17-jdk
   25  sudo apt install maven
   26  sudo su jenkins
   27  sudo su jenkins
   28  cd /tmp
   29  ls
   30  scp movieapi.jar 192.168.186.173:/tmp
   31  scp application.properties 192.168.186.173:/tmp
   32  cd
   33  ls
   34  tree
   35  cd
   36  ls
   37  su
   38  cd /tmp/
   39  scp movieapi.jar djawed@192.168.186.175:/tmp
   40  scp movie_angular.tar.gz  djawed@192.168.186.175:/tmp
   41  history
