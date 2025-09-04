#! /usr/bin/bash

# I read Ebooks a lot. this script will help me to open them fast by just typing the name of the file.


LIBRARY_PATH="/home/parsa/Documents/books/"

cd $LIBRARY_PATH


CHOICES=$(find . -type f -printf "%f\n")

CHOICE=$(echo -e "$CHOICES" | dmenu -i -p "What would you like to read?")

BOOK_PATH=$(find $LIBRARY_PATH -type f -iname "$CHOICE")

echo -e $BOOK_PATH


zathura "$BOOK_PATH"






