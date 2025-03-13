#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # if user not giving no of days then taken 14 days by default

LOGS_FOLDER="/home/ec2-user/shellscript-logs"
LOG_FILE=$(echo $0 |awk -F "/" '{print $NF}' | cut -d "." -f1)
TIMESTAMP=$(date +%d-%m-%y-%H-%M-%S)
LOG_FILE_NAME=$LOGS_FOLDER/$LOG_FILE-$TIMESTAMP
USAGE(){
    echo -e "$R USAGE:: $N sh 18-backup.sh <SOURCE_DIR> <DEST_DIR> <DAYS(optional)>"
    exit 1
}

mkdir -p /home/ec2-user/shellscript-logs/
echo "Filename: $0"

if [ $# -lt 2 ]
    then
        USAGE
fi

if [ ! -d $SOURCE_DIR ]
    then
        echo -e "$SOURCE_DIR Does not exits ..... please check"
        exit 1
fi

if [ ! -d $DEST_DIR ]
    then
        echo -e "$DEST_DIR Does not exits ...... please check"
        exit 1
fi

echo "script started and executing at: $TIMESTAMP" &>>$LOG_FILE_NAME

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)
echo " Files are: $FILES"

if [ -n "$FILES" ] # true if there are files to zip
then
    echo "Files are: $FILES"
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.log"
    find $SOURCE_DIR -name "*.log" -mtime +$DAYS | zip -@ "$ZIP_FILE"
    if [ -f "$ZIP_FILE" ]
    then
        echo -e "Successfully created zip file for files older than $DAYS"
        while read -r filepath # here filepath is variable name , you can give any name
        do
            echo "Deleting file: $filepath" &>>$LOG_FILE_NAME
            rm -rf $filepath
            echo "Deleted file: $filepath"
        done <<< $FILES
    else
        echo -e "$R Error:: $N failed to create zip file"
        exit 1
    fi
else
    echo "No files found older than $DAYS"
fi