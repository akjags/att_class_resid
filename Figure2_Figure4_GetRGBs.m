
% Take the residual correlations results on the full glasser atlas and
% transform them to an RGB colormap that we can use in Connectome
% Workbench. 

clear all

%% Residual Correlations (Figure 4ab)

% Load data
load('data_residual_correlations_by_subject.mat')

LH_attended = mean(LH_attended,2)';
RH_attended = mean(RH_attended,2)';
LH_ignored = mean(LH_ignored,2)';
RH_ignored = mean(RH_ignored,2)';


% Keep track of ROI order
AreasToUse = {'1','2','3a','3b','4','5L','5m','5mv','6a','6d','6ma','6mp','6r','6v','7AL','7Am','7m','7PC','7PL','7Pm','8Ad','8Av','8BL','8BM','8C','9_46d','9a','9m','9p','10d','10pp','10r','10v','11l','13l','23c','23d','24dd','24dv','25','31a','31pd','31pv','33pr','43','44','45','46','47l','47m','47s','52','55b','A1','A4','A5','a9_46v','a10p','a24','a24pr','a32pr','a47r','AAIC','AIP','AVI','d23ab','d32','DVT','EC','FEF','FFC','FOP1','FOP2','FOP3','FOP4','FOP5','FST','H','i6_8','IFJa','IFJp','IFSa','IFSp','Ig','IP0','IP1','IP2','IPS1','LBelt','LIPd','LIPv','LO1','LO2','LO3','MBelt','MI','MIP','MST','MT','OFC','OP1','OP2_3','OP4','p9_46v','p10p','p24','p24pr','p32','p32pr','p47r','PBelt','PCV','PeEc','PEF','PF','PFcm','PFm','PFop','PFt','PGi','PGp','PGs','PH','PHA1','PHA2','PHA3','PHT','PI','Pir','PIT','pOFC','PoI1','PoI2','POS1','POS2','PreS','ProS','PSL','RI','RSC','s6_8','s32','SCEF','SFL','STGa','STSda','STSdp','STSva','STSvp','STV','TA2','TE1a','TE1m','TE1p','TE2a','TE2p','TF','TGd','TGv','TPOJ1','TPOJ2','TPOJ3','V1','V2','V3','V3A','V3B','V3CD','V4','V4t','V6','V6A','V7','V8','v23ab','VIP','VMV1','VMV2','VMV3','VVC'};
VTCareasToExclude = [71 123 124 125 126 156 177 178 179];

