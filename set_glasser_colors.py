import nibabel as nib
import nibabel.cifti2 as ci
import numpy as np
import os

from scipy.io import loadmat

def load_data(filepath):
  data = loadmat(filepath)
  fix_str_vec = lambda vec: np.array([vec[0][i][0] for i in range(len(vec[0]))])
  for field in ['AreasToUse']:
    data[field] = fix_str_vec(data[field])
  for field in ['__globals__', '__header__', '__version__']:
    data.pop(field, None)
  return data

def save_label_file(data, fieldname='FixCoeff_Glasser', save_name=''):
  savedir = '/Users/akshay/proj/kgs/Glasser_et_al_2016_HCP_MMP1.0_RVVG/HCP_PhaseTwo/Q1-Q6_RelatedValidation210/MNINonLinear/fsaverage_LR32k'
  outdir = '/Users/akshay/proj/kgs/dlabel_files'

  img = ci.Cifti2Image.from_filename(f'{savedir}/Q1-Q6_RelatedValidation210.CorticalAreas_dil_Final_Final_Areas_Group_Colors.32k_fs_LR.dlabel.nii')
  label_axis = img.header.get_axis(0)

	# Create new labels
  new_labels = {0: ('???', (1.0, 1.0, 1.0, 0.0))}
  for i in np.arange(1, 361):
    glasser_roi = label_axis.label[0][i][0]
    hemi, shortened = glasser_roi.split('_')[0], glasser_roi.split('_')[1].replace('-', '_')

    index = np.argwhere(data['AreasToUse']==shortened)[0,0]
    if f'rgb_{fieldname}_{hemi}' in data:
      color = data[f'rgb_{fieldname}_{hemi}'][index,:]
    else:
      color = data[f'rgb_{hemi}H_{fieldname}'][index,:]
    new_labels[i] = (glasser_roi, (color[0],color[1], color[2], 1.))

  # modify the label
  label_axis.label[0] = new_labels
  
  new_header = ci.Cifti2Header.from_axes((label_axis, img.header.get_axis(1)))
  new_image = ci.Cifti2Image(img.get_fdata(), header = new_header)
  new_image.to_filename(f'{outdir}/{fieldname}_{save_name}.dlabel.nii')
  return new_image

if __name__ == '__main__':
  ## Classification accuracy annd residual correlations
  # data1 = load_data('Results_Colormaps/Glasser_Classification_Colormaps_withThresh_Revision2.mat');
  # data2 = load_data('Results_Colormaps/Glasser_Residuals_Colormaps_withThresh_Oct21.mat');
  # new_image1 = save_label_file(data1, fieldname='attended', save_name='class_thresh_revision2')
  # new_image1 = save_label_file(data1, fieldname='ignored', save_name='class_thresh_revision2')
  # new_image2 = save_label_file(data2, fieldname='attended', save_name='resid_thresh_oct21')
  # new_image2 = save_label_file(data2, fieldname='ignored', save_name='resid_thresh_oct21')

  ## Differennces
  data3 = load_data('Results_Colormaps/Glasser_Classification_Difference_Colormaps_withThresh_Dec21.mat');
  new_image3 = save_label_file(data3, fieldname='diffs', save_name='class_diffs_Dec21')
  data4 = load_data('Results_Colormaps/Glasser_Residuals_Difference_Colormaps_withThresh_Dec21.mat');
  new_image4 = save_label_file(data4, fieldname='diffs', save_name='resid_diffs_Dec21')

  ## Behavior
  # data5 = load_data('Results_Colormaps/Glasser_Classification_BehFixEff_Colormaps_withThresh.mat');
  # data6 = load_data('Results_Colormaps/Glasser_Residuals_BehFixEff_Colormaps_withThresh.mat');
  # new_image5 = save_label_file(data5, fieldname='FixCoeff_Glasser', save_name='Class_rt')
  # new_image6 = save_label_file(data6, fieldname='FixCoeff_Glasser', save_name='Resid_rt')

  # data7 = load_data('Results_Colormaps/Glasser_Classification_BehFixEff_Colormaps_Acc.mat');
  # data8 = load_data('Results_Colormaps/Glasser_Residuals_BehFixEff_Colormaps_Acc.mat');
  # new_image7 = save_label_file(data7, fieldname='FixCoeff_Glasser', save_name='Class_acc')
  # new_image8 = save_label_file(data8, fieldname='FixCoeff_Glasser', save_name='Resid_acc')
