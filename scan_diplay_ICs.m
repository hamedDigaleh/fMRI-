function varargout = scan_diplay_ICs(varargin)
% SCAN_DIPLAY_ICS MATLAB code for scan_diplay_ICs.fig
%      SCAN_DIPLAY_ICS, by itself, creates a new SCAN_DIPLAY_ICS or raises the existing
%      singleton*.
%
%      H = SCAN_DIPLAY_ICS returns the handle to a new SCAN_DIPLAY_ICS or the handle to
%      the existing singleton*.
%
%      SCAN_DIPLAY_ICS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCAN_DIPLAY_ICS.M with the given input arguments.
%
%      SCAN_DIPLAY_ICS('Property','Value',...) creates a new SCAN_DIPLAY_ICS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before scan_diplay_ICs_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to scan_diplay_ICs_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help scan_diplay_ICs

% Last Modified by GUIDE v2.5 30-Dec-2015 05:51:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @scan_diplay_ICs_OpeningFcn, ...
                   'gui_OutputFcn',  @scan_diplay_ICs_OutputFcn, ...
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


% --- Executes just before scan_diplay_ICs is made visible.
function scan_diplay_ICs_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to scan_diplay_ICs (see VARARGIN)

% Choose default command line output for scan_diplay_ICs
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes scan_diplay_ICs wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = scan_diplay_ICs_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str=get(handles.case_number_ICs,'String');
case_num = str2num(str);

str=get(handles.IC_one,'String');
first_IC = str2num(str);

str=get(handles.IC_two,'String');
second_IC = str2num(str);

str=get(handles.IC_third,'String');
third_IC = str2num(str);

str=get(handles.IC_fourth,'String');
fourth_IC = str2num(str);

str=get(handles.zmin,'String');
zmin = str2num(str);

str=get(handles.zmax,'String');
zmax = str2num(str);

load('ICs_all_images_new.mat')
% case_num is the case number in our cases we do have 148
ICs=ICs_all_images(:,:,case_num);
% total_num_Ics we choose the number of the ICs 20 in this approach
total_num_Ics=20;
for m=1:total_num_Ics
l(:,:,m)=reshape(ICs(m,:),[49,58]);  % the size of l  will be 64*64*20
end
d=handles.condition;

switch d
    case 1
ll_first_IC=l(:,:,first_IC);
axes(handles.axes1)
contourf(ll_first_IC,20);

ll_second_IC=l(:,:,second_IC);
axes(handles.axes2)
contourf(ll_second_IC,10);

ll_third_IC=l(:,:,third_IC);
axes(handles.axes3)
contourf(ll_third_IC,10);

ll_fourth_IC=l(:,:,fourth_IC);
axes(handles.axes4)
contourf(ll_fourth_IC,10);
    case 2
ll_first_IC=l(:,:,first_IC);
axes(handles.axes1)
imagesc(ll_first_IC,[zmin zmax]);

ll_second_IC=l(:,:,second_IC);
axes(handles.axes2)
imagesc(ll_second_IC,[zmin zmax]);

ll_third_IC=l(:,:,third_IC);
axes(handles.axes3)
imagesc(ll_third_IC,[zmin zmax]);

ll_fourth_IC=l(:,:,fourth_IC);
axes(handles.axes4)
imagesc(ll_fourth_IC,[zmin zmax]);
end



function case_number_ICs_Callback(hObject, eventdata, handles)
% hObject    handle to case_number_ICs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of case_number_ICs as text
%        str2double(get(hObject,'String')) returns contents of case_number_ICs as a double


% --- Executes during object creation, after setting all properties.
function case_number_ICs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to case_number_ICs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IC_one_Callback(hObject, eventdata, handles)
% hObject    handle to IC_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IC_one as text
%        str2double(get(hObject,'String')) returns contents of IC_one as a double


% --- Executes during object creation, after setting all properties.
function IC_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IC_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IC_two_Callback(hObject, eventdata, handles)
% hObject    handle to IC_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IC_two as text
%        str2double(get(hObject,'String')) returns contents of IC_two as a double


