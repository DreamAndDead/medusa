#!/usr/bin/env bash

PYTHON=python3.4
pylua=./medusa.py

function usage()
{
    echo "$0 py_file_path or py_file_dir ..."
    exit 1
}

function transpile()
{
    pyfile=$1
    pyluafile=${pyfile%.py}.lua
    $PYTHON $pylua < $pyfile > $pyluafile
}


if [[ -z $1 ]]; then
    usage
fi

function run()
{
    path=$1

    if [[ -f $path ]] && [[ $path == *.py ]]
    then
	transpile $path
    fi
    
    if [[ -d $path ]]
    then
	for p in "$path"/*
	do
	    run $p
	done
    fi
}

for p in $*
do
    run $p
done

