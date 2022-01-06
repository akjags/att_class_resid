%% Function to plot classification accuracy and residual correlation of every ROI, grouped by lobes.
%%
%%:
%%
function Figure3bd_Figure5bd()

%% Change these paths if you need to.
results_path = '/Users/akshay/proj/kgs';
rc_results = load(sprintf('%s/data_residual_correlations_by_subject.mat', results_path));
class_results = load(sprintf('%s/data_classification_accuracy_by_subject.mat', results_path));


%% Loop through all fields and take the mean
% for i=1:length(conds)
%   class_results.(sprintf('%s_SE', conds{i})) = 1.96*std(class_results.(conds{i}), [], 1)/ sqrt(size(class_results.(conds{i}),1));
%   class_results.(conds{i}) = mean(class_results.(conds{i}), 1);
% end

%%
glasser_table = readtable('~/proj/kgs/GlasserLobeMapping.csv');
lobe_map = struct();
lobe_map.roi_name = glasser_table.GlasserROI';
lobe_map.lobes = glasser_table.Lobe';
mapping = [4, 3, 2, 1];
lobe_map.lobe_nums = mapping(glasser_table.Lobe___');
lobe_map.lobe_names = {'Occipital', 'Temporal', 'Parietal', 'Frontal'};

%%
colors = [.55 .63 0.796; 0.796 0.835 0.90;0.4 0.76 0.65;0.70 0.89 0.80; 0.78 0.48 0.53; 0.97 0.84 0.87; .99 .57 .36; 1.0 .84 .68];
colorsAtt = colors([1,3,5,7],:);
%colorsUnatt = colors([2,4,6,8],:);
colorsUnatt = colors([1,3,5,7],:);
colorCell = {colorsAtt, colorsUnatt};
symbol = {'x', 'o'};

hemis = {'LH', 'RH'};

%% Exclude ROIs that overlap VTC

rois_to_exclude = {'FFC', 'VMV1', 'VMV2', 'VMV3', 'PH','PHA1','PHA2', 'PHA3', 'TE2p'};
for ri = 1:length(rois_to_exclude)    
    idx = find(strcmp(lobe_map.roi_name, rois_to_exclude{ri}));
    lobe_map.roi_name(idx) = [];
    lobe_map.lobes(idx) = [];
    lobe_map.lobe_nums(idx) = [];
    
    class_results.LH_attended(idx,:) = [];
    class_results.RH_attended(idx,:) = [];
    class_results.LH_ignored(idx,:) = [];
    class_results.RH_ignored(idx,:) = [];
    
    rc_results.LH_attended(idx,:) = [];
    rc_results.RH_attended(idx,:) = [];
    rc_results.LH_ignored(idx,:) = [];
    rc_results.RH_ignored(idx,:) = []; 
end

%%
figure;
for hi = 1:length(hemis)
    subplot(1, length(hemis), hi);
    x = 1;
    cr_att = mean(class_results.(sprintf('%s_attended', hemis{hi})), 2);
    cr_ign = mean(class_results.(sprintf('%s_ignored', hemis{hi})), 2);
    se_att = 1.96*std(class_results.(sprintf('%s_attended', hemis{hi})), [], 2) / sqrt(size(class_results.(sprintf('%s_attended', hemis{hi})), 2));
    se_ign = 1.96*std(class_results.(sprintf('%s_ignored', hemis{hi})), [], 2) / sqrt(size(class_results.(sprintf('%s_ignored', hemis{hi})), 2));
    
    xticks = [];
    for li = 1:length(lobe_map.lobe_names)
        lobe_name = lobe_map.lobe_names{li};
        att_lobe = cr_att(lobe_map.lobe_nums == li);
        ign_lobe = cr_ign(lobe_map.lobe_nums == li);
        att_se_lobe = se_att(lobe_map.lobe_nums==li);
        ign_se_lobe = se_ign(lobe_map.lobe_nums==li);
        roi_names_lobe = lobe_map.roi_name(lobe_map.lobe_nums==li);
        
        [sorted, idx] = sort(att_lobe, 'descend');
        
        myerrorbar(x:(x+length(att_lobe)-1), ign_lobe(idx), 'yError',ign_se_lobe,...
                   'Symbol', ':', 'yErrorBarType', 'fill', 'Color', colorsUnatt(li,:),...
                   'LineWidth', 2); hold on;
        myerrorbar(x:(x+length(att_lobe)-1), att_lobe(idx), 'yError',att_se_lobe, ...
                   'Symbol', '-', 'yErrorBarType', 'fill', 'Color', colorsAtt(li,:),...
                   'LineWidth', 2);
        xticks = [xticks, (2*x + length(att_lobe)-1)/2];

        index = 1:2:5;
        for ii = 1:3
            ti = index(ii);
            offsets = [3 .05; 5, .05; 7, .02];
            text_xpos = (x+ti-1)+offsets(ii,1);
            text_ypos = att_lobe(idx(ti))+offsets(ii,2);
            text( text_xpos, text_ypos, roi_names_lobe{idx(ti)});
            plot( x+ti-1, att_lobe(idx(ti)), '.k', 'MarkerSize', 10);
            plot([x+ti-1, text_xpos] , [att_lobe(idx(ti)) text_ypos], '-k');
        end
        x = x+length(att_lobe);
    end
    x_ax = 1:x;
    myerrorbar(x_ax, repmat(0.2002, 1,length(x_ax)),'yError',repmat(0.0234, 1, length(x_ax)),...
                   'Symbol', '--', 'yErrorBarType', 'fill', 'Color', [0.5,0.5,0.5],...
                   'LineWidth', 2);

    xticks(2:4) = xticks(2:4)+10;
    title(hemis{hi});
    ylim([0,.75]);
    xlim([1, x]);
    %hline(0.2002, 'k');
    set(gca, 'XTick', xticks);
    set(gca, 'XTickLabels', lobe_map.lobe_names);
    set(gca, 'FontSize', 18);
    ylabel('Classification Accuracy');
end
legend({'Attended', 'Ignored'});
legend('boxoff');

%%
figure;
for hi = 1:length(hemis)
    subplot(1, length(hemis), hi);
    x = 1;
    
    cr_att = mean(rc_results.(sprintf('%s_attended', hemis{hi})), 2);
    cr_ign = mean(rc_results.(sprintf('%s_ignored', hemis{hi})), 2);
    se_att = 1.96*std(rc_results.(sprintf('%s_attended', hemis{hi})), [], 2) / sqrt(size(rc_results.(sprintf('%s_attended', hemis{hi})), 2));
    se_ign = 1.96*std(rc_results.(sprintf('%s_ignored', hemis{hi})), [], 2) / sqrt(size(rc_results.(sprintf('%s_ignored', hemis{hi})), 2));

    xticks = [];
    for li = 1:length(lobe_map.lobe_names)
        lobe_name = lobe_map.lobe_names{li};
        att_lobe = cr_att(lobe_map.lobe_nums == li);
        ign_lobe = cr_ign(lobe_map.lobe_nums == li);
        att_se_lobe = se_att(lobe_map.lobe_nums==li);
        ign_se_lobe = se_ign(lobe_map.lobe_nums==li);
        
        
        [sorted, idx] = sort(att_lobe, 'descend');
        
        myerrorbar(x:(x+length(att_lobe)-1), ign_lobe(idx),'yError',ign_se_lobe,...
                   'Symbol', ':', 'yErrorBarType', 'fill', 'Color', colorsUnatt(li,:),...
                   'LineWidth', 2); hold on;
        myerrorbar(x:(x+length(att_lobe)-1), att_lobe(idx),'yError',att_se_lobe,...
                   'Symbol', '-', 'yErrorBarType', 'fill', 'Color', colorsAtt(li,:),...
                   'LineWidth', 2);
        xticks = [xticks, (2*x + length(att_lobe)-1)/2];

        index = 1:2:5;
        for ii = 1:3
            ti = index(ii);
            offsets = [3 .05; 5, .03; 6.5, .02];
            text_xpos = (x+ti-1)+offsets(ii,1);
            text_ypos = att_lobe(idx(ti))+offsets(ii,2);
            text( text_xpos, text_ypos, roi_names_lobe{idx(ti)});
            plot( x+ti-1, att_lobe(idx(ti)), '.k', 'MarkerSize', 10);
            plot([x+ti-1, text_xpos] , [att_lobe(idx(ti)) text_ypos], '-k');
        end
        x = x+length(att_lobe);
    end
    x_ax = 1:x;
    myerrorbar(x_ax, repmat(0.01, 1,length(x_ax)),'yError',repmat(.03, 1, length(x_ax)),...
                   'Symbol', '--', 'yErrorBarType', 'fill', 'Color', [0.5,0.5,0.5],...
                   'LineWidth', 2);

    xticks(2:4) = xticks(2:4)+10;
    title(hemis{hi});
    ylim([-.1, .4]);
    xlim([1, x]);    
    set(gca, 'XTick', xticks);
    set(gca, 'XTickLabels', lobe_map.lobe_names);
    set(gca, 'FontSize', 18);
    ylabel('Residual Correlation');
end
legend({'Attended', 'Ignored'});
legend('boxoff');

%%
keyboard
