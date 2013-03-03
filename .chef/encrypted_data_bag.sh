#!/bin/bash -e

knife data bag $1 $2 $3 --secret-file .chef/encrypted_data_bag_secret
if [ "$1" == "edit" ] ; then
    knife data bag show $2 $3 -Fj > "./data_bags/$2/$3.json"
fi
