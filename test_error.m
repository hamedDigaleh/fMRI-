%% Reading the subfolders
clc;    % Clear the command window.
clear all;
number_ICs=input('Enter the number of independent components:\n');
workspace;  % Make sure the workspace panel is showing.
format longg;
format compact;
% Define a starting folder.
start_path = fullfile('/Users/hamed/Desktop/Analysis/FunImgRW');
% Ask user to confirm or change.
topLevelFolder = uigetdir(start_path);
if topLevelFolder == 0
	return;
end
% Get list of all subfolders.
allSubFolders = genpath(topLevelFolder);
% Parse into a cell array.
remain = allSubFolders;
listOfFolderNames = {};
n=1;
while true
	[singleSubFolder, remain] = strtok(remain, ':');
	if isempty(singleSubFolder)
		break;
    end
    n=n+1;
	listOfFolderNames = [listOfFolderNames singleSubFolder];
end
numberOfFolders = length(listOfFolderNames)
% Process all image files in those folders.
 k = 75;
	% Get this folder and print it out.
	thisFolder = listOfFolderNames{k};
	%fprintf('Processing folder %s\n', thisFolder);
	
	% Get .nii files.
	filePattern = sprintf('%s/*.nii', thisFolder);
	baseFileNames = dir(filePattern);
	numberOfImageFiles = length(baseFileNames);
	% Now we have a list of all files in this folder.
	
	if numberOfImageFiles >= 1
		% Go through all those image files.
		for f = 1 : numberOfImageFiles
			fullFileName = fullfile(thisFolder, baseFileNames(f).name);
			%fprintf('     Processing image file %s\n', fullFileName);

%% Applying the main algorithm <<

%% Reading the 4 dimensional Image with .nii format
[V,info]=ReadData3D(fullFileName);
D=[];
ICASIG=[];
l=[];
[a b c d]=size(V); % c is the slices here we do have 61
%%
counter=1;
% I have deleted the 3 last slice of each volume because it was zero
for(r=2:c) % we do repete the algorithm for each slice
    
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
if (B==0)
    if(r~=1)
    break;
    end
end
if(r==38)
    break;
end
%---------------------------------------------------------------------
[COEFF SCORE LATENT]=princomp(B);
D=SCORE(:,1:number_ICs);
D=D'; 
[icasig, A, W] = fastica(D,'numOfIC', number_ICs);
%%

%% It needs to normalize an IC before the rest of the calculation
for j=1:number_ICs
   icasig(j,:) = ( icasig(j,:) - min(icasig(j,:)))./(max(icasig(j,:))-min(icasig(j,:)));
end
icasig = floor (icasig.*255);
%%
%% Reshape the IC form to make the Images 
for m=1:number_ICs 
l(:,:,r,m)=reshape(icasig(m,:),[a,b]); % the number of volume(repetition) decrease to 10 from 190
end

clear D SCORE icasig A W COEFF B;

%%

% Do this procedure for all of the slices numbers
% at the end we will have l matrix 
end
fprintf('\nPCA is computed for case %d.\n',k);
fprintf('IC is perform for the case %d.\n',k);

[a b c d]=size(l);
fprintf('the number of repetition decreased to %d after PCA and ICA now our dimension is\n %d * %d * %d * %d \n',d,a,b,c,d);


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
for p=1:number_ICs
VolData=l(:,:,:,p);
Histogram = RIVLBP(VolData, 1, 1, 4, 1, 1, 0, 0);
Histogram_ICs(p,:)=Histogram';
end
fprintf('VLBP is done for the case %d.\n',k);
%fprintf('The histogram bins for 10 components are saved in *Histogram_ICs* matrix');
Histogram_ICs_allImages(:,:,k)=Histogram_ICs;
fprintf('Case %d >> ok .\n',k);
fprintf('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%\n');
%% End of the main algorithm>>
		end
	else
		fprintf('     Folder %s has no image files in it.\n', thisFolder);
    end