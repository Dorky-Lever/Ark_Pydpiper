#!/bin/bash
mincreshape -clobber "/media/sf_vmshare/12_5_stage_rem_training/18288_eth_e2_het_20170820_170059_170209.mnc" "new_vol.mnc" -start 0,0,0 -count 506,345,512
volrot -z_rotation -25 -clobber new_vol.mnc new_vol_rot.mnc
mincreshape -clobber "new_vol_rot.mnc" "rot_cropped.mnc" -start 0,0,0 -count 512,512,440
volrot -z_rotation 35 -clobber rot_cropped.mnc rot_rot.mnc
mincreshape -clobber "rot_rot.mnc" "final.mnc" -start 0,0,0 -count 512,399,512
