
function  [accuracy,s_value,c_value,max_accuracy]=SVM_grid_search(selected_peaks,histogram,kernal_function_GUI,feature_selection_method_GUI,rbf_sigma_GUI,rbf_C_GUI,num_ICs)
tic
%% Reading the excel file from patients and controlled groups labels
clc
rbf_sigma_GUI
rbf_C_GUI
s1=rbf_sigma_GUI(1,1);
s1_saved=s1

s2=rbf_sigma_GUI(1,2);
c1=rbf_C_GUI(1,1);
c1_saved=c1;
c2=rbf_C_GUI(1,2);
st=(s2-s1)+1;
ct=(c2-c1)+1;
% load('totalHistogram.mat')
load(histogram)
filename = 'Schizophernia_data.xlsx';
A = xlsread(filename);
%%
%% Constructing the Normal and Patient matrix 
% according to the data instuction file 
% the 0040000 mean 1 >> (num-40000)+1 equal to the array number in stored
% data
[a ,b]=size(A);
A=(A-40000)+1;
Controlled_index=A(:,1)';
Patient_index=A(1:(a-2),2)'; % because the number of patient was 72 while the number of controlled one are 74

%Choosing the patient and controlled from save histogram matrix of all
%images
Normal=Histogram_ICs_allImages(:,:,Controlled_index);
Patient=Histogram_ICs_allImages(:,:,Patient_index);

% normal and patient are now 3D we need to list them in 2D
[a,b,c]=size(Normal);
%  max_num_ICs = input('Entenr the max number of the components:\n');
%  max_num_selected_peaks=input('Enter the max number of peaks to select :\n');
 
     %% making 3D data into 2 dimensions without selecting specific numbers of ICs in this step
     max_num_ICs=20;  % in the last version we have extracted 20 ICs
n=1;
for i=1:c
    normal(n:(n+max_num_ICs-1),:)=Normal(:,:,i);
    n=n+max_num_ICs;
end

[a,b,c]=size(Patient);
n=1;
for i=1:c
    patient(n:(n+max_num_ICs-1),:)=Patient(:,:,i);
    n=n+max_num_ICs;
end
save('normal.mat','normal')
save('patient.mat','patient')
counter=0;

% for num_selected_peaks=2:max_num_selected_peaks
% for num_ICs=1:max_num_ICs
for sigma =1:st
    for C =1:ct
load('normal.mat')
load('patient.mat')
%% selecting specific components number for example ICs_num=2;
n=0;
% num_ICs=4;
a=[num_ICs:max_num_ICs:size(normal,1)];
for i=1:num_ICs
    b(1,(1+n):(length(a)+n))=a;
    a=a-1;
    n=n+74;
end
b=sort(b);
normal=normal(b,:);

n=0;
a=[num_ICs:max_num_ICs:size(patient,1)];
for i=1:num_ICs
    c(1,(1+n):(length(a)+n))=a;
    a=a-1;
    n=n+72;
end

c=sort(c);
patient=patient(c,:);

%% perform  two sample T-test and find two  voxels numbers with the highest value of t 
% saved as i1 , i2 
% perevious version we have tried :)
%  for i=1:length(normal)
%     x1=mean(normal(:,i));
%     x2=mean(patient(:,i));
%     variance1=var(normal(:,i));
%     variance2=var(patient(:,i));
%     n1=size(normal,1);
%     n2=size(patient,1);
%     t(i)= (x1-x2)./sqrt( (variance1)/n1 + (variance2)/n2);
% 
%  end
% latest version we have found
 Y= [patient' normal'];
 grp= [ones(1,size(patient',2)) -1.*ones(1,size(normal',2))];
[feat,stat] = rankfeatures(Y,grp,'CRITERION',feature_selection_method_GUI,'NUMBER',selected_peaks);

% prevouis version>>
 %fprintf('The two sample  t-test is performed ! \n  ')
% num_selected_peaks=input('enter the number of the peaks to select:\n');
% t=abs(t);
% for i=0:(num_selected_peaks-1)
%     B = sort(t);
%     % if there are nan value find and remove it (error type)
%     n=length(B);
%     while (isnan(B(n)))
%      n=n-1;  
%     end
%     B=B(1,1:n);
%     %------------------------------------------
%     max_f(i+1)=B(1,end-i);
%     ll=find(t==max_f(i+1));
%     finded_positions(i+1)=ll(1,1);
% end
 %%
 
 %% Extacting two most relative voxel from Histogram Bins of normal and patient group
