# Changer le nom de la debian de maniere automatique
sudo sed -i "s/debian/jenkins/g" /etc/hostname /etc/hosts
sudo reboot
# Créer un utilisateur jenkins
sudo useradd -m -s /bin/bash jenkins
# Se connecter à l'utilisateur Jenkins
sudo su jenkins
# Telecharger Jenkins
wget https://get.jenkins.io/war-stable/2.387.2/jenkins.war
# créer une clé sans mot de passe
ssh-keygen
# Sécuriser le dossier .ssh
chmod 700 .ssh
# Se déplacer dans le dossier
cd .ssh
# Supprimer les 2 clées préalablement créé
rm id*
# Glisser la clé privé et publique transmis par Francesca dans tmp
# Déplacer les dossiers dans .ssh
su
mv /tmp/id_rs* .
# Définir les droits du fichier privé
chmod 600 id_rsa
# Rendre propriétaire jenkins des clés
chown jenkins:jenkins /home/jenkins/.ssh/id*
# Se connecter à jenkins
su jenkins
# Créer un fichier (vi config) et le remplir avec ce qui suit:
Host github.com
        Hostname github.com
        IdentityFile=/home/jenkins/.ssh/id_rsa
# Protéger se fichier
chmod 600 config
# Se déplacer dans le home de l'utilisateur
cd
# Cloner le git de Matthias pour pouvoir l'utiliser
git clone git@github.com:matthcol/movieapi2k3.git
# Remmettre a jours les diffrents telechargement
sudo apt update
# Chercher l'openjdk (java kit de developpement jdk + jre)
sudo apt search openjdk
# Choisir le java a utiliser (le jdk comprend a l'interieur le JRE)
sudo apt install openjdk-17-jdk 
# Verifier si le jdk est bien present
java --version
javac --version
jar --version
# Installer maven pour pouvoir compiler, nettoyer et constuire une application java
sudo apt install maven
# Se connecter à jenkins
sudo su jenkins
# Lors d'un git pull pour eviter d'avoir un warning en jaune effectuer 
git config --global pull.rebase false
# Installer Jenkins
java -jar jenkins.war
# Vérifier le port
sudo netstat -tuplan | grep -i listen
# Lancer jenkins
http://192.168.186.132:8080

