#!/bin/bash

USERID=$(id -u)

R="\e[31"
G="\e[32"
Y="\e[33"
VALIDATE() {
 if [ $1 -ne 0 ]
    then
        echo -e "$2 .... $R FAILURE"
        exit 1
    else
        echo -e "$2 .... $G SUCCESS"
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
    echo -e "MYSQL is already .... $Y INSTALLED"
fi

dnf list installed Git
if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "Installing Git"
    
else
    echo -e "Git is already .... $Y INSTALLED"
fi