%  normal_group_fetures(:,1) = normal(:,i1);
%  normal_group_fetures(:,2) = normal(:,i2);
finded_positions=feat;
for i=1:length(finded_positions)
    normal_group_fetures(:,i) = normal(:,finded_positions(i));
    patient_group_fetures(:,i) = patient(:,finded_positions(i));
end
 
%   patient_group_fetures(:,1) = patient(:,i1);
%   patient_group_fetures(:,2) = patient(:,i2);
 % fprintf('The most relative two features are stored in \n normal_group_fetures \n patient_group_fetures \n matrix.\n ')
  
 %%
%  save('normal_group_fetures.mat','normal_group_fetures');
%  save('patient_group_fetures.mat','patient_group_fetures');

  %% perfoming one sample t-test om both control and healthy ones seperatly
  
  
  
  
  %%
  %% perfoming one sample t-test om both control and healthy ones seperatly
  
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
%     SVMModel = fitcsvm(Datas_mod,Classes_mod);
%     species = predict(SVMModel,ind(1,1:size(ind,2)));
% %      species = svmclassify(svmStruct,ind(1,1:size(ind,2)));

if isequal(kernal_function_GUI, 'rbf')
    m=1;
elseif isequal(kernal_function_GUI, 'polynomial')
    m=2;
elseif isequal(kernal_function_GUI, 'mlp')
    m=3;
else
    m=4;
end
switch m 
    case 1
        
            svmStruct = svmtrain(Datas_mod,Classes_mod,'kernel_function',kernal_function_GUI,'rbf_sigma',(2.^s1), 'BoxConstraint', (2.^c1),'method','SMO');
    species = svmclassify(svmStruct,ind(1,1:size(ind,2)));
    case 2
         svmStruct = svmtrain(Datas_mod,Classes_mod,'kernel_function',kernal_function_GUI,'polyorder',poloynomial_order_GUI,'method','SMO');
    species = svmclassify(svmStruct,ind(1,1:size(ind,2)));
    case 3
        svmStruct = svmtrain(Datas_mod,Classes_mod,'kernel_function',kernal_function_GUI,'mlp_params',mlp_scale_GUI,'method','SMO');
    species = svmclassify(svmStruct,ind(1,1:size(ind,2)));
    case 4
         svmStruct = svmtrain(Datas_mod,Classes_mod,'kernel_function',kernal_function_GUI,'method','SMO');
    species = svmclassify(svmStruct,ind(1,1:size(ind,2)));
end
%     svmStruct = svmtrain(Datas_mod,Classes_mod,'kernel_function',kernal_function_GUI,'rbf_sigma',rbf_sigma_GUI,'method','SMO');
%     species = svmclassify(svmStruct,ind(1,1:size(ind,2)));
%     mdl=fitcknn(Datas_mod , Classes_mod,'NumNeighbors',4,'Standardize',1);
%     species = predict(mdl,ind(1,1:size(ind,2)));
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
for i=1:146
    if ((added_componet_matrix(i,1)==added_componet_matrix(i,2)) && (added_componet_matrix(i,2)==1))
        TP=TP+1;
    end
end
FN=0; % FN means incorrectly identified controls 
for i=1:146
    if ((added_componet_matrix(i,1)~=added_componet_matrix(i,2))&& (added_componet_matrix(i,2)==1))
        FN=FN+1;
    end
end


%%
%% Defining TN and FP for calculating specificity , precision, accuracy and error
TN=0; % TN is correctly diagnosed controls
for i=1:146
    if ((added_componet_matrix(i,1)==added_componet_matrix(i,2))&& (added_componet_matrix(i,2)==-1))
        TN=TN+1;
    end
end
FP=0; % FP is incorrecrly identified patients
for i=1:146
    if (added_componet_matrix(i,1)~=added_componet_matrix(i,2) && (added_componet_matrix(i,2)==-1))
        FP=FP+1;
    end
end

accuracy(sigma,C) = ((TP+TN)/(TP+TN+FP+FN))*100;

save('accuracy.mat','accuracy')

clear normal_group_fetures patient_group_fetures normal patient 
counter=counter+1
toc
c1=c1+1;
s1=s1+1;
    end
end
[a,b]=find(accuracy==max(max(accuracy))) % here a is rows refere to Sigma value and b are columns refer to C value
a=a(1,1);
b=b(1,1);
s_min=s1_saved+(a-1);
c_min= c1_saved + (b-1);

s_value=2.^s_min;
c_value=2.^c_min;
max_accuracy=max(max(accuracy));

end
% end
% accuracy=floor(accuracy);
%%
