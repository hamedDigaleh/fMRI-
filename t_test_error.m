clc
clear all
%% Reading the excel file from patients and controlled groups labels
load('totalHistogram.mat')
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
num_ICs = input('Entenr the number of the components:\n');
tr_normal=input('please enter the threshold for normal group :\n');
tr_patient=input('please enter the threshold for patient group :\n');
tr_diff=input('please enter the threshold for difference group :\n');

n=1;
for i=1:c
    normal(n:(n+num_ICs-1),:)=Normal(:,:,i);
    n=n+num_ICs;
end

[a,b,c]=size(Patient);
n=1;
for i=1:c
    patient(n:(n+num_ICs-1),:)=Patient(:,:,i);
    n=n+num_ICs;
end

%% performing one sample t-test seperatly on patients and healthy ones
n=1;
mu=mean(mean([normal;patient]));
for j=1:length(normal)
    m=mean(normal(:,j));
    sd = std(normal(:,j));
    n1=740;
    tn(j)= (m-mu)./(sd/sqrt(n1));
   if abs(tn(j)) < tr_normal
%       index_normal(n)=j ;
%       n=n+1;
   tn(j)=0;
   end
end

 n=1;   
for j=1:length(patient)
    m=mean(patient(:,j));
    sd = std(patient(:,j));
    n2=720;
    tp(j)= (m-mu)./(sd/sqrt(n2));
    
       if abs(tp(j)) < tr_patient
%        index_patient(n)=i ;
%        n=n+1;
         tp(j)=0;
       end
end


%%

%% perform  two sample T-test and find two  voxels numbers with the highest value of t 
% saved as i1 , i2 
n=1;
for i=1:length(normal)
    x1=mean(normal(:,i));
    x2=mean(patient(:,i));
    variance1=var(normal(:,i));
    variance2=var(patient(:,i));
    n1=740;
    n2=720;
    
    t(i)= (x1-x2)./sqrt( (variance1)/n1 + (variance2)/n2);
    
       if abs(t(i)) < tr_diff
% %        index_deff(n)=i ;
% %        n=n+1;
         t(i)=0;
       end
   
end

t=t.*tp.*tn;
 fprintf('The two sample  t-test is performed ! \n  ')
  [b1,i1] = max(abs(t));
 [b2,i2] = max(abs(t([1:i1-1,i1+1:end])));
 if i2>=i1, i2 = i2+1; end
 B = [b1,b2]; % <-- The two largest elements of A
 ix = [i1,i2]; % <-- Their corresponding indices
 %%
 
 %% Extacting two most relative voxel from Histogram Bins of normal and patient group
 normal_group_fetures(:,1) = normal(:,i1);
 normal_group_fetures(:,2) = normal(:,i2);
 
  patient_group_fetures(:,1) = patient(:,i1);
  patient_group_fetures(:,2) = patient(:,i2);
  fprintf('The most relative two features are stored in \n normal_group_fetures \n patient_group_fetures \n matrix.\n ')
  
 %%
 save('normal_group_fetures.mat','normal_group_fetures');
 save('patient_group_fetures.mat','patient_group_fetures');
  %% perfoming one sample t-test om both control and healthy ones seperatly
  
  
  
  
  %%