clc
clear all
%% Reading the 4 dimensional Image with .nii format
[V,info]=ReadData3D('wrrest.nii');
D=[];
ICASIG=[];
l=[];
[a b c d]=size(V); % c is the slices here we do have 61
%%
counter=1;
c=c-3; % I have deleted the 3 last slice of each volume because it was zero
for(r=1:c) % we do repete the algorithm for each slice
    
%% extracting sclice *repition matrix
for i=1:d % d is the repetitions here we will have 190
D(:,i)=reshape(V(:,:,r,i),[a*b,1]); % In the model paper PCA performed for a scan her
% I have constuct for each slice the repititions 
end
%%
%%  implementing PCA and ICA on data
B=zscore(D);
%---------------------------------------------------------------------
% this break is for an error ocurred some time when in some slices the
% matrice value is completly zero then the programm should break
if B==0
    % should delet the specific slice but needs to go on and check the
    % condition again!
    clear D;
    for i=1:d 
    D(:,i)=reshape(V(:,:,r+1,i),[a*b,1]); 
    B=zscore(D);
    end
    r=r+1;
else if B==0
        clear D;
        for i=1:d 
        D(:,i)=reshape(V(:,:,r+2,i),[a*b,1]); 
        B=zscore(D);
        end
        r=r+2;
    else
    break;
    end
end
%---------------------------------------------------------------------
[COEFF SCORE LATENT]=princomp(B);
D=SCORE(:,1:10);
D=D'; 
[icasig, A, W] = fastica(D,'numOfIC', 10);
%%

%% It needs to normalize an IC before the rest of the calculation
for j=1:10
   icasig(j,:) = ( icasig(j,:) - min(icasig(j,:)))./(max(icasig(j,:))-min(icasig(j,:)));
end
%%
%% Reshape the IC form to make the Images 
for m=1:10 
l(:,:,r,m)=reshape(icasig(m,:),[a,b]); % the number of volume(repetition) decrease to 10 from 190
end
clear D SCORE icasig A W COEFF B;
%%

% Do this procedure for all of the slices numbers
% at the end we will have l matrix 
end

[a b c d]=size(l);
fprintf('the number of volume decreased to %d now our dimension is\n %d * %d * %d * %d \n',d,a,b,c,d);


%% Volume local Binary pattern
% VolData -> 3D image in a specific time point
% TInterval -> we choose 1 because we want to compute by g(t,p)=(t-1,t,t+1)
% FRadius -> is also 1 because is in a circle by one radius which has 4
% neaighbour
% NiehborPoints -> is eqaul to 4  -> as a result we will compute
% 2*(4+1)+4=14 or (3p+2) point in a neighborhood of the central point
%BorderLength and TimeLength have the same value with TInterval and FRaduis
%so they will be equal to 1
% I think we dont need RotateIndex and bBilinearInterpolation so we will
% set them 0
% Histogram = RIVLBP(VolData, TInterval, FRadius, NeighborPoints, BorderLength, TimeLength, RotateIndex, bBilinearInterpolation)
for p=1:10
VolData=l(:,:,:,p);
Histogram = RIVLBP(VolData, 1, 1, 4, 1, 1, 0, 0);
Histogram_ICs(p,:)=Histogram';
end
fprintf('The histogram bins for 10 components are saved in *Histogram_ICs* matrix');
%%

