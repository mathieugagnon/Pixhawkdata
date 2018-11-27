#!/bin/bash

date=$1

directory_in="$date/ulog"

# Crée la liste des fichier a traiter
list='list.tmp'
ls -l $directory_in | awk '$9 {print $9}' > $list

# Crée le dossier csv après avoir listé les fichiers à traiter
[ ! -d $directory_in/csv ] && mkdir $directory_in/csv

# Pour chaque fichier à traiter
while read file
do
	# Crée un dossier de sortie
	directory_out="$directory_in/csv/${file/.ulg/}"
	[ ! -d $directory_out ] && mkdir -v $directory_out
	# Traite le fichier
	ulog2csv -o $directory_out $directory_in/$file
done < $list

rm $list
