#!/bin/bash

for var in "$@"
do
    pdfcrop $var $var
done
