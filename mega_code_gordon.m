
nSubs = 60;
nTime = 1250;
nROI = 333;
nRun = 3;
nTrials = 48;
sub_ts = [2;4;5;6;7;8;9;10;11;12;13;14;15;17;18;19;20;21;22;23;24;25;26;27;28;29;30;31;33;34;35;36;37;38;39;40;41;42;43;45;46;47;48;49;50;51;52;53;54;55;56;57;58;59;60;61;62;63;64;65];
nSubs = size(sub_ts,1);


% prepare task regressors (epoch)

for i = 1:nSubs
    
    cd ~/Desktop/
    cd ../../../Volumes/'Seagate Backup Plus Drive '/7T_data/3_behav_data/
    
    abc = sprintf('%s%d%s','load(''Sub_',sub_ts(i),'_fMRI_LST_results'');');
    eval(abc)
        
    run1_cat = rec.Key(1,1:48)';
    run2_cat = rec.Key(1,49:96)';
    run3_cat = rec.Key(1,97:144)';
        
    run1 = fMRI_out(1:48,3);
    run2 = fMRI_out(49:96,3);
    run3 = fMRI_out(97:144,3);
        
    run1_acc = fMRI_out(1:48,6);
    run2_acc = fMRI_out(49:96,6);
    run3_acc = fMRI_out(97:144,6);
   
    onset1 = zeros(1400,6);
    onset2 = zeros(1400,6);
    onset3 = zeros(1400,6);
    
        
    for x = 1:nTrials
    	for y = 1:nRun
            for z = 1:2
                if run1_cat(x,1) == y
                    onset1(round(run1(x)./.586):round(run1(x)./.586)+9,y) = 1;
            end
        end
    end
    
    for x = 1:nTrials
    	for y = 1:4
        	if run2_cat(x,1) == y
            	onset2(round(run2(x)./.586):round(run2(x)./.586)+9,y) = 1;
            end
        end
    end
    
    for x = 1:nTrials
    	for y = 1:4
        	if run
            _cat(x,1) == y
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


% prepare task regressors (FIR)

