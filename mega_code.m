
nSubs = 65;
nTime = 1250;
nROI = 264;
nRun = 3;
nTrials = 48;


% prepare task regressors (start of trial)

subs = [1;2;3;4;5;6;7;8;9;10;11;12;13;14;15;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;32;33;34;35;36;37;38;39;40;41;42;43;44;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59;60;61;62;63;64;65];

for i = 1:nSubs
    
    cd ~/Desktop/
    cd ../../../Volumes/'Seagate Backup Plus Drive '/7T_data/3_behav_data/
    
    abc = sprintf('%s%d%s','load(''Sub_',subs(i),'_fMRI_LST_results'');');
    eval(abc)
        
    run1 = fMRI_out(1:48,3);
    run2 = fMRI_out(49:96,3);
    run3 = fMRI_out(97:144,3);
        
    run1_cat = fMRI_out(1:48,2);
    run2_cat = fMRI_out(49:96,2);
    run3_cat = fMRI_out(97:144,2);
        
    
    onset1 = zeros(1304,4);
    onset2 = zeros(1304,4);
    onset3 = zeros(1304,4);
    
        
    for x = 1:48
    	for y = 1:4
        	if run1_cat(x,1) == y
            	onset1(round(run1(x)./.586),y) = 1;
            end
        end
    end
    
    for x = 1:48
    	for y = 1:4
        	if run2_cat(x,1) == y
            	onset2(round(run2(x)./.586),y) = 1;
            end
        end
    end
    
    for x = 1:48
    	for y = 1:4
        	if run3_cat(x,1) == y
            	onset3(round(run3(x)./.586),y) = 1;
            end
        end
    end
    
    clear dsmtx1 dsmtx2 dsmtx3
    
    for y = 1:4
        dsmtx1(:,y) = conv(hrf,onset1(:,y));
        dsmtx2(:,y) = conv(hrf,onset2(:,y));
        dsmtx3(:,y) = conv(hrf,onset3(:,y));
    end
        
    dsmtx1(nTime+1:end,:) = [];
    dsmtx2(nTime+1:end,:) = [];
    dsmtx3(nTime+1:end,:) = [];
    
    
    cd ~/Documents/Drafts/Continuing/7t/data/
    abc = sprintf('%s%d','cd sub',subs(i));
    eval(abc)
    
    save dsmtx1 dsmtx1
    save dsmtx2 dsmtx2
    save dsmtx3 dsmtx3
    
    sprintf('%d',subs(i))
    
end


% prepare task regressors (epoch)

for i = 1:nSubs
    
    cd ~/Desktop/
    cd ../../../Volumes/'Seagate Backup Plus Drive '/7T_data/3_behav_data/
    
    abc = sprintf('%s%d%s','load(''Sub_',subs(i),'_fMRI_LST_results'');');
    eval(abc)
        
    run1_cat = rec.Key(1,1:48)';
    run2_cat = rec.Key(1,49:96)';
    run3_cat = rec.Key(1,97:144)';
        
    run1 = fMRI_out(1:48,3);
    run2 = fMRI_out(49:96,3);
    run3 = fMRI_out(97:144,3);
        
    
    onset1 = zeros(1400,4);
    onset2 = zeros(1400,4);
    onset3 = zeros(1400,4);
    
        
    for x = 1:48
    	for y = 1:4
        	if run1_cat(x,1) == y
            	onset1(round(run1(x)./.586):round(run1(x)./.586)+9,y) = 1;
            end
        end
    end
    
    for x = 1:48
    	for y = 1:4
        	if run2_cat(x,1) == y
            	onset2(round(run2(x)./.586):round(run2(x)./.586)+9,y) = 1;
            end
        end
    end
    
    for x = 1:48
    	for y = 1:4
        	if run3_cat(x,1) == y
            	onset3(round(run3(x)./.586):round(run3(x)./.586)+9,y) = 1;
            end
        end
    end
    
    clear dsmtx1a dsmtx2a dsmtx3a
    
    for y = 1:4
        dsmtx1a(:,y) = conv(hrf,onset1(:,y));
        dsmtx2a(:,y) = conv(hrf,onset2(:,y));
        dsmtx3a(:,y) = conv(hrf,onset3(:,y));
    end
        
    dsmtx1a(nTime+1:end,:) = [];
    dsmtx2a(nTime+1:end,:) = [];
    dsmtx3a(nTime+1:end,:) = [];
    
    
    cd ~/Documents/Drafts/Continuing/7t/data/
    abc = sprintf('%s%d','cd sub',subs(i));
    eval(abc)
    
    save dsmtx1a dsmtx1a
    save dsmtx2a dsmtx2a
    save dsmtx3a dsmtx3a
    
    sprintf('%d',subs(i))
    
end


% prepare task regressors (epoch + correct/error)

