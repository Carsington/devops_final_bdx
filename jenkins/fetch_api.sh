#!/bin/bash

sudo -i <<'EOF'
ls
echo "I am root now"
ifdown ens33
ifup ens33

su - jenkins
echo "I am jenkins now"

# récupérer l'api de github
#git clone https://github.com/matthcol/movieapi2k3.git
git clone git@github.com:matthcol/movieapi2k3.git
echo "Cloning is done"

# insérer dans pom.xml
sed -i -e '/add your dependency here*/a\  <dependency> \
<groupId>com.oracle.database.jdbc</groupId> \
     <artifactId>ojdbc8</artifactId> \
     <scope>runtime</scope> \
     </dependency>' movieapi2k3/pom.xml
sed -i "s/$(printf '\r')\$//g" movieapi2k3/pom.xml
echo "pom.xml modifié"

# ajouter dans build.gradle, dans dependencies
sed -i -e "/com.h2database:h2*/a\ \
runtimeOnly 'com.oracle.database.jdbc:ojdbc8'" movieapi2k3/build.gradle
echo "build.gradle modifié"

# maven clean et préparer package
cd movieapi2k3/
mvn -DskipTests clean package
echo "package ready"

cp target/movieapi.jar /tmp
exit

# A SUPPRIMER CAR TRAITE PAR ANSIBLE
# créer un nouveau fichier application.properties 
echo "spring.datasource.url=jdbc:oracle:thin:@//192.168.186.159:1521/CDB1
spring.datasource.username=movie
spring.datasource.password=password
# DDL : Data Definition Language (create/alter/drop table)
spring.jpa.hibernate.ddl-auto=none
# show SQL requests
spring.jpa.show-sql=true" > application.properties

cp application.properties /tmp
exit

EOF

# envoyer le package à VM API (modifier l'ip et home path)
cd /tmp
scp movieapi.jar 192.168.186.145:/home/user1/api
scp application.properties 192.168.186.145:/home/user1/api


