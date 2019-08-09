#!/bin/bash

#DICOM to MNC file  bash script

#TODO: add genotype detection by identifying 'wt' in the parent directory 
#(uCT scans are performed before genotyping to reduce bias and therefore 
#a method of simplified labelling post scanning will be required)
#May be able to intergrate code from tiff_to_minc.sh

#loops through folders
for directory in */;
do 
    #Go within the specific DICOM directory:
    dir_name=${directory%/*// /_}
    cd ${dir_name}

    #Error trap for spaces in dicom filenames from previous PhD student
    for f in *\ *; do mv "$f" "${f// /_}"; done

    #Make directory and perform the conversion
    #TODO: simplify folder output
    mkdir ${dir_name%/}_mnc
    dcm2mnc $(ls) ${dir_name%/}_mnc
    cd ../
done

