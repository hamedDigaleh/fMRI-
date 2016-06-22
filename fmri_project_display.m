function varargout = fmri_project_display(varargin)
% FMRI_PROJECT_DISPLAY MATLAB code for fmri_project_display.fig
%      FMRI_PROJECT_DISPLAY, by itself, creates a new FMRI_PROJECT_DISPLAY or raises the existing
%      singleton*.
%
%      H = FMRI_PROJECT_DISPLAY returns the handle to a new FMRI_PROJECT_DISPLAY or the handle to
%      the existing singleton*.
%
%      FMRI_PROJECT_DISPLAY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FMRI_PROJECT_DISPLAY.M with the given input arguments.
%
%      FMRI_PROJECT_DISPLAY('Property','Value',...) creates a new FMRI_PROJECT_DISPLAY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before fmri_project_display_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to fmri_project_display_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help fmri_project_display

% Last Modified by GUIDE v2.5 12-Jan-2016 17:34:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @fmri_project_display_OpeningFcn, ...
                   'gui_OutputFcn',  @fmri_project_display_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before fmri_project_display is made visible.
function fmri_project_display_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to fmri_project_display (see VARARGIN)

% Choose default command line output for fmri_project_display
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes fmri_project_display wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = fmri_project_display_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in SVM.
function SVM_Callback(hObject, eventdata, handles)
% hObject    handle to SVM (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of SVM
histogram = get(handles.Histogramfile_display,'String');
str=get(handles.NumICs,'String');
max_num_ICs = str2num(str);
str2=get(handles.NumPeaks,'String');
max_num_selected_peaks = str2num(str2);
n= handles.kernal;
switch n
    case 1
        kernal_function_GUI='linear'
    case 2 
        kernal_function_GUI= 'quadratic'
    case 3 
        kernal_function_GUI = 'polynomial'
    case 4 
        kernal_function_GUI = 'rbf'
    case 5
        kernal_function_GUI = 'mlp'
end

m= handles.featureSelection;
switch m
    case 1
        feature_selection_method_GUI='ttest'
    case 2 
        feature_selection_method_GUI= 'entropy'
    case 3 
        feature_selection_method_GUI = 'bhattacharyya'
    case 4 
        feature_selection_method_GUI = 'roc'
    case 5
        feature_selection_method_GUI = 'wilcoxon'
end


str2=get(handles.Sigma,'String');
rbf_sigma_GUI = str2num(str2);

str2=get(handles.poloynomial_order,'String');
poloynomial_order_GUI = str2num(str2);

str2=get(handles.mlp_scale,'String');
mlp_scale_GUI = str2num(str2);

str2=get(handles.c_value_svm_get,'String');
C_value_svm = str2num(str2);

[specificity precision accuracy error  sensitivity]=PerformSVM(max_num_ICs,max_num_selected_peaks,histogram,kernal_function_GUI,feature_selection_method_GUI,rbf_sigma_GUI,poloynomial_order_GUI,mlp_scale_GUI,C_value_svm);
handles.data1=specificity;
handles.data2=precision;
handles.data3=accuracy;
handles.data4=error;
handles.data5=sensitivity;
guidata(hObject, handles); 



function NumICs_Callback(hObject, eventdata, handles)
% hObject    handle to NumICs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumICs as text
%        str2double(get(hObject,'String')) returns contents of NumICs as a double


% --- Executes during object creation, after setting all properties.
function NumICs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumICs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function NumPeaks_Callback(hObject, eventdata, handles)
% hObject    handle to NumPeaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumPeaks as text
%        str2double(get(hObject,'String')) returns contents of NumPeaks as a double


% --- Executes during object creation, after setting all properties.
function NumPeaks_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumPeaks (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in KNN.
function KNN_Callback(hObject, eventdata, handles)
% hObject    handle to KNN (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of KNN
histogram = get(handles.Histogramfile_display,'String');
str=get(handles.NumICs,'String');
max_num_ICs = str2num(str);
str2=get(handles.NumPeaks,'String');
max_num_selected_peaks = str2num(str2);

str=get(handles.NumNH,'String');
NumNH = str2num(str);
[specificity precision accuracy error  sensitivity]=PerformKNN(max_num_ICs,max_num_selected_peaks,NumNH,histogram);
handles.data1=specificity;
handles.data2=precision;
handles.data3=accuracy;
handles.data4=error;
handles.data5=sensitivity;
guidata(hObject, handles); 

function NumNH_Callback(hObject, eventdata, handles)
% hObject    handle to NumNH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of NumNH as text
%        str2double(get(hObject,'String')) returns contents of NumNH as a double


% --- Executes during object creation, after setting all properties.
function NumNH_CreateFcn(hObject, eventdata, handles)
% hObject    handle to NumNH (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on button press in togglebutton5.
function togglebutton5_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton5


% --- Executes on button press in load_data.
function load_data_Callback(hObject, eventdata, handles)
% hObject    handle to load_data (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[histogram, pathname] = uigetfile('*.mat', 'Select the histogram matrix');
if isequal(histogram,0)
   disp('User selected Cancel')
else
   disp(['User selected ', fullfile(pathname, histogram)])
end
set(handles.Histogramfile_display,'string',histogram)


% --- Executes on button press in togglebutton6.
function togglebutton6_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton6


% --- Executes on button press in togglebutton7.
function togglebutton7_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton7


% --- Executes on button press in Results_table.
function Results_table_Callback(hObject, eventdata, handles)
% hObject    handle to Results_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Results_table
f = figure('Position',[200 400 1300 500]);
% create the data
% d = [1 2 3; 4 5 6; 7 8 9];
i=1;
d1=handles.data1;
d2=handles.data2;
d3=handles.data3;
d4=handles.data4;
d5=handles.data5;
d(1,:)=d3; % Accuracy
d(2,:)=d5; % Sensitivity
d(3,:)=d2; % Precision
d(4,:)=d1; % Specificity
d(5,:)=d4; % Error


% Create the column and row names in cell arrays
cnames = {'1 ICs','2 ICs','3 ICs','4 ICs','5 ICs'...
    ,'6 ICs','7 ICs','8 ICs','9 ICs'...
    ,'10 ICs','11 ICs','12 ICs','13 ICs'...
    ,'14 ICs','15 ICs','16 ICs','17 ICs','18 ICs','19 ICs','20 ICs'};
rnames = {'Accuracy','Sensitivity','Precision','Specificity','Error'};
% Create the uitable
t = uitable(f,'Data',d,...
            'ColumnName',cnames,...
            'RowName',rnames);
% Set width and height
t.Position(2) = t.Extent(2);
t.Position(3) = t.Extent(3);






% --- Executes on button press in plot_histogram.
function plot_histogram_Callback(hObject, eventdata, handles)
% hObject    handle to plot_histogram (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
plot_histogram


% --- Executes on button press in plot_ICs_Images.
function plot_ICs_Images_Callback(hObject, eventdata, handles)
% hObject    handle to plot_ICs_Images (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
scan_diplay_ICs


% --- Executes on selection change in kernalOption.
function kernalOption_Callback(hObject, eventdata, handles)
% hObject    handle to kernalOption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns kernalOption contents as cell array
%        contents{get(hObject,'Value')} returns selected item from kernalOption
contents = get (hObject , 'Value');
handles.kernal=contents;
guidata(hObject, handles); 
% --- Executes during object creation, after setting all properties.
function kernalOption_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kernalOption (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popup_feature_selection.
function popup_feature_selection_Callback(hObject, eventdata, handles)
% hObject    handle to popup_feature_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popup_feature_selection contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popup_feature_selection
contents = get (hObject , 'Value');
handles.featureSelection=contents;
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function popup_feature_selection_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popup_feature_selection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sigma_Callback(hObject, eventdata, handles)
% hObject    handle to Sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sigma as text
%        str2double(get(hObject,'String')) returns contents of Sigma as a double
 



% --- Executes during object creation, after setting all properties.
function Sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function poloynomial_order_Callback(hObject, eventdata, handles)
% hObject    handle to poloynomial_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of poloynomial_order as text
%        str2double(get(hObject,'String')) returns contents of poloynomial_order as a double




% --- Executes during object creation, after setting all properties.
function poloynomial_order_CreateFcn(hObject, eventdata, handles)
% hObject    handle to poloynomial_order (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mlp_scale_Callback(hObject, eventdata, handles)
% hObject    handle to mlp_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mlp_scale as text
%        str2double(get(hObject,'String')) returns contents of mlp_scale as a double




% --- Executes during object creation, after setting all properties.
function mlp_scale_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mlp_scale (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Sigma_grid_search_Callback(hObject, eventdata, handles)
% hObject    handle to Sigma_grid_search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Sigma_grid_search as text
%        str2double(get(hObject,'String')) returns contents of Sigma_grid_search as a double


% --- Executes during object creation, after setting all properties.
function Sigma_grid_search_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Sigma_grid_search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function C_GUI_Callback(hObject, eventdata, handles)
% hObject    handle to C_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of C_GUI as text
%        str2double(get(hObject,'String')) returns contents of C_GUI as a double


% --- Executes during object creation, after setting all properties.
function C_GUI_CreateFcn(hObject, eventdata, handles)
% hObject    handle to C_GUI (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function specific_num_ICs_Callback(hObject, eventdata, handles)
% hObject    handle to specific_num_ICs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of specific_num_ICs as text
%        str2double(get(hObject,'String')) returns contents of specific_num_ICs as a double


% --- Executes during object creation, after setting all properties.
function specific_num_ICs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to specific_num_ICs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in perform_grid_search.
function perform_grid_search_Callback(hObject, eventdata, handles)
% hObject    handle to perform_grid_search (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
histogram = get(handles.Histogramfile_display,'String');

str=get(handles.get_c_range,'String');
rbf_C_GUI = str2num(str);

str=get(handles.specific_num_ICs,'String');
num_ICs = str2num(str);

str2=get(handles.NumPeaks,'String');
selected_peaks = str2num(str2);

n= handles.kernal;
switch n
    case 1
        kernal_function_GUI='linear'
    case 2 
        kernal_function_GUI= 'quadratic'
    case 3 
        kernal_function_GUI = 'polynomial'
    case 4 
        kernal_function_GUI = 'rbf'
    case 5
        kernal_function_GUI = 'mlp'
end

m= handles.featureSelection;
switch m
    case 1
        feature_selection_method_GUI='ttest'
    case 2 
        feature_selection_method_GUI= 'entropy'
    case 3 
        feature_selection_method_GUI = 'bhattacharyya'
    case 4 
        feature_selection_method_GUI = 'roc'
    case 5
        feature_selection_method_GUI = 'wilcoxon'
end


str2=get(handles.Sigma_grid_search,'String');
rbf_sigma_GUI = str2num(str2);



[accuracy,s_value,c_value,max_accuracy]=SVM_grid_search(selected_peaks,histogram,kernal_function_GUI,feature_selection_method_GUI,rbf_sigma_GUI,rbf_C_GUI,num_ICs);

s_value=num2str(s_value);
set(handles.optimum_sigma_grid_search, 'string',s_value);

c_value=num2str(c_value);
set(handles.optimum_C_grid_search, 'string',c_value);

max_accuracy=num2str(max_accuracy);
set(handles.max_accuracy_grid_search, 'string',max_accuracy);
% handles.data1=specificity;
% handles.data2=precision;
handles.data3=accuracy;
% handles.data4=error;

% handles.data5=sensitivity;
guidata(hObject, handles); 

% Hint: get(hObject,'Value') returns toggle state of perform_grid_search



function get_c_range_Callback(hObject, eventdata, handles)
% hObject    handle to get_c_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of get_c_range as text
%        str2double(get(hObject,'String')) returns contents of get_c_range as a double


% --- Executes during object creation, after setting all properties.
function get_c_range_CreateFcn(hObject, eventdata, handles)
% hObject    handle to get_c_range (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_value_svm_get_Callback(hObject, eventdata, handles)
% hObject    handle to c_value_svm_get (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c_value_svm_get as text
%        str2double(get(hObject,'String')) returns contents of c_value_svm_get as a double


% --- Executes during object creation, after setting all properties.
function c_value_svm_get_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_value_svm_get (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
