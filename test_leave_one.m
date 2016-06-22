
clc
clear all
load('patient_group_fetures.mat')
load('normal_group_fetures.mat')

num_ICs=input('please enter the number of the components : \n');
% creating group elements by assigning 1 to patient and -1 to normal
% control
[a,b]=size(patient_group_fetures);
[c,d]=size(normal_group_fetures);
group_total = [ones(a,1) ; (-1.*ones(c,1))];

% xdata_total contain all independent components 
xdata_total=[patient_group_fetures ; normal_group_fetures];


for j=1:num_ICs

Classes=group_total; % It's size is \\ num_ICs*num_cases (1460*1)\\ , num_ICs components for each subject
Datas=xdata_total; % It's size is \\ num_ICs*num_cases (1460*2)\\ , num_ICs components for each subject

% Since we need to select each time one component (for example the first components)
Datas=Datas(j:num_ICs:end,:);
Classes=Classes(j:num_ICs:end,:); % By selecting the first component the size of the matrix will be 146=72(patient)+74(normal)
%% Leave-One-Out cross validation method
% Initialize result matrix
Results = zeros(size(Datas,1),2);
% Validate classifier settings with leave-one-out procedure
for k=1:size(Datas,1)
    % Extract sample
    ind = Datas(k,:);
    % Copy the database
    Datas_mod = Datas;
    % Copy the classes vector
    Classes_mod = Classes;
    % Keep the sample real class
    Results(k,2) = Classes(k);
    % Remove sample from database
    Datas_mod(k,:) = [];
    % Remove sample from class vector
    Classes_mod(k)   = [];
    % Execute the classification algorithm
    svmStruct = svmtrain(Datas_mod,Classes_mod,'method','SMO');
    species = svmclassify(svmStruct,ind(1,1:size(ind,2)));
    %
    %[Individu,MxD(k)] = knn(ind(1,1:size(ind,2)),Datas_mod,Classes_mod,5,700);
   % Keep the class found by the classifier for the current sample
    %Results(k,1) = Individu(1,size(Individu,2));
    Results(k,1) = species(1,size(species,2));
end
total_result(:,j)=Results(:,1);
end
total_result(:,j+1)=Results(:,2);


%%
% added_componet_matrix(:,1)=total_result(:,1)+total_result(:,2)+total_result(:,3);
% added_componet_matrix(:,2)=total_result(:,4);
added_componet_matrix=sum(total_result(:,1:j),2);
added_componet_matrix(:,2)=total_result(:,j+1);
for i=1:146
    if added_componet_matrix(i,1)>0
        added_componet_matrix(i,1)=1;
    elseif added_componet_matrix(i,1)<0
        added_componet_matrix(i,1)=-1; 
    else
         added_componet_matrix(i,1)=0;
    end
end
%% Defining TP and FN for calculating sensitivity
TP=0; % TP means correctly diagnosed patients
for i=1:72
    if (added_componet_matrix(i,1)==added_componet_matrix(i,2))
        TP=TP+1;
    end
end
FN=0; % FN means incorrectly identified controls 
for i=73:146
    if (added_componet_matrix(i,1)~=added_componet_matrix(i,2))
        FN=FN+1;
    end
end
 sensitivity = ((TP)/(TP+FN))*100

%%
%% Defining TN and FP for calculating specificity , precision, accuracy and error
TN=0; % TN is correctly diagnosed controls
for i=73:146
    if (added_componet_matrix(i,1)==added_componet_matrix(i,2))
        TN=TN+1;
    end
end
FP=0; % FP is incorrecrly identified patients
for i=1:72
    if (added_componet_matrix(i,1)~=added_componet_matrix(i,2))
        FP=FP+1;
    end
end

specificity = ((TN) / (TN+FP))*100
precision = ((TP)/(TP+FP))*100
accuracy = ((TP+TN)/(TP+TN+FP+FN))*100
error =((FP+FN)/(TP+TN+FP+FN))*100
%%