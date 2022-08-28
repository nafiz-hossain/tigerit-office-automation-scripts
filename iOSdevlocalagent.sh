cd ~/TigerIT/projects/communicator-desktop-pwa/

#npm install on condition
if [ "$1" = "npm" ]; then
    npm i

fi
cd electron/
if [ "$1" = "npm" ]; then
    npm i
fi

if [ "$#" -eq 1 ]; then
    if [ "$1" = "stash" ]; then
            git stash
	    git checkout dev
	    git pull origin dev
	    git stash pop
    else
    git reset --hard
    git pull origin dev
    git checkout $1
fi

else
    git reset --hard
    git checkout dev
    git pull origin dev

fi

sed -i 's/ios/iOOS/' /home/tigerit/TigerIT/projects/communicator-desktop-pwa/src/app/data-sync/data-sync.page.ts #replace a string with another string in file


ionic cap sync
npm run electron:build-linux-agent


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
sudo snap install --dangerous CommChatSetup-Agent_${SUBSTRING}.snap
