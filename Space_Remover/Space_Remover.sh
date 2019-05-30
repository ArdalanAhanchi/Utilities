#! /bin/bash

# Author:    Ardalan Ahanchi
# Date:      May 29, 2019
#
# A bash script which traverses through the current directory and replaces all
# The spaces in the file and directory names with the "_" character.

#A function to mv the file to the new name.
function remove_space {
    #Get the new file name using an Awk script.
    newfile=$(echo $file | awk 'BEGIN{ OFS = "_" }; { $1 = $1; print $0;}')

    #Check if name is chenged, if yes, try to rename, and print error if failed.
    if [ "$newfile" != "$file" ]; then
        if ! $(mv "$file" "$newfile"); then
            echo Move Failed, Please Try Again.
        fi
    fi
}

#A recursive function to traverse through the directory tree and remove spaces.
function traverse {
    #Go through all the files and directories.
    for file in * ; do
        #If it's a directory go to it, call itself recursively, and come back.
        if [ -d "$file" ] ; then
            remove_space;
            cd "$newfile";
            traverse;
            cd ..;
        else
            #If not a directory (A file) just rename it.
            remove_space;
        fi
    done
}

#Call the traverse function for the current directory.
traverse;
