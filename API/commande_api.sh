 #Changer le host et hostname
 sudo sed -i "s/debian/api/g" /etc/hostname /etc/hosts
# Redemarrer ma vm
sudo reboot
# Mettre à jours mes logiciel
sudo apt update
sudo apt upgrade
# Installer le jdk 17
sudo apt install openjdk-17-jdk
# Installer nginx
sudo apt-get install nginx
# Vérifier les différentes version de java
java --version
javac --version
jar --version
# Copier 2 fichiers envoyé dans tmp par la vm repository dans le home de votre utilisateur
cp /tmp/application.properties .
cp /tmp/movieapi.jar .
# Lancer l'api
java -jar movieapi.jar
# Ouvrir une autre page api et vérifier les ports d'écoutes
sudo netstat -tuplan | grep -i listen
