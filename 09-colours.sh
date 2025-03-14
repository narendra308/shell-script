#!/bin/bash

USERID=$(id -u)

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE() {
 if [ $1 -ne 0 ]
    then
        echo -e "$2 .... $R FAILURE $N"
        exit 1
    else
        echo -e "$2 .... $G SUCCESS $N"
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
    echo -e "MYSQL is already .... $Y INSTALLED $N"
fi

dnf list installed Git
if [ $? -ne 0 ]
then
    dnf install git -y
    VALIDATE $? "Installing Git"
    
else
    echo -e "Git is already .... $Y INSTALLED $N"
fi