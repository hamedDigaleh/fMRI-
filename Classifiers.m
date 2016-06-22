%% Performing the SVM classifier 
clc
clear all
load('patient_group_fetures.mat')
load('normal_group_fetures.mat')
% creating group elements by assigning 1 to patient and -1 to normal
% control
[a,b]=size(patient_group_fetures);
[c,d]=size(normal_group_fetures);
group_total = [ones(a,1) ; (-1.*ones(c,1))];

% we need to select only one component in each process (we do have 3 ICs and two feature for each ones)
xdata_total=[patient_group_fetures ; normal_group_fetures];
[a,b]=size(xdata_total);
xdata=xdata_total(1:3:a,:);
group=group_total(1:3:a,:);
% figure;
% svmStruct = svmtrain(xdata,group,'ShowPlot',true);
% 
% 
%  species = svmclassify(svmStruct,xdata_total(200,:),'ShowPlot',true)
% % hold on;
% % plot(Xnew(:,1),Xnew(:,2),'ro','MarkerSize',12);
% % hold off

%%