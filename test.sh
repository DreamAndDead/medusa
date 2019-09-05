#! /usr/bin/env bash

source rainbow.sh

PYTHON=python3.7
LUA=lua5.1
dir=/home/manjaro/project/python-lua/
TEST_FOLDER=${dir}codeblock/
pylua=${dir}__main__.py


for pyfile in ${TEST_FOLDER}*.py
do
    echocyan "test file $pyfile"
    pyluafile=$pyfile.lua

    echo "dofile('${dir}pythonlua/luainit.lua')" > $pyluafile
    echo >> $pyluafile
    $PYTHON $pylua --no-lua-init $pyfile >> $pyluafile

    pyout=`$PYTHON $pyfile`
    luaout=`$LUA $pyluafile`

    echo "==========pyout=============="
    echo $pyout

    echo "==========luaout=============="
    echo $luaout

    if [[ $pyout -ne $luaout ]]; then
	echored "fail"
    else
	echogreen "success"
    fi

    echo
done
