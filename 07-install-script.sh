#!/bin/bash

USERID=&(id -u) 

if [ $USERID -ne 0 ]
then
    echo "ERROR:: you must have sudo access to exectue this script"
    exit 1
fi

dnf install mysql -y

if [ $? -ne 0 ]
then
    echo "Installing MYSQL .... FAILURE"
    exit 1
else
    echo "Installing MYSQL .... SUCESS"
fi

dnf install git -y

if [ $? -ne 0 ]
then
    echo "Inastalling git .... FAILURE"
    exit 1
else
     echo "Installing git .... SUCESS"
fi
