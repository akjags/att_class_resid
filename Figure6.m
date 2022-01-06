

clear all


% Load csvs with data for each Glasser ROI for Classification and
% Residual Correlations
% Columns here are: 1) Data (Residual Correlation or Classification
% Accuracy), 2) Hemisphere, 3) AttendIgnore, 4) Lobe
class_results = xlsread('data_classification_accuracy.xls');
resid_results = xlsread('data_residual_correlations.xls');

class_results_avg = [];
resid_results_avg = [];

for takeAvg = 1:684
    class_results_avg = [class_results_avg; mean(class_results(((21*takeAvg)-20):(21*takeAvg),1)) class_results(((21*takeAvg)-20),2) class_results(((21*takeAvg)-20),3) class_results(((21*takeAvg)-20),4)];
    resid_results_avg = [resid_results_avg; mean(resid_results(((21*takeAvg)-20):(21*takeAvg),1)) resid_results(((21*takeAvg)-20),2) resid_results(((21*takeAvg)-20),3) resid_results(((21*takeAvg)-20),4)];
end

class_results = class_results_avg;
resid_results = resid_results_avg;


class_Frontal = class_results(class_results(:,4)==1,:);
class_Parietal = class_results(class_results(:,4)==2,:);
class_Temporal = class_results(class_results(:,4)==3,:);
class_Occipital = class_results(class_results(:,4)==4,:);
resid_Frontal = resid_results(resid_results(:,4)==1,:);
resid_Parietal = resid_results(resid_results(:,4)==2,:);
resid_Temporal = resid_results(resid_results(:,4)==3,:);
resid_Occipital = resid_results(resid_results(:,4)==4,:);

class_Frontal_LH = class_Frontal(class_Frontal(:,2)==1,:);
class_Parietal_LH = class_Parietal(class_Parietal(:,2)==1,:);
class_Temporal_LH = class_Temporal(class_Temporal(:,2)==1,:);
class_Occipital_LH = class_Occipital(class_Occipital(:,2)==1,:);
resid_Frontal_LH = resid_Frontal(resid_Frontal(:,2)==1,:);
resid_Parietal_LH = resid_Parietal(resid_Parietal(:,2)==1,:);
resid_Temporal_LH = resid_Temporal(resid_Temporal(:,2)==1,:);
resid_Occipital_LH = resid_Occipital(resid_Occipital(:,2)==1,:);
class_Frontal_RH = class_Frontal(class_Frontal(:,2)==2,:);
class_Parietal_RH = class_Parietal(class_Parietal(:,2)==2,:);
class_Temporal_RH = class_Temporal(class_Temporal(:,2)==2,:);
class_Occipital_RH = class_Occipital(class_Occipital(:,2)==2,:);
resid_Frontal_RH = resid_Frontal(resid_Frontal(:,2)==2,:);
resid_Parietal_RH = resid_Parietal(resid_Parietal(:,2)==2,:);
resid_Temporal_RH = resid_Temporal(resid_Temporal(:,2)==2,:);
resid_Occipital_RH = resid_Occipital(resid_Occipital(:,2)==2,:);



%% Generate Figure

