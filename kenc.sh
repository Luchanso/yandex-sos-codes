#!/bin/bash
# Encrypt script
folder=keys
echo "LEStore 1.1.26"
read -p "Encrypt or decrypt (e/d)? " -n1 mode
echo ""

case $mode in
  e|E) 
    echo "---------------------------"
    echo "ENCRYPTED mode"
    read -p "Enter encrypt password: " -s password
    printf "\n\n"
    # read -p "Repeat password: " -s rePassword
    # printf "\n\n"

    # if $rePassword != $password; then
    #   echo "Passwords don't match!!!"
    #   echo "---------------------------"
    #   echo "ERROR - NOT ENCRYPTED"
    #   exit
    # fi

    echo "Crypting..."
    tar -cf - $folder | openssl aes-256-cbc -salt -k $password -out $folder.crypto
    echo "Crypted in $folder.crypto"

    echo "Removing folder..."
    rm -rf $folder
    echo "Folder $folder removed"
    
    echo "---------------------------"
    echo "Encrypt finish"
  ;;
  d|D)
    echo "---------------------------"
    echo "DECRYPTED mode"
    read -p "Enter decrypt password: " -s password
    printf "\n\n"
    echo "Decripting... $folder.crypto"
    openssl aes-256-cbc -d -in $folder.crypto -k $password | tar -x -f -
    echo "Decripted $folder"
    echo "---------------------------"
    echo "Decript finish"
  ;;
esac
exit

# if $mode