% --- Executes during object creation, after setting all properties.
function IC_two_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IC_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IC_third_Callback(hObject, eventdata, handles)
% hObject    handle to IC_third (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IC_third as text
%        str2double(get(hObject,'String')) returns contents of IC_third as a double


% --- Executes during object creation, after setting all properties.
function IC_third_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IC_third (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IC_fourth_Callback(hObject, eventdata, handles)
% hObject    handle to IC_fourth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IC_fourth as text
%        str2double(get(hObject,'String')) returns contents of IC_fourth as a double


% --- Executes during object creation, after setting all properties.
function IC_fourth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IC_fourth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function case_one_Callback(hObject, eventdata, handles)
% hObject    handle to case_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of case_one as text
%        str2double(get(hObject,'String')) returns contents of case_one as a double


% --- Executes during object creation, after setting all properties.
function case_one_CreateFcn(hObject, eventdata, handles)
% hObject    handle to case_one (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function case_two_Callback(hObject, eventdata, handles)
% hObject    handle to case_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of case_two as text
%        str2double(get(hObject,'String')) returns contents of case_two as a double


% --- Executes during object creation, after setting all properties.
function case_two_CreateFcn(hObject, eventdata, handles)
% hObject    handle to case_two (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function case_third_Callback(hObject, eventdata, handles)
% hObject    handle to case_third (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of case_third as text
%        str2double(get(hObject,'String')) returns contents of case_third as a double


% --- Executes during object creation, after setting all properties.
function case_third_CreateFcn(hObject, eventdata, handles)
% hObject    handle to case_third (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function case_fourth_Callback(hObject, eventdata, handles)
% hObject    handle to case_fourth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of case_fourth as text
%        str2double(get(hObject,'String')) returns contents of case_fourth as a double


% --- Executes during object creation, after setting all properties.
function case_fourth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to case_fourth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function specific_slice_number_Callback(hObject, eventdata, handles)
% hObject    handle to specific_slice_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of specific_slice_number as text
%        str2double(get(hObject,'String')) returns contents of specific_slice_number as a double


% --- Executes during object creation, after setting all properties.
function specific_slice_number_CreateFcn(hObject, eventdata, handles)
% hObject    handle to specific_slice_number (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in several_case_plot.
function several_case_plot_Callback(hObject, eventdata, handles)
% hObject    handle to several_case_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

str=get(handles.specific_slice_number,'String');
specific_slice_num = str2num(str);

str=get(handles.case_one,'String');
first_case = str2num(str);

str=get(handles.case_two,'String');
second_case = str2num(str);

str=get(handles.case_third,'String');
third_case = str2num(str);

str=get(handles.case_fourth,'String');
fourth_case = str2num(str);

str=get(handles.zmin,'String');
zmin = str2num(str);

str=get(handles.zmax,'String');
zmax = str2num(str);

load('ICs_all_images_new.mat')

ICs=ICs_all_images(specific_slice_num,:,:);

total_num_cases=148;
for m=1:total_num_cases
l(:,:,m)=reshape(ICs(1,:,m),[49,58]);  % the size of l  will be 64*64*148
end
d=handles.condition;
switch d
    case 1
ll_first_case=l(:,:,first_case);
axes(handles.axes1)
contourf(ll_first_case,10);

ll_second_case=l(:,:,second_case);
axes(handles.axes2)
contourf(ll_second_case,10);

ll_third_case=l(:,:,third_case);
axes(handles.axes3)
contourf(ll_third_case,10);

ll_fourth_case=l(:,:,fourth_case);
axes(handles.axes4)
contourf(ll_fourth_case,10);
    case 2
        ll_first_case=l(:,:,first_case);
axes(handles.axes1)
imagesc(ll_first_case,[zmin zmax]);

ll_second_case=l(:,:,second_case);
axes(handles.axes2)
imagesc(ll_second_case,[zmin zmax]);

ll_third_case=l(:,:,third_case);
axes(handles.axes3)
imagesc(ll_third_case,[zmin zmax]);

ll_fourth_case=l(:,:,fourth_case);
axes(handles.axes4)
imagesc(ll_fourth_case,[zmin zmax]);
end

% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
contents = get (hObject , 'Value');
handles.condition=contents;
guidata(hObject, handles); 

% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
b = get(hObject.slider2,'Value');
handles.sliderValue_max = b;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a = get(hObject.slider1,'Value');
handles.sliderValue_min = a;
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function zmin_Callback(hObject, eventdata, handles)
% hObject    handle to zmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zmin as text
%        str2double(get(hObject,'String')) returns contents of zmin as a double


% --- Executes during object creation, after setting all properties.
function zmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zmax_Callback(hObject, eventdata, handles)
% hObject    handle to zmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zmax as text
%        str2double(get(hObject,'String')) returns contents of zmax as a double


% --- Executes during object creation, after setting all properties.
function zmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
