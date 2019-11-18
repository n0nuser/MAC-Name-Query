#!/bin/bash

if [ $# -ne  2 ];then
  echo "USAGE: ./mac_query.sh -f FC:A1:3E:2A:1C:33"
  echo "       ./mac_query.sh -f FC-A1-3E-2A-1C-33"
  echo "       ./mac_query.sh -f FC.A1.3E.2A.1C.33"
  echo "       ./mac_query.sh -F file"
  exit
fi

if [ $1 = "-f" ];then
  if [ "$(echo "$2" | cut -b 3)" = ":" ]; then echo -n "$2 - "; curl https://api.macvendors.com/$2 ; echo
elif [ "$(echo "$2" | cut -b 3)" = "-" ]; then echo -n "$2 - "; curl https://api.macvendors.com/$2 ; echo
elif [ "$(echo "$2" | cut -b 3)" = "." ]; then echo -n "$2 - "; curl https://api.macvendors.com/$2 ; echo
else echo "MAC address bad formatted.\n\nUSAGE: ./mac_query.sh -f FC:A1:3E-2A:1C:33\n       ./mac_query.sh -f FC-A1-3E-2A-1C-33\n       ./mac_query.sh -f FC.A1.3E.2A.1C.33\n       ./mac_query.sh -F file"; exit
  fi
elif [ $1 = "-F" ];then
  if [ ! -f "$2" ]; then echo "File does not exist or location is wrong." ; exit
  else
    while IFS= read -r MAC
     do
      if [[ $MAC = *":"* || $MAC = *"."* || $MAC = *"-"*  ]]; then
        echo -n "$MAC - "
        curl https://api.macvendors.com/$MAC
        echo
      fi
     done < $2
  fi
else echo -e "Argument invalid.\n\nUSAGE: ./mac_query.sh -f FC:A1:3E-2A:1C:33\n       ./mac_query.sh -f FC-A1-3E-2A-1C-33\n       ./mac_query.sh -f FC.A1.3E.2A.1C.33\n       ./mac_query.sh -F file"; exit
fi
