#!/bin/bash
for dir in */;
do
    cd $dir
    pwd
    mincmath -clobber -div $(echo ${dir%/}*) ../correct_stage.mnc  stage_labelled.mnc
    mincmath -clobber -const2 0 100000 -clamp stage_labelled.mnc cropped_${dir%/}.mnc
    cd ../
done



