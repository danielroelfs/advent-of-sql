#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo -e "\nYou forgot to provide the day number!\n"
    exit
fi

day=`printf %02d $1`
year=`date +"%Y"`

mkdir ./${year}/day_${day}
touch ./${year}/day_${day}/input_day${day}.sql
touch ./${year}/day_${day}/query_day${day}.sql

echo """# Advent of SQL - Day ${1}

[link to the challenge](https://databaseschool.com/series/advent-of-sql/)""" > ./${year}/day_${day}/README.md
