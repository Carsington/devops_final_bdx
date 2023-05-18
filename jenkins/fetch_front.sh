#!/bin/bash

# récupérer le projet angular de github
git clone -b devf1 https://github.com/matthcol/movie_angular.git

tar -czvf movie_angular.tar.gz movie_angular/

scp movie_angular.tar.gz 192.168.186.145:/home/user1/front 



