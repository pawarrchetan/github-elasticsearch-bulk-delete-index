#!/bin/bash

export ES_ENDPOINT="https://XYZ.ES.AWS.COM:PORT"
export ES_API="/_cat/indices?v&s=index"
export ES_TOKEN="YOUR_TOKEN"

function es_index_list(){
  indexes=`curl -s -u "$ES_TOKEN" "$ES_ENDPOINT$ES_API" | awk '{print $3}' | egrep "kube|audit" | sort -nr`

  for index in $indexes;
    do
      retention_date=`date --date="$1 days ago" +%Y%m%d`
      index_date=`echo $index | cut -d "-" -f 5 | sed 's/\.//g'`
      if [ $index_date -le $retention_date ]
      then
        echo "$index">> $PWD/index_list.lst
      else
        continue
      fi
    done
}

function es_index_delete(){
  curl -s -u "$ES_TOKEN" -X DELETE "$ES_ENDPOINT/$1?pretty"
}

# main body of the script #
if [ $# -eq 0 ]
  then
    echo "The script requires 1 argument which is the number of days for the indexes to be retained elasticsearch."
    echo "Example : ./es-bulk-delete-index.sh 4"
else
  es_index_list $1
  index_list=$(cat $PWD/index_list.lst)
  for ind in $index_list; do (es_index_delete "$ind"); done
  #for ind in $index_list; do (echo "$ind"); done
  rm -rf $PWD/index_list.lst
fi  