% need to re-do this...


for i = 1:nSubs
    
    cd ~/Desktop/
    cd ../../../Volumes/'Seagate Backup Plus Drive '/7T_data/3_behav_data/
    
    abc = sprintf('%s%d%s','load(''Sub_',subs(i),'_fMRI_LST_results'');');
    eval(abc)
        
        
    run1 = fMRI_out(1:48,3);
    run2 = fMRI_out(49:96,3);
    run3 = fMRI_out(97:144,3);
    
    run1_cat = fMRI_out(1:48,2);
    run2_cat = fMRI_out(49:96,2);
    run3_cat = fMRI_out(97:144,2);
     
    run1_resp = fMRI_out(1:48,6);
    run2_resp = fMRI_out(49:96,6);
    run3_resp = fMRI_out(97:144,6);
    
    onset1 = zeros(1400,3);
    onset2 = zeros(1400,3);
    onset3 = zeros(1400,3);
    onset1b = zeros(1400,3);
    onset2b = zeros(1400,3);
    onset3b = zeros(1400,3);
    
%     
%     sub_table(1,1,i) = sum(run1_cat == 1 & run1_resp == 1);
%     sub_table(2,1,i) = sum(run1_cat == 1 & run1_resp == 0);
%     sub_table(3,1,i) = sum(run1_cat == 2 & run1_resp == 1);
%     sub_table(4,1,i) = sum(run1_cat == 2 & run1_resp == 0);
%     sub_table(5,1,i) = sum(run1_cat == 3 & run1_resp == 1);
%     sub_table(6,1,i) = sum(run1_cat == 3 & run1_resp == 0);
%     sub_table(7,1,i) = sum(run1_cat == 4 & run1_resp == 1);
%     sub_table(8,1,i) = sum(run1_cat == 4 & run1_resp == 0);
%     
%     sub_table(1,2,i) = sum(run2_cat == 1 & run2_resp == 1);
%     sub_table(2,2,i) = sum(run2_cat == 1 & run2_resp == 0);
%     sub_table(3,2,i) = sum(run2_cat == 2 & run2_resp == 1);
%     sub_table(4,2,i) = sum(run2_cat == 2 & run2_resp == 0);
%     sub_table(5,2,i) = sum(run2_cat == 3 & run2_resp == 1);
%     sub_table(6,2,i) = sum(run2_cat == 3 & run2_resp == 0);
%     sub_table(7,2,i) = sum(run2_cat == 4 & run2_resp == 1);
%     sub_table(8,2,i) = sum(run2_cat == 4 & run2_resp == 0);
%     
%     sub_table(1,3,i) = sum(run3_cat == 1 & run3_resp == 1);
%     sub_table(2,3,i) = sum(run3_cat == 1 & run3_resp == 0);
%     sub_table(3,3,i) = sum(run3_cat == 2 & run3_resp == 1);
%     sub_table(4,3,i) = sum(run3_cat == 2 & run3_resp == 0);
%     sub_table(5,3,i) = sum(run3_cat == 3 & run3_resp == 1);
%     sub_table(6,3,i) = sum(run3_cat == 3 & run3_resp == 0);
%     sub_table(7,3,i) = sum(run3_cat == 4 & run3_resp == 1);
%     sub_table(8,3,i) = sum(run3_cat == 4 & run3_resp == 0);
%     
    
    
    
    for x = 1:48
    	for y = 1:3
        	if run1_cat(x,1) == y & run1_resp(x,1) == 1
            	onset1(round(run1(x)./.586):round(run1(x)./.586)+9,y) = 1;
            else
                onset1b(round(run1(x)./.586):round(run1(x)./.586)+9,y) = 1;
            end
        end
    end
    
    
    for x = 1:48
    	for y = 1:3
        	if run2_cat(x,1) == y & run2_resp(x,1) == 1
            	onset2(round(run2(x)./.586):round(run2(x)./.586)+9,y) = 1;
            else
                onset2b(round(run2(x)./.586):round(run2(x)./.586)+9,y) = 1;
            end
        end
    end
    
    for x = 1:48
    	for y = 1:3
        	if run3_cat(x,1) == y & run3_resp(x,1) == 1
            	onset3(round(run3(x)./.586):round(run3(x)./.586)+9,y) = 1;
            else
                onset3b(round(run3(x)./.586):round(run3(x)./.586)+9,y) = 1;
            end
        end
    end
    
    clear dsmtx1c dsmtx2c dsmtx3c dsmtx1e dsmtx2e dsmtx3e
    
    for y = 1:3
        dsmtx1c(:,y) = conv(hrf,onset1(:,y));
        dsmtx2c(:,y) = conv(hrf,onset2(:,y));
        dsmtx3c(:,y) = conv(hrf,onset3(:,y));
        dsmtx1e(:,y) = conv(hrf,onset1b(:,y));
        dsmtx2e(:,y) = conv(hrf,onset2b(:,y));
        dsmtx3e(:,y) = conv(hrf,onset3b(:,y));
    end
        
    dsmtx1c(nTime+1:end,:) = [];
    dsmtx2c(nTime+1:end,:) = [];
    dsmtx3c(nTime+1:end,:) = [];
    dsmtx1e(nTime+1:end,:) = [];
    dsmtx2e(nTime+1:end,:) = [];
    dsmtx3e(nTime+1:end,:) = [];
    
    cd ~/Documents/Drafts/Continuing/7t/data/
    abc = sprintf('%s%d','cd sub',subs(i));
    eval(abc)
    
    save dsmtx1c dsmtx1c
    save dsmtx2c dsmtx2c
    save dsmtx3c dsmtx3c
    save dsmtx1e dsmtx1e
    save dsmtx2e dsmtx2e
    save dsmtx3e dsmtx3e
    
    sprintf('%d',subs(i))
    
