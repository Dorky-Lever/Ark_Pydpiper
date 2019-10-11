#!/bin/bash
#TODO make the script open register to show the orientation of each scan  and pass gueses of the rotation to volrot. 
#Script to make our raw scans match the intiial model described in Wong et al 2012 (it's dimensions x,y,z are 347,405,602 and resolution of 0.027 microns)
#go through every_file in directory 
for file in $(echo *.mnc);
do
    echo $file
    #convert resolution from 40 microns to 27 microns 
    #autocrop -clobber -step 0.027 0.027 0.027 $file correct_dims/$file
    #Turns out I rotated the volumes the wrong way and I need to rotate them by 180 degrees
    volrot -clobber -z_rotation 180 $file tmp_vol_rot.mnc
    #crop the volume at the centre - don't use  -start -count when cropping in the middle, they do not working together!!!
    mincreshape -signed -clobber -dimorder zspace,yspace,xspace -dimrange zspace=79,602 -dimrange yspace=177,405 -dimrange xspace=206,347 tmp_vol_rot.mnc tmp_length.mnc
    mincinfo tmp_length.mnc
    #DO NOT TOUCH THIS - I DON'T FULLY UNDERSTAND THIS BUT IT WORKS!!
    #FUTURE KYLE / HONOURS STUDENTS - YOU TOUCH YOU DIE !!! 
    #use minctracc to estimate  an initial transformation  that somewhat corrects for differences between world co-ordinates of the model and our scans
    #minctracc -clobber -lsq12 tmp_length.mnc ../image.mnc tmp_tracc.xfm
    #display the transform - it should have -20 rot in y (2nd column)
    xfm2param mod_tracc_two.xfm 
    #apply that transform the scan but use transformation sampling to not change the orientation of the embryos but partially fix differences in world co-ordinates. 
    mincresample -clobber -tfm_input_sampling -transformation mod_tracc_two.xfm tmp_length.mnc tmp_input_sampling.mnc
    mincinfo tmp_input_sampling.mnc
    #estimate another transformation with partially corrected world co-ordinates, but make it more accurate (ignore the est_translation warnings)
    #minctracc -clobber -lsq12 -tol 0.0005 ../image.mnc tmp_input_sampling.mnc tmp_sampling_two.xfm
    #Apply the transform but get the proper world co-ordinates from the inital model so they match 
    mincresample -signed -clobber -like ../image.mnc -transformation tmp_sampling_two.xfm tmp_input_sampling.mnc ../processed/$file
done

