#!/bin/bash

project_name=$1
instance_name=$2
zone_name=$3

if [ -z $project_name ] || [ -z $instance_name ] || [ -z $zone_name ]: then
  echo "One or more required inputs are missing!!! Exiting !!!"
  exit 1
else
 gcloud compute instances describe $instance_name \
    --project=$project_name --zone=asia-southeast2-a --format="json" > $instance_name.json

 key_list=$(cat $instance_name.json | jq -r keys)

 ch="Y"
 while [ "$ch" = "Y" ] || [ "$ch" = "y" ]
 do
   echo "This is the list of keys avaiable: $key_list."
   read -p "Enter the key you want to query: " key_name
   result=$(cat $instance_name.json | jq -r .$key_name)
   if [ "$result" != "null" ] ; then
    echo "Value for $key_name is: $result"
   else
    echo "Wrong key. Please try again !!!!"
   fi
   read -p "Do you want to continue to query more keys? If yes press 'Y' or 'y' :" ch
 done
fi