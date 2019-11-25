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

function echocyan() 
{
  echo $(__colortext "$1" "36")
}

#######################################################


PYTHON=python3.4
LUA=luajit-2.0.5
TEST_FOLDER=./tests/
pylua=./medusa.py
luatest=./run_test.lua

function test_pyfile()
{
    pyfile=$1
    pyluafile=${pyfile%.py}.lua
    echocyan "test $pyfile"

    $PYTHON $pylua < $pyfile > $pyluafile

    $PYTHON $pyfile
    py_exit=$?

    # cd and pop
    pushd $(dirname $pyfile) > /dev/null
    $LUA $luatest $(basename $pyfile .py).lua
    lua_exit=$?
    popd > /dev/null

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
}

if [[ -z $1 ]]; then
    for f in ${TEST_FOLDER}*.py
    do
	test_pyfile $f
    done
fi

for pyfile_path in $*
do
    test_pyfile $pyfile_path
done


