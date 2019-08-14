#!/bin/bash
mincreshape -clobber -nofill "/media/sf_vmshare/Kristen_bfcs/190806_bfc949_e4_FOV20_44_20190806_124947/190806_bfc949_e4_FOV20_44_20190806_124947_mnc/190806_bfc949_e4_fov20_20190806_124809/190806_bfc949_e4_fov20_20190806_124809_124947.mnc"  "new_vol.mnc" -start 0,0,0 -count 506,340,512
volrot -z_rotation -25 -clobber new_vol.mnc new_vol_rot.mnc
mincreshape -clobber -nofill -nopixfill "new_vol_rot.mnc" "rot_cropped.mnc" -start 50,120,170 -count 360,400,280
mincreshape -clobber -nofill -nopixfill "rot_cropped.mnc" "rot_cropped_good.mnc" -start 0,0,0 -count 360,219,230
volrot -z_rotation 40 -clobber rot_cropped.mnc rot_rot.mnc
