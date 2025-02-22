#!/bin/bash

USERID=$(id -u) 

if [ $USERID -ne 0 ]
then
    echo "ERROR:: you must have sudo access to execute this script"
    exit 1
fi

dnf list installed mysql
if [ $? -ne ]
then
    dnf install mysql -y

    if [ $? -ne 0 ]
    then
        echo "Installing MYSQL .... FAILURE"
        exit 1
    else
        echo "Installing MYSQL .... SUCCESS"
    fi
else
    echo "MYSQL is already .... INSTALLED"
fi

dnf list installed Git
if [ $? -ne 0 ]
then
    dnf install git -y

    if [ $? -ne 0 ]
    then
        echo "Inastalling git .... FAILURE"
        exit 1
    else
        echo "Installing git .... SUCCESS"
    fi
else
    echo "Git is already .... INSTALLED"