end





%% import Power ROI time series

sub_ts = [2;4;5;6;7;8;9;10;11;12;13;14;15;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;33;34;35;36;37;38;39;40;41;42;43;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59;60;61;62;63;64;65];
nSubs2 = size(sub_ts,1);


for i = 1:nSubs2

    for x = 1:3
            
        cd ~/Desktop/
        cd ../../../Volumes/'Seagate Backup Plus Drive '/7T_data/x_Power_ROI/2_task/
        
        abc = sprintf('%s%d%s','cd Block_',x,'/Results/ROISignals_FunImgRCWSF');
        eval(abc)
        
        if i < 8
            abc = sprintf('%s%d%s','load(''ROISignals_S0',sub_ts(i),''');');
            eval(abc)
        else
            abc = sprintf('%s%d%s','load(''ROISignals_S',sub_ts(i),''');');
            eval(abc)
        end

        
        % add in preprocessing here
        
        for j = 1:264
            data1(j,:) = zscore(ROISignals(:,j));
        end
        
        for t = 1:1250
            data2(:,t) = zscore(data1(:,t));
        end
        
        cd ~/Documents/Drafts/Continuing/7t/data/
        abc = sprintf('%s%d','cd sub',sub_ts(i));
        eval(abc)
        
        abc = sprintf('%s%d%s','run',x,'=data2;');
        eval(abc)
            
        abc = sprintf('%s%d%s%d','save run',x,' run',x);
        eval(abc)
        
        
    end
    
    sprintf('%d',subs(i))
    
end


%% concatenate data



for i = 1:nSubs2

    for x = 1:3
        
        cd ~/Documents/Drafts/Continuing/7t/data/
        
        abc = sprintf('%s%d','cd sub',sub_ts(i));
        eval(abc)
        
        abc = sprintf('%s%d','load run',x);
        eval(abc)
        
        abc = sprintf('%s%d','data_concat(:,(i-1)*3750+(x-1)*1250+1:x*1250+(i-1)*3750) = run',x,';');
        eval(abc)
        
        
    end
    
    sprintf('%d',subs(i))
    
end

save data_concat data_concat

%% run pca

