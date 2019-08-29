%% Recovery of trajectories

%load data
cd ~/Documents/Drafts/Continuing/7t/results
load('q_corr_grp');
load('q_err_grp');


%define groups
total_ind = ones(1717,1);
total_ind(1187:end,1) = 2;


%correct - euclidean distance from mean correct
for x = 1:1186
    for t = 1:17
        q_corr_gap(t,x) = mean((q_corr_grp(:,t,x)-q_corr_mean(:,t)).^2);
    end
    sprintf('%d',x)
end


%error - euclidean distance from mean correct
for x = 1:531
    for t = 1:17
        q_err_gap(t,x) = mean((q_err_grp(:,t,x)-q_corr_mean(:,t)).^2);
    end
    sprintf('%d',x)
end


%% compare q_corr vs. q_err euclidean distance

[hh,pp] = ttest2(q_corr_gap,q_err_gap,'dim',2)


%% compare first 3 TRs of B vs. T vs. Q

% early trajectories
bsum = squeeze(nansum(nansum(score_beta_full_ss(:,1:3,:,:),2),3));
tsum = squeeze(nansum(nansum(score_beta_full_ss(:,28:30,:,:),2),3));
qsum = squeeze(nansum(nansum(score_beta_full_ss(:,55:57,:,:),2),3));

%t-tests
[hbt,pbt] = ttest(tsum,bsum,'dim',2);
[hqt,pqt] = ttest(tsum,qsum,'dim',2);
[hbq,pbq] = ttest(bsum,qsum,'dim',2);



%% restoration

%combine correct and error
q_total_gap = horzcat(q_corr_gap,q_err_gap);

%calculate the sum of early deviations
q_total_early_sum = sum(q_total_gap(1:5,:));

%define threshold
threshold = prctile(q_total_early_sum,66);
early_high = double(q_total_early_sum>threshold);

%t-test
[hh,tt] = ttest2(q_total_gap(:,early_high'&total_ind==2)',q_total_gap(:,early_high'&total_ind==1)','tail','right');


%% core matrix

load('beta_thal_grp')

% core = 1, balanced = 2 & matrix = 3
cbm = [2;1;3;2;2;2;3;1;3;3;3;2;2;1;2;1;3;2;2;1;1;2;2;1;2;2;2;2;1;1;2];

% parametric effect in matrix > core
matrix_para = mean(mean(mean(beta_thal_grp(cbm==3,1:27,:,:),3),4),1) + 2*mean(mean(mean(beta_thal_grp(cbm==3,28:54,:,:),3),4),1) + 3*mean(mean(mean(beta_thal_grp(cbm==3,55:81,:,:),3),4),1);
core_para = mean(mean(mean(beta_thal_grp(cbm==1,1:27,:,:),3),4),1) + 2*mean(mean(mean(beta_thal_grp(cbm==1,28:54,:,:),3),4),1) + 3*mean(mean(mean(beta_thal_grp(cbm==1,55:81,:,:),3),4),1);
