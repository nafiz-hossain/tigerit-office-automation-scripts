#!/bin/bash
	#saved the file at root, changed permission (chmod +x file.sh)
	cd TigerIT/projects/communicator-desktop-pwa/ #directory

	clear
	read -p "branch name : " branch
	echo ""
	read -p "environment  : loc/prod? " environment
	echo ""
	read -p "version  : " version
	echo ""
	read -p "Do you want to install npm  : y/n " isnpm
	echo ""
	if [ $isnpm = y ]
		then npm i
	echo "npm i"
	echo "<<<------------------------ npm updated -------------------------->>>"
	echo ""
	fi
	d=$(date "+%d%b%H%M")
	Appversion="$version-$branch$environment$d"
	#Appversion="$version-$performanceJuly12$environment$d"  #for branch contains /
	#d=$(date +%Y-%m-%d)
        #echo " current date is $d"

	echo "setting up build for $branch branch, $Appversion version on $environment environment"
	echo ""

	#git
	echo "<<<------------------------ -----git------ -------------------------->>>"
	git fetch
	git reset --hard
	git checkout $branch
	git pull
	echo ""
	echo "<<<------------------------ environment setup completed -------------------------->>>"
	#setting up environment
	#first you need to have to create two environment files named lenvironment.ts (local config) and penvironment.ts(prod config) and save at src/environments
	cd src/environments
	rm environment.ts
	if [ $environment = loc ]
		then cp lenvironment.ts environment.ts
	elif [ $environment = prod ]
		then cp penvironment.ts environment.ts
	fi
	cd ../../electron/
	#edit package.json version with the input
	sed -i '3d' package.json
	sed -i '3i   "version": "'"$Appversion"'",' package.json
	echo ""
	echo "<<<------------------------ -----building the app------ -------------------------->>>"	
	#build command for specific OS, here is for linux
	ionic cap sync electron
	npm run electron:build-linux
	cd dist/
	sudo snap remove commchatbeta
	sudo snap install --dangerous commchatbeta_${Appversion}_amd64.snap
	commchatbeta 
