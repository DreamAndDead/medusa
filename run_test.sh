#! /usr/bin/env bash

#######################################################
# source rainbow.sh

__RAINBOWPALETTE="1"

function __colortext()
{
  echo -e " \e[$__RAINBOWPALETTE;$2m$1\e[0m"
}

 
function echogreen() 
{
  echo $(__colortext "$1" "32")
}

function echored() 
{
  echo $(__colortext "$1" "31")
}

function echoblue() 
{
  echo $(__colortext "$1" "34")
}

function echopurple() 
{
  echo $(__colortext "$1" "35")
}

function echoyellow() 
{
  echo $(__colortext "$1" "33")
}

function echocyan() 
{
  echo $(__colortext "$1" "36")
}

#######################################################


PYTHON=python3
LUA=lua5.1
TEST_FOLDER=./codeblock/
pylua=./py2lua.py

pyfile_path=$1

function test_pyfile()
{
    pyfile=$1
    pyluafile=$pyfile.lua
    echocyan "test python file $pyfile"

    echo "dofile('./polyfill/pypolyfill.lua')" > $pyluafile
    $PYTHON $pylua < $pyfile >> $pyluafile

    $PYTHON $pyfile
    py_exit=$?
    
    $LUA $pyluafile
    lua_exit=$?

    if [[ $py_exit -eq 0 ]] && [[ $lua_exit -eq 0 ]]; then
	echogreen "success"
    else
	echored "fail"
    fi

    if [[ $py_exit -ne 0 ]]; then
	cat -n $pyfile
    fi

    if [[ $lua_exit -ne 0 ]]; then
	cat -n $pyluafile
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

