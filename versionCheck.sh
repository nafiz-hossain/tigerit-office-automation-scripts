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