[coeff_grp,score_grp,~,~,exp_grp] = pca(data_concat');

save coeff_grp coeff_grp
save score_grp score_grp
save exp_grp exp_grp


%% concatenate dsmtx

for i = 1:nSubs2

    for x = 1:3
        
        cd ~/Documents/Drafts/Continuing/7t/data/
        
        abc = sprintf('%s%d','cd sub',sub_ts(i));
        eval(abc)
        
        abc = sprintf('%s%d','load dsmtx',x);
        eval(abc)
        
        abc = sprintf('%s%d','dsmtx_concat(:,(i-1)*3750+(x-1)*1250+1:x*1250+(i-1)*3750) = dsmtx',x,''';');
        eval(abc)
        
        
    end
    
    sprintf('%d',subs(i))
    
end

save dsmtx_concat dsmtx_concat

%% concatenate dsmtx_epoch

for i = 1:nSubs2

    for x = 1:3
        
        cd ~/Documents/Drafts/Continuing/7t/data/
        
        abc = sprintf('%s%d','cd sub',sub_ts(i));
        eval(abc)
        
        abc = sprintf('%s%d%s','load dsmtx',x,'a');
        eval(abc)
        
        abc = sprintf('%s%d','dsmtx_concat1(:,(i-1)*3750+(x-1)*1250+1:x*1250+(i-1)*3750) = dsmtx',x,'a'';');
        eval(abc)
        
        
    end
    
    sprintf('%d',subs(i))
    
end

save dsmtx_concat1 dsmtx_concat1


%% concatenate dsmtx_epoch

for i = 1:nSubs2

    for x = 1:3
        
        cd ~/Documents/Drafts/Continuing/7t/data/
        
        abc = sprintf('%s%d','cd sub',sub_ts(i));
        eval(abc)
        
        abc = sprintf('%s%d%s','load dsmtx',x,'c');
        eval(abc)
        
        abc = sprintf('%s%d','dsmtx_concat1_corr(:,(i-1)*3750+(x-1)*1250+1:x*1250+(i-1)*3750) = dsmtx',x,'c'';');
        eval(abc)
        
        
    end
    
    sprintf('%d',subs(i))
    
end

save dsmtx_concat1_corr dsmtx_concat1_corr


for i = 1:nSubs2

    for x = 1:3
        
        cd ~/Documents/Drafts/Continuing/7t/data/
        
        abc = sprintf('%s%d','cd sub',sub_ts(i));
        eval(abc)
        
        abc = sprintf('%s%d%s','load dsmtx',x,'e');
        eval(abc)
        
        abc = sprintf('%s%d','dsmtx_concat1_err(:,(i-1)*3750+(x-1)*1250+1:x*1250+(i-1)*3750) = dsmtx',x,'e'';');
        eval(abc)
        
        
    end
    
    sprintf('%d',subs(i))
    
end

save dsmtx_concat1_err dsmtx_concat1_err





%% fit GLM

for x = 1:20
    beta_score(:,x) = glmfit(dsmtx_concat',score_grp(:,x),'normal');
end

for x = 1:20
    beta1_score(:,x) = glmfit(dsmtx_concat1',score_grp(:,x),'normal');
end


for x = 1:20
    beta1_score_corr(:,x) = glmfit(dsmtx_concat1_corr',score_grp(:,x),'normal');
end


for x = 1:20
    beta1_score_err(:,x) = glmfit(dsmtx_concat1_err',score_grp(:,x),'normal');
end



%% extract trial-based time series

dsmtx_bin = double(dsmtx_concat>0);

[~,on1,vals] = find(diff(dsmtx_bin(1,:)));
on1a = on1(vals==1);
on1b = on1(vals==-1);

[~,on2,vals] = find(diff(dsmtx_bin(2,:)));
on2a = on2(vals==1);
on2b = on2(vals==-1);

[~,on3,vals] = find(diff(dsmtx_bin(3,:)));
on3a = on3(vals==1);
on3b = on3(vals==-1);

[~,on4,vals] = find(diff(dsmtx_bin(4,:)));
on4a = on4(vals==1);
on4b = on4(vals==-1);

for x = 1:2000

    score_grp1b(:,:,x) = score_grp(on1a(x):on1a(x)+39,1:10)';
    score_grp2b(:,:,x) = score_grp(on2a(x):on2a(x)+39,1:10)';
    score_grp3b(:,:,x) = score_grp(on3a(x):on3a(x)+39,1:10)';
    score_grp4b(:,:,x) = score_grp(on4a(x):on4a(x)+39,1:10)';
    
end

for x = 1:2000

    data_grp1b(:,:,x) = data_concat(:,on1a(x):on1a(x)+39);
    data_grp2b(:,:,x) = data_concat(:,on2a(x):on2a(x)+39);
    data_grp3b(:,:,x) = data_concat(:,on3a(x):on3a(x)+39);
    data_grp4b(:,:,x) = data_concat(:,on4a(x):on4a(x)+39);
    
end

data_grp1b = data_concat

%correct vs error

dsmtx_bin = double(dsmtx_concat1_corr>0);

[~,on1,vals] = find(diff(dsmtx_bin(1,:)));
on1a = on1(vals==1);
on1b = on1(vals==-1);

[~,on2,vals] = find(diff(dsmtx_bin(2,:)));
on2a = on2(vals==1);
on2b = on2(vals==-1);

[~,on3,vals] = find(diff(dsmtx_bin(3,:)));
on3a = on3(vals==1);
on3b = on3(vals==-1);


for x = 1:6000

    score_grp1c(:,:,x) = score_grp(on1a(x):on1a(x)+39,1:10)';
    score_grp2c(:,:,x) = score_grp(on2a(x):on2a(x)+39,1:10)';
    score_grp3c(:,:,x) = score_grp(on3a(x):on3a(x)+39,1:10)';
    score_grp4c(:,:,x) = score_grp(on4a(x):on4a(x)+39,1:10)';
    
end






for x = 1:6000

    score_grp1c(:,:,x) = score_grp(on1a(x):on1a(x)+39,1:10)';
    score_grp2c(:,:,x) = score_grp(on2a(x):on2a(x)+39,1:10)';
    score_grp3c(:,:,x) = score_grp(on3a(x):on3a(x)+39,1:10)';
    score_grp4c(:,:,x) = score_grp(on4a(x):on4a(x)+39,1:10)';
    
end