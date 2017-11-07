#!/bin/bash
if [ $# -ne 1 ];then
    echo "Usage: $0 add|del"
    exit 5
else
    if [ "$1" == "add" ];then
        for user in `cat userlist.txt`
        do 
            if id $user &> /dev/null ;then
                echo "User $user is exist."
            else
                useradd $user &> /dev/null
                echo -n "$user" | passwd --stdin $user > /dev/null
                chage -d 0 $user > /dev/null
                echo "Create user $user Successful."
            fi
        done
    elif [ "$1" == "del" ];then
        for user in `cat userlist.txt`
        do
            if id $user &> /dev/null ;then
                userdel -r $user
                echo "Delete $user Successful."
            fi
        done
    else
        echo "Usage: $0 add|del"
    fi
	rocks sync users
fi
