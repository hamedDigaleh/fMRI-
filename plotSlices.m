clc
% load l;
% [a b c d]=size(l);
% fprintf('the number of volume decreased to %d now our dimension is\n %d * %d * %d * %d \n',d,a,b,c,d);
% n=1;
% v=input('Enter the slice number to compare in different time points\n');
% from=input('Enter the volume number from you want to compare in screen(up to 10)\n');
% to=input('Enter the volume number to compare \n');
% for i=from:to
%     subplot(2,4,n)
%     n=n+1;
%     contourf(l(:,:,v,i));
% end
%%
% case_num is the case number in our cases we do have 148
ICs=ICs_all_images(:,:,case_num);
% total_num_Ics we choose the number of the ICs 20 in this approach
for m=1:total_num_Ics
l(:,:,m)=reshape(ICs(m,:),[64,64]);  % the size of l  will be 64*64*20
end

% the choose which ICs to display  in num_IC component

ll=l(:,:,num_IC);
contourf(ll)