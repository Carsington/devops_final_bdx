#Changer le host et hostname
sudo sed -i "s/debian/Front/g" /etc/hostname /etc/hosts
# Redemarrer ma vm
sudo reboot
# Mettre à jours mes logiciel
sudo apt update
sudo apt upgrade
# Installer logiciels
sudo apt install nginx
sudo apt install curl
# Copier le fichier envoyé dans tmp par la vm repository dans le home de votre utilisateur et le decomprésser
cp /tmp/movie_angular.tar.gz .
tar -xzvf movie_angular.tar.gz
# Se mettre en root
su -
# Installer les différents logiciels
# --> la commande curl comprend bien les 2 lignes suivantes
curl -fsSL https://deb.nodesource.com/setup_16.x | bash - &&\
apt-get install -y nodejs

apt-get install -y build-essential
apt install npm
# Se connecter en djawed
su - djawed
# Installer les différents logiciels
sudo npm install -g n
sudo n 16.14.0
sudo npm install -g @angular/cli
npm install
# Listes des fichiers à modifier(les fichiers sont présents dans ce dossier)
# Ecrir les commandes comme elles sont écrite svp
sudo vi /etc/nginx/sites-available/default
sudo vi /etc/nginx/nginx.conf
sudo vi /etc/nginx/conf.d/api.conf
vi /home/djawed/movie_angular/src/environments/environment.ts
vi /home/djawed/movie_angular/src/environments/environment.prod.ts
# Effectuer ces différentes commandes
sudo nginx -t
sudo systemctl restart nginx
sudo systemctl status nginx
# Se positionner dans le bon répertoire
cd /home/djawed/movie_angular/
# Lancer angular
ng serve --host 192.168.186.175
# Aller à l'adresse http indiqué
# Ouvrir une autre page Front et vérifier les ports d'écoutes
sudo netstat -tuplan | grep -i listen