for i = 1:nSubs
    
    cd ~/Desktop/
    cd ../../../Volumes/'Seagate Backup Plus Drive '/7T_data/3_behav_data/
    
    abc = sprintf('%s%d%s','load(''Sub_',sub_ts(i),'_fMRI_LST_results'');');
    eval(abc)
        
    
    
    
    run1_cat = fMRI_out(1:nTrials,2)';
    run2_cat = fMRI_out(nTrials+1:nTrials*2,2)';
    run3_cat = fMRI_out(nTrials*2+1:nTrials*3,2)';
        
    run1 = fMRI_out(1:nTrials,3);
    run2 = fMRI_out(nTrials+1:nTrials*2,3);
    run3 = fMRI_out(nTrials*2+1:nTrials*3,3);
        
    run1_acc = fMRI_out(1:nTrials,6);
    run2_acc = fMRI_out(nTrials+1:nTrials*2,6);
    run3_acc = fMRI_out(nTrials*2+1:nTrials*3,6);
    
    run1_conf = rec.confKey(1:nTrials)';
    run2_conf = rec.confKey(nTrials+1:nTrials*2)';
    run3_conf = rec.confKey(nTrials*2+1:nTrials*3)';
    
    clear runcat runresp
    
    runcat = zeros(12,4,3);
    runresp = zeros(12,4,2,3);
    
    runcat(:,1,1) = round(run1(run1_cat==1)./.586); %run1 binary
    runcat(:,2,1) = round(run1(run1_cat==2)./.586); %run1 ternary
    runcat(:,3,1) = round(run1(run1_cat==3)./.586); %run1 quaternary
    runcat(:,4,1) = round(run1(run1_cat==4)./.586); %run1 null
    runcat(:,1,2) = round(run2(run2_cat==1)./.586); %run2 binary
    runcat(:,2,2) = round(run2(run2_cat==2)./.586); %run2 ternary
    runcat(:,3,2) = round(run2(run2_cat==3)./.586); %run2 quaternary
    runcat(:,4,2) = round(run2(run2_cat==4)./.586); %run2 null
    runcat(:,1,3) = round(run3(run3_cat==1)./.586); %run3 binary
    runcat(:,2,3) = round(run3(run3_cat==2)./.586); %run3 ternary
    runcat(:,3,3) = round(run3(run3_cat==3)./.586); %run3 quaternary
    runcat(:,4,3) = round(run3(run3_cat==4)./.586); %run3 null
    
    onset1 = zeros(1400,27,4,3);
        
    for z = 1:3 %nSessions
        for y = 1:4 %nLoads
            for x = 1:12 %nTrials
                onset1(runcat(x,y,z),1,y,z) = 1;
                onset1(runcat(x,y,z)+1,2,y,z) = 1;
                onset1(runcat(x,y,z)+2,3,y,z) = 1;
                onset1(runcat(x,y,z)+3,4,y,z) = 1;
                onset1(runcat(x,y,z)+4,5,y,z) = 1;
                onset1(runcat(x,y,z)+5,6,y,z) = 1;
                onset1(runcat(x,y,z)+6,7,y,z) = 1;
                onset1(runcat(x,y,z)+7,8,y,z) = 1;
                onset1(runcat(x,y,z)+8,9,y,z) = 1;
                onset1(runcat(x,y,z)+9,10,y,z) = 1;
                onset1(runcat(x,y,z)+10,11,y,z) = 1;
                onset1(runcat(x,y,z)+11,12,y,z) = 1;
                onset1(runcat(x,y,z)+12,13,y,z) = 1;
                onset1(runcat(x,y,z)+13,14,y,z) = 1;
                onset1(runcat(x,y,z)+14,15,y,z) = 1;
                onset1(runcat(x,y,z)+15,16,y,z) = 1;
                onset1(runcat(x,y,z)+16,17,y,z) = 1;
                onset1(runcat(x,y,z)+17,18,y,z) = 1;
                onset1(runcat(x,y,z)+18,19,y,z) = 1;
                onset1(runcat(x,y,z)+19,20,y,z) = 1;
                onset1(runcat(x,y,z)+20,21,y,z) = 1;
                onset1(runcat(x,y,z)+21,22,y,z) = 1;
                onset1(runcat(x,y,z)+22,23,y,z) = 1;
                onset1(runcat(x,y,z)+23,24,y,z) = 1;
                onset1(runcat(x,y,z)+24,25,y,z) = 1;
                onset1(runcat(x,y,z)+25,26,y,z) = 1;
                onset1(runcat(x,y,z)+26,27,y,z) = 1;   
            end
        end
    end
    
    
   
    dsmtx1f_full = reshape(onset1(1:1250,:,:,1),1250,27*4);
    dsmtx2f_full = reshape(onset1(1:1250,:,:,2),1250,27*4);
    dsmtx3f_full = reshape(onset1(1:1250,:,:,3),1250,27*4);
    
    cd ~/Documents/Drafts/Continuing/7t/data/
    abc = sprintf('%s%d','cd sub',sub_ts(i));
    eval(abc)
    
    save dsmtx1f_full dsmtx1f_full
    save dsmtx2f_full dsmtx2f_full
    save dsmtx3f_full dsmtx3f_full
    save runcat runcat
    
    
    %% correct vs error 
    
    run1_resp = fMRI_out(1:48,6);
    run2_resp = fMRI_out(49:96,6);
    run3_resp = fMRI_out(97:144,6);
    
    
    runresp(1:sum(double(run1_cat'==1 & run1_resp==1 & run1_conf>2 & run1_conf~=999)),1,1,1) = round(run1(run1_cat'==1 & run1_resp==1 & run1_conf>2 & run1_conf~=999)./.586); %run 1 binary correct
    runresp(1:sum(double(run1_cat'==1 & run1_resp==0 & run1_conf>2 & run1_conf~=999)),1,2,1) = round(run1(run1_cat'==1 & run1_resp==0 & run1_conf>2 & run1_conf~=999)./.586); %run 1 binary error
    runresp(1:sum(double(run1_cat'==2 & run1_resp==1 & run1_conf>2 & run1_conf~=999)),2,1,1) = round(run1(run1_cat'==2 & run1_resp==1 & run1_conf>2 & run1_conf~=999)./.586); %run 1 ternary correct
    runresp(1:sum(double(run1_cat'==2 & run1_resp==0 & run1_conf>2 & run1_conf~=999)),2,2,1) = round(run1(run1_cat'==2 & run1_resp==0 & run1_conf>2 & run1_conf~=999)./.586); %run 1 ternary error
    runresp(1:sum(double(run1_cat'==3 & run1_resp==1 & run1_conf>2 & run1_conf~=999)),3,1,1) = round(run1(run1_cat'==3 & run1_resp==1 & run1_conf>2 & run1_conf~=999)./.586); %run 1 quaternary correct
    runresp(1:sum(double(run1_cat'==3 & run1_resp==0 & run1_conf>2 & run1_conf~=999)),3,2,1) = round(run1(run1_cat'==3 & run1_resp==0 & run1_conf>2 & run1_conf~=999)./.586); %run 1 quaternary error
    runresp(1:sum(double(run2_cat'==1 & run2_resp==1 & run2_conf>2 & run2_conf~=999)),1,1,2) = round(run2(run2_cat'==1 & run2_resp==1 & run2_conf>2 & run2_conf~=999)./.586); %run 2 binary correct
    runresp(1:sum(double(run2_cat'==1 & run2_resp==0 & run2_conf>2 & run2_conf~=999)),1,2,2) = round(run2(run2_cat'==1 & run2_resp==0 & run2_conf>2 & run2_conf~=999)./.586); %run 2 binary error
    runresp(1:sum(double(run2_cat'==2 & run2_resp==1 & run2_conf>2 & run2_conf~=999)),2,1,2) = round(run2(run2_cat'==2 & run2_resp==1 & run2_conf>2 & run2_conf~=999)./.586); %run 2 ternary correct
    runresp(1:sum(double(run2_cat'==2 & run2_resp==0 & run2_conf>2 & run2_conf~=999)),2,2,2) = round(run2(run2_cat'==2 & run2_resp==0 & run2_conf>2 & run2_conf~=999)./.586); %run 2 ternary error
    runresp(1:sum(double(run2_cat'==3 & run2_resp==1 & run2_conf>2 & run2_conf~=999)),3,1,2) = round(run2(run2_cat'==3 & run2_resp==1 & run2_conf>2 & run2_conf~=999)./.586); %run 2 quaternary correct
    runresp(1:sum(double(run2_cat'==3 & run2_resp==0 & run2_conf>2 & run2_conf~=999)),3,2,2) = round(run2(run2_cat'==3 & run2_resp==0 & run2_conf>2 & run2_conf~=999)./.586); %run 2 quaternary error
    runresp(1:sum(double(run3_cat'==1 & run3_resp==1 & run3_conf>2 & run3_conf~=999)),1,1,3) = round(run3(run3_cat'==1 & run3_resp==1 & run3_conf>2 & run3_conf~=999)./.586); %run 3 binary correct
    runresp(1:sum(double(run3_cat'==1 & run3_resp==0 & run3_conf>2 & run3_conf~=999)),1,2,3) = round(run3(run3_cat'==1 & run3_resp==0 & run3_conf>2 & run3_conf~=999)./.586); %run 3 binary error
    runresp(1:sum(double(run3_cat'==2 & run3_resp==1 & run3_conf>2 & run3_conf~=999)),2,1,3) = round(run3(run3_cat'==2 & run3_resp==1 & run3_conf>2 & run3_conf~=999)./.586); %run 3 ternary correct
    runresp(1:sum(double(run3_cat'==2 & run3_resp==0 & run3_conf>2 & run3_conf~=999)),2,2,3) = round(run3(run3_cat'==2 & run3_resp==0 & run3_conf>2 & run3_conf~=999)./.586); %run 3 ternary error
    runresp(1:sum(double(run3_cat'==3 & run3_resp==1 & run3_conf>2 & run3_conf~=999)),3,1,3) = round(run3(run3_cat'==3 & run3_resp==1 & run3_conf>2 & run3_conf~=999)./.586); %run 3 quaternary correct
    runresp(1:sum(double(run3_cat'==3 & run3_resp==0 & run3_conf>2 & run3_conf~=999)),3,2,3) = round(run3(run3_cat'==3 & run3_resp==0 & run3_conf>2 & run3_conf~=999)./.586); %run 3 quaternary error
    
    onset2 = zeros(1400,27,3,2,3); % time X beta X load x trial x session

        
    for z = 1:3 %nSessions
        for w = 1:2%nTrials
            for y = 1:3 %nLoads
                for x = 1:12
                    if runresp(x,y,w,z) > 0
                        onset2(runresp(x,y,w,z),1,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+1,2,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+2,3,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+3,4,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+4,5,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+5,6,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+6,7,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+7,8,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+8,9,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+9,10,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+10,11,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+11,12,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+12,13,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+13,14,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+14,15,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+15,16,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+16,17,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+17,18,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+18,19,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+19,20,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+20,21,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+21,22,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+22,23,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+23,24,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+24,25,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+25,26,y,w,z) = 1;
                        onset2(runresp(x,y,w,z)+26,27,y,w,z) = 1;  
                    end
                end
            end
        end
    end
    
    % dsmtx*p_full = time X beta/load/trial (across 3 sessions)
    
    dsmtx1p_full1 = reshape(onset2(1:1250,:,:,:,1),1250,27*6);
    dsmtx2p_full1 = reshape(onset2(1:1250,:,:,:,2),1250,27*6);
    dsmtx3p_full1 = reshape(onset2(1:1250,:,:,:,3),1250,27*6);
    
    cd ~/Documents/Drafts/Continuing/7t/data/
    abc = sprintf('%s%d','cd sub',sub_ts(i));
    eval(abc)
    
    save dsmtx1p_full1 dsmtx1p_full1
    save dsmtx2p_full1 dsmtx2p_full1
    save dsmtx3p_full1 dsmtx3p_full1
    
    
    
    
    sprintf('%d',i)
    
end




% prepare task regressors (epoch + correct/error)

% need to re-do this...


for i = 1:nSubs
    
    cd ~/Desktop/
    cd ../../../Volumes/'Seagate Backup Plus Drive '/7T_data/3_behav_data/
    
    abc = sprintf('%s%d%s','load(''Sub_',sub_ts(i),'_fMRI_LST_results'');');
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
    
    onset1 = zeros(1400,40,3);
    onset2 = zeros(1400,40,3);
    onset3 = zeros(1400,40,3);
    onset1a = zeros(1400,40,3);
    onset2a = zeros(1400,40,3);
    onset3a = zeros(1400,40,3);


    resp_grp(1,i,1) = sum(run1_resp(run1_cat==1));
    resp_grp(2,i,1) = sum(run1_resp(run1_cat==2));
    resp_grp(3,i,1) = sum(run1_resp(run1_cat==3));
    resp_grp(1,i,2) = sum(run2_resp(run2_cat==1));
    resp_grp(2,i,2) = sum(run2_resp(run2_cat==2));
    resp_grp(3,i,2) = sum(run2_resp(run2_cat==3));
    resp_grp(1,i,3) = sum(run3_resp(run3_cat==1));
    resp_grp(2,i,3) = sum(run3_resp(run3_cat==2));
    resp_grp(3,i,3) = sum(run3_resp(run3_cat==3));

    
    for x = 1:48
    	for y = 1:3
        	if run1_cat(x,1) == y && run1_resp(x,1) == 1
            	onset1(round(run1(x)./.586),1,y) = 1;
                onset1(round(run1(x)./.586)+1,2,y) = 1;
                onset1(round(run1(x)./.586)+2,3,y) = 1;
                onset1(round(run1(x)./.586)+3,4,y) = 1;
                onset1(round(run1(x)./.586)+4,5,y) = 1;
                onset1(round(run1(x)./.586)+5,6,y) = 1;
                onset1(round(run1(x)./.586)+6,7,y) = 1;
                onset1(round(run1(x)./.586)+7,8,y) = 1;
                onset1(round(run1(x)./.586)+8,9,y) = 1;
                onset1(round(run1(x)./.586)+9,10,y) = 1;
                onset1(round(run1(x)./.586)+10,11,y) = 1;
                onset1(round(run1(x)./.586)+11,12,y) = 1;
                onset1(round(run1(x)./.586)+12,13,y) = 1;
                onset1(round(run1(x)./.586)+13,14,y) = 1;
                onset1(round(run1(x)./.586)+14,15,y) = 1;
                onset1(round(run1(x)./.586)+15,16,y) = 1;
                onset1(round(run1(x)./.586)+16,17,y) = 1;
                onset1(round(run1(x)./.586)+17,18,y) = 1;
                onset1(round(run1(x)./.586)+18,19,y) = 1;
                onset1(round(run1(x)./.586)+19,20,y) = 1;
                onset1(round(run1(x)./.586)+20,21,y) = 1;
                onset1(round(run1(x)./.586)+21,22,y) = 1;
                onset1(round(run1(x)./.586)+22,23,y) = 1;
                onset1(round(run1(x)./.586)+23,24,y) = 1;
                onset1(round(run1(x)./.586)+24,25,y) = 1;
                onset1(round(run1(x)./.586)+25,26,y) = 1;
                onset1(round(run1(x)./.586)+26,27,y) = 1; 
            else
                onset1(round(run1(x)./.586),28,y) = 1;
                onset1(round(run1(x)./.586)+1,29,y) = 1;
                onset1(round(run1(x)./.586)+2,30,y) = 1;
                onset1(round(run1(x)./.586)+3,31,y) = 1;
                onset1(round(run1(x)./.586)+4,32,y) = 1;
                onset1(round(run1(x)./.586)+5,33,y) = 1;
                onset1(round(run1(x)./.586)+6,34,y) = 1;
                onset1(round(run1(x)./.586)+7,35,y) = 1;
                onset1(round(run1(x)./.586)+8,36,y) = 1;
                onset1(round(run1(x)./.586)+9,37,y) = 1;
                onset1(round(run1(x)./.586)+10,38,y) = 1;
                onset1(round(run1(x)./.586)+11,39,y) = 1;
                onset1(round(run1(x)./.586)+12,40,y) = 1;
                onset1(round(run1(x)./.586)+13,41,y) = 1;
                onset1(round(run1(x)./.586)+14,42,y) = 1;
                onset1(round(run1(x)./.586)+15,43,y) = 1;
                onset1(round(run1(x)./.586)+16,44,y) = 1;
                onset1(round(run1(x)./.586)+17,45,y) = 1;
                onset1(round(run1(x)./.586)+18,46,y) = 1;
                onset1(round(run1(x)./.586)+19,47,y) = 1;
                onset1(round(run1(x)./.586)+20,48,y) = 1;
                onset1(round(run1(x)./.586)+21,49,y) = 1;
                onset1(round(run1(x)./.586)+22,50,y) = 1;
                onset1(round(run1(x)./.586)+23,51,y) = 1;
                onset1(round(run1(x)./.586)+24,52,y) = 1;
                onset1(round(run1(x)./.586)+25,53,y) = 1;
                onset1(round(run1(x)./.586)+26,54,y) = 1; 
            end
        end
    end
    
    for x = 1:48
    	for y = 1:3
        	if run2_cat(x,1) == y && run2_resp(x,1) == 1
            	onset2(round(run2(x)./.586),1,y) = 1;
                onset2(round(run2(x)./.586)+1,2,y) = 1;
                onset2(round(run2(x)./.586)+2,3,y) = 1;
                onset2(round(run2(x)./.586)+3,4,y) = 1;
                onset2(round(run2(x)./.586)+4,5,y) = 1;
                onset2(round(run2(x)./.586)+5,6,y) = 1;
                onset2(round(run2(x)./.586)+6,7,y) = 1;
                onset2(round(run2(x)./.586)+7,8,y) = 1;
                onset2(round(run2(x)./.586)+8,9,y) = 1;
                onset2(round(run2(x)./.586)+9,10,y) = 1;
                onset2(round(run2(x)./.586)+10,11,y) = 1;
                onset2(round(run2(x)./.586)+11,12,y) = 1;
                onset2(round(run2(x)./.586)+12,13,y) = 1;
                onset2(round(run2(x)./.586)+13,14,y) = 1;
                onset2(round(run2(x)./.586)+14,15,y) = 1;
                onset2(round(run2(x)./.586)+15,16,y) = 1;
                onset2(round(run2(x)./.586)+16,17,y) = 1;
                onset2(round(run2(x)./.586)+17,18,y) = 1;
                onset2(round(run2(x)./.586)+18,19,y) = 1;
                onset2(round(run2(x)./.586)+19,20,y) = 1;
                onset2(round(run2(x)./.586)+20,21,y) = 1;
                onset2(round(run2(x)./.586)+21,22,y) = 1;
                onset2(round(run2(x)./.586)+22,23,y) = 1;
                onset2(round(run2(x)./.586)+23,24,y) = 1;
                onset2(round(run2(x)./.586)+24,25,y) = 1;
                onset2(round(run2(x)./.586)+25,26,y) = 1;
                onset2(round(run2(x)./.586)+26,27,y) = 1; 
            else
                onset2(round(run2(x)./.586),28,y) = 1;
                onset2(round(run2(x)./.586)+1,29,y) = 1;
                onset2(round(run2(x)./.586)+2,30,y) = 1;
                onset2(round(run2(x)./.586)+3,31,y) = 1;
                onset2(round(run2(x)./.586)+4,32,y) = 1;
                onset2(round(run2(x)./.586)+5,33,y) = 1;
                onset2(round(run2(x)./.586)+6,34,y) = 1;
                onset2(round(run2(x)./.586)+7,35,y) = 1;
                onset2(round(run2(x)./.586)+8,36,y) = 1;
                onset2(round(run2(x)./.586)+9,37,y) = 1;
                onset2(round(run2(x)./.586)+10,38,y) = 1;
                onset2(round(run2(x)./.586)+11,39,y) = 1;
                onset2(round(run2(x)./.586)+12,40,y) = 1;
                onset2(round(run2(x)./.586)+13,41,y) = 1;
                onset2(round(run2(x)./.586)+14,42,y) = 1;
                onset2(round(run2(x)./.586)+15,43,y) = 1;
                onset2(round(run2(x)./.586)+16,44,y) = 1;
                onset2(round(run2(x)./.586)+17,45,y) = 1;
                onset2(round(run2(x)./.586)+18,46,y) = 1;
                onset2(round(run2(x)./.586)+19,47,y) = 1;
                onset2(round(run2(x)./.586)+20,48,y) = 1;
                onset2(round(run2(x)./.586)+21,49,y) = 1;
                onset2(round(run2(x)./.586)+22,50,y) = 1;
                onset2(round(run2(x)./.586)+23,51,y) = 1;
                onset2(round(run2(x)./.586)+24,52,y) = 1;
                onset2(round(run2(x)./.586)+25,53,y) = 1;
                onset2(round(run2(x)./.586)+26,54,y) = 1;
            end
        end
    end
    
    for x = 1:48
    	for y = 1:3
        	if run3_cat(x,1) == y && run3_resp(x,1) == 1
            	onset3(round(run3(x)./.586),1,y) = 1;
                onset3(round(run3(x)./.586)+1,2,y) = 1;
                onset3(round(run3(x)./.586)+2,3,y) = 1;
                onset3(round(run3(x)./.586)+3,4,y) = 1;
                onset3(round(run3(x)./.586)+4,5,y) = 1;
                onset3(round(run3(x)./.586)+5,6,y) = 1;
                onset3(round(run3(x)./.586)+6,7,y) = 1;
                onset3(round(run3(x)./.586)+7,8,y) = 1;
                onset3(round(run3(x)./.586)+8,9,y) = 1;
                onset3(round(run3(x)./.586)+9,10,y) = 1;
                onset3(round(run3(x)./.586)+10,11,y) = 1;
                onset3(round(run3(x)./.586)+11,12,y) = 1;
                onset3(round(run3(x)./.586)+12,13,y) = 1;
                onset3(round(run3(x)./.586)+13,14,y) = 1;
                onset3(round(run3(x)./.586)+14,15,y) = 1;
                onset3(round(run3(x)./.586)+15,16,y) = 1;
                onset3(round(run3(x)./.586)+16,17,y) = 1;
                onset3(round(run3(x)./.586)+17,18,y) = 1;
                onset3(round(run3(x)./.586)+18,19,y) = 1;
                onset3(round(run3(x)./.586)+19,20,y) = 1;
                onset3(round(run3(x)./.586)+20,21,y) = 1;
                onset3(round(run3(x)./.586)+21,22,y) = 1;
                onset3(round(run3(x)./.586)+22,23,y) = 1;
                onset3(round(run3(x)./.586)+23,24,y) = 1;
                onset3(round(run3(x)./.586)+24,25,y) = 1;
                onset3(round(run3(x)./.586)+25,26,y) = 1;
                onset3(round(run3(x)./.586)+26,27,y) = 1; 
            else
                onset3(round(run3(x)./.586),28,y) = 1;
                onset3(round(run3(x)./.586)+1,29,y) = 1;
                onset3(round(run3(x)./.586)+2,30,y) = 1;
                onset3(round(run3(x)./.586)+3,31,y) = 1;
                onset3(round(run3(x)./.586)+4,32,y) = 1;
                onset3(round(run3(x)./.586)+5,33,y) = 1;
                onset3(round(run3(x)./.586)+6,34,y) = 1;
                onset3(round(run3(x)./.586)+7,35,y) = 1;
                onset3(round(run3(x)./.586)+8,36,y) = 1;
                onset3(round(run3(x)./.586)+9,37,y) = 1;
                onset3(round(run3(x)./.586)+10,38,y) = 1;
                onset3(round(run3(x)./.586)+11,39,y) = 1;
                onset3(round(run3(x)./.586)+12,40,y) = 1;
                onset3(round(run3(x)./.586)+13,41,y) = 1;
                onset3(round(run3(x)./.586)+14,42,y) = 1;
                onset3(round(run3(x)./.586)+15,43,y) = 1;
                onset3(round(run3(x)./.586)+16,44,y) = 1;
                onset3(round(run3(x)./.586)+17,45,y) = 1;
                onset3(round(run3(x)./.586)+18,46,y) = 1;
                onset3(round(run3(x)./.586)+19,47,y) = 1;
                onset3(round(run3(x)./.586)+20,48,y) = 1;
                onset3(round(run3(x)./.586)+21,49,y) = 1;
                onset3(round(run3(x)./.586)+22,50,y) = 1;
                onset3(round(run3(x)./.586)+23,51,y) = 1;
                onset3(round(run3(x)./.586)+24,52,y) = 1;
                onset3(round(run3(x)./.586)+25,53,y) = 1;
                onset3(round(run3(x)./.586)+26,54,y) = 1;
            end
        end
    end
   
    onset1a = reshape(onset1,1400,162);
    onset2a = reshape(onset2,1400,162);
    onset3a = reshape(onset3,1400,162);
    
    dsmtx1p_full = onset1a(1:1250,:);
    dsmtx2p_full = onset2a(1:1250,:);
    dsmtx3p_full = onset3a(1:1250,:);
    
    
    cd ~/Documents/Drafts/Continuing/7t/data/
    abc = sprintf('%s%d','cd sub',sub_ts(i));
    eval(abc)
    
    save dsmtx1p_full dsmtx1p_full
    save dsmtx2p_full dsmtx2p_full
    save dsmtx3p_full dsmtx3p_full
    
    sprintf('%d',subs(i))
    
end









%% run FIR GLM

nThal = 31;

for i = 1:nSubs
    
    cd ~/Documents/Drafts/Continuing/7t/data/
    abc = sprintf('%s%d','cd sub',sub_ts(i));
    eval(abc)
    
    data_temp = thal_grp(:,:,:,i);
    
    load('dsmtx1f_full')
    load('dsmtx2f_full')
    load('dsmtx3f_full')
    load('dsmtx1p_full')
    load('dsmtx2p_full')
    load('dsmtx3p_full')
    
    for j = 1:nThal
        beta_f1_thal(j,:) = glmfit(dsmtx1f_full,data_temp(j,:,1)','normal');
        beta_f2_thal(j,:) = glmfit(dsmtx2f_full,data_temp(j,:,2)','normal');
        beta_f3_thal(j,:) = glmfit(dsmtx3f_full,data_temp(j,:,3)','normal');
        beta_p1_thal(j,:) = glmfit(dsmtx1p_full,data_temp(j,:,1)','normal');
        beta_p2_thal(j,:) = glmfit(dsmtx2p_full,data_temp(j,:,2)','normal');
        beta_p3_thal(j,:) = glmfit(dsmtx3p_full,data_temp(j,:,3)','normal');
    end
    
    save beta_f1_thal beta_f1_thal
    save beta_f2_thal beta_f2_thal
    save beta_f3_thal beta_f3_thal
    save beta_p1_thal beta_p1_thal
    save beta_p2_thal beta_p2_thal
    save beta_p3_thal beta_p3_thal
    
    sprintf('%d',i)
    
end




for i = 1:nSubs
    
    cd ~/Documents/Drafts/Continuing/7t/data/
    abc = sprintf('%s%d','cd sub',sub_ts(i));
    eval(abc)
        

    load('beta_p1_full')
    load('beta_p2_full')
    load('beta_p3_full')
    
    beta_grp(:,:,1,i) = beta_p1_full(:,2:end);
    beta_grp(:,:,2,i) = beta_p2_full(:,2:end);
    beta_grp(:,:,3,i) = beta_p3_full(:,2:end);
    
    
    
    
    sprintf('%d',i)
    
end


for i = 1:nSubs
    
    cd ~/Documents/Drafts/Continuing/7t/data/
    abc = sprintf('%s%d','cd sub',sub_ts(i));
    eval(abc)
        

    load('beta_p1_thal')
    load('beta_p2_thal')
    load('beta_p3_thal')
    
    beta_p_thal_grp(:,:,1,i) = beta_p1_thal(:,2:end);
    beta_p_thal_grp(:,:,2,i) = beta_p2_thal(:,2:end);
    beta_p_thal_grp(:,:,3,i) = beta_p3_thal(:,2:end);
    
    load('beta_f1_thal')
    load('beta_f2_thal')
    load('beta_f3_thal')
    
    beta_thal_grp(:,:,1,i) = beta_f1_thal(:,2:end);
    beta_thal_grp(:,:,2,i) = beta_f2_thal(:,2:end);
    beta_thal_grp(:,:,3,i) = beta_f3_thal(:,2:end);
    
    sprintf('%d',i)
    
end



%% import Gordon ROI time series


for i = 1:nSubs

    for x = 1:3
            
        cd ~/Documents/Drafts/Continuing/7t/gordon/
        
        abc = sprintf('%s%d%s','cd task',x);
        eval(abc)
        
        if i < 8
            abc = sprintf('%s%d%s','load(''ROISignals_S0',sub_ts(i),''');');
            eval(abc)
        else
            abc = sprintf('%s%d%s','load(''ROISignals_S',sub_ts(i),''');');
            eval(abc)
        end

        
        % add in preprocessing here
        
        for j = 1:nNodes
            data1(j,:) = zscore(ROISignals(:,j));
        end
        
        for t = 1:nTime
            data2(:,t) = zscore(data1(:,t));
        end
        
        
        
        
        abc = sprintf('%s%d','data_concat_gord(:,(i-1)*3750+(x-1)*1250+1:x*1250+(i-1)*3750) = data2;');
        eval(abc)
        
        data_unpack_gord(:,:,x,i) = data2;
        
        
        % translate into HCP PCs
        
%         for n = 1:5
%             for t = 1:nTime
%                 score_sub(t,n) = dot(data2(:,t),COEFF5a(:,n));
%             end
%         end
%         
%         abc = sprintf('%s%d','score_concat_gord(:,(i-1)*3750+(x-1)*1250+1:x*1250+(i-1)*3750) = score_sub'';');
%         eval(abc)
        
        
        % run single session PCA
        
%         [c_temp,s_temp,~,~,e_temp] = pca(data2');
%         
%         abc = sprintf('%s%d','score_sub_gord(:,(i-1)*3750+(x-1)*1250+1:x*1250+(i-1)*3750) = s_temp(:,1:5)'';');
%         eval(abc)
%         
%         coeff_sub_grp(:,:,x,i) = c_temp(:,1:5);
%         exp_sub_grp(:,x,i) = e_temp(1:5,1);
        
        
        
    end
    
    sprintf('%d',subs(i))
    
end


%% concatenate data



for i = 1:nSubs

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

[coeff_grp,score_grp,~,~,exp_grp] = pca(data_concat_gord');

save coeff_grp coeff_grp
save score_grp score_grp
save exp_grp exp_grp


%% concatenate dsmtx

for i = 1:nSubs

    for x = 1:3
        
        cd ~/Documents/Drafts/Continuing/7t/data/
        
        abc = sprintf('%s%d','cd sub',sub_ts(i));
        eval(abc)
        
        abc = sprintf('%s%d','load dsmtx',x,'a');
        eval(abc)
        
        abc = sprintf('%s%d','dsmtx_concat(:,(i-1)*3750+(x-1)*1250+1:x*1250+(i-1)*3750) = dsmtx',x,'a'';');
        eval(abc)
        
        
    end
    
    sprintf('%d',subs(i))
    
end

save dsmtx_concat dsmtx_concat

%% concatenate dsmtx_epoch

for i = 1:nSubs

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


for i = 1:nSubs

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

for x = 1:5
    beta_score_concat(:,x) = glmfit(dsmtx_concat1',score_concat_gord(x,:)','normal');
    beta_score_grp(:,x) = glmfit(dsmtx_concat1',score_grp(:,x),'normal');
end


for x = 1:5
    beta_score_concat_corr(:,x) = glmfit(dsmtx_concat1_corr',score_concat_gord(x,:)','normal');
    beta_score_grp_corr(:,x) = glmfit(dsmtx_concat1_corr',score_grp(:,x),'normal');
end


for x = 1:5
    beta_score_concat_err(:,x) = glmfit(dsmtx_concat1_err',score_concat_gord(x,:)','normal');
    beta_score_grp_corr(:,x) = glmfit(dsmtx_concat1_corr',score_grp(:,x),'normal');
end



%% extract trial-based time series

for i = 1:nSubs

    for x = 1:3
        
        cd ~/Documents/Drafts/Continuing/7t/data/
        
        abc = sprintf('%s%d','cd sub',sub_ts(i));
        eval(abc)
        
        abc = sprintf('%s%d%s','load dsmtx',x,'a');
        eval(abc)
        
        dsmtx_bin = double(dsmtx1a>0)';

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


        for y = 1:11
        	data_grp_sub1b(:,:,y,x,i) = data_unpack_gord(:,on1a(x):on1a(x)+39,x,i);
        	data_grp_sub2b(:,:,y,x,i) = data_unpack_gord(:,on2a(x):on2a(x)+39,x,i);
        	data_grp_sub3b(:,:,y,x,i) = data_unpack_gord(:,on3a(x):on3a(x)+39,x,i);
        	data_grp_sub4b(:,:,y,x,i) = data_unpack_gord(:,on4a(x):on4a(x)+39,x,i);
        end

    end
end



    
    % 
% for i = 1:nSubs2
%     for y = 1:3
%         for x = 1:11
%             score_grp_sub1b(:,:,x,y,i) = score_unpack_grp(1:5,on1a(x):on1a(x)+39,y,i)';
%             score_grp_sub2b(:,:,x,y,i) = score_unpack_grp(1:5,on2a(x):on2a(x)+39,y,i)';
%             score_grp_sub3b(:,:,x,y,i) = score_unpack_grp(1:5,on3a(x):on3a(x)+39,y,i)';
%             score_grp_sub4b(:,:,x,y,i) = score_unpack_grp(1:5,on4a(x):on4a(x)+39,y,i)';
%         end
%     end
% end
for i = 1:nSubs
    for y = 1:3
        for x = 1:10

        score_concat_sub1b_corr(:,:,x,y,i) = score_unpack_gord(1:5,on1a(x):on1a(x)+39,y,i)';
        score_concat_sub2b_corr(:,:,x,y,i) = score_unpack_gord(1:5,on2a(x):on2a(x)+39,y,i)';
        score_concat_sub3b_corr(:,:,x,y,i) = score_unpack_gord(1:5,on3a(x):on3a(x)+39,y,i)';
    
        end
    end
    
end


for i = 1:nSubs
    for y = 1:3
        for x = 1:11

        score_concat_sub1b(:,:,x,y,i) = score_unpack_gord(1:5,on1a(x):on1a(x)+39,y,i)';
        score_concat_sub2b(:,:,x,y,i) = score_unpack_gord(1:5,on2a(x):on2a(x)+39,y,i)';
        score_concat_sub3b(:,:,x,y,i) = score_unpack_gord(1:5,on3a(x):on3a(x)+39,y,i)';
        score_concat_sub4b(:,:,x,y,i) = score_unpack_gord(1:5,on4a(x):on4a(x)+39,y,i)';
    
        end
    end
    
end

for x = 1:2156

    score_concat_sub1b(:,:,x) = score_concat_gord(:,on1a(x):on1a(x)+39);
    score_concat_sub2b(:,:,x) = score_concat_gord(:,on2a(x):on2a(x)+39);
    score_concat_sub3b(:,:,x) = score_concat_gord(:,on3a(x):on3a(x)+39);
    score_concat_sub4b(:,:,x) = score_concat_gord(:,on4a(x):on4a(x)+39);
    
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
