#sudo killall commchat-agent
cd ~/TigerIT/projects/communicator-desktop-pwa/
echo "Enter inputs maintaining following sequence seperated by comma (,): "
echo "AppName (commchat/agent), Branch Name, Environment (local/staging/prod), Update Npm (yes/no):, Git change (stash/reset), iOS user (yes/no): "


read text

# Set comma as delimiter
IFS=','

#Read the split words into an array based on comma delimiter
read -a strarr <<< "$text"

appName=${strarr[0]}
branchName=${strarr[1]}
environment=${strarr[2]}
updateNpm=${strarr[3]}
gitChange=${strarr[4]}
iOSUser=${strarr[5]}


#Print the splitted words
echo "App Name : $appName"
echo "Branch Name : $branchName"
echo "Environment : $environment"
echo "Update Npm (yes/no) : $updateNpm"
echo "Git change (stash/reset) : $gitChange"
echo "iOS user (yes/no) : $iOSUser"





#npm install on condition
if [ "$updateNpm" = "yes" ]; then
    npm i

fi
cd electron/
if [ "$updateNpm" = "yes" ]; then
    npm i
fi


if [ "$gitChange" = "stash" ]; then
            git stash
            git fetch
	    git checkout $branchName
	    git pull origin $branchName
	    git stash pop
fi

if [ "$gitChange" = "reset" ]; then
    git reset --hard
    git fetch
    git checkout $branchName
    git pull origin $branchName
fi



if [ "$iOSUser" = "yes" ]; then
sed -i 's/ios/iOOS/' /home/tigerit/TigerIT/projects/communicator-desktop-pwa/src/app/data-sync/data-sync.page.ts #replace a string with another string in file
fi


cd ..




if [ "$environment" = "local" ]; then
ionic build
fi
if [ "$environment" = "staging" ]; then
ionic build -c=staging
fi
if [ "$environment" = "prod" ]; then
ionic build --prod
fi





npx cap sync @capacitor-community/electron
cd electron/

if [ "$appName" = "commchat" ]; then
npm run electron:build-linux
fi

if [ "$appName" = "agent" ]; then
npm run electron:build-linux-agent
fi

#Reading version from package.json
while IFS= read -r line; do
    #echo "Text read from file: $line"
    var=""
for word in $line
do
  if [ "$word" == '"version":' ]
     then
     last=${line##*:}
          SUBSTRING=$(echo "$last" | cut -d'"' -f 2)
          echo "###########################$SUBSTRING"
    break
  fi
done
done < package.json
#End of Reading version from package.json

cd dist/
echo "Removing builder-debug.yml"
rm builder-debug.yml

echo "Latest file name is $(ls -Art | tail -n 1)"
sudo dpkg -i $(ls -Art | tail -n 1)


echo "Killing commchat and agent app"
sudo killall commchat
sudo killall commchat-agent




#if [ "$appName" = "commchat" ]; then
#sudo dpkg -i CommChatSetup_${SUBSTRING}.deb
#fi

#if [ "$appName" = "agent" ]; then
#sudo dpkg -i CommChatSetup-Agent_${SUBSTRING}.deb
#fi


#nautilus ~/TigerIT/projects/communicator-desktop-pwa/electron/dist
#commchat-agent

echo "Restarting desktop app"

sleep 0.2
xdotool key Super_L
sleep 1
if [ "$appName" = "commchat" ]; then
xdotool type "commchat"
fi
if [ "$appName" = "agent" ]; then
xdotool type "commchat agent"
fi
sleep 0.2
xdotool key Return
exit 0

#commchat,dev,local,no,reset,yes
