# Changer le nom de la debian de maniere automatique
sudo sed -i "s/debian/VMIntegration/g" /etc/hostname /etc/hosts
sudo reboot
# Telecharger Jenkins
wget https://get.jenkins.io/war-stable/2.387.2/jenkins.war
# Remmettre a jours les diffrents telechargement
sudo apt update
# Chercher l'openjdk (java kit de developpement jdk + jre)
sudo apt search openjdk
# Choisir le java a utiliser (le jdk comprend a l'interieur le JRE)
sudo apt install openjdk-11-jdk 
# Verifier si le jdk est bien present
java --version
javac --version
jar --version
# Installer maven pour pouvoir compiler, nettoyer et constuire une application java
sudo apt install maven
# Effectuer un git clone 
git clone https://github.com/matthcol/devops2023S1.git
# Lors d'un git pull pour eviter d'avoir un warning en jaune effectuer 
git config --global pull.rebase false
# Installer Jenkins
java -jar jenkins.war
# Vérifier le port
sudo netstat -tuplan | grep -i listen
# Lancer jenkins
http://adresseip:8080