figure()
subplot(2,4,4)
axis([-0.2 0.6 0 1])
line([-0.5 1.5],[0.2 0.2],'Color',[.7 .7 .7])
line([0.01 0.01],[-0.2 1],'Color',[.7 .7 .7])
hold on
scatter(resid_Frontal_LH(resid_Frontal_LH(:,3)==2,1),class_Frontal_LH(class_Frontal_LH(:,3)==2,1),30,[1 .84 .68])
hold on
linearFit = polyfit(resid_Frontal_LH(resid_Frontal_LH(:,3)==2,1),class_Frontal_LH(class_Frontal_LH(:,3)==2,1),1);
hline2 = refline(linearFit);
hline2.Color=[1 .84 .68];
hline2.LineWidth=1.5;
scatter(resid_Frontal_LH(resid_Frontal_LH(:,3)==1,1),class_Frontal_LH(class_Frontal_LH(:,3)==1,1),40,[.99 .57 .36],'x')
linearFit = polyfit(resid_Frontal_LH(resid_Frontal_LH(:,3)==1,1),class_Frontal_LH(class_Frontal_LH(:,3)==1,1),1);
hline = refline(linearFit);
hline.Color=[.99 .57 .36];
hline.LineWidth=1.5;
xlabel('Residual Correlation')
ylabel('Classification Accuracy')
title('Frontal')
subplot(2,4,8)
axis([-0.2 0.6 0 1])
line([-0.5 1.5],[0.2 0.2],'Color',[.7 .7 .7])
line([0.01 0.01],[-0.2 1],'Color',[.7 .7 .7])
hold on
scatter(resid_Frontal_RH(resid_Frontal_RH(:,3)==2,1),class_Frontal_RH(class_Frontal_RH(:,3)==2,1),30,[1 .84 .68])
hold on
linearFit = polyfit(resid_Frontal_RH(resid_Frontal_RH(:,3)==2,1),class_Frontal_RH(class_Frontal_RH(:,3)==2,1),1);
hline2 = refline(linearFit);
hline2.Color=[1 .84 .68];
hline2.LineWidth=1.5;
scatter(resid_Frontal_RH(resid_Frontal_RH(:,3)==1,1),class_Frontal_RH(class_Frontal_RH(:,3)==1,1),40,[.99 .57 .36],'x')
linearFit = polyfit(resid_Frontal_RH(resid_Frontal_RH(:,3)==1,1),class_Frontal_RH(class_Frontal_RH(:,3)==1,1),1);
hline = refline(linearFit);
hline.Color=[.99 .57 .36];
hline.LineWidth=1.5;
xlabel('Residual Correlation')
ylabel('Classification Accuracy')
title('Frontal')
subplot(2,4,3)
axis([-0.2 0.6 0 1])
line([-0.5 1.5],[0.2 0.2],'Color',[.7 .7 .7])
line([0.01 0.01],[-0.2 1],'Color',[.7 .7 .7])
hold on
scatter(resid_Parietal_LH(resid_Parietal_LH(:,3)==2,1),class_Parietal_LH(class_Parietal_LH(:,3)==2,1),30,[.97 .84 .87])
hold on
linearFit = polyfit(resid_Parietal_LH(resid_Parietal_LH(:,3)==2,1),class_Parietal_LH(class_Parietal_LH(:,3)==2,1),1);
hline2 = refline(linearFit);
hline2.Color=[.97 .84 .87];
hline2.LineWidth=1.5;
scatter(resid_Parietal_LH(resid_Parietal_LH(:,3)==1,1),class_Parietal_LH(class_Parietal_LH(:,3)==1,1),40,[.78 .48 .53],'x')
linearFit = polyfit(resid_Parietal_LH(resid_Parietal_LH(:,3)==1,1),class_Parietal_LH(class_Parietal_LH(:,3)==1,1),1);
hline = refline(linearFit);
hline.Color=[.78 .48 .53];
hline.LineWidth=1.5;
xlabel('Residual Correlation')
ylabel('Classification Accuracy')
title('Parietal')
subplot(2,4,7)
axis([-0.2 0.6 0 1])
line([-0.5 1.5],[0.2 0.2],'Color',[.7 .7 .7])
line([0.01 0.01],[-0.2 1],'Color',[.7 .7 .7])
hold on
scatter(resid_Parietal_RH(resid_Parietal_RH(:,3)==2,1),class_Parietal_RH(class_Parietal_RH(:,3)==2,1),30,[.97 .84 .87])
hold on
linearFit = polyfit(resid_Parietal_RH(resid_Parietal_RH(:,3)==2,1),class_Parietal_RH(class_Parietal_RH(:,3)==2,1),1);
hline2 = refline(linearFit);
hline2.Color=[.97 .84 .87];
hline2.LineWidth=1.5;
hold on
scatter(resid_Parietal_RH(resid_Parietal_RH(:,3)==1,1),class_Parietal_RH(class_Parietal_RH(:,3)==1,1),40,[.78 .48 .53],'x')
linearFit = polyfit(resid_Parietal_RH(resid_Parietal_RH(:,3)==1,1),class_Parietal_RH(class_Parietal_RH(:,3)==1,1),1);
hline = refline(linearFit);
hline.Color=[.78 .48 .53];
hline.LineWidth=1.5;
axis([-0.2 0.6 0 1])
xlabel('Residual Correlation')
ylabel('Classification Accuracy')
title('Parietal')
subplot(2,4,2)
axis([-0.2 0.6 0 1])
line([-0.5 1.5],[0.2 0.2],'Color',[.7 .7 .7])
line([0.01 0.01],[-0.2 1],'Color',[.7 .7 .7])
hold on
scatter(resid_Temporal_LH(resid_Temporal_LH(:,3)==2,1),class_Temporal_LH(class_Temporal_LH(:,3)==2,1),30,[.7 .89 .80])
hold on
linearFit = polyfit(resid_Temporal_LH(resid_Temporal_LH(:,3)==2,1),class_Temporal_LH(class_Temporal_LH(:,3)==2,1),1);
hline2 = refline(linearFit);
hline2.Color=[.7 .89 .80];
hline2.LineWidth=1.5;
scatter(resid_Temporal_LH(resid_Temporal_LH(:,3)==1,1),class_Temporal_LH(class_Temporal_LH(:,3)==1,1),40,[.4 .76 .65],'x')
linearFit = polyfit(resid_Temporal_LH(resid_Temporal_LH(:,3)==1,1),class_Temporal_LH(class_Temporal_LH(:,3)==1,1),1);
hline = refline(linearFit);
hline.Color=[.4 .76 .65];
hline.LineWidth=1.5;
axis([-0.2 0.6 0 1])
hold on
xlabel('Residual Correlation')
ylabel('Classification Accuracy')
title('Temporal')
subplot(2,4,6)
axis([-0.2 0.6 0 1])
line([-0.5 1.5],[0.2 0.2],'Color',[.7 .7 .7])
line([0.01 0.01],[-0.2 1],'Color',[.7 .7 .7])
hold on
scatter(resid_Temporal_RH(resid_Temporal_RH(:,3)==2,1),class_Temporal_RH(class_Temporal_RH(:,3)==2,1),30,[.7 .89 .80])
hold on
linearFit = polyfit(resid_Temporal_RH(resid_Temporal_RH(:,3)==2,1),class_Temporal_RH(class_Temporal_RH(:,3)==2,1),1);
hline2 = refline(linearFit);
hline2.Color=[.7 .89 .80];
hline2.LineWidth=1.5;
scatter(resid_Temporal_RH(resid_Temporal_RH(:,3)==1,1),class_Temporal_RH(class_Temporal_RH(:,3)==1,1),40,[.4 .76 .65],'x')
linearFit = polyfit(resid_Temporal_RH(resid_Temporal_RH(:,3)==1,1),class_Temporal_RH(class_Temporal_RH(:,3)==1,1),1);
hline = refline(linearFit);
hline.Color=[.4 .76 .65];
hline.LineWidth=1.5;
axis([-0.2 0.6 0 1])
hold on
xlabel('Residual Correlation')
ylabel('Classification Accuracy')
title('Temporal')
subplot(2,4,1)
axis([-0.2 0.6 0 1])
line([-0.5 1.5],[0.2 0.2],'Color',[.7 .7 .7])
line([0.01 0.01],[-0.2 1],'Color',[.7 .7 .7])
hold on
scatter(resid_Occipital_LH(resid_Occipital_LH(:,3)==2,1),class_Occipital_LH(class_Occipital_LH(:,3)==2,1),30,[.796 .835 .9])
hold on
linearFit = polyfit(resid_Occipital_LH(resid_Occipital_LH(:,3)==2,1),class_Occipital_LH(class_Occipital_LH(:,3)==2,1),1);
hline2 = refline(linearFit);
hline2.Color=[.796 .835 .9];
hline2.LineWidth=1.5;
hold on
scatter(resid_Occipital_LH(resid_Occipital_LH(:,3)==1,1),class_Occipital_LH(class_Occipital_LH(:,3)==1,1),40,[.55 .63 .796],'x')
linearFit = polyfit(resid_Occipital_LH(resid_Occipital_LH(:,3)==1,1),class_Occipital_LH(class_Occipital_LH(:,3)==1,1),1);
hline = refline(linearFit);
hline.Color=[.55 .63 .796];
hline.LineWidth=1.5;
axis([-0.2 0.6 0 1])
xlabel('Residual Correlation')
ylabel('Classification Accuracy')
title('Occipital')
subplot(2,4,5)
axis([-0.2 0.6 0 1])
line([-0.5 1.5],[0.2 0.2],'Color',[.7 .7 .7])
line([0.01 0.01],[-0.2 1],'Color',[.7 .7 .7])
hold on
scatter(resid_Occipital_RH(resid_Occipital_RH(:,3)==2,1),class_Occipital_RH(class_Occipital_RH(:,3)==2,1),30,[.796 .835 .9])
hold on
linearFit = polyfit(resid_Occipital_RH(resid_Occipital_RH(:,3)==2,1),class_Occipital_RH(class_Occipital_RH(:,3)==2,1),1);
hline2 = refline(linearFit);
hline2.Color=[.796 .835 .9];
hline2.LineWidth=1.5;
hold on
scatter(resid_Occipital_RH(resid_Occipital_RH(:,3)==1,1),class_Occipital_RH(class_Occipital_RH(:,3)==1,1),40,[.55 .63 .796],'x')
linearFit = polyfit(resid_Occipital_RH(resid_Occipital_RH(:,3)==1,1),class_Occipital_RH(class_Occipital_RH(:,3)==1,1),1);
hline = refline(linearFit);
hline.Color=[.55 .63 .796];
hline.LineWidth=1.5;
axis([-0.2 0.6 0 1])
xlabel('Residual Correlation')
ylabel('Classification Accuracy')
title('Occipital')


