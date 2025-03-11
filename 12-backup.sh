#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # if user not giving no of days then taken 14 days by default

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 | cut -d '.' -f1)
TIMESTAMP=$(date +%d-%m-%y-%H-%M-%S)
LOG_FILE_NAME=$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP
VALIDATE(){
    if [ $1 -ne 0 ]
        then
            echo -e "$2 ....... $R FAILURE $N"
            exit 1
        else
            echo -e "$2 ....... $G SUCCESS $N"
    fi

}

USAGE(){

    echo -e "$R USAGE:: $N sh 18-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
    exit 1
}

mkdir -p /home/ec2-user/shellscript-logs/

if [ $# -lt 2 ]
    then
        USAGE
fi

echo "script started and executing at: $TIMESTAMP" &>>$LOGS_FOLDER