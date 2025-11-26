#!/bin/bash
FISIER="$1"
if [ -z "$FISIER" ]; then
   echo "Eroare: Va rugam specificati un fisier de hosts."
   echo " Utilizare: ./chec_hosts.sh <cale_fisier>"
   exit 1
fi
echo "Analizez fisierul: $FISIER"
while read -r linie; do
  ip=$(echo "$linie" | awk '{print $1}')
  if [[ -z "$ip" ]] || [[ "$ip" == \#* ]]; then
     continue
  fi
  if [[ $ip =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
     echo "IP Valid: $ip"
  else 
     echo "IP Invalid : $ip"
  fi
done < "$FISIER"