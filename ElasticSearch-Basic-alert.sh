#!/bin/sh

#Configure the IP addresses
#Elastic Search Server IP's

esip1="192.168.100.190"
esip2="192.168.100.191"
esip3="192.168.100.192"
# Array
IP=("$esip1" "$esip2" "$esip3")


#Configure the hostnames
hostname1="es-core1.localhost.com"
hostname2="es-core2.localhost.com"
hostname3="es-core3.localhost.com"
hostname=("$hostname1" "$hostname2" "$hostname3")

while true
do
   message=""
   flag=0
   for (( i=0; i < ${#IP[@]}; i++ ))
   do
      echo $i
      response=$(curl ${IP[$i]}:9200/_cluster/health) #checking the health
      if [[ ! "$response" =~ "green" ]]; then
      flag=1
         if [[ "$response" =~ "red" ]];
         then
            message+="Elasticsearch Server ${hostname[$i]}(${IP[$i]}) is down\n"
         elif [[ "$response" =~ "yellow" ]]; then
            message+="Elasticsearch  server ${hostname[$i]}(${IP[$i]}) shards are allocating\n"
         elif [[ "$response" == "" ]]; then
            message+="Elasticsearch process is not running in ${hostname[$i]}(${IP[$i]})\n"
         fi
      fi
   done

   if [ $flag == 1 ]; then
      echo "Sending Mail"

      #Configure the E-Mail addresses
      echo $message | mail -s "Pulse - Elasticssearch Server Down" eMailID #dhanesh@gmail.com
      echo $message
   fi

   #Time duration between the monitoring. 10m represents 10 minutes
   sleep 10m
done
