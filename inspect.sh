#! /usr/bin/env bash

pyfile=$1
pyast=pyast.py
pylua=py2lua.py

echo "==========py=========="
cat $pyfile
echo

echo "==========ast=========="
python $pyast $pyfile
echo

echo "==========lua=========="
python $pylua < $pyfile
echo
