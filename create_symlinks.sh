#!/bin/bash

DIR="$(cd "$(dirname "$0" )" && pwd )"
FILES=$DIR/*

for f in $FILES
do
    if [ `basename $f` != `basename $0` -a `basename $f` != README ]
    then
        ln -s $f $HOME/.`basename $f`
    fi
done
