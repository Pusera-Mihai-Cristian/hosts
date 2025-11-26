#!/bin/bash
HOSTS_FILE="$HOME/etc/hosts"
if [ ! -f "HOSTS_FILE" ]; then
   echo "Fisierul $HOSTS_FILE nu exista!"
   exit 2
fi 
exit_code=0
while read -r ip host rest; do
  [[ -z "$ip" || "$ip" == \#* ]] && continue
  resolved_ip=$(nslookup "$host" 2>/dev/null | awk -F': ' '/Adress: /{print $2; exit}')
  if [ -z "$resolved_ip" ]; then
     echo "NU am putut rezolva $host"
     exit_code=1
     continue
  fi
  if [ "$resolved_ip" != "$ip" ]; then
    echo "Bogus IP for $host: expected $ip, got $resolved_ip"
    exit_code=1
  fi
done < "$HOSTS_FILE"
exit $exit_code