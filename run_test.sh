#! /usr/bin/env bash

source rainbow.sh

PYTHON=python3.7
LUA=lua5.1
TEST_FOLDER=./codeblock/
pylua=./__main__.py

pyfile_path=$1

function test_pyfile()
{
    pyfile=$1
    pyluafile=$pyfile.lua
    echocyan "test python file $pyfile"

    echo "dofile('./codeblock/luainit.lua')" > $pyluafile
    echo >> $pyluafile
    $PYTHON $pylua < $pyfile >> $pyluafile

    pyout=`$PYTHON $pyfile`
    luaout=`$LUA $pyluafile`

    echo "==========pyout=============="
    echo "$pyout"

    echo "==========luaout=============="
    echo "$luaout"

    if [[ "$pyout" == "$luaout" ]]; then
	echogreen "success"
    else
	echored "fail"
    fi

    echo
}

if [[ "$pyfile_path" == "" ]]; then
    for f in ${TEST_FOLDER}*.py
    do
	test_pyfile $f
    done
else
    test_pyfile $pyfile_path
fi

