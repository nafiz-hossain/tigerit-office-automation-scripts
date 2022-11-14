cd /home/tigerit/TigerIT/projects/Coding/freeCodeCamp/JavaScript\ Algorithms\ and\ Data\ Structures/
param="'$*'"
echo $param
oldstr=" "
newstr="_"
result=$(echo $param | sed "s/$oldstr/$newstr/g")
result=$(echo $result | sed "s/'//g")
echo $result
nano $result

git add $result
git commit -m "$result solved"
git push origin -u master
