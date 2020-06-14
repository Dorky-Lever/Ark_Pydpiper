#!bin/bash
#Script to make our raw scans match the intiial model described in Wong et al 2012 (it's dimensions x,y,z are 347,405,602 and resolution of 0.027 microns)
#go through every_file in directory 
for file in $(echo *.mnc);
do
    echo $file
    #convert resolution from 40 microns to 27 microns 
    autocrop -clobber -step 0.027 0.027 0.027 $file tmp_autocrop.mnc
    #rotate volume 90 degrees to switch x and y around and make them match
    volrot -clobber -right tmp_autocrop.mnc tmp_vol_rot.mnc
    #crop the volume at the centre - don't use  -start -count when cropping in the middle, they do not working together!!!
    mincreshape -clobber -dimorder zspace,yspace,xspace -dimrange zspace=79,602 -dimrange yspace=140,405 -dimrange xspace=206,347 tmp_vol_rot.mnc correct_dims/$file    
done

