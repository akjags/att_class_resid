function plot_residcorr_classification_correlation()
%% Change these paths if you need to.
results_path = '/Users/akshay/proj/kgs';
rc_results = load(sprintf('%s/Results_ResidCorr_Glasser_BySubj.mat', results_path));
class_results = load(sprintf('%s/Results_Classification_Glasser_BySubj.mat', results_path));

%% Lobes
glasser_table = readtable(sprintf('%s/GlasserLobeMapping.csv', results_path));
lobe_map = struct();
lobe_map.roi_name = glasser_table.GlasserROI';
lobe_map.lobes = glasser_table.Lobe';
mapping = [4, 3, 2, 1];
lobe_map.lobe_nums = mapping(glasser_table.Lobe___');
lobe_map.lobe_names = {'Occipital', 'Temporal', 'Parietal', 'Frontal'};

%% Specify colors and markers for attended and ignored conditions for each lobe.
colors = [.55 .63 0.796; 0.796 0.835 0.90;0.4 0.76 0.65;0.70 0.89 0.80; 0.78 0.48 0.53; 0.97 0.84 0.87; .99 .57 .36; 1.0 .84 .68];
colorsAtt = colors([1,3,5,7],:);
colorsIgn = colors([2,4,6,8],:);
colorCell = {colorsIgn, colorsAtt};
symbol = {'v', '^'};

%% Set Significance Threshold
alpha = 0.05;

%%
hemis = {'LH', 'RH'};
conditions = {'ignored', 'attended'};
hemis_text = {'Left', 'Right'};
lobes = lobe_map.lobe_names;
f=figure;
set(f, 'Position', [1 67 1440 738]);
correlations = zeros(length(hemis), length(lobes), length(conditions));
Ns = zeros(length(hemis), length(lobes), length(conditions));
slopes = zeros(length(hemis), length(lobes), length(conditions));

Z_score = zeros(length(hemis), length(lobes));
p_values = zeros(length(hemis), length(lobes));
corr_p_vals = zeros(length(hemis), length(lobes), length(conditions));
for i = 1:length(hemis)
    for li = 1:length(lobes)
        subplot(length(hemis), length(lobes), (i-1)*length(lobes)+li);
        this_lobe = lobe_map.lobe_nums==li;
        
        text_pos = [];
        handles=[];
        for j = 1:length(conditions)
            cond = sprintf('%s_%s', hemis{i}, conditions{j});
            % Take mean across subjects
            rc = mean(rc_results.(cond),2);
            class = mean(class_results.(cond),2);
            
            % Get 
            x = rc(this_lobe);
            y = class(this_lobe);
            
            % Plot each ROI as a point.
            h = plot(x,y, symbol{j}, 'Color', colorCell{j}(li,:)); hold on;

            % Plot best fit line
            handles(j) = h;
            coeffs = polyfit(x, y, 1);
            fittedX = linspace(-.2, 1, 200);
            fittedY = polyval(coeffs, fittedX);
            plot(fittedX, fittedY, '-', 'Color', colorCell{j}(li,:));
            
            % Draw R values as text
            [correlation, corr_p_vals(i,li,j)] = corr(x,y);
            text_pos(j,:) = [fittedX(125), min(fittedY(150), 0.9)];
            text(text_pos(j,1), text_pos(j,2), sprintf('R=%.3f', correlation));
            
            % Store out some important values
            slopes(i,li,j) = coeffs(1);
            correlations(i,li,j) = correlation;
            Ns(i,li,j) = length(x);
        end
        
        % Compute Fisher Z to R transformation and significance test.
        [Z_score(i,li), p_values(i,li)] = fisher_test(correlations(i,li,1), correlations(i,li,2), Ns(i,li,1), Ns(i,li,2));
        if (p_values(i,li) < alpha)
          fw = 'Bold';
          text(fittedX(125)+.1, mean(text_pos(:,2)), '*', 'FontSize', 18, 'FontWeight', 'Bold');
        else
          fw = 'normal';
        end
        text(text_pos(1,1), text_pos(1,2), sprintf('R=%.3f', correlations(i,li,1)), 'FontWeight', fw);
        text(text_pos(2,1), text_pos(2,2), sprintf('R=%.3f', correlations(i,li,2)), 'FontWeight', fw);
        
        legend(fliplr(handles), fliplr(conditions), 'location', 'Southeast');
        xlabel('Residual Correlation');
        ylabel('Classification Accuracy');
        ylim([0,1]);
        xlim([-.2, 1]);
        title(sprintf('%s %s', hemis_text{i}, lobes{li}));
        
        % Plot dashed lines
        hline(0.2, ':k');
        vline(0, ':k');
        set(gca, 'box', 'off');
    end
end


%%
results = struct();
results.dims = {'hemis', 'lobes', 'attention'};
results.Ns = Ns;
results.correlations = correlations;
results.correlation_pvals = corr_p_vals;
results.fisher_Z_scores = Z_score;
results.fisher_p_values = p_values;
results.slopes = slopes;

%%
keyboard

%%
function [z,p] = fisher_test(X1, X2, N1, N2)

% Use Fisher R To Z transform to convert correlation to z-score
FisherZ = @(r) 0.5*(log(1+r)-log(1-r));

Z1 = FisherZ(X1);
Z2 = FisherZ(X2);

% Compute significance test
sigma = sqrt( (1./(N2-3)) + (1./(N1-3)));
z = (Z2 - Z1) ./ sigma;
p = 1-normcdf(z);
