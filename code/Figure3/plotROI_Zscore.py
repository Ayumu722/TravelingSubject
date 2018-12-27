#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on 2017 1228

@author: ayumu
"""
import glob
import pandas as pd
import numpy as np
from matplotlib import pyplot as plt
import seaborn as sns
from nilearn import plotting
import matplotlib.colors as mcol
import matplotlib.cm as cm
#from matplotlib.colors import LinearSegmentedColormap
#################
# make colormap #
#################
def create_cmap(color_list = None):
    n = len(color_list)-1
    return mcol.LinearSegmentedColormap.from_list(name = 'custom',colors = [(i/n,j) for i,j in enumerate(color_list)])

cm2 = create_cmap(["blue","ghostwhite","red"])

##############
# parameters #
##############
dummy = 0
top_dir = '/home/denbo3/ayumu/TravelingSubject/code/Figure3/Node_Zscore/' ## CHANGE HERE!!
save_dir = top_dir
# roi
P_roi = top_dir + '/ParticipantFactor.nii'
M_roi = top_dir + '/MeasurementBias.nii'
shc_roi = top_dir + '/SamplingBiasHC.nii'
smdd_roi = top_dir + '/SamplingBiasMDD.nii'
sscz_roi = top_dir + '/SamplingBiasSCZ.nii'
mdd_roi = top_dir + '/MDD.nii'
scz_roi = top_dir + '/SCZ.nii'
asd_roi = top_dir + '/ASD.nii'

# stat_map
plotting.plot_stat_map(P_roi,display_mode='z',vmax=3,cut_coords=[-46,2,12,24,36,46,62],cmap=plotting.cm.bwr,title='Participant Factor',
                       output_file=save_dir + 'Participant_z.pdf')
plotting.plot_stat_map(M_roi,display_mode='z',vmax=3,cut_coords=[-46,2,12,24,36,46,62],cmap=plotting.cm.bwr,title='Measurement Bias',
                       output_file=save_dir + 'Measurement_z.pdf')
plotting.plot_stat_map(shc_roi,display_mode='z',vmax=3,cut_coords=[-46,2,12,24,36,46,62],cmap=plotting.cm.bwr,title='Sampling Bias(HC)',
                       output_file=save_dir + 'SamplingHC_z.pdf')
plotting.plot_stat_map(smdd_roi,display_mode='z',vmax=3,cut_coords=[-46,2,12,24,36,46,62],cmap=plotting.cm.bwr,title='Sampling Bias(MDD)',
                       output_file=save_dir + 'SamplingMDD_z.pdf')
plotting.plot_stat_map(sscz_roi,display_mode='z',vmax=3,cut_coords=[-46,2,12,24,36,46,62],cmap=plotting.cm.bwr,title='Sampling Bias(SCZ)',
                       output_file=save_dir + 'SamplingSCZ_z.pdf')
plotting.plot_stat_map(mdd_roi,display_mode='z',vmax=3,cut_coords=[-46,2,12,24,36,46,62],cmap=plotting.cm.bwr,title='MDD factor',
                       output_file=save_dir + 'MDD_z.pdf')
plotting.plot_stat_map(scz_roi,display_mode='z',vmax=3,cut_coords=[-46,2,12,24,36,46,62],cmap=plotting.cm.bwr,title='SCZ factor',
                       output_file=save_dir + 'SCZ_z.pdf')
plotting.plot_stat_map(asd_roi,display_mode='z',vmax=3,cut_coords=[-46,2,12,24,36,46,62],cmap=plotting.cm.bwr,title='ASD factor',
                       output_file=save_dir + 'ASD_z.pdf')

plotting.plot_stat_map(P_roi,display_mode='x',vmax=3,cut_coords=[-50,-30,-10,10,30,50],cmap=plotting.cm.bwr,title='Participant Factor',
                       output_file=save_dir + 'Participant_x.pdf')
plotting.plot_stat_map(M_roi,display_mode='x',vmax=3,cut_coords=[-50,-30,-10,10,30,50],cmap=plotting.cm.bwr,title='Measurement Bias',
                       output_file=save_dir + 'Measurement_x.pdf')
plotting.plot_stat_map(shc_roi,display_mode='x',vmax=3,cut_coords=[-50,-30,-10,10,30,50],cmap=plotting.cm.bwr,title='Sampling Bias(HC)',
                       output_file=save_dir + 'SamplingHC_x.pdf')
plotting.plot_stat_map(smdd_roi,display_mode='x',vmax=3,cut_coords=[-50,-30,-10,10,30,50],cmap=plotting.cm.bwr,title='Sampling Bias(MDD)',
                       output_file=save_dir + 'SamplingMDD_x.pdf')
plotting.plot_stat_map(sscz_roi,display_mode='x',vmax=3,cut_coords=[-50,-30,-10,10,30,50],cmap=plotting.cm.bwr,title='Sampling Bias(SCZ)',
                       output_file=save_dir + 'SamplingSCZ_x.pdf')
plotting.plot_stat_map(mdd_roi,display_mode='x',vmax=3,cut_coords=[-50,-30,-10,10,30,50],cmap=plotting.cm.bwr,title='MDD factor',
                       output_file=save_dir + 'MDD_x.pdf')
plotting.plot_stat_map(scz_roi,display_mode='x',vmax=3,cut_coords=[-50,-30,-10,10,30,50],cmap=plotting.cm.bwr,title='SCZ factor',
                       output_file=save_dir + 'SCZ_x.pdf')
plotting.plot_stat_map(asd_roi,display_mode='x',vmax=3,cut_coords=[-50,-30,-10,10,30,50],cmap=plotting.cm.bwr,title='ASD factor',
                       output_file=save_dir + 'ASD_x.pdf')
