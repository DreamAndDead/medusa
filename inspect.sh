#! /usr/bin/env bash

pyfile=$1
dir=/home/manjaro/project/python-lua/
pyast=${dir}../ast/python/local_ast.py
pylua=${dir}__main__.py

echo "==========py=========="
cat $pyfile
echo

echo "==========ast=========="
$pyast $pyfile
echo

echo "==========lua=========="
python $pylua --no-lua-init $pyfile
echo