% Get colormaps
rgb_LH_attended = vals2colormap(LH_attended','hot',[0.04 .5]);
rgb_RH_attended = vals2colormap(RH_attended','hot',[0.04 .5]);
rgb_LH_ignored = vals2colormap(LH_ignored','hot',[0.04 .5]);
rgb_RH_ignored = vals2colormap(RH_ignored','hot',[0.04 .5]);

for eachArea = 1:length(AreasToUse)
    if LH_attended(eachArea) < .1
        rgb_LH_attended(eachArea,:) = [150/255 150/255 150/255];
    end
    if RH_attended(eachArea) < .1
        rgb_RH_attended(eachArea,:) = [150/255 150/255 150/255];
    end
    if LH_ignored(eachArea) < .1
        rgb_LH_ignored(eachArea,:) = [150/255 150/255 150/255];
    end
    if RH_ignored(eachArea) < .1
        rgb_RH_ignored(eachArea,:) = [150/255 150/255 150/255];
    end
end

rgb_LH_attended(VTCareasToExclude,:) = ones(9,3);
rgb_RH_attended(VTCareasToExclude,:) = ones(9,3);
rgb_LH_ignored(VTCareasToExclude,:) = ones(9,3);
rgb_RH_ignored(VTCareasToExclude,:) = ones(9,3);


% Save output:
save('Glasser_Residuals_Colormaps_AttendIgnore','rgb_LH_attended','rgb_RH_attended','rgb_LH_ignored','rgb_RH_ignored','AreasToUse');


%% Residual Correlations Difference Maps (Figure 4c)

% Calculate difference scores
LH_Diffs = LH_attended-LH_ignored;
RH_Diffs = RH_attended-RH_ignored;

% Get colormaps
rgb_LH_diffs = vals2colormap(LH_Diffs','jet',[-0.2 0.2]);
rgb_RH_diffs = vals2colormap(RH_Diffs','jet',[-0.2 0.2]);
rgb_LH_diffs(VTCareasToExclude,:) = ones(9,3);
rgb_RH_diffs(VTCareasToExclude,:) = ones(9,3);

% Save output:
save('Glasser_Residuals_Colormaps_Difference','rgb_LH_diffs','rgb_RH_diffs','AreasToUse');

%% Classification Accuracy (Figure 2ab)
clear all

% Load classification accuracy results
% NOTE: 5-dim accuracy matrix is:
% 180: Glasser ROIs
% 2: Hemisphere (1=LH, 2=RH)
% 2: Attention condition (attended=1, ignored=2)
% 5: Category (Face, Body, Car, House, Word)
% 12: Subject
cd('/Volumes/GoogleDrive/My Drive/SelecAttnProj/Revision_Analyses/')
load('data_classification_accuracy_by_subject.mat')

LH_attended = mean(LH_attended,2)';
RH_attended = mean(RH_attended,2)';
LH_ignored = mean(LH_ignored,2)';
RH_ignored = mean(RH_ignored,2)';

% accuracy_avgOverSubj = mean(category_accuracy,5);
% accuracy_avgOverCond = mean(accuracy_avgOverSubj,4);
% LH_attended = accuracy_avgOverCond(:,1,1);
% RH_attended = accuracy_avgOverCond(:,2,1);
% LH_ignored = accuracy_avgOverCond(:,1,2);
% RH_ignored = accuracy_avgOverCond(:,2,2);

% Keep track of ROI order
AreasToUse = {'1','2','3a','3b','4','5L','5m','5mv','6a','6d','6ma','6mp','6r','6v','7AL','7Am','7m','7PC','7PL','7Pm','8Ad','8Av','8BL','8BM','8C','9_46d','9a','9m','9p','10d','10pp','10r','10v','11l','13l','23c','23d','24dd','24dv','25','31a','31pd','31pv','33pr','43','44','45','46','47l','47m','47s','52','55b','A1','A4','A5','a9_46v','a10p','a24','a24pr','a32pr','a47r','AAIC','AIP','AVI','d23ab','d32','DVT','EC','FEF','FFC','FOP1','FOP2','FOP3','FOP4','FOP5','FST','H','i6_8','IFJa','IFJp','IFSa','IFSp','Ig','IP0','IP1','IP2','IPS1','LBelt','LIPd','LIPv','LO1','LO2','LO3','MBelt','MI','MIP','MST','MT','OFC','OP1','OP2_3','OP4','p9_46v','p10p','p24','p24pr','p32','p32pr','p47r','PBelt','PCV','PeEc','PEF','PF','PFcm','PFm','PFop','PFt','PGi','PGp','PGs','PH','PHA1','PHA2','PHA3','PHT','PI','Pir','PIT','pOFC','PoI1','PoI2','POS1','POS2','PreS','ProS','PSL','RI','RSC','s6_8','s32','SCEF','SFL','STGa','STSda','STSdp','STSva','STSvp','STV','TA2','TE1a','TE1m','TE1p','TE2a','TE2p','TF','TGd','TGv','TPOJ1','TPOJ2','TPOJ3','V1','V2','V3','V3A','V3B','V3CD','V4','V4t','V6','V6A','V7','V8','v23ab','VIP','VMV1','VMV2','VMV3','VVC'};
VTCareasToExclude = [71 123 124 125 126 156 177 178 179];

% Get colormaps
rgb_LH_attended = vals2colormap(LH_attended','hot',[0.2 1]);
rgb_RH_attended = vals2colormap(RH_attended','hot',[0.2 1]);
rgb_LH_ignored = vals2colormap(LH_ignored','hot',[0.2 1]);
rgb_RH_ignored = vals2colormap(RH_ignored','hot',[0.2 1]);

for eachArea = 1:length(AreasToUse)
    if LH_attended(eachArea) < .2
        rgb_LH_attended(eachArea,:) = [150/255 150/255 150/255];
    end
    if RH_attended(eachArea) < .2
        rgb_RH_attended(eachArea,:) = [150/255 150/255 150/255];
    end
    if LH_ignored(eachArea) < .2
        rgb_LH_ignored(eachArea,:) = [150/255 150/255 150/255];
    end
    if RH_ignored(eachArea) < .2
        rgb_RH_ignored(eachArea,:) = [150/255 150/255 150/255];
    end
end

rgb_LH_attended(VTCareasToExclude,:) = ones(9,3);
rgb_RH_attended(VTCareasToExclude,:) = ones(9,3);
rgb_LH_ignored(VTCareasToExclude,:) = ones(9,3);
rgb_RH_ignored(VTCareasToExclude,:) = ones(9,3);


% Save output:
save('Glasser_Classification_Colormaps_AttendIgnore','rgb_LH_attended','rgb_RH_attended','rgb_LH_ignored','rgb_RH_ignored','AreasToUse');


%% Classification Accuracy Difference Maps (Figure 2c)

% Calculate difference scores
LH_Diffs = LH_attended-LH_ignored;
RH_Diffs = RH_attended-RH_ignored;

% Get colormaps
rgb_LH_diffs = vals2colormap(LH_Diffs','jet',[-0.2 0.2]);
rgb_RH_diffs = vals2colormap(RH_Diffs','jet',[-0.2 0.2]);
rgb_LH_diffs(VTCareasToExclude,:) = ones(9,3);
rgb_RH_diffs(VTCareasToExclude,:) = ones(9,3);


% Save output:
save('Glasser_Classification_Colormaps_Difference','rgb_LH_diffs','rgb_RH_diffs','AreasToUse');

