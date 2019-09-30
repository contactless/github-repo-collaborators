#!/bin/bash

username=$1

echo -n Password: 
read -s password
echo 

repos=`curl -s -u "$username":"$password" "https://api.github.com/user/repos?visibility=private&per_page=100"| jq -r '.[] | .name'`

for repo in $repos; do
    users=`curl -s -u "$username":"$password" "https://api.github.com/repos/"$username"/$repo/collaborators?per_page=100" | jq -r '.[] | .login'`

    users=`echo $users | tr '\r\n' ' '`

    echo -e "$repo\t$users"
    
    
done