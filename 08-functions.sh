#!/bin/bash

USERID=$(id -u)

VALIDATE() {
 if [ $1 -ne 0 ]
    then
        echo "$2 .... FAILURE"
        exit 1
    else
        echo "$2 .... SUCCESS"
    fi
}

if [ $USERID -ne 0 ]
then
    echo "ERROR:: you must have sudo access to execute this script"
    exit 1
fi

dnf list installed mysql
if [ $? -ne 0 ]
then
    dnf install mysql -y
    VALIDATE $? "Installing MYSQL"
   
else
    echo "MYSQL is already .... INSTALLED"
fi

dnf list installed Git
if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "Installing Git"
    
else
    echo "Git is already .... INSTALLED"
fi